package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.crm.entity.CustomerLabelRef;
import com.wiiy.crm.service.CustomerLabelRefService;

/**
 * @author my
 */
public class CustomerLabelRefAction extends JqGridBaseAction<CustomerLabelRef>{
	
	private CustomerLabelRefService customerLabelRefService;
	private Result result;
	private CustomerLabelRef customerLabelRef;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = customerLabelRefService.save(customerLabelRef);
		return JSON;
	}
	
	public String view(){
		result = customerLabelRefService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = customerLabelRefService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		result = customerLabelRefService.update(customerLabelRef);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = customerLabelRefService.deleteById(id);
		} else if(ids!=null){
			result = customerLabelRefService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(CustomerLabelRef.class));
	}
	
	@Override
	protected List<CustomerLabelRef> getListByFilter(Filter fitler) {
		return customerLabelRefService.getListByFilter(fitler).getValue();
	}
	
	
	public CustomerLabelRef getCustomerLabelRef() {
		return customerLabelRef;
	}

	public void setCustomerLabelRef(CustomerLabelRef customerLabelRef) {
		this.customerLabelRef = customerLabelRef;
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

	public void setCustomerLabelRefService(CustomerLabelRefService customerLabelRefService) {
		this.customerLabelRefService = customerLabelRefService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
