package com.wiiy.pb.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.pb.entity.VehicleManagement;
import com.wiiy.pb.service.VehicleManagementService;

/**
 * @author my
 */
public class VehicleManagementAction extends JqGridBaseAction<VehicleManagement>{
	
	private VehicleManagementService vehicleManagementService;
	private Result result;
	private VehicleManagement vehicleManagement;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = vehicleManagementService.save(vehicleManagement);
		return JSON;
	}
	
	public String view(){
		result = vehicleManagementService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = vehicleManagementService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		VehicleManagement dbBean = vehicleManagementService.getBeanById(vehicleManagement.getId()).getValue();
		BeanUtil.copyProperties(vehicleManagement, dbBean);
		result = vehicleManagementService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = vehicleManagementService.deleteById(id);
		} else if(ids!=null){
			result = vehicleManagementService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(VehicleManagement.class));
	}
	
	@Override
	protected List<VehicleManagement> getListByFilter(Filter fitler) {
		return vehicleManagementService.getListByFilter(fitler).getValue();
	}
	
	
	public VehicleManagement getVehicleManagement() {
		return vehicleManagement;
	}

	public void setVehicleManagement(VehicleManagement vehicleManagement) {
		this.vehicleManagement = vehicleManagement;
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

	public void setVehicleManagementService(VehicleManagementService vehicleManagementService) {
		this.vehicleManagementService = vehicleManagementService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
