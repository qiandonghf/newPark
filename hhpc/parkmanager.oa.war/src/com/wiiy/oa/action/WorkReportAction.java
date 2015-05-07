package com.wiiy.oa.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.commons.util.POIUtil;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.commons.util.TreeUtil;
import com.wiiy.core.entity.Org;
import com.wiiy.core.entity.User;
import com.wiiy.core.external.service.OrgPubService;
import com.wiiy.core.external.service.UserPubService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dto.MonthDto;
import com.wiiy.oa.dto.ReportUserDto;
import com.wiiy.oa.dto.WeekDto;
import com.wiiy.oa.dto.WorkCountDto;
import com.wiiy.oa.dto.WorkDayDto;
import com.wiiy.oa.dto.WorkReportDto;
import com.wiiy.oa.entity.Document;
import com.wiiy.oa.entity.Task;
import com.wiiy.oa.entity.TaskDepart;
import com.wiiy.oa.entity.WorkDayReport;
import com.wiiy.oa.entity.WorkReport;
import com.wiiy.oa.entity.WorkReportConfig;
import com.wiiy.oa.preferences.enums.TaskStatusEnum;
import com.wiiy.oa.preferences.enums.WorkReportEnum;
import com.wiiy.oa.preferences.enums.WorkReportStatusEnum;
import com.wiiy.oa.service.TaskDepartService;
import com.wiiy.oa.service.TaskService;
import com.wiiy.oa.service.WorkDayReportService;
import com.wiiy.oa.service.WorkReportConfigService;
import com.wiiy.oa.service.WorkReportService;
import com.wiiy.oa.util.ScheduleUtil;

public class WorkReportAction extends JqGridBaseAction<WorkReport> {
	private WorkReportService workReportService;
	private WorkDayReportService workDayReportService;
	private WorkReportConfigService workReportConfigService;
	private TaskService taskService;
	private TaskDepartService departService;
	private WorkReport workReport;
	private WorkReport workReport2;
	private List<WorkReportConfig> workReportConfigList;
	private Result result;
	private Boolean flag = false;
	private List<WorkCountDto> workCountDtoList;
	private List<MonthDto> monthDtoList;
	private List<MonthDto> monthDtos;
	private List<WeekDto> weekDtoList;
	private List<Date> dateList;
	private MonthDto month;
	private WeekDto week;
	private Integer year;
	private Integer myMonth;
	private Integer myWeek;
	private Integer curYear;
	private Long day;
	private Date startTime;
	private Date endTime;
	private Date prevYear;
	private Date nextYear;
	private String myYear;
	private Date prevMonth;
	private Date nextMonth;
	private String selectMonth;
	private Date date;
	private String dateStr;
	
	private List<WorkDayReport> workDayReportList;
	private List<WorkReport> workReportList;
	private String workReportReceiverIds;
	private Long id;
	private List<Integer> yearList;
	private List<Integer> monthList;
	private String type;
	private List<Document> nodeList;
	
	private String excelName;
	private InputStream inputStream;
	private String taskReportParam;//填写周报、月报用于load任务时从页面传来的参数
	
	private String sTime;//开始时间
	private String eTime;//结束时间
	
