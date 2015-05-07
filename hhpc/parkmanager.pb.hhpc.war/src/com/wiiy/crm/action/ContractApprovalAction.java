package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.crm.entity.ContractApproval;
import com.wiiy.crm.service.ContractApprovalService;

/**
 * @author my
 */
public class ContractApprovalAction extends JqGridBaseAction<ContractApproval>{
	
	private ContractApprovalService contractApprovalService;
	private Result result;
	private ContractApproval contractApproval;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = contractApprovalService.save(contractApproval);
		return JSON;
	}
	
	public String view(){
		result = contractApprovalService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = contractApprovalService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		ContractApproval dbBean = contractApprovalService.getBeanById(contractApproval.getId()).getValue();
		BeanUtil.copyProperties(contractApproval, dbBean);
		result = contractApprovalService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = contractApprovalService.deleteById(id);
		} else if(ids!=null){
			result = contractApprovalService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(ContractApproval.class));
	}
	
	@Override
	protected List<ContractApproval> getListByFilter(Filter fitler) {
		return contractApprovalService.getListByFilter(fitler).getValue();
	}
	
	
	public ContractApproval getContractApproval() {
		return contractApproval;
	}

	public void setContractApproval(ContractApproval contractApproval) {
		this.contractApproval = contractApproval;
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

	public void setContractApprovalService(ContractApprovalService contractApprovalService) {
		this.contractApprovalService = contractApprovalService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
