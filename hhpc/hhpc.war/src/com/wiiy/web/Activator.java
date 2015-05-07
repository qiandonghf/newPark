package com.wiiy.web;

import org.osgi.framework.BundleContext;

import com.wiiy.commons.activator.AbstractActivator;
import com.wiiy.core.service.export.AppConfig;
import com.wiiy.core.service.export.AppConfigManager;
import com.wiiy.core.service.export.FKService;
import com.wiiy.core.service.export.HttpSessionService;
import com.wiiy.core.service.export.ModuleRegister;
import com.wiiy.core.service.export.ResourcesService;
import com.wiiy.web.preferences.R;

public class Activator extends AbstractActivator {
	
	public static final String APP_CONFIG_NAME = "ParkManagement-AppName";
	private static BundleContext context;
	private static AppConfigManager appConfigManager;
	
	


	static BundleContext getContext() {
		return context;
	}

	


	@Override
	protected void registryFK() {
		
	}

	@Override
	protected void initDataDict() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void startBundle(BundleContext bundleContext) throws Exception {
		// TODO Auto-generated method stub
		bundleContext = context;
		addInitService(new ModuleRegister());
		appConfigManager = new AppConfigManager();
		addInitService(appConfigManager);
		logger.debug("bundle 【web.war】 start");
	}

	
	public static ResourcesService getResourcesService(){
		return getService(bundleContext, ResourcesService.class);
	}
	@Override
	public void stopBundle(BundleContext context) throws Exception {
		logger.debug("bundle 【web.war】 stop");
	}
	
	public static String getFKMessage(String fk){
		FKService fkService = getService(bundleContext, FKService.class);
		String classDescription = fkService.getFKClassDescription(fk);
		return R.getFKMessage(classDescription);
	}
	public static AppConfig getAppConfig() {
		return appConfigManager.getAppConfig();
	}


	public static HttpSessionService getHttpSessionService(){
		return getService(bundleContext, HttpSessionService.class);
	}

}
