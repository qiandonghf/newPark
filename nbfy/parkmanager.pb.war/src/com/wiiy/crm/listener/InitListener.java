package com.wiiy.crm.listener;

import java.util.Date;
import java.util.LinkedList;
import java.util.Queue;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.wiiy.crm.entity.DataCheck;
import com.wiiy.crm.job.BillArrearsJob;
import com.wiiy.crm.job.BillPlanCheckJob;
import com.wiiy.crm.job.BillPlanRentCheckoutJob;
import com.wiiy.crm.job.ContractExpiredCheckJob;
import com.wiiy.crm.job.ContractExpiredJob;
import com.wiiy.crm.job.DataCheckJob;
import com.wiiy.crm.job.DataReportToCustomerJob;
import com.wiiy.crm.job.RepeatJob;
import com.wiiy.crm.job.RoomStatusCheckJob;
import com.wiiy.crm.preferences.enums.CheckStatusEnum;
import com.wiiy.crm.service.DataCheckService;

public class InitListener implements ServletContextListener{
	@Override
	public void contextDestroyed(ServletContextEvent servletContextEvent) {
	}
	
class JobTask extends TimerTask{
		
		private ServletContextEvent servletContextEvent;
		private ApplicationContext applicationContext;
		private Timer timer;
		private Queue<RepeatJob> taskQueue = new LinkedList<RepeatJob>();
		
		public JobTask(ServletContextEvent servletContextEvent) {
			this.servletContextEvent = servletContextEvent;
			applicationContext = WebApplicationContextUtils
					.getWebApplicationContext(servletContextEvent
							.getServletContext());
			taskQueue.add(new BillArrearsJob(applicationContext));
			taskQueue.add(new BillPlanCheckJob(applicationContext));
			taskQueue.add(new BillPlanRentCheckoutJob(applicationContext));
			taskQueue.add(new ContractExpiredJob(applicationContext));
			taskQueue.add(new DataReportToCustomerJob(applicationContext));
		}

		@Override
		public void run() {
			timer = new Timer();
			timer.schedule(new TimerTask() {
				@Override
				public void run() {
					while (!taskQueue.isEmpty()) {
						RepeatJob job = taskQueue.peek();
						try {
							job.start();
							taskQueue.poll();
							System.out.println("--------------------");
							System.out.println("JOB启动成功");
							System.out.println("--------------------");
						} catch (Throwable e) {
							System.err.println("--------------------");
							System.out.println("JOB启动失败，稍后再次启动");
							System.err.println("--------------------");
							// 跳出等待
							break;
						}
					}
					timer.cancel();
				}
			}, 1000, 1000*60);
		}

	}

	@Override
	public void contextInitialized(ServletContextEvent servletContextEvent) {
		try {
			new Timer().schedule(new JobTask(servletContextEvent),
					1000 * 60 );// 延迟启动
			new Timer().schedule(new CheckJobTask(servletContextEvent),
					1000 * 60 );
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	class CheckJobTask extends TimerTask{
		private ServletContextEvent servletContextEvent;
		private ApplicationContext applicationContext;
		
		private DataCheckService dataCheckService;
		
		public CheckJobTask(ServletContextEvent servletContextEvent) {
			this.servletContextEvent = servletContextEvent;
			applicationContext = WebApplicationContextUtils
					.getWebApplicationContext(servletContextEvent
							.getServletContext());
			dataCheckService = applicationContext.getBean(DataCheckService.class);
		}

		@Override
		public void run() {
			DataCheckJob dataCheckJob = new DataCheckJob(applicationContext);
			dataCheckJob.init();
		}
	}
}
