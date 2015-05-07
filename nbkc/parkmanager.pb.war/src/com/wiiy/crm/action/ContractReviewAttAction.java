package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.crm.entity.ContractReviewAtt;
import com.wiiy.crm.service.ContractReviewAttService;

/**
 * @author my
 */
public class ContractReviewAttAction extends JqGridBaseAction<ContractReviewAtt>{
	
	private ContractReviewAttService contractReviewAttService;
	private Result result;
	private ContractReviewAtt contractReviewAtt;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = contractReviewAttService.save(contractReviewAtt);
		return JSON;
	}
	
	public String view(){
		result = contractReviewAttService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = contractReviewAttService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		ContractReviewAtt dbBean = contractReviewAttService.getBeanById(contractReviewAtt.getId()).getValue();
		BeanUtil.copyProperties(contractReviewAtt, dbBean);
		result = contractReviewAttService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = contractReviewAttService.deleteById(id);
		} else if(ids!=null){
			result = contractReviewAttService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(ContractReviewAtt.class));
	}
	
	@Override
	protected List<ContractReviewAtt> getListByFilter(Filter fitler) {
		return contractReviewAttService.getListByFilter(fitler).getValue();
	}
	
	
	public ContractReviewAtt getContractReviewAtt() {
		return contractReviewAtt;
	}

	public void setContractReviewAtt(ContractReviewAtt contractReviewAtt) {
		this.contractReviewAtt = contractReviewAtt;
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

	public void setContractReviewAttService(ContractReviewAttService contractReviewAttService) {
		this.contractReviewAttService = contractReviewAttService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
