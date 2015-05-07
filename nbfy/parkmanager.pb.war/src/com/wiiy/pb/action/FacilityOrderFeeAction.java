package com.wiiy.pb.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.pb.entity.FacilityOrder;
import com.wiiy.pb.entity.FacilityOrderFee;
import com.wiiy.pb.service.FacilityOrderFeeService;
import com.wiiy.pb.service.FacilityOrderService;

/**
 * @author my
 */
public class FacilityOrderFeeAction extends JqGridBaseAction<FacilityOrderFee>{
	
	private FacilityOrderFeeService facilityOrderFeeService;
	private FacilityOrderService facilityOrderService;
	private Result result;
	private FacilityOrderFee facilityOrderFee;
	private Long id;
	private String ids;
	
	public String add(){
		FacilityOrder facilityOrder = facilityOrderService.getBeanById(id).getValue();
		facilityOrderFee = new FacilityOrderFee();
		facilityOrderFee.setFacility(facilityOrder.getFacility());
		facilityOrderFee.setOrder(facilityOrder);
		return "add";
	}
	
	public String save(){
		result = facilityOrderFeeService.save(facilityOrderFee);
		return JSON;
	}
	
	public String view(){
		result = facilityOrderFeeService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = facilityOrderFeeService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		FacilityOrderFee dbBean = facilityOrderFeeService.getBeanById(facilityOrderFee.getId()).getValue();
		BeanUtil.copyProperties(facilityOrderFee, dbBean);
		result = facilityOrderFeeService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = facilityOrderFeeService.deleteById(id);
		} else if(ids!=null){
			result = facilityOrderFeeService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(FacilityOrderFee.class).eq("orderId", id));
	}
	
	@Override
	protected List<FacilityOrderFee> getListByFilter(Filter fitler) {
		return facilityOrderFeeService.getListByFilter(fitler).getValue();
	}
	
	
	public FacilityOrderFee getFacilityOrderFee() {
		return facilityOrderFee;
	}

	public void setFacilityOrderFee(FacilityOrderFee facilityOrderFee) {
		this.facilityOrderFee = facilityOrderFee;
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

	public void setFacilityOrderFeeService(FacilityOrderFeeService facilityOrderFeeService) {
		this.facilityOrderFeeService = facilityOrderFeeService;
	}
	
	public Result getResult() {
		return result;
	}

	public FacilityOrderService getFacilityOrderService() {
		return facilityOrderService;
	}

	public void setFacilityOrderService(FacilityOrderService facilityOrderService) {
		this.facilityOrderService = facilityOrderService;
	}
	
}
