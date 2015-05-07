package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.crm.entity.CustomerRiskCapital;
import com.wiiy.crm.service.CustomerRiskCapitalService;

/**
 * @author my
 */
public class CustomerRiskCapitalAction extends JqGridBaseAction<CustomerRiskCapital>{
	
	private CustomerRiskCapitalService customerRiskCapitalService;
	private Result result;
	private CustomerRiskCapital customerRiskCapital;
	private Long id;
	private String ids;
	private boolean service;
	
	public String loadByCustomerId(){
		return "loadByCustomerId";
	}
	
	public String save(){
		if ("".equals(customerRiskCapital.getCurrencyTypeId())) {
			customerRiskCapital.setCurrencyTypeId(null);
		}
		result = customerRiskCapitalService.save(customerRiskCapital);
		return JSON;
	}
	
	public String view(){
		result = customerRiskCapitalService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = customerRiskCapitalService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		CustomerRiskCapital dbBean = customerRiskCapitalService.getBeanById(customerRiskCapital.getId()).getValue();
		BeanUtil.copyProperties(customerRiskCapital, dbBean);
		if ("".equals(customerRiskCapital.getCurrencyTypeId())) {
			dbBean.setCurrencyTypeId(null);
		}
		result = customerRiskCapitalService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = customerRiskCapitalService.deleteById(id);
		} else if(ids!=null){
			result = customerRiskCapitalService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(CustomerRiskCapital.class));
	}
	
	@Override
	protected List<CustomerRiskCapital> getListByFilter(Filter fitler) {
		return customerRiskCapitalService.getListByFilter(fitler).getValue();
	}
	
	
	public CustomerRiskCapital getCustomerRiskCapital() {
		return customerRiskCapital;
	}

	public void setCustomerRiskCapital(CustomerRiskCapital customerRiskCapital) {
		this.customerRiskCapital = customerRiskCapital;
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

	public void setCustomerRiskCapitalService(CustomerRiskCapitalService customerRiskCapitalService) {
		this.customerRiskCapitalService = customerRiskCapitalService;
	}
	
	public Result getResult() {
		return result;
	}
	public boolean isService() {
		return service;
	}

	public void setService(boolean service) {
		this.service = service;
	}
}
