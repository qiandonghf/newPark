package com.wiiy.cloud.capture.job;

import java.util.Timer;
import java.util.TimerTask;

import org.springframework.context.ApplicationContext;


public abstract class WebJob {
protected ApplicationContext applicationContext;
	public WebJob(ApplicationContext applicationContext) {
		this.applicationContext = applicationContext;
		init();
	}
	
	public void init(){
		new Timer().schedule(new JobTask(),1000*10, 1000*60*60);
	}
	
	protected abstract void execute();
	
    class JobTask extends TimerTask{
		@Override
		public void run() {
			execute();
		}
	}

}
