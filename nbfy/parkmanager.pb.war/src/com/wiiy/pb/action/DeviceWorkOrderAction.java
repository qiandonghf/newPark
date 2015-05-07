package com.wiiy.pb.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.pb.entity.DeviceWorkOrder;
import com.wiiy.pb.service.DeviceWorkOrderService;

/**
 * @author my
 */
public class DeviceWorkOrderAction extends JqGridBaseAction<DeviceWorkOrder>{
	
	private DeviceWorkOrderService deviceWorkOrderService;
	private Result<DeviceWorkOrder> result;
	private DeviceWorkOrder deviceWorkOrder;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = deviceWorkOrderService.save(deviceWorkOrder);
		return JSON;
	}
	
	public String view(){
		result = deviceWorkOrderService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = deviceWorkOrderService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		DeviceWorkOrder dbBean = deviceWorkOrderService.getBeanById(deviceWorkOrder.getId()).getValue();
		BeanUtil.copyProperties(deviceWorkOrder, dbBean);
		result = deviceWorkOrderService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = deviceWorkOrderService.deleteById(id);
		} else if(ids!=null){
			result = deviceWorkOrderService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(DeviceWorkOrder.class);
		if (id != null) {
			filter.eq("deviceId", id);
		}
		return refresh(filter);
	}
	
	@Override
	protected List<DeviceWorkOrder> getListByFilter(Filter fitler) {
		return deviceWorkOrderService.getListByFilter(fitler).getValue();
	}
	
	
	public DeviceWorkOrder getDeviceWorkOrder() {
		return deviceWorkOrder;
	}

	public void setDeviceWorkOrder(DeviceWorkOrder deviceWorkOrder) {
		this.deviceWorkOrder = deviceWorkOrder;
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

	public void setDeviceWorkOrderService(DeviceWorkOrderService deviceWorkOrderService) {
		this.deviceWorkOrderService = deviceWorkOrderService;
	}
	
	public Result<DeviceWorkOrder> getResult() {
		return result;
	}
	
}
