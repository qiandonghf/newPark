package com.wiiy.oa.listener;

import java.util.LinkedList;
import java.util.Queue;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.wiiy.oa.job.RepeatJob;
import com.wiiy.oa.job.ScheduleJob;
import com.wiiy.oa.job.SmsJob;
import com.wiiy.oa.job.StaffContractJob;
import com.wiiy.oa.job.TaskJob;
import com.wiiy.oa.job.TaskTimeoutJob;

public class InitListener implements ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent servletContextEvent) {
	}

	class JobTask extends TimerTask {

		private ServletContextEvent servletContextEvent;
		private ApplicationContext applicationContext;
		private Queue<RepeatJob> taskQueue = new LinkedList<RepeatJob>();
		private Timer timer;

		public JobTask(ServletContextEvent servletContextEvent) {
			this.servletContextEvent = servletContextEvent;
			applicationContext = WebApplicationContextUtils
					.getWebApplicationContext(servletContextEvent
							.getServletContext());
			taskQueue.add(new ScheduleJob(applicationContext));
			taskQueue.add(new TaskJob(applicationContext));
			taskQueue.add(new SmsJob(applicationContext));
			taskQueue.add(new TaskTimeoutJob(applicationContext));
			taskQueue.add(new StaffContractJob(applicationContext));
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
					1000 * 60);// 延迟启动
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

}
