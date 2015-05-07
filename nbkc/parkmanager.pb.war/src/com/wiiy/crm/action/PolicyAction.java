package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.entity.Policy;
import com.wiiy.crm.service.PolicyService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class PolicyAction extends JqGridBaseAction<Policy>{
	
	private PolicyService policyService;
	private Result result;
	private Policy policy;
	private Long id;
	private String ids;
	
	
	public String save(){
		if(policy.getTypeId()!=null && policy.getTypeId().length()==0) policy.setTypeId(null);
		result = policyService.save(policy);
		return JSON;
	}
	
	public String view(){
		result = policyService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = policyService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		Policy dbBean = policyService.getBeanById(policy.getId()).getValue();
		BeanUtil.copyProperties(policy, dbBean);
		if(dbBean.getTypeId()!=null && dbBean.getTypeId().length()==0) dbBean.setTypeId(null);
		result = policyService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = policyService.deleteById(id);
		} else if(ids!=null){
			result = policyService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(Policy.class));
	}
	
	@Override
	protected List<Policy> getListByFilter(Filter fitler) {
		return policyService.getListByFilter(fitler).getValue();
	}
	
	
	public Policy getPolicy() {
		return policy;
	}

	public void setPolicy(Policy policy) {
		this.policy = policy;
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

	public void setPolicyService(PolicyService policyService) {
		this.policyService = policyService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
