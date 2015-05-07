package com.wiiy.oa.action;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dto.DateDto;
import com.wiiy.oa.dto.DayDto;
import com.wiiy.oa.entity.Schedule;
import com.wiiy.oa.preferences.enums.PromotEnum;
import com.wiiy.oa.preferences.enums.RepeatEnum;
import com.wiiy.oa.service.ScheduleService;

public class ScheduleAction extends JqGridBaseAction<Schedule>{
	
	private ScheduleService scheduleService;
	private List<DateDto> dateDtoList = new ArrayList<DateDto>();

	private List<Schedule> schedules;
	private Schedule schedule;
	private Result result;
	private Long id;
	private String ids;
	private Date scheduledDay = new Date();
	private String monthAction = "";//"pre next"
	
	
	public String view(){
		result = scheduleService.getBeanById(id);
		return VIEW;
	}
	
	public String workBenchSchedule(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar calendar = Calendar.getInstance();
		Date startDate;
		Date endDate;
		try {
			String startTime = sdf.format(CalendarUtil.getEarliest(calendar.getTime(),Calendar.DAY_OF_YEAR));
			calendar.add(Calendar.DATE, 2);    
			String endTime = sdf.format(CalendarUtil.getLatest(calendar.getTime(),Calendar.DAY_OF_YEAR));
			startDate = sdf.parse(startTime);
			endDate = sdf.parse(endTime);
			schedules = scheduleService.getListByFilter(new Filter(Schedule.class).between("startTime", startDate, endDate).orderBy("startTime",Filter.ASC).maxResults(4)).getValue();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return "workBenchSchedule";
	}

	public String promotCount(){
		Date[][] days = CalendarUtil.generateCalendar(scheduledDay, Calendar.MONDAY);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date startDate;
		Date endDate;
		try {
			String startTime = sdf.format(CalendarUtil.getEarliest(days[0][0],Calendar.DAY_OF_MONTH));
			String endTime = sdf.format(CalendarUtil.getLatest(days[days.length-1][days[days.length-1].length-1],Calendar.DAY_OF_MONTH));
			startDate = sdf.parse(startTime);
			endDate = sdf.parse(endTime);
			schedules = scheduleService.getListByFilter(new Filter(Schedule.class).eq("ownerId", OaActivator.getSessionUser().getId()).between("startTime", startDate, endDate).orderBy("startTime",Filter.ASC)).getValue();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		result = Result.value(schedules.size());
		return JSON;
	}
	public String remindCount(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		Date thisDate;
		List<Schedule> list = new ArrayList<Schedule>();
		try {
			String thisTime = sdf.format(CalendarUtil.getEarliest(date,Calendar.DAY_OF_MONTH));
			thisDate = sdf.parse(thisTime);
			list = scheduleService.getListByFilter(new Filter(Schedule.class).eq("ownerId", OaActivator.getSessionUser().getId()).ge("promotTime", thisDate).ne("promot", PromotEnum.NOPROMOT).isNull("parentId").orderBy("promotTime",Filter.DESC)).getValue();
		} catch (Exception e) {
			e.printStackTrace();
		}
		result = Result.value(list.size());
		return JSON;
	}
	
	public String save(){
		result = scheduleService.save(schedule);
		return JSON;
	}
	
	public String edit(){
		result = scheduleService.getBeanById(id);
		return EDIT;
	}
	
	public String delete(){
		if(id!=null){
			result = scheduleService.deleteById(id);
		} else if(ids!=null){
			result = scheduleService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String update(){
		if(schedule.getSms()==null)schedule.setSms(BooleanEnum.NO);
		if(schedule.getEmail()==null)schedule.setEmail(BooleanEnum.NO);
		if(schedule.getDefaultEmail()==null)schedule.setDefaultEmail(BooleanEnum.NO);
		Schedule dbBean = scheduleService.getBeanById(schedule.getId()).getValue();
		BeanUtil.copyProperties(schedule, dbBean);
		result = scheduleService.update(dbBean);
		return JSON;
	}
	
	public String remind(){
		result = scheduleService.getListByFilter(new Filter(Schedule.class).eq("ownerId", OaActivator.getSessionUser().getId()).ne("promot", PromotEnum.NOPROMOT).isNull("parentId").orderBy("promotTime",Filter.DESC));
		return "remind";
	}
	public String remindList(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		Date thisDate;		
		List<Schedule> list = new ArrayList<Schedule>();
		try {
			String thisTime = sdf.format(CalendarUtil.getEarliest(date,Calendar.DAY_OF_MONTH));
			thisDate = sdf.parse(thisTime);
			list = scheduleService.getListByFilter(new Filter(Schedule.class).eq("ownerId", OaActivator.getSessionUser().getId()).ne("promot", PromotEnum.NOPROMOT).isNull("parentId").orderBy("promotTime",Filter.DESC).eq("promotTime", thisDate)).getValue();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		result = Result.value(list);
		return "remind";
	}
	
	public String list(){
		if(monthAction.equals("prev")){
			Calendar c = CalendarUtil.getCalendarInstance(scheduledDay);
			c.add(Calendar.MONTH, -1);
			scheduledDay = c.getTime();
		}else if(monthAction.equals("next")){
			Calendar c = CalendarUtil.getCalendarInstance(scheduledDay);
			c.add(Calendar.MONTH, 1);
			scheduledDay = c.getTime();
		}
		Date[][] days = CalendarUtil.generateCalendar(scheduledDay, Calendar.MONDAY);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date startDate;
		Date endDate;
		try {
			String startTime = sdf.format(CalendarUtil.getEarliest(days[0][0],Calendar.DAY_OF_MONTH));
			String endTime = sdf.format(CalendarUtil.getLatest(days[days.length-1][days[days.length-1].length-1],Calendar.DAY_OF_MONTH));
			startDate = sdf.parse(startTime);
			endDate = sdf.parse(endTime);
			schedules = scheduleService.getListByFilter(new Filter(Schedule.class).eq("ownerId", OaActivator.getSessionUser().getId()).between("startTime", startDate, endDate).orderBy("startTime",Filter.ASC)).getValue();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		Map<Long,List<Schedule>> scheduleMap = new HashMap<Long,List<Schedule>>();
		if(schedules!=null&&schedules.size()>0){
			for (Schedule schedule : schedules) {
				Long key = CalendarUtil.getEarliest(schedule.getStartTime(),Calendar.DAY_OF_MONTH).getTime();
				List<Schedule> list = scheduleMap.get(key);
				if(list==null){
					list = new ArrayList<Schedule>();
					scheduleMap.put(key, list);
				}
				list.add(schedule);
			}
		}
		List<DayDto> dayDtoList = new ArrayList<DayDto>();
		for (int i = 0; i < days.length; i++) {
			boolean weekFlag = false;
			Long startTime = CalendarUtil.getEarliest(days[i][0],Calendar.DAY_OF_MONTH).getTime();
			Long endTime = CalendarUtil.getLatest(days[i][days[i].length-1],Calendar.DAY_OF_MONTH).getTime();
			weekFlag = (startTime<scheduledDay.getTime()|startTime == scheduledDay.getTime()) && (endTime>scheduledDay.getTime()|endTime==scheduledDay.getTime());
			for (int j = 0; j < days.length+1; j++) {
				DayDto dto = new DayDto();
				Date date = days[i][j];
				Long key = CalendarUtil.getEarliest(date,Calendar.DAY_OF_MONTH).getTime();
				dto.setDate(date);
				dto.setDay(DateUtil.format(date,"d"));
				dto.setCheckedDay(DateUtil.format(date, "yyyy-MM-dd").equals(DateUtil.format(scheduledDay, "yyyy-MM-dd")));
				dto.setThisMonth(DateUtil.format(date, "MM").equals(DateUtil.format(scheduledDay, "MM")));
				dto.setNowDate(key==CalendarUtil.getEarliest(new Date(),Calendar.DAY_OF_MONTH).getTime());
				List<Schedule> list = scheduleMap.get(key);
				dto.setThisWeek(weekFlag);
				dto.setSchedules(list);
				dayDtoList.add(dto);
			}
		}
		result = Result.value(dayDtoList);
		return LIST;
	}
	
	public String getMonthAction() {
		return monthAction;
	}

	public void setMonthAction(String monthAction) {
		this.monthAction = monthAction;
	}

	@Override
	protected List<Schedule> getListByFilter(Filter fitler) {
		return scheduleService.getListByFilter(fitler).getValue();
	}

	public Schedule getSchedule() {
		return schedule;
	}

	public void setSchedule(Schedule schedule) {
		this.schedule = schedule;
	}

	public Result getResult() {
		return result;
	}

	public void setResult(Result result) {
		this.result = result;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public void setScheduleService(ScheduleService scheduleService) {
		this.scheduleService = scheduleService;
	}


	public Date getScheduledDay() {
		return scheduledDay;
	}

	public void setScheduledDay(Date scheduledDay) {
		this.scheduledDay = scheduledDay;
	}

	public List<DateDto> getDateDtoList() {
		return dateDtoList;
	}

	public void setDateDtoList(List<DateDto> dateDtoList) {
		this.dateDtoList = dateDtoList;
	}
	public List<Schedule> getSchedules() {
		return schedules;
	}

	public void setSchedules(List<Schedule> schedules) {
		this.schedules = schedules;
	}

}
