package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.crm.entity.DataTemplatePropertyConfig;
import com.wiiy.crm.service.DataTemplatePropertyConfigService;

/**
 * @author my
 */
public class DataTemplatePropertyConfigAction extends JqGridBaseAction<DataTemplatePropertyConfig>{
	
	private DataTemplatePropertyConfigService dataTemplatePropertyConfigService;
	private Result result;
	private DataTemplatePropertyConfig dataTemplatePropertyConfig;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = dataTemplatePropertyConfigService.save(dataTemplatePropertyConfig);
		return JSON;
	}
	
	public String view(){
		result = dataTemplatePropertyConfigService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = dataTemplatePropertyConfigService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		DataTemplatePropertyConfig dbBean = dataTemplatePropertyConfigService.getBeanById(dataTemplatePropertyConfig.getId()).getValue();
		BeanUtil.copyProperties(dataTemplatePropertyConfig, dbBean);
		result = dataTemplatePropertyConfigService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = dataTemplatePropertyConfigService.deleteById(id);
		} else if(ids!=null){
			result = dataTemplatePropertyConfigService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(DataTemplatePropertyConfig.class));
	}
	
	@Override
	protected List<DataTemplatePropertyConfig> getListByFilter(Filter fitler) {
		return dataTemplatePropertyConfigService.getListByFilter(fitler).getValue();
	}
	
	
	public DataTemplatePropertyConfig getDataTemplatePropertyConfig() {
		return dataTemplatePropertyConfig;
	}

	public void setDataTemplatePropertyConfig(DataTemplatePropertyConfig dataTemplatePropertyConfig) {
		this.dataTemplatePropertyConfig = dataTemplatePropertyConfig;
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

	public void setDataTemplatePropertyConfigService(DataTemplatePropertyConfigService dataTemplatePropertyConfigService) {
		this.dataTemplatePropertyConfigService = dataTemplatePropertyConfigService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
