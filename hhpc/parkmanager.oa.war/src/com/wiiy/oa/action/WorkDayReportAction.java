package com.wiiy.oa.action;

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
import com.wiiy.core.entity.Org;
import com.wiiy.core.entity.User;
import com.wiiy.core.external.service.OrgPubService;
import com.wiiy.core.external.service.UserPubService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dto.DayDto;
import com.wiiy.oa.dto.MonthDto;
import com.wiiy.oa.dto.ReportUserDto;
import com.wiiy.oa.dto.WeekDto;
import com.wiiy.oa.dto.WorkCountDto;
import com.wiiy.oa.dto.WorkDayDto;
import com.wiiy.oa.entity.Task;
import com.wiiy.oa.entity.TaskDepart;
import com.wiiy.oa.entity.WorkDayReport;
import com.wiiy.oa.entity.WorkReportConfig;
import com.wiiy.oa.preferences.enums.WorkReportStatusEnum;
import com.wiiy.oa.service.TaskDepartService;
import com.wiiy.oa.service.TaskService;
import com.wiiy.oa.service.WorkDayReportService;
import com.wiiy.oa.service.WorkReportConfigService;
import com.wiiy.oa.util.ScheduleUtil;

public class WorkDayReportAction extends JqGridBaseAction<WorkDayReport>{
	private WorkDayReportService workDayReportService;
	private WorkReportConfigService workReportConfigService;
	private TaskService taskService;
	private TaskDepartService departService;
	private WorkDayReport workDayReport;
	private Long id;
	private Result result;
	
	private List<WorkReportConfig> workReportConfigList;
	private List<MonthDto> monthDtoList;
	private List<WorkCountDto> workCountDtoList;
	private Integer myWeek;
	private Integer year;//视图显示年份
	private Integer mon;//视图显示月份
	private MonthDto month;
	private WeekDto week;
	private Date date;
	private String dateStr;
	private Long day;//逾期天数
	
	private String yearStr;//视图选择参数
	private String monthStr;//视图选择参数
	private String selectDate;//选着日期
	
	private Date prevYear;
	private Date nextYear;
	private Date prevMonth;
	private Date nextMonth;
	
	private List<Integer> years;
	
	public String addDayReport(){
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
		workReportConfigList = workReportConfigService.getListByFilter(new Filter(WorkReportConfig.class).eq("reporterId",OaActivator.getSessionUser().getId())).getValue();
		/*Integer y = Integer.parseInt(DateUtil.format(date, "yyyy"));
		Integer m = Integer.parseInt(DateUtil.format(date, "MM"));
		Integer d = Integer.parseInt(DateUtil.format(date, "dd"));*/
		/*workDayReport = workDayReportService.getBeanByFilter(new Filter(WorkDayReport.class).eq("yearNo", y).eq("monthNo", m).eq("dayNo", d).eq("reporterId", OaActivator.getSessionUser().getId())).getValue();*/
		ServletActionContext.getRequest().setAttribute("date", date);
		/*	if(workDayReport!=null){
			List<WorkDayDto> workDayDtoList = new ArrayList<WorkDayDto>();
			s:for(int i= 0;i<workDayReport.getContent().split("`_`").length;i++){
				WorkDayDto dto = new WorkDayDto();
				String c = workDayReport.getContent().split("`_`")[i];
				if(c.equals("null"))
					continue s;
				dto.setTitle(c);
				dto.setStatus(workDayReport.getProcessStr().split("`_`")[i]);
				workDayDtoList.add(dto);
			}
			ServletActionContext.getRequest().setAttribute("workDayDtoList", workDayDtoList);
			if(workDayReport.getStatus().equals(WorkReportStatusEnum.TEMPORARY)){
				return "editDay";
			}else if(workDayReport.getStatus().equals(WorkReportStatusEnum.REPORTED)){
				return "viewByDay";
			}
		}else*/
		monthDtoList = ScheduleUtil.weekInMonthList(date);
		List<Task> taskList = taskService.getListByFilter(new Filter(Task.class).eq("receiverId", OaActivator.getSessionUser().getId()).le("startTime", date).ge("endTime", date)).getValue();
		if(taskList.size()>0 && taskList!=null){
			ServletActionContext.getRequest().setAttribute("taskList", taskList);
		}
		monthLoop: for (MonthDto monthDto : monthDtoList) {
			myWeek = 0;
			for (WeekDto weekDto : monthDto.getWeekList()) {
				myWeek++;
				for (Date date2 : weekDto.getDateList()) {
					if (CalendarUtil.getEarliest(date2, Calendar.DAY_OF_MONTH).getTime() == CalendarUtil.getEarliest(date, Calendar.DAY_OF_MONTH).getTime()) {
						month = monthDto;
						week = weekDto;
						break monthLoop;
					}
				}
			}
		}
		Integer curYear = Integer.parseInt(DateUtil.format(new Date(),"yyyy"));
		years = new ArrayList<Integer>();
		for(int n=(curYear-3);n<(curYear+2);n++){
			years.add(n);
		}
		return "addDayReport";
	}
	
