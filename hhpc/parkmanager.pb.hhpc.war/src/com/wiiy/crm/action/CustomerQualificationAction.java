package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.crm.entity.CustomerQualification;
import com.wiiy.crm.service.CustomerQualificationService;

/**
 * @author my
 */
public class CustomerQualificationAction extends JqGridBaseAction<CustomerQualification>{
	
	private CustomerQualificationService customerQualificationService;
	private Result result;
	private CustomerQualification customerQualification;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = customerQualificationService.save(customerQualification);
		return JSON;
	}
	
	public String view(){
		result = customerQualificationService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = customerQualificationService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		CustomerQualification dbBean = customerQualificationService.getBeanById(customerQualification.getId()).getValue();
		BeanUtil.copyProperties(customerQualification, dbBean);
		result = customerQualificationService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = customerQualificationService.deleteById(id);
		} else if(ids!=null){
			result = customerQualificationService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(CustomerQualification.class));
	}
	
	@Override
	protected List<CustomerQualification> getListByFilter(Filter fitler) {
		return customerQualificationService.getListByFilter(fitler).getValue();
	}
	
	
	public CustomerQualification getCustomerQualification() {
		return customerQualification;
	}

	public void setCustomerQualification(CustomerQualification customerQualification) {
		this.customerQualification = customerQualification;
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

	public void setCustomerQualificationService(CustomerQualificationService customerQualificationService) {
		this.customerQualificationService = customerQualificationService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
