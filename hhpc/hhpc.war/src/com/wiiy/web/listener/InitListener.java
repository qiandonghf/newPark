package com.wiiy.web.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.wiiy.cms.entity.Param;
import com.wiiy.cms.service.ParamService;
import com.wiiy.cms.service.impl.ParamServiceImpl;
import com.wiiy.commons.activator.AbstractActivator.CachedLog;
import com.wiiy.core.service.export.AppConfig.Config;
import com.wiiy.web.Activator;
import com.wiiy.web.job.RepeatJob;
import com.wiiy.web.job.SendEmailJob;


public class InitListener implements ServletContextListener{
	protected CachedLog logger = CachedLog.getLog(getClass());
	public static ServletContext servletContext;
	public static Long webID=4l;
	public static Integer sendDate = 1;
	public static Param webParam;
	@Override
	public void contextDestroyed(ServletContextEvent servletContextEvent) {
	}
	
	
	@Override
	public void contextInitialized(ServletContextEvent servletContextEvent) {
		servletContext=servletContextEvent.getServletContext();
		Config config=Activator.getAppConfig().getConfig("webID");
		String code=config.getParameter("code");
		config=Activator.getAppConfig().getConfig("sendDate");
		String date = config.getParameter("code");
		try {
			webID=Long.parseLong(code);
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			sendDate = Integer.parseInt(date);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		ApplicationContext applicationContext = WebApplicationContextUtils.getWebApplicationContext(servletContextEvent.getServletContext());
		//ApplicationContext applicationContext1 = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContextEvent.getServletContext());
		
		ParamService paramService = applicationContext.getBean(ParamServiceImpl.class);
		//ParamService paramService1 = applicationContext1.getBean(ParamService.class);
		
		webParam=paramService.getBeanById(webID).getValue();
		
		//启动发送短信JOB
		RepeatJob job = new SendEmailJob(applicationContext);
		job.start();
	}
	
	
	
}
