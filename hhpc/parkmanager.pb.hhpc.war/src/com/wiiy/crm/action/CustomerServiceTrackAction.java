package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.crm.entity.CustomerServiceTrack;
import com.wiiy.crm.service.CustomerServiceTrackService;

/**
 * @author my
 */
public class CustomerServiceTrackAction extends JqGridBaseAction<CustomerServiceTrack>{
	
	private CustomerServiceTrackService customerServiceTrackService;
	@SuppressWarnings("rawtypes")
	private Result result;
	private CustomerServiceTrack customerServiceTrack;
	private Long id;
	private String ids;
	private Long serviceId;
	
	
	public String save(){
		result = customerServiceTrackService.save(customerServiceTrack);
		return JSON;
	}
	
	public String view(){
		result = customerServiceTrackService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = customerServiceTrackService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		CustomerServiceTrack dbBean = customerServiceTrackService.getBeanById(customerServiceTrack.getId()).getValue();
		BeanUtil.copyProperties(customerServiceTrack, dbBean);
		result = customerServiceTrackService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = customerServiceTrackService.deleteById(id);
		} else if(ids!=null){
			result = customerServiceTrackService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(CustomerServiceTrack.class).eq("serviceId", serviceId).orderBy("handleTime", Filter.DESC));
	}
	
	@Override
	protected List<CustomerServiceTrack> getListByFilter(Filter fitler) {
		return customerServiceTrackService.getListByFilter(fitler).getValue();
	}
	
	
	public CustomerServiceTrack getCustomerServiceTrack() {
		return customerServiceTrack;
	}

	public void setCustomerServiceTrack(CustomerServiceTrack customerServiceTrack) {
		this.customerServiceTrack = customerServiceTrack;
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

	public void setCustomerServiceTrackService(CustomerServiceTrackService customerServiceTrackService) {
		this.customerServiceTrackService = customerServiceTrackService;
	}
	
	public Result getResult() {
		return result;
	}

	public Long getServiceId() {
		return serviceId;
	}

	public void setServiceId(Long serviceId) {
		this.serviceId = serviceId;
	}
	
}
