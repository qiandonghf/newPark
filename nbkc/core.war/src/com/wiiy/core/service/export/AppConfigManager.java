package com.wiiy.core.service.export;


import org.osgi.framework.BundleContext;
import org.springframework.osgi.context.BundleContextAware;

import com.wiiy.commons.service.InitService;

public class AppConfigManager extends InitService<AppConfigRegisterService> implements BundleContextAware {
	
	private AppConfig appConfig;
	
	@Override
	public void setBundleContext(BundleContext bundleContext) {
		appConfig = AppConfig.load(bundleContext.getBundle());
	}
	
	public AppConfig getAppConfig() {
		return appConfig;
	}

	@Override
	public void init() {
		getDependOnService().register(appConfig);
	}
}
