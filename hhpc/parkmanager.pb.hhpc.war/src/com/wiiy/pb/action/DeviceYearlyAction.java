package com.wiiy.pb.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.pb.entity.DeviceYearly;
import com.wiiy.pb.service.DeviceYearlyService;

/**
 * @author my
 */
public class DeviceYearlyAction extends JqGridBaseAction<DeviceYearly>{
	
	private DeviceYearlyService deviceYearlyService;
	private Result<DeviceYearly> result;
	private DeviceYearly deviceYearly;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = deviceYearlyService.save(deviceYearly);
		return JSON;
	}
	
	public String view(){
		result = deviceYearlyService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = deviceYearlyService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		DeviceYearly dbBean = deviceYearlyService.getBeanById(deviceYearly.getId()).getValue();
		BeanUtil.copyProperties(deviceYearly, dbBean);
		result = deviceYearlyService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = deviceYearlyService.deleteById(id);
		} else if(ids!=null){
			result = deviceYearlyService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(DeviceYearly.class);
		if (id != null) {
			filter.eq("deviceId", id);
		}
		return refresh(filter);
	}
	
	@Override
	protected List<DeviceYearly> getListByFilter(Filter fitler) {
		return deviceYearlyService.getListByFilter(fitler).getValue();
	}
	
	
	public DeviceYearly getDeviceYearly() {
		return deviceYearly;
	}

	public void setDeviceYearly(DeviceYearly deviceYearly) {
		this.deviceYearly = deviceYearly;
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

	public void setDeviceYearlyService(DeviceYearlyService deviceYearlyService) {
		this.deviceYearlyService = deviceYearlyService;
	}
	
	public Result<DeviceYearly> getResult() {
		return result;
	}
	
}
