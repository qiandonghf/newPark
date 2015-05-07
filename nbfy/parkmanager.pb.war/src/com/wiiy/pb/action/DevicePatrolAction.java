package com.wiiy.pb.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.pb.entity.DevicePatrol;
import com.wiiy.pb.service.DevicePatrolService;

/**
 * @author my
 */
public class DevicePatrolAction extends JqGridBaseAction<DevicePatrol>{
	
	private DevicePatrolService devicePatrolService;
	private Result<DevicePatrol> result;
	private DevicePatrol devicePatrol;
	private Long id;
	private String ids;
	private List<DevicePatrol> remainList;
	
	public String save(){
		result = devicePatrolService.save(devicePatrol);
		return JSON;
	}
	
	public String view(){
		result = devicePatrolService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = devicePatrolService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		DevicePatrol dbBean = devicePatrolService.getBeanById(devicePatrol.getId()).getValue();
		BeanUtil.copyProperties(devicePatrol, dbBean);
		result = devicePatrolService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = devicePatrolService.deleteById(id);
		} else if(ids!=null){
			result = devicePatrolService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(DevicePatrol.class);
		if(id != null){
			filter.eq("deviceId", id);
		}
		return refresh(filter);
	}
	
	@Override
	protected List<DevicePatrol> getListByFilter(Filter fitler) {
		return devicePatrolService.getListByFilter(fitler).getValue();
	}
	
	
	public DevicePatrol getDevicePatrol() {
		return devicePatrol;
	}

	public void setDevicePatrol(DevicePatrol devicePatrol) {
		this.devicePatrol = devicePatrol;
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

	public void setDevicePatrolService(DevicePatrolService devicePatrolService) {
		this.devicePatrolService = devicePatrolService;
	}
	
	public Result<DevicePatrol> getResult() {
		return result;
	}

	public List<DevicePatrol> getRemainList() {
		return remainList;
	}
	
}
