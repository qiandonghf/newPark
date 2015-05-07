package com.wiiy.cloud.capture.listener;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.wiiy.cloud.capture.demo.NingBo;
import com.wiiy.cloud.capture.job.NewsJob;



public class InitListener implements ServletContextListener{

	@Override
	public void contextDestroyed(ServletContextEvent servletContextEvent) {
	}
	
	class JobTask extends TimerTask{
		
		private ServletContextEvent servletContextEvent;
		public JobTask(ServletContextEvent servletContextEvent) {
			this.servletContextEvent = servletContextEvent;
		}
		@Override
		public void run() {
//			ApplicationContext applicationContext = WebApplicationContextUtils.getWebApplicationContext(servletContextEvent.getServletContext());
//			new NingBo(applicationContext);
//			new NewsJob(applicationContext);
		}
	}
	
	@Override
	public void contextInitialized(ServletContextEvent servletContextEvent) {
//		new Timer().schedule(new JobTask(servletContextEvent),1000*60);//延迟启动
	}

}
