package com.wiiy.core.service.impl;

import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.service.export.RemindEmailService;

/***
 * 
 * @author Administrator
 *提醒邮件连接
 */
public class RemindEmailServiceImpl implements RemindEmailService {

	@Override
	public String getRemindEmailLink() {
		return CoreActivator.getAppConfig().getConfig("msgLink").getParameter("name");
	}

	@Override
	public String getRemindEmailLogo() {
		return CoreActivator.getAppConfig().getConfig("msgLogo").getParameter("name");
	}
}
