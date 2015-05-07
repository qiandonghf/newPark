package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.TreeUtil;
import com.wiiy.crm.entity.DataProperty;
import com.wiiy.crm.entity.DataTemplate;
import com.wiiy.crm.service.DataPropertyService;
import com.wiiy.crm.service.DataTemplatePropertyConfigService;
import com.wiiy.crm.service.DataTemplateService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class DataTemplateAction extends JqGridBaseAction<DataTemplate>{
	
	private DataTemplateService dataTemplateService;
	private DataTemplatePropertyConfigService dataTemplatePropertyConfigService;
	private DataPropertyService dataPropertyService;
	private Result result;
	private DataTemplate dataTemplate;
	private Long id;
	private String ids;
	private List<DataProperty> propertyList;
	
	public String loadTemplate(){
		result = dataTemplateService.getList();
		return "rvalue";
	}
	
	public String preview(){
		DataTemplate template = dataTemplateService.getBeanById(id).getValue();
		result = Result.value(template);
		propertyList = dataTemplatePropertyConfigService.getTemplatePropertys(id).getValue();
		propertyList = TreeUtil.generateTree(propertyList);
		return "preview";
	}
	
	public String saveConfig(){
		result = dataTemplateService.saveConfig(id,ids);
		return JSON;
	}
	
	public String loadConfig(){
		result = dataTemplateService.loadConfig(id);
		return JSON;
	}
	
	public String save(){
		dataTemplate.setFixed(BooleanEnum.NO);
		result = dataTemplateService.save(dataTemplate);
		return JSON;
	}
	
	public String view(){
		DataTemplate template = dataTemplateService.getBeanById(id).getValue();
		result = Result.value(template);
		return VIEW+"_"+template.getFormat();
	}
	
	public String edit(){
		result = dataTemplateService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		DataTemplate dbBean = dataTemplateService.getBeanById(dataTemplate.getId()).getValue();
		BeanUtil.copyProperties(dataTemplate, dbBean);
		result = dataTemplateService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			DataTemplate template = dataTemplateService.getBeanById(id).getValue();
			if(template.getFixed()==BooleanEnum.YES) {
				result = Result.failure("此模块为系统预设不能删除");
			} else {
				result = dataTemplateService.deleteById(id);
			}
		} else if(ids!=null){
			result = dataTemplateService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		result = dataTemplateService.getList();
		propertyList = dataPropertyService.getList().getValue();
		return LIST;
	}
	
	@Override
	protected List<DataTemplate> getListByFilter(Filter fitler) {
		return dataTemplateService.getListByFilter(fitler).getValue();
	}
	
	
	public DataTemplate getDataTemplate() {
		return dataTemplate;
	}

	public void setDataTemplate(DataTemplate dataTemplate) {
		this.dataTemplate = dataTemplate;
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

	public void setDataTemplateService(DataTemplateService dataTemplateService) {
		this.dataTemplateService = dataTemplateService;
	}
	
	public Result getResult() {
		return result;
	}

	public void setDataPropertyService(DataPropertyService dataPropertyService) {
		this.dataPropertyService = dataPropertyService;
	}

	public List<DataProperty> getPropertyList() {
		return propertyList;
	}

	public void setDataTemplatePropertyConfigService(
			DataTemplatePropertyConfigService dataTemplatePropertyConfigService) {
		this.dataTemplatePropertyConfigService = dataTemplatePropertyConfigService;
	}
	
}
