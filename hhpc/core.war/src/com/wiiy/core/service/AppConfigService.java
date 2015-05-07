package com.wiiy.core.service;

import com.wiiy.core.service.export.AppConfig;
import com.wiiy.hibernate.Result;

public interface AppConfigService {
	
	Result<AppConfig> getAppConfig(Long bundleId);
	
	Result<AppConfig> persist(AppConfig appConfig);

}
