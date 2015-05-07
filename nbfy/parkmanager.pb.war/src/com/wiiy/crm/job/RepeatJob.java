package com.wiiy.crm.job;

import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import org.springframework.context.ApplicationContext;

import com.wiiy.commons.util.CalendarUtil;

public abstract class RepeatJob {
	
	protected ApplicationContext applicationContext;
	
	public RepeatJob(ApplicationContext applicationContext) {
		this.applicationContext = applicationContext;
//		init();
	}
	
	public void start() {
		init();
	}
	
	public void init(){
		new Timer().schedule(new JobTask(),CalendarUtil.getEarliest(CalendarUtil.add(new Date(), Calendar.DAY_OF_YEAR, 1).getTime(), Calendar.DAY_OF_YEAR), 1000*60*60*24);
	}
	
	protected abstract void execute();
	
	class JobTask extends TimerTask{
		@Override
		public void run() {
			execute();
		}
	
	}

}
