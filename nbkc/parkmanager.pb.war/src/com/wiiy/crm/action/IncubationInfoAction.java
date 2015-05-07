package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.crm.entity.IncubationInfo;
import com.wiiy.crm.service.IncubationInfoService;

/**
 * @author my
 */
public class IncubationInfoAction extends JqGridBaseAction<IncubationInfo>{
	
	private IncubationInfoService incubationInfoService;
	private Result result;
	private IncubationInfo incubationInfo;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = incubationInfoService.save(incubationInfo);
		return JSON;
	}
	
	public String view(){
		result = incubationInfoService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = incubationInfoService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		result = incubationInfoService.update(incubationInfo);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = incubationInfoService.deleteById(id);
		} else if(ids!=null){
			result = incubationInfoService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(IncubationInfo.class));
	}
	
	@Override
	protected List<IncubationInfo> getListByFilter(Filter fitler) {
		return incubationInfoService.getListByFilter(fitler).getValue();
	}
	
	
	public IncubationInfo getIncubationInfo() {
		return incubationInfo;
	}

	public void setIncubationInfo(IncubationInfo incubationInfo) {
		this.incubationInfo = incubationInfo;
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

	public void setIncubationInfoService(IncubationInfoService incubationInfoService) {
		this.incubationInfoService = incubationInfoService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
