package com.wiiy.core.action;

import java.util.List;

import com.wiiy.commons.action.BaseAction;
import com.wiiy.core.dto.AppDto;
import com.wiiy.core.service.AppService;
import com.wiiy.hibernate.Result;

/**
 * @author Administrator
 *
 *
 */
public class AppAction extends BaseAction {
	
	private AppService appService;
	
	private Result<AppDto> result;
	
	private List<AppDto> appDtoList;
	
	private Long bundleId;
	
	public void setBundleId(Long bundleId) {
		this.bundleId = bundleId;
	}

	public Long getBundleId() {
		return bundleId;
	}

	public Result<AppDto> getResult() {
		return result;
	}

	public void setAppService(AppService appService) {
		this.appService = appService;
	}
	
	
	public List<AppDto> getAppDtoList() {
		return appDtoList;
	}

	public String detail() {
		result = appService.getApp(bundleId);
		return JSON;
	}

	public String execute() {
		appDtoList = appService.getAppList().getValue();
		return VIEW;
	}
	
	public String load() {
		result = appService.start(bundleId);
		return JSON;
	}
	
	public String unload() {
		result = appService.stop(bundleId);
		return JSON;
	}
}
