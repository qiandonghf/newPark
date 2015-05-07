package com.wiiy.oa.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.CarApply;
import com.wiiy.oa.preferences.enums.CarApplyStatusEnum;
import com.wiiy.oa.service.CarApplyService;

public class CarApplyAction extends JqGridBaseAction<CarApply>{
	private CarApplyService carApplyService;
	private CarApply carApply;
	private Long id;
	private String ids;
	private Result result;
	private Long approverId;//审批人id
	private String approverl;//审批人
	private String applyCheck;//是否同意  
	
	public String list(){
		Filter filter = new Filter(CarApply.class);
		return refresh(filter);
	}
	
	public String save(){
		carApply.setStatus(CarApplyStatusEnum.PENDING);
		result = carApplyService.save(carApply);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = carApplyService.deleteById(id);
		}
		if(ids!=null){
			result = carApplyService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String edit(){
		result = carApplyService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		result = carApplyService.update(carApply);
		return JSON;
	}
	
	public String view(){
		result = carApplyService.getBeanById(id);
		return VIEW;
	}
	//提交申请
	public String approve(){
		result = carApplyService.approve(id,approverId,approverl);
		return JSON;
	}
	//审批
	public String approveCarApply(){
		result = carApplyService.approveCarApply(id,applyCheck);
		return JSON;
	}
	
	public void setCarApplyService(CarApplyService carApplyService) {
		this.carApplyService = carApplyService;
	}
	@Override
	protected List<CarApply> getListByFilter(Filter fitler) {
		return carApplyService.getListByFilter(fitler).getValue();
	}
	public CarApply getCarApply() {
		return carApply;
	}
	public void setCarApply(CarApply carApply) {
		this.carApply = carApply;
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
	public Result getResult() {
		return result;
	}
	public void setResult(Result result) {
		this.result = result;
	}

	public Long getApproverId() {
		return approverId;
	}

	public void setApproverId(Long approverId) {
		this.approverId = approverId;
	}

	public String getApproverl() {
		return approverl;
	}

	public void setApproverl(String approverl) {
		this.approverl = approverl;
	}

	public String getApplyCheck() {
		return applyCheck;
	}

	public void setApplyCheck(String applyCheck) {
		this.applyCheck = applyCheck;
	}


}