	public String changWeekNo(){
		try {
			Date selectdate = new SimpleDateFormat("yyyy-MM").parse(myYear+"-"+myMonth);
			monthDtoList = ScheduleUtil.weekInMonthList(selectdate);
			monthLoop: for (MonthDto monthDto : monthDtoList) {
				for (WeekDto weekDto : monthDto.getWeekList()) {
					if(myWeek==null){
						month = monthDto;
						week = weekDto;
						break monthLoop;
					}else if(myWeek!=null && weekDto.getWeek().equals(myWeek)){
						month = monthDto;
						week = weekDto;
						break monthLoop;
					}
				}
			}
			sTime = DateUtil.format(week.getDateList().get(0),"yyyy-MM-dd");
			eTime = DateUtil.format(week.getDateList().get(6),"yyyy-MM-dd");
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return JSON;
	}
	
	
	/**
	 * 判断两个日期区间之间是否存在交集
	 * @param dateStart
	 * @param dateEnd
	 * @param taskStartTime
	 * @param taskEndTime
	 * @return
	 * @author ldd
	 */
	public boolean isDateHaveIntersection(Date dateStart,Date dateEnd,Date taskStartTime,Date taskEndTime){
		boolean flag = false;
		if(dateStart.getTime()>=taskStartTime.getTime() && dateStart.getTime()<=taskEndTime.getTime()){
			flag = true;
		}
		if(dateEnd.getTime()>=taskStartTime.getTime() && dateEnd.getTime()<=taskEndTime.getTime()){
			flag = true;
		}
		if(dateStart.getTime()<=taskStartTime.getTime() && dateEnd.getTime()>=taskEndTime.getTime()){
			flag = true;
		}
		if(dateStart.getTime()>=taskStartTime.getTime() && dateEnd.getTime()<=taskStartTime.getTime()){
			flag = true;
		}
		return flag;
	}
	
	/**
	 * 根据查询的条件返回相应的周报任务
	 * 条件:taskReportParam
	 * String	finished:返回本周完成的任务
	 * String	unfinished:返回本周未完成的任务
	 * Date		weekStart:指定开始日期
	 * Date 	endTime:指定结束日期
	 * @return 相应本周任务
	 */
	public String loadTaskForWeekReport(){
		 //以四个日期（周开始、周结束、任务开始时间、任务结束时间）来判断已经完成的Task是否落在这周内，
		 //然后将Task放进Map里面，以第几周作为KEY
		
		Date weekStart = startTime;//周的开始日期
		Date weekEnd = endTime;//周的结束日期
		Map<Integer, List<Task>> finishedTaskMap = 
				new HashMap<Integer, List<Task>>();
		
		//所有已完成的任务的集合
		List<Task> finishedTaskList = 
				taskService.getListByFilter(new Filter(Task.class).eq(
						"receiverId", OaActivator.getSessionUser().getId()).eq(
								"status", TaskStatusEnum.FINISHED)).getValue();
		if(finishedTaskList!=null && finishedTaskList.size()>0){
	    	for (Task task : finishedTaskList) {
				Date  taskStartTime = task.getStartTime();
				Date taskEndTime = task.getEndTime();
				boolean flag = isDateHaveIntersection(
						weekStart, weekEnd, taskStartTime, taskEndTime);
				if(flag){
					if(finishedTaskMap.containsKey(myWeek)){
						finishedTaskMap.get(myWeek).add(task);
					}else{
						List<Task> taskList2 = new ArrayList<Task>();
						taskList2.add(task);
						finishedTaskMap.put(myWeek, taskList2);
					}
				}
				
			}
	    } 
	    
		//将任务分配中的工作取出，在写周报的时候，填充到周报填写页面
        String finishedTask = "";
        String unfinishedTask = "";
        List<Task> taskList3= finishedTaskMap.get(myWeek);
        if(taskList3!=null && taskList3.size()>0){
           for (Task task : taskList3) {
        		   finishedTask += task.getTitle()+"；";
           	}
        }
        Map<Integer, List<Task>> unFinishedTaskMap = 
        		new HashMap<Integer, List<Task>>();
        List<Task> unFinishedTaskList = taskService.getListByFilter(
        		new Filter(Task.class).eq("receiverId", 
        				OaActivator.getSessionUser().getId()).ne("status", 
        						TaskStatusEnum.FINISHED)).getValue();
        if(unFinishedTaskList!=null && unFinishedTaskList.size()>0){
	    	for (Task task : unFinishedTaskList) {
				Date  taskStartTime = task.getStartTime();
				Date taskEndTime = task.getEndTime();
				boolean flag = isDateHaveIntersection(weekStart, weekEnd, taskStartTime, taskEndTime);
				if(flag){
					if(unFinishedTaskMap.containsKey(myWeek)){
						unFinishedTaskMap.get(myWeek).add(task);
					}else{
						List<Task> taskList2 = new ArrayList<Task>();
						taskList2.add(task);
						unFinishedTaskMap.put(myWeek, taskList2);
					}
				}
				
			}
        }
	    List<Task> taskList4= unFinishedTaskMap.get(myWeek);
	    if(taskList4!=null && taskList4.size()>0){
	    	for (Task task : taskList4) {
	    		unfinishedTask += task.getTitle()+"；";
	    	}
	    }
        WeekDto dto = new WeekDto();
        if(taskReportParam.equals("finished")){
        	dto.setFinishedTask(finishedTask);
        }else if(taskReportParam.equals("unfinished")){
        	dto.setUnfinishedTask(unfinishedTask);
        }
        result = Result.value(dto);
		return JSON;
	}
	
	

	/**
	 * 根据查询的条件返回相应的月报任务
	 * 条件:taskReportParam
	 * 		finished:返回本月完成的任务
	 * 		unfinished:返回本月未完成的任务
	 * @return 相应本月任务
	 */
	public String loadTaskForMonthReport(){
		 //以四个日期（月开始日期、月结束日期、任务开始时间、任务结束时间）来判断已经完成的Task是否落在这个月内，
		 //然后将Task放进Map里面，以第几月作为KEY
		
		Date monthStart = startTime;//月的开始日期
		Date monthEnd = endTime;//月的结束日期
		Map<Integer, List<Task>> finishedTaskMap = 
				new HashMap<Integer, List<Task>>();
		List<Task> finishedTaskList = taskService.getListByFilter(new Filter(Task.class).eq("receiverId", OaActivator.getSessionUser().getId()).eq("status", TaskStatusEnum.FINISHED)).getValue();
		if(finishedTaskList!=null && finishedTaskList.size()>0){
	    	for (Task task : finishedTaskList) {
				Date taskStartTime = task.getStartTime();
				Date taskEndTime = task.getEndTime();
				boolean flag = isDateHaveIntersection(monthStart, monthEnd, taskStartTime, taskEndTime);
				if(flag){
					if(finishedTaskMap.containsKey(myMonth)){
						finishedTaskMap.get(myMonth).add(task);
					}else{
						List<Task> taskList2 = new ArrayList<Task>();
						taskList2.add(task);
						finishedTaskMap.put(myMonth, taskList2);
					}
				}
			}
	    } 
	    
	    //将任务分配中的工作取出，在写月报的时候，填充到月报填写页面
        String finishedTask = "";
        String unfinishedTask = "";
        List<Task> taskList3 = finishedTaskMap.get(myMonth);
        if(taskList3!=null && taskList3.size()>0){
	           for (Task task : taskList3) {
	        		   finishedTask += task.getTitle()+"；";
	           	}
        }
        
        //未完成
        Map<Integer, List<Task>> unFinishedTaskMap = 
				new HashMap<Integer, List<Task>>();
        List<Task> unFinishedTaskList = taskService.getListByFilter(new Filter(Task.class).eq("receiverId", OaActivator.getSessionUser().getId()).ne("status", TaskStatusEnum.FINISHED)).getValue();
        if(unFinishedTaskList!=null && unFinishedTaskList.size()>0){
        	for (Task task : unFinishedTaskList) {
        		Date taskStartTime = task.getStartTime();
				Date taskEndTime = task.getEndTime();
				boolean flag = isDateHaveIntersection(monthStart, monthEnd, taskStartTime, taskEndTime);
				if(flag){
					if(unFinishedTaskMap.containsKey(myMonth)){
						unFinishedTaskMap.get(myMonth).add(task);
					}else{
						List<Task> taskList2 = new ArrayList<Task>();
						taskList2.add(task);
						unFinishedTaskMap.put(myMonth, taskList2);
					}
				}
			}
        }
        
        List<Task> taskList4= unFinishedTaskMap.get(myMonth);
	    if(taskList4!=null && taskList4.size()>0){
	    	for (Task task : taskList4) {
	    		unfinishedTask += task.getTitle()+"；";
	    	}
	    }
        WeekDto dto = new WeekDto();
        if(taskReportParam.equals("finished")){
        	dto.setFinishedTask(finishedTask);
        }else if(taskReportParam.equals("unfinished")){
        	dto.setUnfinishedTask(unfinishedTask);
        }
        result = Result.value(dto);
		return JSON;
	}
	public String addDayReport(){
		monthDtoList = ScheduleUtil.weekInMonthList(new Date());
		workReportConfigList = workReportConfigService.getListByFilter(new Filter(WorkReportConfig.class).eq("reporterId",OaActivator.getSessionUser().getId())).getValue();
		
		monthLoop: for (MonthDto monthDto : monthDtoList) {
			myWeek = 0;
			for (WeekDto weekDto : monthDto.getWeekList()) {
				myWeek++;
				for (Date date : weekDto.getDateList()) {
					if (CalendarUtil.getEarliest(date, Calendar.DAY_OF_MONTH).getTime() == CalendarUtil.getEarliest(new Date(), Calendar.DAY_OF_MONTH).getTime()) {
						month = monthDto;
						week = weekDto;
						break monthLoop;
					}
				}
			}
		}
		
		return "addDayReport";
	}
	
	public String myWorkReportList(){
		year = Integer.parseInt(DateUtil.format(new Date(),"yyyy"));
		myMonth = Calendar.getInstance().get(Calendar.MONTH)+1; 
		myWeek = Calendar.getInstance().get(Calendar.WEEK_OF_YEAR); 
		//result = Result.value(workReportService.getWorkReportlList(myWeek,myMonth,year).getValue());
		WorkReportDto dto =  (WorkReportDto) workDayReportService.getWorkReportlList(myWeek,myMonth,year).getValue();
		Date preDay = CalendarUtil.add(new Date(), Calendar.DATE, -2).getTime();
		Date nextDay = CalendarUtil.add(new Date(), Calendar.DATE, 2).getTime();
		Integer dayCount = 0;
		List<WorkDayReport> list = workDayReportService.getListByFilter(new Filter(WorkDayReport.class).eq("status", WorkReportStatusEnum.REPORTED).between("modifyTime", preDay, nextDay)).getValue();
		if(list.size()>0 && list!=null){
			for(WorkDayReport wdr : list){
				if(wdr.getReceiver()!=null){
				for(String receiver : wdr.getReceiver().split(",")){
					if(receiver.equals(OaActivator.getSessionUser().getRealName())){
						dayCount++;
					}
				}
				}
			}
		}
		dto.setDayCount(dayCount);
		result = Result.value(dto);
		return "myWorkReportList";
	}
	
	public String addWeekReport(){
		// 根据当前时间找到对应的时间段(年月周)
		if(dateStr!=null){
			SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
			try {
				date = fmt.parse(dateStr);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}else{
			date = new Date();
		}
		monthDtoList = ScheduleUtil.generateMonthWeekList();
		monthLoop: for (MonthDto monthDto : monthDtoList) {
			for (WeekDto weekDto : monthDto.getWeekList()) {
				for (Date date : weekDto.getDateList()) {
					if (CalendarUtil.getEarliest(date, Calendar.DAY_OF_MONTH).getTime() == CalendarUtil.getEarliest(new Date(), Calendar.DAY_OF_MONTH).getTime()) {
						month = monthDto;
						week = weekDto;
						break monthLoop;
					}
				}
			}
		}
		List<WorkDayReport> workDayReportList = workDayReportService.getListByFilter(new Filter(WorkDayReport.class).notNull("dayNo").eq("reporterId", OaActivator.getSessionUser().getId()).eq("weekNo", week.getWeek()).eq("yearNo", month.getYear()).eq("status", WorkReportStatusEnum.REPORTED)).getValue();
		if(workDayReportList.size()>0 && workDayReportList!=null){
			List<WorkDayDto> workDayDtoList = new ArrayList<WorkDayDto>();
			for (WorkDayReport wdr : workDayReportList) {
				s:for(int i= 0;i<wdr.getContent().split("`_`").length;i++){
					WorkDayDto dto = new WorkDayDto();
					String c = wdr.getContent().split("`_`")[i];
					if(c.equals("null"))
						continue s;
					dto.setTitle(c);
					dto.setStatus(wdr.getProcessStr().split("`_`")[i]);
					workDayDtoList.add(dto);
				}
			}
			ServletActionContext.getRequest().setAttribute("workDayDtoList", workDayDtoList);
		}
		workReportConfigList = workReportConfigService.getListByFilter(
				new Filter(WorkReportConfig.class).eq("reporterId",OaActivator.getSessionUser().getId())).getValue();
		/*WorkDayReport workDayReport = workDayReportService.getBeanByFilter(new Filter(WorkDayReport.class).isNull("dayNo").eq("reporterId", OaActivator.getSessionUser().getId()).eq("weekNo", week.getWeek()).eq("yearNo", month.getYear())).getValue();*/
		/*if (workDayReport==null) {*/
			return "addWeekReport";
		/*} else {
			List<WorkDayDto> dtoList = new ArrayList<WorkDayDto>();
			if(workDayReport.getContent()!=null){
			s:for(int i= 0;i<workDayReport.getContent().split("`_`").length;i++){
				WorkDayDto dto = new WorkDayDto();
				String c = workDayReport.getContent().split("`_`")[i];
				if(c.equals("null"))
					continue s;
				dto.setTitle(c);
				dto.setStatus(workDayReport.getProcessStr().split("`_`")[i]);
				dtoList.add(dto);
			}
			}
			List<WorkDayDto> playList = new ArrayList<WorkDayDto>();
			if(workDayReport.getPlayContent().split("`_`").length>0 && workDayReport.getPlayContent().split("`_`")!=null){
				s2:for(int j= 0;j<workDayReport.getPlayContent().split("`_`").length;j++){
					WorkDayDto dto = new WorkDayDto();
					String c = workDayReport.getPlayContent().split("`_`")[j];
					if(c.equals("null"))
						continue s2;
					dto.setTitle(c);
					playList.add(dto);
				}
			}
			ServletActionContext.getRequest().setAttribute("playList", playList);
			ServletActionContext.getRequest().setAttribute("dtoList", dtoList);
			ServletActionContext.getRequest().setAttribute("workDayReport", workDayReport);
			String re = "";
			if(workDayReport.getStatus().equals(WorkReportStatusEnum.TEMPORARY)){
				re = "editWeek";
			}else if(workDayReport.getStatus().equals(WorkReportStatusEnum.REPORTED)){
				re =  "viewByWeek";
			}
			return re;
		}*/
	}

	public String addMonthReport() {
		// 根据当前时间找到对应的时间段(年月周)
		monthDtoList = ScheduleUtil.generateMonthWeekList();
		monthLoop: for (MonthDto monthDto : monthDtoList) {
			for (WeekDto weekDto : monthDto.getWeekList()) {
				for (Date date : weekDto.getDateList()) {
					if (CalendarUtil.getEarliest(date, Calendar.DAY_OF_MONTH).getTime() == CalendarUtil.getEarliest(new Date(), Calendar.DAY_OF_MONTH).getTime()) {
						month = monthDto;
						week = weekDto;
						startTime = CalendarUtil.getEarliest(date,Calendar.MONTH);
						Date end = CalendarUtil.add(date, Calendar.MONTH, 1).getTime();
						endTime = CalendarUtil.getEarliest(end, Calendar.MONTH);
						break monthLoop;
					}
				}
			}
		}
		List<WorkDayReport> workDayReportList = workDayReportService.getListByFilter(new Filter(WorkDayReport.class).isNull("dayNo").notNull("weekNo").eq("reporterId", OaActivator.getSessionUser().getId()).eq("monthNo", month.getMonth()).eq("yearNo", month.getYear()).eq("status", WorkReportStatusEnum.REPORTED)).getValue();
		if(workDayReportList.size()>0 && workDayReportList!=null){
			List<WorkDayDto> workDayDtoList = new ArrayList<WorkDayDto>();
			for (WorkDayReport wdr : workDayReportList) {
				s:for(int i= 0;i<wdr.getContent().split("`_`").length;i++){
					WorkDayDto dto = new WorkDayDto();
					String c = wdr.getContent().split("`_`")[i];
					if(c.equals("null"))
						continue s;
					dto.setTitle(c);
					dto.setStatus(wdr.getProcessStr().split("`_`")[i]);
					workDayDtoList.add(dto);
				}
			}
			ServletActionContext.getRequest().setAttribute("workDayDtoList", workDayDtoList);
		}
		
		
		workReportConfigList = workReportConfigService.getListByFilter(new Filter(WorkReportConfig.class).eq("reporterId",OaActivator.getSessionUser().getId())).getValue();
		WorkDayReport workDayReport = workDayReportService.getBeanByFilter(new Filter(WorkDayReport.class).isNull("dayNo").isNull("weekNo").eq("reporterId", OaActivator.getSessionUser().getId()).eq("monthNo", month.getMonth()).eq("yearNo", month.getYear())).getValue();
		if (workDayReport==null) {
			return "addMonthReport";
		} else {
			List<WorkDayDto> dtoList = new ArrayList<WorkDayDto>();
			if(workDayReport.getContent()!=null){
			s:for(int i= 0;i<workDayReport.getContent().split("`_`").length;i++){
				WorkDayDto dto = new WorkDayDto();
				String c = workDayReport.getContent().split("`_`")[i];
				if(c.equals("null"))
					continue s;
				dto.setTitle(c);
				dto.setStatus(workDayReport.getProcessStr().split("`_`")[i]);
				dtoList.add(dto);
			}
			}
			List<WorkDayDto> playList = new ArrayList<WorkDayDto>();
			if(workDayReport.getPlayContent().split("`_`").length>0 && workDayReport.getPlayContent().split("`_`")!=null){
				s2:for(int j= 0;j<workDayReport.getPlayContent().split("`_`").length;j++){
					WorkDayDto dto = new WorkDayDto();
					String c = workDayReport.getPlayContent().split("`_`")[j];
					if(c.equals("null"))
						continue s2;
					dto.setTitle(c);
					playList.add(dto);
				}
			}
			ServletActionContext.getRequest().setAttribute("playList", playList);
			ServletActionContext.getRequest().setAttribute("dtoList", dtoList);
			ServletActionContext.getRequest().setAttribute("workDayReport", workDayReport);
		
			monthDtoList = ScheduleUtil.generateMonthWeekList();
			
			String re = "";
			if(workDayReport.getStatus().equals(WorkReportStatusEnum.TEMPORARY)){
				re = "editMonth";
			}else if(workDayReport.getStatus().equals(WorkReportStatusEnum.REPORTED)){
				re =  "viewByMonth";
			}
			return re;
		}
	}

	 public String addByMonth()
	  {
	    String str = this.curYear + "-10";
	    SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM");
	    try {
	      Date dateYear = fmt.parse(str);
	      monthDtoList = ScheduleUtil.generateMonthWeekList(dateYear);
	    } catch (ParseException e) {
	      e.printStackTrace();
	    }
	    
	    workReportConfigList = workReportConfigService.getListByFilter(new Filter(WorkReportConfig.class).eq("reporterId", OaActivator.getSessionUser().getId())).getValue();
	    for (MonthDto monthDto : monthDtoList) {
	      for (WeekDto weekDto : monthDto.getWeekList()) {
	        if (monthDto.getMonth() == myMonth) {
	          month = monthDto;
	          week = weekDto;
	          for (Date date : weekDto.getDateList()) {
	            startTime = CalendarUtil.getEarliest(date, 
	              2);
	            Date end = CalendarUtil.add(date, 2, 1)
	              .getTime();
	            endTime = CalendarUtil.getEarliest(end, 2);
	          }
	          break;
	        }
	      }
	    }
	    return "addMonthReport";
	  }

	  public String addByWeek()
	  {
	    String str = curYear + "-10";
	    SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM");
	    try {
	      Date dateYear = fmt.parse(str);
	       monthDtoList = ScheduleUtil.generateMonthWeekList(dateYear);
	    } catch (ParseException e) {
	      e.printStackTrace();
	    }
	    
		workReportConfigList = workReportConfigService.getListByFilter(new Filter(WorkReportConfig.class).eq("reporterId", OaActivator.getSessionUser().getId())).getValue();
	    for (MonthDto monthDto :  monthDtoList) {
	      for (WeekDto weekDto : monthDto.getWeekList()) {
	        if (weekDto.getWeek() ==  myWeek) {
	           month = monthDto;
	           week = weekDto;
	          break;
	        }
	      }
	    }
	    return "addWeekReport";
	  }

	  public String editByMonth() {
	     flag = Boolean.valueOf(false);
	     workReport = 
	      ((WorkReport) workReportService.getBeanByFilter(
	      new Filter(WorkReport.class).eq("monthNo",  myMonth)
	      .isNull("weekNo").eq("yearNo",  curYear).eq(
	      "reporterId", OaActivator.getSessionUser().getId()))
	      .getValue());
	     workReportConfigList = workReportConfigService.getListByFilter(new Filter(WorkReportConfig.class).eq("reporterId", OaActivator.getSessionUser().getId())).getValue();
	    String str =  curYear + "-10";
	    SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM");
	    try {
	      Date dateYear = fmt.parse(str);
	       monthDtoList = ScheduleUtil.generateMonthWeekList(dateYear);
	    } catch (ParseException e) {
	      e.printStackTrace();
	    }
	    for (MonthDto monthDto :  monthDtoList) {
	      for (WeekDto weekDto : monthDto.getWeekList()) {
	        if (monthDto.getMonth() ==  myMonth) {
	           month = monthDto;
	           week = weekDto;
	          for (Date date : weekDto.getDateList()) {
	             startTime = CalendarUtil.getEarliest(date, 
	              2);
	            Date end = CalendarUtil.add(date, 2, 1)
	              .getTime();
	             endTime = CalendarUtil.getEarliest(end, 2);
	          }
	          break;
	        }
	      }
	    }
	    return "editMonth";
	  }

	  public String editByWeek() {
	     flag = Boolean.valueOf(false);
	     workReport = 
	      ((WorkReport) workReportService.getBeanByFilter(
	      new Filter(WorkReport.class).eq("weekNo",  myWeek)
	      .eq("yearNo",  curYear).eq("reporterId", 
	      OaActivator.getSessionUser().getId())).getValue());

	    String str =  curYear + "-10";
	    SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM");
	    try {
	      Date dateYear = fmt.parse(str);
	       monthDtoList = ScheduleUtil.generateMonthWeekList(dateYear);
	    } catch (ParseException e) {
	      e.printStackTrace();
	    }
	    for (MonthDto monthDto :  monthDtoList) {
	      for (WeekDto weekDto : monthDto.getWeekList()) {
	        if (weekDto.getWeek() ==  myWeek) {
	           month = monthDto;
	           week = weekDto;
	          break;
	        }
	      }
	    }
	    return "editWeek";
	  }

	public String save() {
		if(workReport.getWeekNo()!=null){
			WorkReport workWeekReport = workReportService.getBeanByFilter(new Filter(WorkReport.class).eq("reporterId", OaActivator.getSessionUser().getId()).eq("weekNo", workReport.getWeekNo()).eq("yearNo", workReport.getYearNo())).getValue();
			if(workWeekReport!=null){
				result = Result.failure("你已经对本周周报进行过操作");
				return JSON;
			}
		}else{
			WorkReport workMonthReport = workReportService.getBeanByFilter(new Filter(WorkReport.class).eq("reporterId", OaActivator.getSessionUser().getId()).eq("monthNo", workReport.getMonthNo()).eq("yearNo", workReport.getYearNo())).getValue();
			if(workMonthReport!=null){
				result = Result.failure("你已经对本月月报进行过操作");
				return JSON;
			}
		}
		result = workReportService.save(workReport);
		return JSON;
	}

	public String update() {
		WorkReport dbBean = workReportService.getBeanById(workReport.getId()).getValue();
		BeanUtil.copyProperties(workReport, dbBean);
		result = workReportService.update(dbBean);
		return JSON;
	}

	public String list(){
		monthDtos = new ArrayList<MonthDto>();
		// 显示年份列表,判断前一年和后一年传递的参数是否为空
		if (myYear != null) {
			try {
				Date dateYear = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(myYear);
				monthDtoList = ScheduleUtil.weekInMonthList(dateYear);
				prevYear = CalendarUtil.add(dateYear, Calendar.YEAR, -1).getTime();
				nextYear = CalendarUtil.add(dateYear, Calendar.YEAR, 1).getTime();
				prevMonth = CalendarUtil.add(dateYear, Calendar.MONTH, -1).getTime();
				nextMonth = CalendarUtil.add(dateYear, Calendar.MONTH, 1).getTime();
				Integer intYear = Integer.parseInt(DateUtil.format(dateYear,"yyyy"));
				Integer intMonth = Integer.parseInt(DateUtil.format(dateYear,"MM"));
				if(1==intMonth){
					Integer[] lastyears = new Integer[]{intYear,intYear-1};
					workDayReportList = workDayReportService.getListByFilter(new Filter(WorkDayReport.class).in("yearNo", lastyears).eq("reporterId",OaActivator.getSessionUser().getId())).getValue();
				}else if(12==intMonth){
					Integer[] lastyears = new Integer[]{intYear,intYear+1};
					workDayReportList = workDayReportService.getListByFilter(new Filter(WorkDayReport.class).in("yearNo", lastyears).eq("reporterId",OaActivator.getSessionUser().getId())).getValue();
				}else{
					workDayReportList = workDayReportService.getListByFilter(new Filter(WorkDayReport.class).eq("yearNo", intYear).eq("reporterId",OaActivator.getSessionUser().getId())).getValue();
				}
				
				workReportList = workReportService.getListByFilter(new Filter(WorkReport.class).eq("monthNo", intMonth).eq("yearNo", intYear).eq("reporterId",OaActivator.getSessionUser().getId())).getValue();
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}else if(selectMonth!=null){
			Date dateMonth = null;
			try {
				dateMonth = new SimpleDateFormat("yyyy-MM").parse(selectMonth);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			monthDtoList = ScheduleUtil.weekInMonthList(dateMonth);
			prevYear = CalendarUtil.add(dateMonth, Calendar.YEAR, -1).getTime();
			nextYear = CalendarUtil.add(dateMonth, Calendar.YEAR, 1).getTime();
			prevMonth = CalendarUtil.add(dateMonth, Calendar.MONTH, -1).getTime();
			nextMonth = CalendarUtil.add(dateMonth, Calendar.MONTH, 1).getTime();
			Integer intYear = Integer.parseInt(DateUtil.format(dateMonth,"yyyy"));
			Integer intMonth = Integer.parseInt(DateUtil.format(dateMonth,"M"));
			if(1==intMonth){
				Integer[] lastyears = new Integer[]{intYear,intYear-1};
				workDayReportList = workDayReportService.getListByFilter(new Filter(WorkDayReport.class).in("yearNo", lastyears).eq("reporterId",OaActivator.getSessionUser().getId())).getValue();
			}else if(12==intMonth){
				Integer[] lastyears = new Integer[]{intYear,intYear+1};
				workDayReportList = workDayReportService.getListByFilter(new Filter(WorkDayReport.class).in("yearNo", lastyears).eq("reporterId",OaActivator.getSessionUser().getId())).getValue();
			}else{
				workDayReportList = workDayReportService.getListByFilter(new Filter(WorkDayReport.class).eq("yearNo", intYear).eq("reporterId",OaActivator.getSessionUser().getId())).getValue();
			}
			
			workReportList = workReportService.getListByFilter(new Filter(WorkReport.class).eq("monthNo", intMonth).eq("yearNo", intYear).eq("reporterId",OaActivator.getSessionUser().getId())).getValue();
		}else {
			monthDtoList = ScheduleUtil.weekInMonthList(new Date());
			prevYear = CalendarUtil.add(new Date(), Calendar.YEAR, -1).getTime();
			nextYear = CalendarUtil.add(new Date(), Calendar.YEAR, 1).getTime();
			prevMonth = CalendarUtil.add(new Date(), Calendar.MONTH, -1).getTime();
			nextMonth = CalendarUtil.add(new Date(), Calendar.MONTH, 1).getTime();
			Integer intYear = Integer.parseInt(DateUtil.format(new Date(),"yyyy"));
			Integer intMonth = Integer.parseInt(DateUtil.format(new Date(),"MM"));
			if(1==intMonth){
				Integer[] lastyears = new Integer[]{intYear,intYear-1};
				workDayReportList = workDayReportService.getListByFilter(new Filter(WorkDayReport.class).in("yearNo", lastyears).eq("reporterId",OaActivator.getSessionUser().getId())).getValue();
			}else if(12==intMonth){
				Integer[] lastyears = new Integer[]{intYear,intYear+1};
				workDayReportList = workDayReportService.getListByFilter(new Filter(WorkDayReport.class).in("yearNo", lastyears).eq("reporterId",OaActivator.getSessionUser().getId())).getValue();
			}else{
				workDayReportList = workDayReportService.getListByFilter(new Filter(WorkDayReport.class).eq("yearNo", intYear).eq("reporterId",OaActivator.getSessionUser().getId())).getValue();
			}
			workReportList = workReportService.getListByFilter(new Filter(WorkReport.class).eq("monthNo", intMonth).eq("yearNo", intYear).eq("reporterId",OaActivator.getSessionUser().getId())).getValue();
		}
		// 根据日期来作为KEY来获取日报
		Map<Date, WorkDayReport> map = new HashMap<Date, WorkDayReport>();
		if(workDayReportList!=null && workDayReportList.size()>0){
			for (WorkDayReport workDayReport : workDayReportList) {
				if(workDayReport.getMonthNo()!=null && workDayReport.getDayNo()!=null){
					map.put(workDayReport.getCurDate(), workDayReport);
				}
			}
		}
		//根据周作为KEY来获取周报
		Map<Integer, WorkReport> map2 = new HashMap<Integer, WorkReport>();
		if(workReportList!=null && workReportList.size()>0){
			for (WorkReport workReport : workReportList) {
				if(workReport.getMonthNo()!=null && workReport.getWeekNo()!=null){
					map2.put(workReport.getWeekNo(), workReport);
				}
			}
		}
		//根据月份作为KEY来获取月报
				Map<Integer, WorkReport> map3 = new HashMap<Integer, WorkReport>();
				if(workReportList!=null && workReportList.size()>0){
					for (WorkReport workReport : workReportList) {
						if(workReport.getMonthNo()!=null && workReport.getWeekNo()==null){
							map3.put(workReport.getMonthNo(), workReport);
						}
					}
				}
		for (MonthDto monthDto : monthDtoList) {
			year = monthDto.getYear();
			myMonth = monthDto.getMonth();
			List<WeekDto> weekDtoList = monthDto.getWeekList();
			List<WeekDto> weekDtos = new ArrayList<WeekDto>();
			for (WeekDto weekDto : weekDtoList) {
				List<Date> dayList  = weekDto.getDateList();
				List<WorkDayDto> workDayDtos = new ArrayList<WorkDayDto>();
				for (Date date : dayList) {
					//日报
					WorkDayDto workDayDto = new WorkDayDto();
					workDayDto.setDate(date);
					WorkDayReport workDayReport = map.get(date);
					if(workDayReport!=null && workDayReport.getStatus().equals(WorkReportStatusEnum.REPORTED)){// 0:未编辑       1:暂存      2:提交
						workDayDto.setNum(2);
					}else if(workDayReport!=null && workDayReport.getStatus().equals(WorkReportStatusEnum.TEMPORARY)){
						workDayDto.setNum(1);
					}else{
						workDayDto.setNum(0);
					}
					workDayDtos.add(workDayDto);
				}
					//周报
				WorkReport workReportWeek = map2.get(weekDto.getWeek());
				WeekDto weekDto2 = new WeekDto();
				if(workReportWeek!= null && workReportWeek.getStatus().equals(WorkReportStatusEnum.REPORTED)){
					weekDto2.setNum(2);
				}
				if(workReportWeek!= null && workReportWeek.getStatus().equals(WorkReportStatusEnum.TEMPORARY)){
					weekDto2.setNum(1);
				}
				weekDto2.setWeek(weekDto.getWeek());
				weekDto2.setWorkDayDtoList(workDayDtos);
				weekDtos.add(weekDto2);
			}
				//月报
			WorkReport workReportWeek = map3.get(monthDto.getMonth());
			MonthDto monthDto2 = new MonthDto();
			if(workReportWeek!= null && workReportWeek.getStatus().equals(WorkReportStatusEnum.REPORTED)){
				monthDto2.setNum(2);
			}
			if(workReportWeek!= null && workReportWeek.getStatus().equals(WorkReportStatusEnum.TEMPORARY)){
				monthDto2.setNum(1);
			}
			monthDto2.setYear(year);
			monthDto2.setMonth(myMonth);
			monthDto2.setWeekList(weekDtos);
			monthDtos.add(monthDto2);
		}
		// 将WorkReportConfig表中的数据取出，以便获取receiveId
		List<WorkReportConfig> reporterList = workReportConfigService.getList().getValue();
		workReportReceiverIds = "";
		if (reporterList != null) {
			for (WorkReportConfig workReportConfig : reporterList) {//87985585 8008
				// 先判断表中的报送人是否与当前登陆人为同一人，若是，则将取出的receiveId拼接成一个字符串传回给页面
				if ((OaActivator.getSessionUser().getId()).equals(workReportConfig.getReporterId())) {
					workReportReceiverIds += ("," + workReportConfig.getReceiverId());
				}
			}
		}
		//workReport用于页面判断当前周的周报是否已提交或暂存
		//workReport2用于页面判断当前月的月报是否已提交或暂存
		Calendar calendar = Calendar.getInstance();
		calendar.setFirstDayOfWeek(Calendar.MONDAY);
		calendar.setTime(new Date());
		int weekNum = calendar.get(Calendar.WEEK_OF_YEAR);
		int monthNum = calendar.get(Calendar.MONTH);
		int yearNum = calendar.get(Calendar.YEAR);
		workReport = workReportService.getBeanByFilter(new Filter(WorkReport.class).eq("reporterId",OaActivator.getSessionUser().getId()).eq("yearNo", yearNum).eq("weekNo", weekNum).eq("type", WorkReportEnum.WEEK)).getValue();
		workReport2 = workReportService.getBeanByFilter(new Filter(WorkReport.class).eq("reporterId",OaActivator.getSessionUser().getId()).eq("yearNo", yearNum).eq("monthNo", monthNum+1).eq("type", WorkReportEnum.MONTH)).getValue();
		return LIST;
	}
	
	//部门周报汇总
	public String depWeekCountList(){
		Date date = null;
		if (myYear != null) {
			try {
				date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(myYear);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		} else {
			date = new Date();
		}
		monthDtoList = ScheduleUtil.generateMonthWeekList(date);
		prevYear = CalendarUtil.add(date, Calendar.YEAR, -1).getTime();
		nextYear = CalendarUtil.add(date, Calendar.YEAR, 1).getTime();
		year = Integer.parseInt(DateUtil.format(date,"yyyy"));
		// 获取指定年份所有已经提交的周报
		List<TaskDepart> taskDeparts = departService.getListByFilter(new Filter(TaskDepart.class)).getValue();
		workCountDtoList = new ArrayList<WorkCountDto>();
		String orgIds = ",";
		for(TaskDepart taskDepart : taskDeparts){
			if(taskDepart.getOrgId()!=null){
				orgIds += taskDepart.getOrgId()+",";
			}
		}
		Filter filter = new Filter(WorkReport.class);
		filter.eq("yearNo", year).notNull("weekNo").eq("type", WorkReportEnum.WEEK).eq("status", WorkReportStatusEnum.REPORTED);
		workReportList = workReportService.getListByFilter(filter).getValue();
		Map<String, WorkReport> workMap = new HashMap<String, WorkReport>();
		for (WorkReport workReport : workReportList) {
			if(workReport.getReporter().getOrg()!=null){
				if(orgIds.contains(","+workReport.getReporter().getOrg().getId()+",")){
					String dateStr = workReport.getYearNo()+"_"+workReport.getWeekNo();
					String userKey = dateStr;
					workMap.put(userKey, workReport);
				}
			}
		}
		for(TaskDepart taskDepart : taskDeparts){
			WorkCountDto dto = new  WorkCountDto();
			dto.setUsername(taskDepart.getName());
			List<MonthDto> newMonthList = new ArrayList<MonthDto>();
			for(MonthDto mdto : monthDtoList){
				MonthDto newMonthDto = new MonthDto();
				List<WeekDto> weekDtoList = new ArrayList<WeekDto>();
				for(WeekDto weekDto : mdto.getWeekList()){
					String weekNo = mdto.getYear()+"_"+weekDto.getWeek();
					WeekDto newWeekDto = new WeekDto();
					if(taskDepart.getOrgId()==null){
						newWeekDto.setNum(0);
					}else{
						if(workMap.get(weekNo)!=null && workMap.get(weekNo).getReporter().getOrg().getId().equals(taskDepart.getOrgId())){
							newWeekDto.setNum(1);
							dto.setId(taskDepart.getOrgId());
						}else{
							newWeekDto.setNum(0);
						}
					}
					newWeekDto.setWeek(weekDto.getWeek());
					weekDtoList.add(newWeekDto);
				}
				BeanUtil.copyProperties(mdto, newMonthDto);
				newMonthDto.setWeekList(weekDtoList);
				newMonthList.add(newMonthDto);
			}
			dto.setMonthDtoList(newMonthList);
			workCountDtoList.add(dto);
		}
		return "depWeekCountList";
	}
	
	//部门月报汇总
	public String depMonthCountList(){
		Date date = null;
		if (myYear != null) {
			try {
				date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(myYear);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		} else {
			date = new Date();
		}
		monthDtoList = ScheduleUtil.generateMonthWeekList(date);
		prevYear = CalendarUtil.add(date, Calendar.YEAR, -1).getTime();
		nextYear = CalendarUtil.add(date, Calendar.YEAR, 1).getTime();
		year = Integer.parseInt(DateUtil.format(date,"yyyy"));
		// 获取当前年份所有已经提交的月报
		List<TaskDepart> taskDeparts = departService.getListByFilter(new Filter(TaskDepart.class)).getValue();
		workCountDtoList = new ArrayList<WorkCountDto>();
		String orgIds = ",";
		for(TaskDepart taskDepart : taskDeparts){
			if(taskDepart.getOrgId()!=null){
				orgIds += taskDepart.getOrgId()+",";
			}
		}
		workReportList = workReportService.getListByFilter(new Filter(WorkReport.class).eq("yearNo", year).notNull("monthNo").eq("type", WorkReportEnum.MONTH).eq("status", WorkReportStatusEnum.REPORTED)).getValue();
		Map<String, WorkReport> workMap = new HashMap<String, WorkReport>();
		for (WorkReport workReport : workReportList) {
			if(workReport.getReporter().getOrg()!=null){
				if(orgIds.contains(","+workReport.getReporter().getOrg().getId()+",")){
					String dateStr = workReport.getYearNo()+"_"+workReport.getMonthNo();
					String userKey = dateStr;
					workMap.put(userKey, workReport);
				}
			}
		}
		for(TaskDepart taskDepart : taskDeparts){
			WorkCountDto dto = new  WorkCountDto();
			dto.setUsername(taskDepart.getName());
			List<MonthDto> newMonthList = new ArrayList<MonthDto>();
			for(MonthDto mdto : monthDtoList){
				MonthDto newMonthDto = new MonthDto();
				String monthStr = mdto.getYear()+"_"+mdto.getMonth();
				if(taskDepart.getOrgId()==null){
					newMonthDto.setNum(0);
				}else{
					if(workMap.get(monthStr)!=null && workMap.get(monthStr).getReporter().getOrg().getId().equals(taskDepart.getOrgId())){
						newMonthDto.setNum(1);
						dto.setId(taskDepart.getOrgId());
					}else{
						newMonthDto.setNum(0);
					}
				}
				newMonthDto.setMonth(mdto.getMonth());
				newMonthList.add(newMonthDto);
			}
			dto.setMonthDtoList(newMonthList);
			workCountDtoList.add(dto);
		}
		
		return "depMonthCountList";
	}
	
	//查看部门周报
	public String viewDepWeek(){
		List<WorkReport> workReportList = workReportService.getListByFilter(new Filter(WorkReport.class).eq("yearNo", curYear).notNull("weekNo").eq("type", WorkReportEnum.WEEK).eq("status", WorkReportStatusEnum.REPORTED)).getValue();
		List<WorkReport> workReportsInOrg = new ArrayList<WorkReport>();
		
		OrgPubService orgPubService=OaActivator.getService(OrgPubService.class);
		List<Org> orgList = orgPubService.getOrgList();
		Map<Long,String> orgMap = new HashMap<Long, String>();
		for (WorkReport workReport : workReportList) {
			Long orgId = workReport.getReporter().getOrg().getId();
			if(orgId.equals(id) && workReport.getWeekNo().equals(myWeek)){
				workReportsInOrg.add(workReport);
			}
		}
		for(Org org : orgList){
			orgMap.put(org.getId(), org.getName());
		}
		String depName = orgMap.get(id);
		ServletActionContext.getRequest().setAttribute("depName", depName);
		ServletActionContext.getRequest().setAttribute("workReportList", workReportsInOrg);
		
		//周报日期段（处于哪两个日期之间）
		String str = curYear+"-10";
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM");
		Date dateYear = null;
		try {
			dateYear = fmt.parse(str);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		monthDtoList = ScheduleUtil.generateMonthWeekList(dateYear);
		for(MonthDto mdto : monthDtoList){
			for(WeekDto dto : mdto.getWeekList()){
				if(dto.getWeek().equals(myWeek)){
					ServletActionContext.getRequest().setAttribute("dateList", dto.getDateList());
				}
			}
		}
		return "viewDepWeek";
	}
	
	//查看部门月报
	public String viewDepMonth(){
		List<WorkReport> workReportList = workReportService.getListByFilter(new Filter(WorkReport.class).eq("yearNo", curYear).notNull("monthNo").eq("type", WorkReportEnum.MONTH).eq("status", WorkReportStatusEnum.REPORTED)).getValue();
		List<WorkReport> workReportsInOrg = new ArrayList<WorkReport>();
		
		OrgPubService orgPubService=OaActivator.getService(OrgPubService.class);
		List<Org> orgList = orgPubService.getOrgList();
		Map<Long,String> orgMap = new HashMap<Long, String>();
		for (WorkReport workReport : workReportList) {
			Long orgId = workReport.getReporter().getOrg().getId();
			if(orgId.equals(id) && workReport.getMonthNo().equals(myMonth)){
				workReportsInOrg.add(workReport);
			}
		}
		for(Org org : orgList){
			orgMap.put(org.getId(), org.getName());
		}
		String depName = orgMap.get(id);
		ServletActionContext.getRequest().setAttribute("depName", depName);
		ServletActionContext.getRequest().setAttribute("workReportList", workReportsInOrg);
		return "viewDepMonth";
	}

	public String viewByMonth() {
	    if ( id == null)
	       workReport = 
	        ((WorkReport) workReportService.getBeanByFilter(
	        new Filter(WorkReport.class).eq("monthNo",  myMonth)
	        .isNull("weekNo").eq("yearNo",  curYear).eq("reporterId", OaActivator.getSessionUser().getId())).getValue());
	    else {
	       workReport = ((WorkReport) workReportService.getBeanByFilter(new Filter(WorkReport.class).eq("monthNo",  myMonth).isNull("weekNo").eq("yearNo",  curYear).eq("reporterId",  id)).getValue());
	    }

	    String str =  curYear + "-10";
	    SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM");
	    try {
	      Date dateYear = fmt.parse(str);
	       monthDtoList = ScheduleUtil.generateMonthWeekList(dateYear);
	    } catch (ParseException e) {
	      e.printStackTrace();
	    }
	    for (MonthDto monthDto :  monthDtoList) {
	      for (WeekDto weekDto : monthDto.getWeekList()) {
	        if (monthDto.getMonth() ==  myMonth) {
	           month = monthDto;
	           week = weekDto;
	          for (Date date : weekDto.getDateList()) {
	             startTime = CalendarUtil.getEarliest(date, 
	              2);
	            Date end = CalendarUtil.add(date, 2, 1)
	              .getTime();
	             endTime = CalendarUtil.getEarliest(end, 2);
	          }
	          break;
	        }
	      }
	    }
	    return "viewByMonth";
	  }

	  public String viewByWeek() {
	    if ( id == null)
	       workReport = 
	        ((WorkReport) workReportService.getBeanByFilter(
	        new Filter(WorkReport.class).eq("weekNo",  myWeek)
	        .eq("yearNo",  curYear).eq("reporterId", 
	        OaActivator.getSessionUser().getId())).getValue());
	    else {
	       workReport = 
	        ((WorkReport) workReportService.getBeanByFilter(
	        new Filter(WorkReport.class).eq("weekNo",  myWeek)
	        .eq("yearNo",  curYear).eq("reporterId",  id)).getValue());
	    }

	    String str =  curYear + "-10";
	    SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM");
	    try {
	      Date dateYear = fmt.parse(str);
	       monthDtoList = ScheduleUtil.generateMonthWeekList(dateYear);
	    } catch (ParseException e) {
	      e.printStackTrace();
	    }
	    for (MonthDto monthDto :  monthDtoList) {
	      for (WeekDto weekDto : monthDto.getWeekList()) {
	        if (weekDto.getWeek() ==  myWeek) {
	           month = monthDto;
	           week = weekDto;
	          break;
	        }
	      }
	    }
	    return "viewByWeek";
	  }
	
	public String viewByReportId(){
		return "";
	}

	public String configMonthReport() {
		// 获取本月的月报信息
		Date smonth = CalendarUtil.add(new Date(), Calendar.MONTH, 0).getTime();
		Integer confMonth = Integer.parseInt(DateUtil.format(smonth, "MM"));
		Integer confYear = Integer.parseInt(DateUtil.format(new Date(), "yyyy"));
		workReport = workReportService.getBeanByFilter(new Filter(WorkReport.class).eq("monthNo", confMonth).eq("yearNo", confYear).isNull("weekNo").eq("reporterId",OaActivator.getSessionUser().getId())).getValue();
		// 取出当前年份的1-12月月份数据
		monthDtoList = ScheduleUtil.generateMonthWeekList();
		monthLoop: for (MonthDto monthDto : monthDtoList) {
			// 取周数据
			for (WeekDto weekDto : monthDto.getWeekList()) {
				if (monthDto.getMonth() == confMonth) {
					month = monthDto;
					week = weekDto;
					for (Date date : weekDto.getDateList()) {
						startTime = CalendarUtil.getEarliest(date,Calendar.MONTH);
						Date end = CalendarUtil.add(date, Calendar.MONTH, 1).getTime();
						endTime = CalendarUtil.getEarliest(end, Calendar.MONTH);
					}
					break monthLoop;
				}
			}
		}
		return "configMonthReport";
	}

	public String configWeekReport() {
		workReportConfigList = workReportConfigService.getListByFilter(new Filter(WorkReportConfig.class).eq("reporterId",OaActivator.getSessionUser().getId())).getValue();
		workReportList = workReportService.getListByFilter(new Filter(WorkReport.class).notNull("weekNo").eq("status",WorkReportStatusEnum.REPORTED).eq("reporterId",OaActivator.getSessionUser().getId())).getValue();
		if (workReportList.size() > 0) {
			workReport = workReportList.get(workReportList.size() - 1);
			String str = workReport.getYearNo() + "-" + workReport.getMonthNo()+ "";
			SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM");
			try {
				Date dateYear = fmt.parse(str);
				monthDtoList = ScheduleUtil.generateMonthWeekList(dateYear);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			monthLoop: for (MonthDto monthDto : monthDtoList) {
				// 取周数据
				for (WeekDto weekDto : monthDto.getWeekList()) {
					while (weekDto.getWeek().equals(workReport.getWeekNo())) {
						month = monthDto;
						week = weekDto;
						break monthLoop;
					}
				}
			}
		} else {
			workReport = null;
		}
		// 取出当前年份的1-12月月份数据

		return "configWeekReport";
	}

	public String workCountList() {
		// 显示年份列表,判断前一年和后一年传递的参数是否为空
		if (myYear != null) {
			try {
				Date dateYear = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(myYear);
				monthDtoList = ScheduleUtil.generateMonthWeekList(dateYear);
				prevYear = CalendarUtil.add(dateYear, Calendar.YEAR, -1).getTime();
				nextYear = CalendarUtil.add(dateYear, Calendar.YEAR, 1).getTime();
				year = Integer.parseInt(DateUtil.format(dateYear,"yyyy"));
				// 获取指定年份所有已经提交的周报
				workReportList = workReportService.getListByFilter(new Filter(WorkReport.class).eq("yearNo", year).notNull("weekNo").eq("type", WorkReportEnum.WEEK).eq("status", WorkReportStatusEnum.REPORTED)).getValue();
			} catch (ParseException e) {
				e.printStackTrace();
			}
		} else {
			monthDtoList = ScheduleUtil.generateMonthWeekList(new Date());
			prevYear = CalendarUtil.add(new Date(), Calendar.YEAR, -1).getTime();
			nextYear = CalendarUtil.add(new Date(), Calendar.YEAR, 1).getTime();
			year = Integer.parseInt(DateUtil.format(new Date(),"yyyy"));
			// 获取当前年份所有已经提交的周报
			workReportList = workReportService.getListByFilter(new Filter(WorkReport.class).eq("yearNo", year).notNull("weekNo").eq("type", WorkReportEnum.WEEK).eq("status", WorkReportStatusEnum.REPORTED)).getValue();
		}
		UserPubService userPubService=OaActivator.getService(UserPubService.class);
		List<User> centerUserList=userPubService.getCenterUserList2();
		//建立Map   根据ReportUserDto(用户信息)  来找到对应用户的工作汇报  workMap 集合  ,再根据Integer(周数) 来找到对应的周报
		if(workReportList.size() > 0){
			workCountDtoList = getWeekCountList(centerUserList,workReportList,monthDtoList);
		}else{
			workCountDtoList = new ArrayList<WorkCountDto>();
			for(User user : centerUserList){
				WorkCountDto dto = new WorkCountDto();
				dto.setMonthDtoList(monthDtoList);
				dto.setUsername(user.getUsername());
				dto.setId(user.getId());
				workCountDtoList.add(dto);
			}
		}
		return "workCount";
	}

	private List<WorkCountDto> getWeekCountList(List<User> centerUserList,
			List<WorkReport> workReportList, List<MonthDto> monthDtoList) {
		Map<ReportUserDto, Map<Integer, WorkReport>> map = new HashMap<ReportUserDto, Map<Integer, WorkReport>>();
		List<ReportUserDto> reportUserDtoList = new ArrayList<ReportUserDto>();
		for(User user : centerUserList){
			ReportUserDto key = new ReportUserDto();
			key.setId(user.getId());
			key.setUsername(user.getUsername());
			for (WorkReport workReport : workReportList) {
				Map<Integer, WorkReport> workMap = map.get(key);
				if (workMap == null || workMap.size() == 0) {
					workMap = new HashMap<Integer, WorkReport>();
				}
				if(user.getRealName().equals(workReport.getReporter().getRealName())){
					workMap.put(workReport.getWeekNo(), workReport);
				}else{
					workMap.put(null, null);
				}
				if (workReportList == null) {
					map = new HashMap<ReportUserDto, Map<Integer, WorkReport>>();
				}
				map.put(key, workMap);
			}
			reportUserDtoList.add(key);
		}
		List<WorkCountDto> workCountDtoList = new ArrayList<WorkCountDto>();
		for (ReportUserDto key : reportUserDtoList) {
			WorkCountDto dto = new WorkCountDto();
			dto.setUsername(key.getUsername());
			dto.setId(key.getId());
			List<MonthDto> myList = new ArrayList<MonthDto>();
			for (MonthDto monthDto : monthDtoList) {
				MonthDto myMonthDto = new MonthDto();
				List<WeekDto> weekDtoList = new ArrayList<WeekDto>();
				for (WeekDto weekDto : monthDto.getWeekList()) {
					WeekDto myWeekDto = new WeekDto();
					BeanUtil.copyProperties(weekDto, myWeekDto);
					WorkReport workReport = map.get(key).get(myWeekDto.getWeek());
					if (workReport == null) {
						myWeekDto.setNum(0);
					} else {
						Long time = workReport.getModifyTime().getTime()- workReport.getCreateTime().getTime();
						Long k = (time) / 1000 / 3600 / 24;
						Long day = k / 7;
						if (day <= 1) {
							myWeekDto.setNum(2);//正常期限(一周内)提交周报
						} else {
							myWeekDto.setNum(1);
						}
					}
					weekDtoList.add(myWeekDto);
				}
				BeanUtil.copyProperties(monthDto, myMonthDto);
				myMonthDto.setWeekList(weekDtoList);
				myList.add(myMonthDto);
			}
			dto.setMonthDtoList(myList);
			workCountDtoList.add(dto);
		}
		return workCountDtoList;
	}

	public String workMonthCountList() {
		if (myYear != null) {
			try {
				Date dateYear = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(myYear);
				monthDtoList = ScheduleUtil.generateMonthWeekList(dateYear);
				prevYear = CalendarUtil.add(dateYear, Calendar.YEAR, -1).getTime();
				nextYear = CalendarUtil.add(dateYear, Calendar.YEAR, 1).getTime();
				year = Integer.parseInt(DateUtil.format(dateYear,"yyyy"));
				// 获取指定年份所有已经提交的月报
				workReportList = workReportService.getListByFilter(new Filter(WorkReport.class).eq("yearNo", year).notNull("monthNo").eq("type", WorkReportEnum.MONTH).eq("status", WorkReportStatusEnum.REPORTED)).getValue();
			} catch (ParseException e) {
				e.printStackTrace();
			}
		} else {
				monthDtoList = ScheduleUtil.generateMonthWeekList(new Date());
				prevYear = CalendarUtil.add(new Date(), Calendar.YEAR, -1).getTime();
				nextYear = CalendarUtil.add(new Date(), Calendar.YEAR, 1).getTime();
				year = Integer.parseInt(DateUtil.format(new Date(),"yyyy"));
				// 获取当前年份所有已经提交的月报
				workReportList = workReportService.getListByFilter(new Filter(WorkReport.class).eq("yearNo", year).notNull("monthNo").eq("type", WorkReportEnum.MONTH).eq("status", WorkReportStatusEnum.REPORTED)).getValue();
		}
		UserPubService userPubService=OaActivator.getService(UserPubService.class);
		List<User> centerUserList=userPubService.getCenterUserList();
		if(workReportList.size()>0){
			workCountDtoList = getMonthCountList(centerUserList,workReportList,monthDtoList);
		}else{
			workCountDtoList = new ArrayList<WorkCountDto>();
			for(User user : centerUserList){
				WorkCountDto dto = new WorkCountDto();
				dto.setMonthDtoList(monthDtoList);
				dto.setUsername(user.getUsername());
				dto.setId(user.getId());
				workCountDtoList.add(dto);
			}
		}
		return "workMonthCount";
	}

	private List<WorkCountDto> getMonthCountList(List<User> centerUserList,
			List<WorkReport> workReportList, List<MonthDto> monthDtoList) {
		Map<ReportUserDto, Map<Integer, WorkReport>> map = new HashMap<ReportUserDto, Map<Integer, WorkReport>>();
		List<ReportUserDto> reportUserDtoList = new ArrayList<ReportUserDto>();
		for(User user : centerUserList){
			ReportUserDto key = new ReportUserDto();
			key.setId(user.getId());
			key.setUsername(user.getUsername());
			for (WorkReport workReport : workReportList) {
				Map<Integer, WorkReport> workMap = map.get(key);
				if (workMap == null || workMap.size() == 0) {
					workMap = new HashMap<Integer, WorkReport>();
				}
				if(user.getRealName().equals(workReport.getReporter().getRealName())){
					workMap.put(workReport.getMonthNo(), workReport);
				}
				map.put(key, workMap);
			}
			reportUserDtoList.add(key);
		}
		List<WorkCountDto>  workCountDtoList = new ArrayList<WorkCountDto>();
		for (ReportUserDto key : reportUserDtoList) {
			WorkCountDto dto = new WorkCountDto();
			dto.setUsername(key.getUsername());
			dto.setId(key.getId());
			List<MonthDto> monthList = new ArrayList<MonthDto>();
			for (MonthDto monthDto : monthDtoList) {
				MonthDto myMonthDto = new MonthDto();
				BeanUtil.copyProperties(monthDto, myMonthDto);
				WorkReport workReport = map.get(key).get(myMonthDto.getMonth());
				if (workReport != null) {
					Long time = workReport.getModifyTime().getTime()- workReport.getCreateTime().getTime();
					Long k = (time) / 1000 / 3600 / 24;
					Long day = k / 7;
					if (day <= 1) {
						myMonthDto.setNum(2);
					} else {
						myMonthDto.setNum(1);
					}
				} else {
					myMonthDto.setNum(0);
				}
				monthList.add(myMonthDto);
			}
			dto.setMonthDtoList(monthList);
			workCountDtoList.add(dto);
		}
		return workCountDtoList;
	}

	public String selectPersonReport(){
		yearList = new ArrayList<Integer>();
		Integer cYear = Integer.parseInt(DateUtil.format(new Date(), "yyyy"));
		for(int i=(cYear-10);i<(cYear+10);i++){
			yearList.add(i);
		}
		
		return "selectPersonReport";
	}
	
	public String loadWeekByYear(){
		List<Integer> weekList = new ArrayList<Integer>();
		if(year!=null){
			String str = year + "-10";
			SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM");
			try {
				Date dateYear = fmt.parse(str);
				monthDtoList = ScheduleUtil.generateMonthWeekList(dateYear);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			for(MonthDto monthDto : monthDtoList){
				for(WeekDto dto : monthDto.getWeekList()){
					weekList.add(dto.getWeek());
				}
			}
		}
		result = Result.value(weekList);
		return JSON;
	}
	
	public String personExport(){
		String report = ServletActionContext.getRequest().getParameter("report");
		String type = ServletActionContext.getRequest().getParameter("type");
		String year = ServletActionContext.getRequest().getParameter("year");
		String week = ServletActionContext.getRequest().getParameter("weekSelect");
		String month = ServletActionContext.getRequest().getParameter("monthSelect");
		String title="";
		List<Object[]> taskList = new ArrayList<Object[]>();
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		if(report.equals("week")){
			String t = "";
			t = getWeekTime(year,week);
			List<WorkDayReport> wdrList = workDayReportService.getListByFilter(new Filter(WorkDayReport.class).isNull("dayNo").eq("yearNo", Integer.parseInt(year)).eq("weekNo", Integer.parseInt(week))).getValue();
			if(wdrList.size()>0 && wdrList!=null){
				int j=1;
				if(type.equals("task")){
					String[] columns = {"序号","姓名","本周工作内容","本周工作完成情况","分管领导","所属部门"};
					title = StringUtil.URLEncoderToUTF8("三略科技个人周工作完成情况");
					for (WorkDayReport wdr : wdrList) {
						if(wdr.getContent()!=null){
							s:for(int i= 0;i<wdr.getContent().split("`_`").length;i++){
								List<String> datas = new ArrayList<String>();
								String c = wdr.getContent().split("`_`")[i];
								String status = wdr.getProcessStr().split("`_`")[i];
								if(c.equals("null"))continue s;
								datas.add(j+"");
								j++;
								datas.add(wdr.getReporter().getRealName());
								datas.add(c);
								String memo = "";
								if(status.equals("NORMAL")){
									memo = "完成";
								}else if(status.equals("UNFINISH")){
									memo = "未完成";
								}else if(status.equals("LATE")){
									memo = "延迟";
								}
								datas.add(memo);
								datas.add("");
								datas.add(wdr.getReporter().getOrgName());
								taskList.add(datas.toArray());
							}
						}
					}
					POIUtil.export("三略科技个人周工作完成情况"+"("+t+")",columns,taskList,out);
				}else if(type.equals("plan")){
					String[] columns = {"序号","姓名","本周工作内容","分管领导","所属部门"};
					title = StringUtil.URLEncoderToUTF8("三略科技个人周工作计划");
					for (WorkDayReport wdr : wdrList) {
						if(wdr.getContent()!=null){
							s:for(int i= 0;i<wdr.getPlayContent().split("`_`").length;i++){
								List<String> datas = new ArrayList<String>();
								String c = wdr.getPlayContent().split("`_`")[i];
								if(c.equals("null"))continue s;
								datas.add(j+"");
								j++;
								datas.add(wdr.getReporter().getRealName());
								datas.add(c);
								datas.add("");
								datas.add(wdr.getReporter().getOrgName());
								taskList.add(datas.toArray());
							}
						}
					}
					POIUtil.export("三略科技个人周工作计划"+"("+t+")",columns,taskList,out);
				}
			}
		}
		if(report.equals("month")){
			String t = "";
			t = year+"年"+month+"月";
			List<WorkDayReport> wdrList = workDayReportService.getListByFilter(new Filter(WorkDayReport.class).isNull("dayNo").eq("yearNo", Integer.parseInt(year)).eq("monthNo", Integer.parseInt(month)).isNull("weekNo")).getValue();
			if(wdrList.size()>0 && wdrList!=null){
				int j=1;
				if(type.equals("task")){
					String[] columns = {"序号","姓名","本月工作内容","本月工作完成情况","分管领导","所属部门"};
					title = StringUtil.URLEncoderToUTF8("三略科技个人月工作完成情况");
					for (WorkDayReport wdr : wdrList) {
						if(wdr.getContent()!=null){
							s:for(int i= 0;i<wdr.getContent().split("`_`").length;i++){
								List<String> datas = new ArrayList<String>();
								String c = wdr.getContent().split("`_`")[i];
								String status = wdr.getProcessStr().split("`_`")[i];
								if(c.equals("null"))continue s;
								datas.add(j+"");
								j++;
								datas.add(wdr.getReporter().getRealName());
								datas.add(c);
								String memo = "";
								if(status.equals("NORMAL")){
									memo = "完成";
								}else if(status.equals("UNFINISH")){
									memo = "未完成";
								}else if(status.equals("LATE")){
									memo = "延迟";
								}
								datas.add(memo);
								datas.add("");
								datas.add(wdr.getReporter().getOrgName());
								taskList.add(datas.toArray());
							}
						}
					}
					POIUtil.export("三略科技个人月工作完成情况"+"("+t+")",columns,taskList,out);
				}else if(type.equals("plan")){
					String[] columns = {"序号","姓名","本月工作内容","分管领导","所属部门"};
					title = StringUtil.URLEncoderToUTF8("三略科技个人月工作计划");
					for (WorkDayReport wdr : wdrList) {
						if(wdr.getContent()!=null){
							s:for(int i= 0;i<wdr.getPlayContent().split("`_`").length;i++){
								List<String> datas = new ArrayList<String>();
								String c = wdr.getPlayContent().split("`_`")[i];
								if(c.equals("null"))continue s;
								datas.add(j+"");
								j++;
								datas.add(wdr.getReporter().getRealName());
								datas.add(c);
								datas.add("");
								datas.add(wdr.getReporter().getOrgName());
								taskList.add(datas.toArray());
							}
						}
					}
					POIUtil.export("三略科技个人月工作计划"+"("+t+")",columns,taskList,out);
				}
			}
		}
		excelName = title+".xls";
		inputStream = new ByteArrayInputStream(out.toByteArray());
		return "export";
	}
	
	private String getWeekTime(String year, String week) {
		String time = "";
		String str = year + "-10";
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM");
		try {
			Date dateYear = fmt.parse(str);
			monthDtoList = ScheduleUtil.generateMonthWeekList(dateYear);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		for(MonthDto monthDto : monthDtoList){
			for(WeekDto dto : monthDto.getWeekList()){
				if(dto.getWeek().equals(Integer.parseInt(week))){
					String startYear = DateUtil.format(dto.getDateList().get(0), "yyyy");
					String startMonth = DateUtil.format(dto.getDateList().get(0), "MM");
					String startDay = DateUtil.format(dto.getDateList().get(0), "dd");
					String endYear = DateUtil.format(dto.getDateList().get(4), "yyyy");
					String endMonth = DateUtil.format(dto.getDateList().get(4), "MM");
					String endDay = DateUtil.format(dto.getDateList().get(4), "dd");
					time = startYear+"年"+startMonth+"月"+startDay+"日"+"---"+endYear+"年"+endMonth+"月"+endDay+"日";
				}
			}
		}
		return time;
	}

	public String selectDepReport(){
		yearList = new ArrayList<Integer>();
		Integer cYear = Integer.parseInt(DateUtil.format(new Date(), "yyyy"));
		for(int i=(cYear-10);i<(cYear+10);i++){
			yearList.add(i);
		}
		return "selectDepReport";
	}
	
	@SuppressWarnings("unchecked")
	public String orgList(){
		OrgPubService orgPubService=OaActivator.getService(OrgPubService.class);
		List<Org> orgList = orgPubService.getOrgList();
		nodeList = new ArrayList<Document>();
		for (Org org : orgList) {
			Document node = new Document();
			node.setId(org.getId());
			node.setText(org.getName());
			node.setLevel(org.getLevelCode());
			nodeList.add(node);
		}
		nodeList = TreeUtil.generateTree(nodeList);
		return JSON;
	}
	
	
	public String depExport(){
		String report = ServletActionContext.getRequest().getParameter("report");
		String type = ServletActionContext.getRequest().getParameter("type");
		String year = ServletActionContext.getRequest().getParameter("year");
		String week = ServletActionContext.getRequest().getParameter("weekSelect");
		String month = ServletActionContext.getRequest().getParameter("monthSelect");
		String depIds = ServletActionContext.getRequest().getParameter("depIds");
		Org[] depNames = getDepName(depIds);
		String title="";
		List<Object[]> taskList = new ArrayList<Object[]>();
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		if(report.equals("week")){
			String t = "";
			t = getWeekTime(year,week);
			//List<WorkDayReport> wdrList = workDayReportService.getListByDepIds(year,month,week,depIds);
			List<WorkDayReport> wdrList = workDayReportService.getListByFilter(new Filter(WorkDayReport.class).isNull("dayNo").eq("yearNo", Integer.parseInt(year)).eq("weekNo", Integer.parseInt(week)).createAlias("reporter", "reporter").in("reporter.org",(Object[])depNames)).getValue();
			if(wdrList.size()>0 && wdrList!=null){
				int j=1;
				if(type.equals("task")){
					//String[] columns = {"姓名","本周工作内容","本周工作完成情况","分管领导","所属部门"};
					String[] columns = {"序号","本周工作内容","本周工作完成情况","分管领导","所属部门"};
					title = StringUtil.URLEncoderToUTF8("三略科技周工作完成情况");
					for (WorkDayReport wdr : wdrList) {
						if(wdr.getContent()!=null){
							s:for(int i= 0;i<wdr.getContent().split("`_`").length;i++){
								List<String> datas = new ArrayList<String>();
								String c = wdr.getContent().split("`_`")[i];
								String status = wdr.getProcessStr().split("`_`")[i];
								if(c.equals("null"))continue s;
								datas.add(j+"");
								j++;
								//datas.add(wdr.getReporter().getRealName());
								datas.add(c);
								String memo = "";
								if(status.equals("NORMAL")){
									memo = "完成";
								}else if(status.equals("UNFINISH")){
									memo = "未完成";
								}else if(status.equals("LATE")){
									memo = "延迟";
								}
								datas.add(memo);
								datas.add("");
								datas.add(wdr.getReporter().getOrgName());
								taskList.add(datas.toArray());
							}
						}
					}
					POIUtil.export("三略科技周工作完成情况"+"("+t+")",columns,taskList,out);
				}else if(type.equals("plan")){
					//String[] columns = {"姓名","本周工作内容","分管领导","所属部门"};
					String[] columns = {"序号","本周工作内容","分管领导","所属部门"};
					title = StringUtil.URLEncoderToUTF8("三略科技周工作计划");
					for (WorkDayReport wdr : wdrList) {
						if(wdr.getContent()!=null){
							s:for(int i= 0;i<wdr.getPlayContent().split("`_`").length;i++){
								List<String> datas = new ArrayList<String>();
								String c = wdr.getPlayContent().split("`_`")[i];
								if(c.equals("null"))continue s;
								datas.add(j+"");
								j++;
								//datas.add(wdr.getReporter().getRealName());
								datas.add(c);
								datas.add("");
								datas.add(wdr.getReporter().getOrgName());
								taskList.add(datas.toArray());
							}
						}
					}
					POIUtil.export("三略科技周工作计划"+"("+t+")",columns,taskList,out);
				}
			}
		}
		if(report.equals("month")){
			String t = "";
			t = year+"年"+month+"月";
			//List<WorkDayReport> wdrList = workDayReportService.getListByDepIds(year,month,week,depIds);
			List<WorkDayReport> wdrList = workDayReportService.getListByFilter(new Filter(WorkDayReport.class).isNull("dayNo").eq("yearNo", Integer.parseInt(year)).eq("monthNo", Integer.parseInt(month)).isNull("weekNo").createAlias("reporter", "reporter").in("reporter.org",(Object[])depNames)).getValue();
			if(wdrList.size()>0 && wdrList!=null){
				int j=1;
				if(type.equals("task")){
					//String[] columns = {"姓名","本月工作内容","本月工作完成情况","分管领导","所属部门"};
					String[] columns = {"序号","本月工作内容","本月工作完成情况","分管领导","所属部门"};
					title = StringUtil.URLEncoderToUTF8("三略科技月工作完成情况");
					for (WorkDayReport wdr : wdrList) {
						if(wdr.getContent()!=null){
							s:for(int i= 0;i<wdr.getContent().split("`_`").length;i++){
								List<String> datas = new ArrayList<String>();
								String c = wdr.getContent().split("`_`")[i];
								String status = wdr.getProcessStr().split("`_`")[i];
								if(c.equals("null"))continue s;
								datas.add(j+"");
								j++;
								//datas.add(wdr.getReporter().getRealName());
								datas.add(c);
								String memo = "";
								if(status.equals("NORMAL")){
									memo = "完成";
								}else if(status.equals("UNFINISH")){
									memo = "未完成";
								}else if(status.equals("LATE")){
									memo = "延迟";
								}
								datas.add(memo);
								datas.add("");
								datas.add(wdr.getReporter().getOrgName());
								taskList.add(datas.toArray());
							}
						}
					}
					POIUtil.export("三略科技月工作完成情况"+"("+t+")",columns,taskList,out);
				}else if(type.equals("plan")){
					//String[] columns = {"姓名","本月工作内容","分管领导","所属部门"};
					String[] columns = {"序号","本月工作内容","分管领导","所属部门"};
					title = StringUtil.URLEncoderToUTF8("三略科技月工作计划");
					for (WorkDayReport wdr : wdrList) {
						if(wdr.getContent()!=null){
							s:for(int i= 0;i<wdr.getPlayContent().split("`_`").length;i++){
								List<String> datas = new ArrayList<String>();
								String c = wdr.getPlayContent().split("`_`")[i];
								if(c.equals("null"))continue s;
								datas.add(j+"");
								j++;
								//datas.add(wdr.getReporter().getRealName());
								datas.add(c);
								datas.add("");
								datas.add(wdr.getReporter().getOrgName());
								taskList.add(datas.toArray());
							}
						}
					}
					POIUtil.export("三略科技月工作计划"+"("+t+")",columns,taskList,out);
				}
			}
		}
		excelName = title+".xls";
		inputStream = new ByteArrayInputStream(out.toByteArray());
		return "export";
	}
	
	private Org[] getDepName(String depIds) {
		OrgPubService orgPubService=OaActivator.getService(OrgPubService.class);
		List<Org> orgList = orgPubService.getOrgList();
		StringBuilder depNames = new StringBuilder();
		Org[] o = new Org[orgList.size()];
		int k=0;
		for(Org org :orgList){
			for(int j=0;j<depIds.split(",").length;j++){
				String orgId = depIds.split(",")[j];
				if(org.getId().equals(Long.parseLong(orgId))){
					o[k] = org;
					k++;
				}
			}
		}
		if(depNames.toString().endsWith(","))depNames.deleteCharAt(depNames.length()-1);
		return o;
	}

	public void setWorkReportService(WorkReportService workReportService) {
		this.workReportService = workReportService;
	}

	public WorkReport getWorkReport() {
		return workReport;
	}

	public void setWorkReport(WorkReport workReport) {
		this.workReport = workReport;
	}

	public Result getResult() {
		return result;
	}

	public void setResult(Result result) {
		this.result = result;
	}

	@Override
	protected List<WorkReport> getListByFilter(Filter fitler) {
		return workReportService.getListByFilter(fitler).getValue();
	}

	public List<MonthDto> getMonthDtoList() {
		return monthDtoList;
	}

	public void setMonthDtoList(List<MonthDto> monthDtoList) {
		this.monthDtoList = monthDtoList;
	}

	public List<Date> getDateList() {
		return dateList;
	}

	public void setDateList(List<Date> dateList) {
		this.dateList = dateList;
	}

	public MonthDto getMonth() {
		return month;
	}

	public void setMonth(MonthDto month) {
		this.month = month;
	}

	public WeekDto getWeek() {
		return week;
	}

	public void setWeek(WeekDto week) {
		this.week = week;
	}

	public Integer getMyMonth() {
		return myMonth;
	}

	public void setMyMonth(Integer myMonth) {
		this.myMonth = myMonth;
	}

	public Integer getMyWeek() {
		return myWeek;
	}

	public void setMyWeek(Integer myWeek) {
		this.myWeek = myWeek;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public List<WorkReport> getWorkReportList() {
		return workReportList;
	}

	public void setWorkReportList(List<WorkReport> workReportList) {
		this.workReportList = workReportList;
	}

	public Integer getYear() {
		return year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}

	public Date getPrevYear() {
		return prevYear;
	}

	public void setPrevYear(Date prevYear) {
		this.prevYear = prevYear;
	}

	public Date getNextYear() {
		return nextYear;
	}

	public void setNextYear(Date nextYear) {
		this.nextYear = nextYear;
	}

	public String getMyYear() {
		return myYear;
	}

	public void setMyYear(String myYear) {
		this.myYear = myYear;
	}

	public Integer getCurYear() {
		return curYear;
	}

	public void setCurYear(Integer curYear) {
		this.curYear = curYear;
	}

	public void setWorkReportConfigService(
			WorkReportConfigService workReportConfigService) {
		this.workReportConfigService = workReportConfigService;
	}

	public List<WorkReportConfig> getWorkReportConfigList() {
		return workReportConfigList;
	}

	public void setWorkReportConfigList(
			List<WorkReportConfig> workReportConfigList) {
		this.workReportConfigList = workReportConfigList;
	}

	public Boolean getFlag() {
		return flag;
	}

	public void setFlag(Boolean flag) {
		this.flag = flag;
	}

	public String getWorkReportReceiverIds() {
		return workReportReceiverIds;
	}

	public void setWorkReportReceiverIds(String workReportReceiverIds) {
		this.workReportReceiverIds = workReportReceiverIds;
	}

	public List<WeekDto> getWeekDtoList() {
		return weekDtoList;
	}

	public void setWeekDtoList(List<WeekDto> weekDtoList) {
		this.weekDtoList = weekDtoList;
	}

	public Long getDay() {
		return day;
	}

	public void setDay(Long day) {
		this.day = day;
	}

	public List<WorkCountDto> getWorkCountDtoList() {
		return workCountDtoList;
	}

	public void setWorkCountDtoList(List<WorkCountDto> workCountDtoList) {
		this.workCountDtoList = workCountDtoList;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Date getPrevMonth() {
		return prevMonth;
	}

	public void setPrevMonth(Date prevMonth) {
		this.prevMonth = prevMonth;
	}

	public Date getNextMonth() {
		return nextMonth;
	}

	public void setNextMonth(Date nextMonth) {
		this.nextMonth = nextMonth;
	}

	public String getSelectMonth() {
		return selectMonth;
	}

	public void setSelectMonth(String selectMonth) {
		this.selectMonth = selectMonth;
	}

	public void setWorkDayReportService(WorkDayReportService workDayReportService) {
		this.workDayReportService = workDayReportService;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getDateStr() {
		return dateStr;
	}

	public void setDateStr(String dateStr) {
		this.dateStr = dateStr;
	}

	public List<WorkDayReport> getWorkDayReportList() {
		return workDayReportList;
	}

	public void setWorkDayReportList(List<WorkDayReport> workDayReportList) {
		this.workDayReportList = workDayReportList;
	}

	public List<Integer> getYearList() {
		return yearList;
	}

	public void setYearList(List<Integer> yearList) {
		this.yearList = yearList;
	}

	public List<Integer> getMonthList() {
		return monthList;
	}

	public void setMonthList(List<Integer> monthList) {
		this.monthList = monthList;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getExcelName() {
		return excelName;
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public List<Document> getNodeList() {
		return nodeList;
	}

	public void setNodeList(List<Document> nodeList) {
		this.nodeList = nodeList;
	}

	public List<MonthDto> getMonthDtos() {
		return monthDtos;
	}

	public void setMonthDtos(List<MonthDto> monthDtos) {
		this.monthDtos = monthDtos;
	}

	public WorkReport getWorkReport2() {
		return workReport2;
	}

	public void setWorkReport2(WorkReport workReport2) {
		this.workReport2 = workReport2;
	}

	public void setTaskService(TaskService taskService) {
		this.taskService = taskService;
	}

	public String getTaskReportParam() {
		return taskReportParam;
	}

	public void setTaskReportParam(String taskReportParam) {
		this.taskReportParam = taskReportParam;
	}
	public void setDepartService(TaskDepartService departService) {
		this.departService = departService;
	}
	
	public String getsTime() {
		return sTime;
	}


	public void setsTime(String sTime) {
		this.sTime = sTime;
	}


	public String geteTime() {
		return eTime;
	}


	public void seteTime(String eTime) {
		this.eTime = eTime;
	}


}
