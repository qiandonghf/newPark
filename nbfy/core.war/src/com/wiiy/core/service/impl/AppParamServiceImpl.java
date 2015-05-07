package com.wiiy.core.service.impl;

import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.service.export.AppParamService;
import com.wiiy.core.service.export.RemindEmailService;

/***
 * 
 * @author Administrator
 * 应用参数
 */
public class AppParamServiceImpl implements AppParamService {

	@Override
	public String loadCardGroupName() {
		if(CoreActivator.getAppConfig().getConfig("cardGroupName")!=null){
			return CoreActivator.getAppConfig().getConfig("cardGroupName").getParameter("name");
		}
		return null;
	}

	@Override
	public String loadIncubatorName() {
		if(CoreActivator.getAppConfig().getConfig("incubatorName")!=null){
			return CoreActivator.getAppConfig().getConfig("incubatorName").getParameter("name");
		}
		return null;
	}

}
