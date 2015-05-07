package com.wiiy.oa.job;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import org.springframework.context.ApplicationContext;

import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.core.entity.User;
import com.wiiy.core.external.service.UserPubService;
import com.wiiy.external.service.SysEmailSenderPubService;
import com.wiiy.hibernate.Filter;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dto.MonthDto;
import com.wiiy.oa.dto.WeekDto;
import com.wiiy.oa.entity.WorkReport;
import com.wiiy.oa.service.WorkReportService;
import com.wiiy.oa.util.ScheduleUtil;

public class WorkReportJob extends RepeatJob{
	
	private WorkReportService workReportService;
	private MonthDto month;
	private WeekDto week;
	private List<User> users = new ArrayList<User>();

	public WorkReportJob(ApplicationContext applicationContext) {
		super(applicationContext);
		workReportService = applicationContext.getBean(WorkReportService.class);
		Calendar lastDayOfWeek = new GregorianCalendar();
		lastDayOfWeek.setFirstDayOfWeek(Calendar.MONDAY);
		lastDayOfWeek.setTime(new Date());
		lastDayOfWeek.set(Calendar.DAY_OF_WEEK, lastDayOfWeek.getFirstDayOfWeek() + 6); //SUNDAY
		new Timer().schedule(new WorkWeekReport(), lastDayOfWeek.getTime());
		Calendar lastDayofMonth = Calendar.getInstance();    
		lastDayofMonth.set(Calendar.DAY_OF_MONTH, lastDayofMonth.getActualMaximum(Calendar.DAY_OF_MONTH));  
		new Timer().schedule(new WorkMonthReport(), lastDayofMonth.getTime());
	}

	@Override
	protected void execute() {
		// 根据当前时间找到对应的时间段(年月周)
		List<MonthDto> monthDtoList = ScheduleUtil.generateMonthWeekList();
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
		UserPubService userPubService=OaActivator.getService(UserPubService.class);
		users = userPubService.getCenterUserList();
	}
	
	class WorkWeekReport extends TimerTask{
		@Override
		public void run() {
			for (User user : users) {
				WorkReport workWeekReport = workReportService.getBeanByFilter(new Filter(WorkReport.class).eq("weekNo", week.getWeek()).eq("yearNo", month.getYear()).eq("reporterId", user.getId())).getValue();
				if(workWeekReport == null){
					String subject = "工作周报填写提醒";
					String receiverEmail = user.getEmail();
					String content = "尊敬的"+user.getRealName()+"；您这周的工作周报还未填写；请您尽快填写";
					sendMail(receiverEmail, content,subject);
				}
			}
		}
		
	}
	
	class WorkMonthReport extends TimerTask{
		@Override
		public void run() {
			for (User user : users) {
				WorkReport workMonthReport = workReportService.getBeanByFilter(new Filter(WorkReport.class).eq("monthNo", month.getMonth()).isNull("weekNo").eq("yearNo",month.getYear()).eq("reporterId",OaActivator.getSessionUser().getId())).getValue();
				if(workMonthReport == null){
					String subject = "工作月报填写提醒";
					String receiverEmail = user.getEmail();
					String content = "尊敬的"+user.getRealName()+"；您这月的工作月报还未填写；请您尽快填写";
					sendMail(receiverEmail, content,subject);
				}
			}
		}
	}
	
	public void sendMail(String receiverEmail,String content,String subject){
		SysEmailSenderPubService sysEmailSenderPubService = OaActivator.getService(SysEmailSenderPubService.class);
		sysEmailSenderPubService.send(receiverEmail, content,subject);
	}
	
}