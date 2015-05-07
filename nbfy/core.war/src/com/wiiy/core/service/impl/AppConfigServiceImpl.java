package com.wiiy.core.service.impl;

import java.util.HashMap;
import java.util.Map;

import com.wiiy.core.service.AppConfigService;
import com.wiiy.core.service.export.AppConfig;
import com.wiiy.core.service.export.AppConfigRegisterService;
import com.wiiy.hibernate.Result;

public class AppConfigServiceImpl implements AppConfigRegisterService, AppConfigService {
	
	private Map<Long, AppConfig> appConfigMap = new HashMap<Long, AppConfig>();

	@Override
	public boolean register(AppConfig appConfig) {
		appConfigMap.put(appConfig.getBundleId(), appConfig);
		return true;
	}

	@Override
	public boolean unregister(AppConfig appConfig) {
		appConfigMap.remove(appConfig.getBundleId());
		return true;
	}

	@Override
	public Result<AppConfig> getAppConfig(Long bundleId) {
		return Result.value(appConfigMap.get(bundleId));
	}

	@Override
	public Result<AppConfig> persist(AppConfig appConfig) {
		try {
			appConfig.persist();
			return Result.success("保存成功", appConfig);
		} catch (Exception e) {
			return Result.failure("保存失败");
		}
	}

}
