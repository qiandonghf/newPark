package com.wiiy.web.job;

import java.util.TimerTask;

import org.springframework.context.ApplicationContext;

public abstract class RepeatJob {
	
	protected ApplicationContext applicationContext;
	
	public RepeatJob(ApplicationContext applicationContext) {
		this.applicationContext = applicationContext;
		/*init();*/
	}
	
	public void start() {
		init();
	}
	
	public void init(){
	}
	
	protected abstract void execute();
	
	class JobTask extends TimerTask{
		@Override
		public void run() {
			execute();
		}
	
	}

}
