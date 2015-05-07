package com.wiiy.core.action;

import java.util.List;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ModelDriven;
import com.wiiy.commons.action.BaseAction;
import com.wiiy.core.dto.AppDto;
import com.wiiy.core.service.AppConfigService;
import com.wiiy.core.service.AppService;
import com.wiiy.core.service.export.AppConfig;
import com.wiiy.hibernate.Result;

public class AppParamAction extends BaseAction implements ModelDriven<AppConfig> {

	private AppService appService;

	private AppConfigService appConfigService;
	
	private List<AppDto> appDtoList;
	
	private Result<AppConfig> result;
	
	private Long bundleId;
		
	public Long getBundleId() {
		return bundleId;
	}

	public void setBundleId(Long bundleId) {
		this.bundleId = bundleId;
	}

	public List<AppDto> getAppDtoList() {
		return appDtoList;
	}

	public void setAppService(AppService appService) {
		this.appService = appService;
	}
	
	public void setAppConfigService(AppConfigService appConfigService) {
		this.appConfigService = appConfigService;
	}
	
	public Result<AppConfig> getResult() {
		return result;
	}
	
	public String execute() {
		appDtoList = appService.getAppList().getValue();
		return VIEW;
	}
	
	public String configDetail() {
		return JSON;
	}

	public String update() {
		if (result.getValue() != null) {
			result = appConfigService.persist(result.getValue());
		}
		return JSON;
	}

	@Override
	public AppConfig getModel() {
		String strBundleId = ServletActionContext.getRequest().getParameter("bundleId");
		if (strBundleId != null) {
			result = appConfigService.getAppConfig(Long.valueOf(strBundleId));
			return result.getValue();
		}
		return null;
	}
}
