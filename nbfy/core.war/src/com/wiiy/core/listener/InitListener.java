package com.wiiy.core.listener;

import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.wiiy.commons.activator.AbstractActivator.CachedLog;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.GenderEnum;
import com.wiiy.commons.preferences.enums.UserTypeEnum;
import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.dto.Module;
import com.wiiy.core.entity.AuthorityType;
import com.wiiy.core.entity.Org;
import com.wiiy.core.entity.Role;
import com.wiiy.core.entity.RoleAuthorityRef;
import com.wiiy.core.entity.User;
import com.wiiy.core.entity.UserRoleRef;
import com.wiiy.core.service.DBService;
import com.wiiy.core.service.export.ModuleService;
import com.wiiy.core.service.export.RoleAuthorityRefService;
import com.wiiy.core.service.OrgService;
import com.wiiy.core.service.RoleService;
import com.wiiy.core.service.UserRoleRefService;
import com.wiiy.core.service.UserService;
import com.wiiy.core.service.export.AppConfig.Config;


public class InitListener implements ServletContextListener{
	protected CachedLog logger = CachedLog.getLog(getClass());
	public static ServletContext servletContext;
	private static int cnt=0;
	@Override
	public void contextDestroyed(ServletContextEvent servletContextEvent) {
	}
	
	class DBBackupJobTask extends TimerTask{
		
		private ServletContextEvent servletContextEvent;
		public DBBackupJobTask(ServletContextEvent servletContextEvent) {
			this.servletContextEvent = servletContextEvent;
		}
		
		@Override
		public void run() {
			logger.debug("------++++++++++++++++DBBackupJobTask start++++++++++++++++--------");
			try {
				Config config=CoreActivator.getAppConfig().getConfig("dbBackupConfig");
				
//				if(cnt==0){
//					
//					//logger.debug("------++++++++++++++++数据库备份开始++++++++++++++++--------");
//					//ApplicationContext applicationContext = WebApplicationContextUtils.getWebApplicationContext(servletContextEvent.getServletContext());
//					//DBService dbService = applicationContext.getBean(DBService.class);
//					//dbService.doBackup();
//					
//					cnt++;
//				}
//				else{
					String time=config.getParameter("time");
					int nowHour=new Date().getHours();
					int backupHour=Integer.parseInt(time);
					logger.debug("nowHour="+nowHour+",backupHour="+backupHour);
					if(nowHour==backupHour){
						logger.debug("------++++++++++++++++数据库备份开始++++++++++++++++--------");
						ApplicationContext applicationContext = WebApplicationContextUtils.getWebApplicationContext(servletContextEvent.getServletContext());
						DBService dbService = applicationContext.getBean(DBService.class);
						dbService.doBackup();
						logger.debug("------++++++++++++++++数据库备份成功++++++++++++++++--------");
					}
//				}
				
			} catch (BeansException e) {
				e.printStackTrace();
				logger.debug("------++++++++++++++++数据库备份失败++++++++++++++++--------");
			} catch (Exception e) {
				e.printStackTrace();
				logger.debug("------++++++++++++++++数据库备份失败++++++++++++++++--------");
			}
		}
	}
	@Override
	public void contextInitialized(ServletContextEvent servletContextEvent) {
		servletContext=servletContextEvent.getServletContext();
		new Timer().schedule(new DBBackupJobTask(servletContextEvent), 1000*90,3500*1000);//延迟启动
	}
	
	
	
}