	public String save(){
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
		Date newDate = null;
		try {
			newDate = fmt.parse(selectDate);
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		WorkDayReport report = workDayReportService.getBeanByFilter(new Filter(WorkDayReport.class).eq("curDate", newDate).eq("reporterId", OaActivator.getSessionUser().getId())).getValue();
		if(report!=null){
			result = Result.failure("日报已填写，请不要重复操作");
			return JSON;
		}
		String[] contentValues = ServletActionContext.getRequest().getParameterValues("content");
		String[] processValues = ServletActionContext.getRequest().getParameterValues("process");
		String[] playValues = ServletActionContext.getRequest().getParameterValues("playContent");
		String content = "";
		String process = "";
		String play = "";
		if(contentValues.length==processValues.length && processValues.length>0){
			for(int i = 0;i<contentValues.length;i++){
				String c = contentValues[i];
				if(c==""){
					content += "null"+"`_`";
				}else{
					content += c+"`_`";
				}
			}
			for(int j = 0;j<processValues.length;j++){
				String p = processValues[j];
				if(p==""){
					process += "null"+"`_`";
				}else{
					process += p+"`_`";
				}
			}
			workDayReport.setContent(content);
			workDayReport.setProcessStr(process);
		}
		if(playValues!=null && playValues.length>0){
			for(int j = 0;j<playValues.length;j++){
				String a = playValues[j];
				if(a==""){
					play += "null"+"`_`";
				}else{
					play += a+"`_`";
				}
			}
			workDayReport.setPlayContent(play);
		}
		try {
			date = fmt.parse(dateStr);
			if(!newDate.equals(date)){
				monthDtoList = ScheduleUtil.weekInMonthList(newDate);
				monthLoop: for (MonthDto monthDto : monthDtoList) {
					myWeek = 0;
					for (WeekDto weekDto : monthDto.getWeekList()) {
						myWeek++;
						for (Date date2 : weekDto.getDateList()) {
							if (CalendarUtil.getEarliest(date2, Calendar.DAY_OF_MONTH).getTime() == CalendarUtil.getEarliest(newDate, Calendar.DAY_OF_MONTH).getTime()) {
								month = monthDto;
								week = weekDto;
								break monthLoop;
							}
						}
					}
				}
				workDayReport.setWeekNo(week.getWeek());
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		workDayReport.setCurDate(newDate);
		if (workDayReport.getWeekNo() == null) {
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(newDate);
			workDayReport.setWeekNo(calendar.get(Calendar.WEEK_OF_YEAR));
		}
		System.out.println(workDayReport);
		result = workDayReportService.save(workDayReport);
		return JSON;
	}
	
	public String editDay(){
		workReportConfigList = workReportConfigService.getListByFilter(new Filter(WorkReportConfig.class).eq("reporterId",OaActivator.getSessionUser().getId())).getValue();
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
		try {
			date = fmt.parse(dateStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		Integer year = Integer.parseInt(DateUtil.format(date, "yyyy"));
		Integer month = Integer.parseInt(DateUtil.format(date, "MM"));
		Integer day = Integer.parseInt(DateUtil.format(date, "dd"));
		workDayReport = workDayReportService.getBeanByFilter(new Filter(WorkDayReport.class).eq("yearNo", year).eq("monthNo", month).eq("dayNo", day).eq("reporterId", OaActivator.getSessionUser().getId())).getValue();
		if(workDayReport!=null){
			List<WorkDayDto> workDayDtoList = new ArrayList<WorkDayDto>();
			s:for(int i= 0;i<workDayReport.getContent().split("`_`").length;i++){
				WorkDayDto dto = new WorkDayDto();
				String c = workDayReport.getContent().split("`_`")[i];
				if(c.equals("null"))
					continue s;
				dto.setTitle(c);
				dto.setStatus(workDayReport.getProcessStr().split("`_`")[i]);
				workDayDtoList.add(dto);
			}
			ServletActionContext.getRequest().setAttribute("workDayDtoList", workDayDtoList);
		}
		return "editDay";
	}
	
	public String update(){
		WorkDayReport dbean = workDayReportService.getBeanById(workDayReport.getId()).getValue();
		BeanUtil.copyProperties(workDayReport, dbean);
		String[] contentValues = ServletActionContext.getRequest().getParameterValues("content");
		String[] processValues = ServletActionContext.getRequest().getParameterValues("process");
		String[] playValues = ServletActionContext.getRequest().getParameterValues("playContent");
		String content = "";
		String process = "";
		String play = "";
		if(contentValues.length==processValues.length && processValues.length>0){
			for(int i = 0;i<contentValues.length;i++){
				String c = contentValues[i];
				if(c==""){
					content += "null"+"`_`";
				}else{
					content += c+"`_`";
				}
			}
			for(int j = 0;j<processValues.length;j++){
				String p = processValues[j];
				if(p==""){
					process += "null"+"`_`";
				}else{
					process += p+"`_`";
				}
			}
			dbean.setContent(content);
			dbean.setProcessStr(process);
		}
		if(playValues!=null && playValues.length>0){
			for(int j = 0;j<playValues.length;j++){
				String a = playValues[j];
				if(a==""){
					play += "null"+"`_`";
				}else{
					play += a+"`_`";
				}
			}
			dbean.setPlayContent(play);
		}
		result = workDayReportService.update(dbean);
		return JSON;
	}
	
	public String viewByDay(){
		workReportConfigList = workReportConfigService.getListByFilter(new Filter(WorkReportConfig.class).eq("reporterId",OaActivator.getSessionUser().getId())).getValue();
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
		if(dateStr!=null){
			try {
				date = fmt.parse(dateStr);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			Integer year = Integer.parseInt(DateUtil.format(date, "yyyy"));
			Integer month = Integer.parseInt(DateUtil.format(date, "M"));
			Integer day = Integer.parseInt(DateUtil.format(date, "d"));
			if(id!=null){
				workDayReport = workDayReportService.getBeanByFilter(new Filter(WorkDayReport.class).eq("yearNo", year).eq("monthNo", month).eq("dayNo", day).eq("reporterId", id)).getValue();
			}else{
				workDayReport = workDayReportService.getBeanByFilter(new Filter(WorkDayReport.class).eq("yearNo", year).eq("monthNo", month).eq("dayNo", day).eq("reporterId", OaActivator.getSessionUser().getId())).getValue();
			}
		}else{
			Integer year = Integer.parseInt(DateUtil.format(new Date(), "yyyy"));
			Integer month = Integer.parseInt(DateUtil.format(new Date(), "M"));
			Integer day = Integer.parseInt(DateUtil.format(new Date(), "d"));
			List<WorkDayReport> list = workDayReportService.getListByFilter(new Filter(WorkDayReport.class).eq("yearNo", year).eq("monthNo", month).eq("yearNo", year).orderBy("modifyTime", Filter.DESC).maxResults(1).eq("reporterId", OaActivator.getSessionUser().getId())).getValue();
			if(list.size()>0 && list!=null){
				workDayReport = list.get(list.size() - 1);
			}
		}
		if(workDayReport!=null){
			List<WorkDayDto> workDayDtoList = new ArrayList<WorkDayDto>();
			s:for(int i= 0;i<workDayReport.getContent().split("`_`").length;i++){
				WorkDayDto dto = new WorkDayDto();
				String c = workDayReport.getContent().split("`_`")[i];
				if(c.equals("null"))
					continue s;
				dto.setTitle(c);
				dto.setStatus(workDayReport.getProcessStr().split("`_`")[i]);
				workDayDtoList.add(dto);
			}
			ServletActionContext.getRequest().setAttribute("workDayDtoList", workDayDtoList);
		}
		return "viewByDay";
	}
	
	public String dayCountList(){
		if (yearStr!= null) {
			try {
				date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(yearStr);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}else if(monthStr!=null){
			try {
				date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(monthStr);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}else {
			date = new Date();
		}
		prevYear = CalendarUtil.add(date, Calendar.YEAR, -1).getTime();
		nextYear = CalendarUtil.add(date, Calendar.YEAR, 1).getTime();
		prevMonth = CalendarUtil.add(date, Calendar.MONTH, -1).getTime();
		nextMonth = CalendarUtil.add(date, Calendar.MONTH, 1).getTime();
		monthDtoList = ScheduleUtil.workDayCount(date);
		for(MonthDto monthDto : monthDtoList){
			year = monthDto.getYear();
			mon = monthDto.getMonth();
		}
		List<WorkDayReport> workDayReportList = workDayReportService.getListByFilter(new Filter(WorkDayReport.class).eq("yearNo", year).eq("monthNo", mon).eq("status", WorkReportStatusEnum.REPORTED)).getValue();
		workCountDtoList = new ArrayList<WorkCountDto>();
		
			UserPubService userPubService=OaActivator.getService(UserPubService.class);
			List<User> centerUserList=userPubService.getCenterUserList();
			Map<ReportUserDto, Map<String, WorkDayReport>> map = new HashMap<ReportUserDto, Map<String, WorkDayReport>>();
			
			List<ReportUserDto> reportUserDtoList = new ArrayList<ReportUserDto>();
			for(User user : centerUserList){
				ReportUserDto key = new ReportUserDto();
				key.setId(user.getId());
				key.setUsername(user.getUsername());
				if(workDayReportList.size()>0 && workDayReportList!=null){
				for (WorkDayReport wdr : workDayReportList) {
					Map<String, WorkDayReport> workMap = map.get(key);
					if (workMap == null || workMap.size() == 0) {
						workMap = new HashMap<String, WorkDayReport>();
					}
					if(user.getRealName().equals(wdr.getReporter().getRealName())){
						String dateStr = DateUtil.format(wdr.getCurDate(), "yyyy-MM-dd");
						workMap.put(dateStr, wdr);
					}else{
						workMap.put(null, null);
					}
					if (workDayReportList == null) {
						map = new HashMap<ReportUserDto, Map<String, WorkDayReport>>();
					}
					map.put(key, workMap);
				}
				}else{
					Map<String, WorkDayReport> workMap = new HashMap<String, WorkDayReport>();
					map.put(key, workMap);
				}
				reportUserDtoList.add(key);
			}
			
			for (ReportUserDto key : reportUserDtoList) {
				WorkCountDto dto = new WorkCountDto();
				dto.setUsername(key.getUsername());
				dto.setId(key.getId());
				List<MonthDto> myList = new ArrayList<MonthDto>();
				for (MonthDto monthDto : monthDtoList) {
					MonthDto myMonthDto = new MonthDto();
					List<DayDto> dayDtoList = new ArrayList<DayDto>();
					for (DayDto dayDto : monthDto.getDayDtoList()) {
						DayDto myDayDto = new DayDto();
						myDayDto.setDate(dayDto.getDate());
						String dayDtoStr = DateUtil.format(dayDto.getDate(), "yyyy-MM-dd");
						WorkDayReport workDayReport = map.get(key).get(dayDtoStr);
						if (workDayReport == null) {
							myDayDto.setDaySign(0);
						} else {
							Long time = workDayReport.getModifyTime().getTime()- workDayReport.getCurDate().getTime();
							Long k = (time) / 1000 / 3600 / 24;
							day = k / 7;
							if (day <= 1) {
								myDayDto.setDaySign(2);//正常期限(一周内)提交周报
							} else {
								myDayDto.setDaySign(1);
								myDayDto.setLateSignInNum(Integer.parseInt(k+""));
							}
						}
						dayDtoList.add(myDayDto);
					}
					BeanUtil.copyProperties(monthDto, myMonthDto);
					myMonthDto.setDayDtoList(dayDtoList);
					myList.add(myMonthDto);
				}
				dto.setMonthDtoList(myList);
				workCountDtoList.add(dto);
			}
		return "dayCountList";
	}
	
	//部门日报汇总
	public String depCountList(){
		if (yearStr!= null) {
			try {
				date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(yearStr);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}else if(monthStr!=null){
			try {
				date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(monthStr);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}else {
			date = new Date();
		}
		prevYear = CalendarUtil.add(date, Calendar.YEAR, -1).getTime();
		nextYear = CalendarUtil.add(date, Calendar.YEAR, 1).getTime();
		prevMonth = CalendarUtil.add(date, Calendar.MONTH, -1).getTime();
		nextMonth = CalendarUtil.add(date, Calendar.MONTH, 1).getTime();
		monthDtoList = ScheduleUtil.workDayCount(date);
		MonthDto monthDto = monthDtoList.get(0);
		year = monthDto.getYear();
		mon = monthDto.getMonth();
		
		List<TaskDepart> taskDeparts = departService.getListByFilter(new Filter(TaskDepart.class)).getValue();
		workCountDtoList = new ArrayList<WorkCountDto>();
		String orgIds = ",";
		for(TaskDepart taskDepart : taskDeparts){
			if(taskDepart.getOrgId()!=null){
				orgIds += taskDepart.getOrgId()+",";
			}
		}
		
		List<WorkDayReport> workDayReportList = workDayReportService.getListByFilter(new Filter(WorkDayReport.class).eq("yearNo", year).eq("monthNo", mon).eq("status", WorkReportStatusEnum.REPORTED)).getValue();
		Map<String, WorkDayReport> workMap = new HashMap<String, WorkDayReport>();
		for (WorkDayReport workDayReport : workDayReportList) {
			if(workDayReport.getReporter().getOrg()!=null){
				if(orgIds.contains(","+workDayReport.getReporter().getOrg().getId()+",")){
					String userKey = DateUtil.format(workDayReport.getCurDate(), "yyyy-MM-dd");
					workMap.put(userKey, workDayReport);
				}
			}
		}
		for(TaskDepart taskDepart : taskDeparts){
			WorkCountDto dto = new  WorkCountDto();
			dto.setUsername(taskDepart.getName());
			List<MonthDto> newMonthList = new ArrayList<MonthDto>();
			for(MonthDto mdto : monthDtoList){
				MonthDto newMonthDto = new MonthDto();
				List<DayDto> newDayList = new ArrayList<DayDto>();
				for(DayDto dayDto : mdto.getDayDtoList()){
					DayDto newDayDto = new DayDto();
					String date = DateUtil.format(dayDto.getDate(), "yyyy-MM-dd");
					if(taskDepart.getOrgId()==null){
						newDayDto.setLateSignInNum(0);
					}else{
						if(workMap.get(date)!=null && workMap.get(date).getReporter().getOrg().getId().equals(taskDepart.getOrgId())){
							newDayDto.setLateSignInNum(1);
							dto.setId(taskDepart.getOrgId());
						}else{
							newDayDto.setLateSignInNum(0);
						}
					}
					newDayDto.setDate(dayDto.getDate());
					newDayList.add(newDayDto);
				}
				BeanUtil.copyProperties(mdto, newMonthDto);
				newMonthDto.setDayDtoList(newDayList);
				newMonthList.add(newMonthDto);
			}
			dto.setMonthDtoList(newMonthList);
			workCountDtoList.add(dto);
		}
		
		return "depCountList";
	}
	
	//查看部门日报
	public String viewDepWork(){
		OrgPubService orgPubService=OaActivator.getService(OrgPubService.class);
		List<Org> orgList = orgPubService.getOrgList();
		Map<Long,String> orgMap = new HashMap<Long, String>();
		for(Org org : orgList){
			orgMap.put(org.getId(), org.getName());
		}
		String depName = orgMap.get(id);
		ServletActionContext.getRequest().setAttribute("depName", depName);
		List<WorkDayDto> workDayDtoList = new ArrayList<WorkDayDto>();
		
		Integer yearNo = Integer.parseInt(dateStr.substring(0,4));
		Integer monthNo = Integer.parseInt(dateStr.substring(5,7));
		Integer dayNo = Integer.parseInt(dateStr.substring(8,10));
		List<WorkDayReport> workDayReportList = workDayReportService.getListByFilter(new Filter(WorkDayReport.class).createAlias("reporter", "reporter").eq("reporter.org.id", id).eq("yearNo", yearNo).eq("monthNo", monthNo).eq("dayNo", dayNo)).getValue();
		UserPubService userPubService=OaActivator.getService(UserPubService.class);
		List<User> centerUserList=userPubService.getCenterUserList();
		for(User user : centerUserList){
			if(user.getOrg().getId().equals(id)){
			WorkDayDto dto = new WorkDayDto();
			dto.setTitle(user.getRealName());
			for(WorkDayReport wdr : workDayReportList){
				int num = 1;
				if(wdr.getReporterId().equals(user.getId())){
					String[] cc = wdr.getContent().split("`_`");
					String text = "";
					for(String c2 : cc){
						if(!c2.equals("null")){
							text += num+"、"+c2+"<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
							num++;
						}
					}
					dto.setStatus(text);
				}
			}
			workDayDtoList.add(dto);
			}
		}
		ServletActionContext.getRequest().setAttribute("workDayDtoList", workDayDtoList);
		return "viewDepWork";
	}
	
	@Override
	protected List<WorkDayReport> getListByFilter(Filter filter) {
		return workDayReportService.getListByFilter(filter).getValue();
	}

	public WorkDayReport getWorkDayReport() {
		return workDayReport;
	}

	public void setWorkDayReport(WorkDayReport workDayReport) {
		this.workDayReport = workDayReport;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Result getResult() {
		return result;
	}

	public void setResult(Result result) {
		this.result = result;
	}

	public void setWorkDayReportService(WorkDayReportService workDayReportService) {
		this.workDayReportService = workDayReportService;
	}

	public void setTaskService(TaskService taskService) {
		this.taskService = taskService;
	}

	public void setWorkReportConfigService(
			WorkReportConfigService workReportConfigService) {
		this.workReportConfigService = workReportConfigService;
	}

	public List<WorkReportConfig> getWorkReportConfigList() {
		return workReportConfigList;
	}

	public void setWorkReportConfigList(List<WorkReportConfig> workReportConfigList) {
		this.workReportConfigList = workReportConfigList;
	}

	public List<MonthDto> getMonthDtoList() {
		return monthDtoList;
	}

	public void setMonthDtoList(List<MonthDto> monthDtoList) {
		this.monthDtoList = monthDtoList;
	}

	public Integer getMyWeek() {
		return myWeek;
	}

	public void setMyWeek(Integer myWeek) {
		this.myWeek = myWeek;
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

	public String getYearStr() {
		return yearStr;
	}

	public void setYearStr(String yearStr) {
		this.yearStr = yearStr;
	}

	public String getMonthStr() {
		return monthStr;
	}

	public void setMonthStr(String monthStr) {
		this.monthStr = monthStr;
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

	public Integer getYear() {
		return year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}

	public Integer getMon() {
		return mon;
	}

	public void setMon(Integer mon) {
		this.mon = mon;
	}

	public List<WorkCountDto> getWorkCountDtoList() {
		return workCountDtoList;
	}

	public void setWorkCountDtoList(List<WorkCountDto> workCountDtoList) {
		this.workCountDtoList = workCountDtoList;
	}
	public void setDepartService(TaskDepartService departService) {
		this.departService = departService;
	}

	public Long getDay() {
		return day;
	}

	public void setDay(Long day) {
		this.day = day;
	}
	public List<Integer> getYears() {
		return years;
	}

	public void setYears(List<Integer> years) {
		this.years = years;
	}
	public String getSelectDate() {
		return selectDate;
	}

	public void setSelectDate(String selectDate) {
		this.selectDate = selectDate;
	}
	
}
