package com.wiiy.cloud.capture.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.cloud.capture.entity.WebContentConfig;
import com.wiiy.cloud.capture.service.WebContentConfigService;

/**
 * @author my
 */
public class WebContentConfigAction extends JqGridBaseAction<WebContentConfig>{
	
	private WebContentConfigService webContentConfigService;
	private Result result;
	private WebContentConfig webContentConfig;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = webContentConfigService.save(webContentConfig);
		return JSON;
	}
	
	public String view(){
		result = webContentConfigService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = webContentConfigService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		WebContentConfig dbBean = webContentConfigService.getBeanById(webContentConfig.getId()).getValue();
		BeanUtil.copyProperties(webContentConfig, dbBean);
		result = webContentConfigService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = webContentConfigService.deleteById(id);
		} else if(ids!=null){
			result = webContentConfigService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(WebContentConfig.class));
	}
	
	@Override
	protected List<WebContentConfig> getListByFilter(Filter fitler) {
		return webContentConfigService.getListByFilter(fitler).getValue();
	}
	
	
	public WebContentConfig getWebContentConfig() {
		return webContentConfig;
	}

	public void setWebContentConfig(WebContentConfig webContentConfig) {
		this.webContentConfig = webContentConfig;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public void setWebContentConfigService(WebContentConfigService webContentConfigService) {
		this.webContentConfigService = webContentConfigService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
