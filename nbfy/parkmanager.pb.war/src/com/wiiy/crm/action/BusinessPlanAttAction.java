package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.crm.entity.BusinessPlanAtt;
import com.wiiy.crm.service.BusinessPlanAttService;

/**
 * @author my
 */
public class BusinessPlanAttAction extends JqGridBaseAction<BusinessPlanAtt>{
	
	private BusinessPlanAttService businessPlanAttService;
	private Result result;
	private BusinessPlanAtt businessPlanAtt;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = businessPlanAttService.save(businessPlanAtt);
		return JSON;
	}
	
	public String view(){
		result = businessPlanAttService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = businessPlanAttService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		BusinessPlanAtt dbBean = businessPlanAttService.getBeanById(businessPlanAtt.getId()).getValue();
		businessPlanAtt.setName(businessPlanAtt.getName()+dbBean.getNewName().substring(dbBean.getNewName().lastIndexOf(".")));
		BeanUtil.copyProperties(businessPlanAtt, dbBean);
		result = businessPlanAttService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = businessPlanAttService.deleteById(id);
		} else if(ids!=null){
			result = businessPlanAttService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(BusinessPlanAtt.class));
	}
	
	@Override
	protected List<BusinessPlanAtt> getListByFilter(Filter fitler) {
		return businessPlanAttService.getListByFilter(fitler).getValue();
	}
	
	
	
	
	
	public String mySave(){
		result = businessPlanAttService.save(businessPlanAtt);
		return JSON;
	}
	
	public String myView(){
		result = businessPlanAttService.getBeanById(id);
		return "my"+VIEW;
	}
	
	public String myEdit(){
		result = businessPlanAttService.getBeanById(id);
		return "my"+EDIT;
	}
	
	public String myUpdate(){
		BusinessPlanAtt dbBean = businessPlanAttService.getBeanById(businessPlanAtt.getId()).getValue();
		businessPlanAtt.setName(businessPlanAtt.getName()+dbBean.getNewName().substring(dbBean.getNewName().lastIndexOf(".")));
		BeanUtil.copyProperties(businessPlanAtt, dbBean);
		result = businessPlanAttService.update(dbBean);
		return JSON;
	}
	
	public String myDelete(){
		if(id!=null){
			result = businessPlanAttService.deleteById(id);
		} else if(ids!=null){
			result = businessPlanAttService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String myList(){
		return refresh(new Filter(BusinessPlanAtt.class));
	}
	
	
	
	
	
	
	
	
	public BusinessPlanAtt getBusinessPlanAtt() {
		return businessPlanAtt;
	}

	public void setBusinessPlanAtt(BusinessPlanAtt businessPlanAtt) {
		this.businessPlanAtt = businessPlanAtt;
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

	public void setBusinessPlanAttService(BusinessPlanAttService businessPlanAttService) {
		this.businessPlanAttService = businessPlanAttService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
