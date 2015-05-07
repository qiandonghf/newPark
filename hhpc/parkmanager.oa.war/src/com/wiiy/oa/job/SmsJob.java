package com.wiiy.oa.job;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import org.springframework.context.ApplicationContext;

import com.wiiy.commons.activator.AbstractActivator.CachedLog;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.external.service.SMSSender;
import com.wiiy.hibernate.Filter;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.entity.Sms;
import com.wiiy.oa.entity.SmsReceiver;
import com.wiiy.oa.service.SmsReceiverService;
import com.wiiy.oa.service.SmsService;

public class SmsJob extends RepeatJob {
	protected CachedLog logger = CachedLog.getLog(getClass());
	private SmsService smsService;
	private SmsReceiverService smsReceiverService;
	private int smsBalance = 1;
	
	private List<Sms> waitList = new ArrayList<Sms>();

	public SmsJob(ApplicationContext applicationContext) {
		super(applicationContext);
		smsService = applicationContext.getBean(SmsService.class);
		smsReceiverService = applicationContext.getBean(SmsReceiverService.class);
		new Timer().schedule(new HeartBeat(), 1000*10, 1000);
		if(logger!=null)
			logger.info("初始化短信发送线程");
	}
	public void init(){
		new Timer().schedule(new JobTask(),1000*10, 1000*60);
		if(logger!=null)logger.info("初始化短信检查线程");
	}
	@Override
	protected void execute() {
		waitList = smsService.getListByFilter(new Filter(Sms.class).between("sendTime", CalendarUtil.getEarliest(Calendar.DAY_OF_MONTH), CalendarUtil.getLatest(Calendar.DAY_OF_MONTH)).eq("sended", BooleanEnum.NO)).getValue();
	}
	
	class HeartBeat extends TimerTask{
		@Override
		public void run() {
			if(smsBalance>0){
				for (Iterator<Sms> it = waitList.iterator(); it.hasNext();) {
					Sms sms = it.next();
					if(sms.getSendTime().getTime()<=CalendarUtil.getEarliest(Calendar.SECOND).getTime()){
						List<SmsReceiver> list = smsReceiverService.getListByFilter(new Filter(SmsReceiver.class).eq("smsId", sms.getId())).getValue();
						List<String> mobiles = new ArrayList<String>();
						for (int i = 0; i < list.size(); i++) {
							mobiles.add(list.get(i).getPhone());
						}
						if(mobiles.size()>0){
							String[] ss = new String[mobiles.size()];
							for (int i = 0; i < ss.length; i++) {
								ss[i] = mobiles.get(i);
							}
							try {
								smsBalance = OaActivator.getService(SMSSender.class).sendSMS(ss, sms.getContent());
							} catch (Exception e) {
								e.printStackTrace();
							}
						}
						sms.setSended(BooleanEnum.YES);
						smsService.updateSmsToSended(sms);
						it.remove();
					}
				}
			}
		}
	}
}