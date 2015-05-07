package com.wiiy.pb.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.pb.entity.DeviceMaintenance;
import com.wiiy.pb.service.DeviceMaintenanceService;

/**
 * @author zhf
 */
public class DeviceMaintenanceAction extends JqGridBaseAction<DeviceMaintenance>{
	
	private DeviceMaintenanceService deviceMaintenanceService;
	private Result<DeviceMaintenance> result;
	private DeviceMaintenance deviceMaintenance;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = deviceMaintenanceService.save(deviceMaintenance);
		return JSON;
	}
	
	public String view(){
		result = deviceMaintenanceService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = deviceMaintenanceService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		DeviceMaintenance dbBean = deviceMaintenanceService.getBeanById(deviceMaintenance.getId()).getValue();
		BeanUtil.copyProperties(deviceMaintenance, dbBean);
		result = deviceMaintenanceService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = deviceMaintenanceService.deleteById(id);
		} else if(ids!=null){
			result = deviceMaintenanceService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(DeviceMaintenance.class);
		if (id != null) {
			filter.eq("deviceId", id);
		}
		return refresh(filter);
	}
	
	@Override
	protected List<DeviceMaintenance> getListByFilter(Filter fitler) {
		return deviceMaintenanceService.getListByFilter(fitler).getValue();
	}
	
	
	public DeviceMaintenance getDeviceMaintenance() {
		return deviceMaintenance;
	}

	public void setDeviceMaintenance(DeviceMaintenance deviceMaintenance) {
		this.deviceMaintenance = deviceMaintenance;
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

	public void setDeviceMaintenanceService(DeviceMaintenanceService deviceMaintenanceService) {
		this.deviceMaintenanceService = deviceMaintenanceService;
	}
	
	public Result<DeviceMaintenance> getResult() {
		return result;
	}
	
}
