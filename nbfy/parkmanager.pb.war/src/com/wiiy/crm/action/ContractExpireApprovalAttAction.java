package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.crm.entity.ContractExpireApprovalAtt;
import com.wiiy.crm.service.ContractExpireApprovalAttService;

/**
 * @author my
 */
public class ContractExpireApprovalAttAction extends JqGridBaseAction<ContractExpireApprovalAtt>{
	
	private ContractExpireApprovalAttService contractExpireApprovalAttService;
	private Result result;
	private ContractExpireApprovalAtt contractExpireApprovalAtt;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = contractExpireApprovalAttService.save(contractExpireApprovalAtt);
		return JSON;
	}
	
	public String view(){
		result = contractExpireApprovalAttService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = contractExpireApprovalAttService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		ContractExpireApprovalAtt dbBean = contractExpireApprovalAttService.getBeanById(contractExpireApprovalAtt.getId()).getValue();
		BeanUtil.copyProperties(contractExpireApprovalAtt, dbBean);
		result = contractExpireApprovalAttService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = contractExpireApprovalAttService.deleteById(id);
		} else if(ids!=null){
			result = contractExpireApprovalAttService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(ContractExpireApprovalAtt.class));
	}
	
	@Override
	protected List<ContractExpireApprovalAtt> getListByFilter(Filter fitler) {
		return contractExpireApprovalAttService.getListByFilter(fitler).getValue();
	}
	
	
	public ContractExpireApprovalAtt getContractExpireApprovalAtt() {
		return contractExpireApprovalAtt;
	}

	public void setContractExpireApprovalAtt(ContractExpireApprovalAtt contractExpireApprovalAtt) {
		this.contractExpireApprovalAtt = contractExpireApprovalAtt;
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

	public void setContractExpireApprovalAttService(ContractExpireApprovalAttService contractExpireApprovalAttService) {
		this.contractExpireApprovalAttService = contractExpireApprovalAttService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
