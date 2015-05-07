package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.entity.Copyright;
import com.wiiy.crm.service.CopyrightService;
import com.wiiy.crm.service.CustomerService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class CopyrightAction extends JqGridBaseAction<Copyright>{
	
	private CopyrightService copyrightService;
	private CustomerService customerService;
	private Result result;
	private Copyright copyright;
	private Long id;
	private String ids;
	
	public String addByCustomerId(){
		result = customerService.getBeanById(id);
		return "addByCustomerId";
	}
	
	public String save(){
		result = copyrightService.save(copyright);
		return JSON;
	}
	
	public String view(){
		result = copyrightService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = copyrightService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		Copyright dbBean = copyrightService.getBeanById(copyright.getId()).getValue();
		BeanUtil.copyProperties(copyright, dbBean);
		result = copyrightService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = copyrightService.deleteById(id);
		} else if(ids!=null){
			result = copyrightService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(Copyright.class);
		filter.createAlias("customer", "customer");
		return refresh(filter);
	}
	
	@Override
	protected List<Copyright> getListByFilter(Filter fitler) {
		return copyrightService.getListByFilter(fitler).getValue();
	}
	
	
	public Copyright getCopyright() {
		return copyright;
	}

	public void setCopyright(Copyright copyright) {
		this.copyright = copyright;
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

	public void setCopyrightService(CopyrightService copyrightService) {
		this.copyrightService = copyrightService;
	}
	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
