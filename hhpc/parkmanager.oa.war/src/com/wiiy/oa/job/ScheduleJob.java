package com.wiiy.oa.job;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Timer;

import org.springframework.context.ApplicationContext;

import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.external.service.SMSPubService;
import com.wiiy.external.service.SysEmailSenderPubService;
import com.wiiy.hibernate.Filter;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.entity.Schedule;
import com.wiiy.oa.preferences.enums.PromotEnum;
import com.wiiy.oa.preferences.enums.RepeatEnum;
import com.wiiy.oa.service.ScheduleService;
import com.wiiy.oa.util.RemindUtil;
import com.wiiy.oa.util.ScheduleUtil;

public class ScheduleJob extends RepeatJob{
	
	private ScheduleService scheduleService;
	
	public ScheduleJob(ApplicationContext applicationContext) {
		super(applicationContext);
		scheduleService = applicationContext.getBean(ScheduleService.class);
	}
	public void init(){
		new Timer().schedule(new JobTask(),CalendarUtil.getEarliest(CalendarUtil.add(new Date(), Calendar.DAY_OF_YEAR, 1).getTime(), Calendar.DAY_OF_YEAR), 1000*60*60*24);
	}
	
	@Override
	protected void execute() {
		//查询日程提醒（提醒方式除不重复，开始时间在当天时间内）
		List<Schedule> list = scheduleService.getListByFilter(new Filter(Schedule.class).ne("repeatType",RepeatEnum.NOREPEAT).between("startTime", CalendarUtil.getEarliest(Calendar.DAY_OF_MONTH), CalendarUtil.getLatest(Calendar.DAY_OF_MONTH))).getValue();
		//查询当天需要提醒的日程(开始时间小于或等于当天时间，提醒时间在当天内)
		List<Schedule> remindList = scheduleService.getListByFilter(new Filter(Schedule.class).ne("repeatType",RepeatEnum.NOREPEAT).le("startTime", CalendarUtil.getLatest(Calendar.DAY_OF_MONTH)).between("promotTime", CalendarUtil.getEarliest(Calendar.DAY_OF_MONTH), CalendarUtil.getLatest(Calendar.DAY_OF_MONTH))).getValue();
		//邮件/短信提醒
		if(remindList!=null && remindList.size()>0){
			for (Schedule schedule : remindList) {
				SMSPubService smsPubService = OaActivator.getService(SMSPubService.class);
				SysEmailSenderPubService sysEmailSenderPubService = OaActivator.getService(SysEmailSenderPubService.class);	
				if(smsPubService!=null && smsActive()){
					if(schedule.getSms().equals(BooleanEnum.YES)){
						String content = OaActivator.getAppConfig().getConfig("scheduleRemind").getParameter("smsModule");
						content = content.replace("${title}", schedule.getTitle());
						String receiverMobile = OaActivator.getSessionUser().getMobile();
						String receiverName = OaActivator.getSessionUser().getRealName();
						smsPubService.sendByAdmin(receiverMobile, content, receiverName);
					}
				}
				if(sysEmailSenderPubService!=null && emailActive()){
					if(schedule.getEmail().equals(BooleanEnum.YES)||schedule.getDefaultEmail().equals(BooleanEnum.YES)){
						String content = RemindUtil.parseHTML("web/msgRemindModule/msgRemindModule.html").toString();
						String subject = "日程提醒";
						String receviceName =  OaActivator.getSessionUser().getRealName();
						content = content.replace("${subject}", schedule.getTitle());
						content = content.replace("${msgType}", "日程提醒");
						content = content.replace("${url}", RemindUtil.basePath()+"parkmanager.oa/schedule!view.action?id="+schedule.getId());
						content = content.replace("${receiver}",receviceName);
						content = content.replace("${customerName}",receviceName);
						Long userId = Long.valueOf(OaActivator.getAppConfig().getConfig("center").getParameter("name"));
						String userName = OaActivator.getUserById(userId).getRealName();
						content = content.replace("${sender}", userName);
						content = content.replace("${content}", schedule.getMemo());
						content = content.replace("${msgLink}", OaActivator.getHttpSessionService().getRemindEmailLink());
						sysEmailSenderPubService.send(OaActivator.getSessionUser().getEmail(), content, subject);
					}
				}
			}
		}
		if(list!=null && list.size()>0){
			//根据以上条件查询出的日程查询父日程
			List<Long> scheduleParentIds = new ArrayList<Long>();
			for(Schedule schedule:list){
				if(schedule.getParentId()!=null){
					scheduleParentIds.add(schedule.getParentId());
				}else{
					scheduleParentIds.add(schedule.getId());
				}
			}
			//根据以上条件查询出开始时间在第二天的日程
			Map<Long,Schedule> nextScheduleMap = new HashMap<Long, Schedule>();
			if(scheduleParentIds!=null && scheduleParentIds.size()>0){
				if(scheduleParentIds!=null && scheduleParentIds.size()>0){
					List<Schedule> existList = scheduleService.getListByFilter(new Filter(Schedule.class).ge("startTime", CalendarUtil.getEarliest(CalendarUtil.add(Calendar.DAY_OF_MONTH, 1).getTime(),Calendar.DAY_OF_MONTH)).in("parentId", scheduleParentIds.toArray())).getValue();
					for(Schedule schedule:existList){
						nextScheduleMap.put(schedule.getParentId(), schedule);
					}
				}
			}
			//建立下一时间的日程
			List<Schedule> insertList = new ArrayList<Schedule>();
			for (Schedule schedule : list) {
				//根据重复规则及重复开始时间生成下一个重复的时间
				Date nextStartDate = ScheduleUtil.getNextRepeatDate(schedule.getStartTime(), schedule.getRepeatType());
				if(schedule.getParentId()==null){
					if(nextScheduleMap.get(schedule.getId())!=null && nextScheduleMap.get(schedule.getId()).getStartTime()!=schedule.getStartTime()){
						continue;
					} else {
						Schedule next = new Schedule();
						BeanUtil.copyProperties(schedule, next);
						next.setParentId(schedule.getId());
						next.setStartTime(nextStartDate);
						if(next.getPromot().equals(PromotEnum.LASTDAY)){
							next.setPromotTime(CalendarUtil.add(next.getStartTime(), Calendar.DAY_OF_MONTH, -1).getTime());
						}else if(next.getPromot().equals(PromotEnum.CURRENTDAY)){
							next.setPromotTime(nextStartDate);
						}else if(next.getPromot().equals(PromotEnum.NOW)){
							next.setPromotTime(nextStartDate);
						}
						if(schedule.getEndTime()!=null){
							next.setEndTime(ScheduleUtil.getNextRepeatDate(schedule.getEndTime(), schedule.getRepeatType()));
						}
						insertList.add(next);
					}
				} else {
					if(nextScheduleMap.get(schedule.getParentId())!=null && nextScheduleMap.get(schedule.getParentId()).getStartTime()!=schedule.getStartTime()){
						continue;
					} else {
						Schedule next = new Schedule();
						BeanUtil.copyProperties(schedule, next);
						next.setStartTime(nextStartDate);
						if(next.getPromot().equals(PromotEnum.LASTDAY)){
							next.setPromotTime(CalendarUtil.add(next.getStartTime(), Calendar.DAY_OF_MONTH, -1).getTime());
						}else if(next.getPromot().equals(PromotEnum.CURRENTDAY)){
							next.setPromotTime(next.getStartTime());
						}else if(next.getPromot().equals(PromotEnum.NOW)){
							next.setPromotTime(nextStartDate);
						}
						if(schedule.getEndTime()!=null){
							next.setEndTime(ScheduleUtil.getNextRepeatDate(schedule.getEndTime(), schedule.getRepeatType()));
						}
						insertList.add(next);
					}
				}
			}
            scheduleService.save(insertList);
		}
	}
	private boolean emailActive(){
		String msgSet =  OaActivator.getAppConfig().getConfig("scheduleRemind").getParameter("email");
		if(msgSet.equals("active")){
			return true;
		}else{
			return false;
		}
	}
	
	private boolean smsActive(){
		String msgSet =  OaActivator.getAppConfig().getConfig("scheduleRemind").getParameter("sms");
		if(msgSet.equals("active")){
			return true;
		}else{
			return false;
		}
	}
}
