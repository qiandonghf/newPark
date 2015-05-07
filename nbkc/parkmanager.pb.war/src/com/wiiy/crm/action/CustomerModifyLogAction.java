package com.wiiy.crm.action;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.entity.CustomerLabel;
import com.wiiy.crm.entity.CustomerLabelRef;
import com.wiiy.crm.entity.CustomerModifyLog;
import com.wiiy.crm.preferences.enums.OwnerEnum;
import com.wiiy.crm.service.CustomerModifyLogService;
import com.wiiy.crm.service.CustomerService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class CustomerModifyLogAction extends JqGridBaseAction<CustomerModifyLog>{
	
	private CustomerService customerService;
	private CustomerModifyLogService customerModifyLogService;
	private Result result;
	private CustomerModifyLog customerModifyLog;
	private Long id;
	private String ids;
	
	public String workBenchCustomerModifyLog(){
		List<CustomerModifyLog> customerModifyLogList = new ArrayList<CustomerModifyLog>();
		customerModifyLogList = customerModifyLogService.getListByFilter(new Filter(CustomerModifyLog.class)).getValue();
		result = Result.value(customerModifyLogList);
		return "workBenchCustomerModifyLog";
	}
	
	public String add(){
		result = customerService.getBeanById(id);
		return "add";
	}
	
	public String save(){
		result = customerModifyLogService.save(customerModifyLog);
		return JSON;
	}
	
	public String view(){
		result = customerModifyLogService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = customerModifyLogService.getBeanById(id);
		return EDIT;
	}
	
	public String editLog(){
		result = customerModifyLogService.getBeanById(id);
		return "editLog";
	}
	
	public String update(){
		CustomerModifyLog dbBean = customerModifyLogService.getBeanById(customerModifyLog.getId()).getValue();
		BeanUtil.copyProperties(customerModifyLog, dbBean);
		result = customerModifyLogService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = customerModifyLogService.deleteById(id);
		} else if(ids!=null){
			result = customerModifyLogService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(CustomerModifyLog.class).orderBy("modifyLogTime", Filter.DESC));
	}
	
	@Override
	protected List<CustomerModifyLog> getListByFilter(Filter fitler) {
		return customerModifyLogService.getListByFilter(fitler).getValue();
	}
	
	
	public CustomerModifyLog getCustomerModifyLog() {
		return customerModifyLog;
	}

	public void setCustomerModifyLog(CustomerModifyLog customerModifyLog) {
		this.customerModifyLog = customerModifyLog;
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

	public void setCustomerModifyLogService(CustomerModifyLogService customerModifyLogService) {
		this.customerModifyLogService = customerModifyLogService;
	}
	
	public Result getResult() {
		return result;
	}

	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}

}
