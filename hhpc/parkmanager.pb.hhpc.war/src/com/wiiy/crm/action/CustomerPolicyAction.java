package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.crm.entity.CustomerPolicy;
import com.wiiy.crm.entity.Policy;
import com.wiiy.crm.service.CustomerPolicyService;
import com.wiiy.crm.service.PolicyService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class CustomerPolicyAction extends JqGridBaseAction<CustomerPolicy>{
	
	private CustomerPolicyService customerPolicyService;
	private PolicyService policyService;
	private Result result;
	private CustomerPolicy customerPolicy;
	private Long id;
	private String ids;
	private boolean service;
	
	private List<Policy> policyList;
	
	public String loadByCustomerId(){
		return "loadByCustomerId";
	}
	
	public String add(){
		Filter filter = new Filter(Policy.class);
		filter.eq("usable", BooleanEnum.YES);
		filter.sqlRestriction("this_.id not in (select policy_id from crm_customer_policy where customer_id = "+id+")");
		policyList = policyService.getListByFilter(filter).getValue();
		return "add";
	}
	
	public String overdue(){
		CustomerPolicy dbBean = customerPolicyService.getBeanById(id).getValue();
		dbBean.setOverdue(BooleanEnum.YES);
		result = customerPolicyService.update(dbBean);
		return JSON;
	}
	
	public String save(){
		if(ids==null){
			result = Result.failure("新增失败");
		} else {
			Long[] idArray = StringUtil.splitToLongArray(ids);
			Long customerId = customerPolicy.getCustomerId();
			for (Long id : idArray) {
				CustomerPolicy customerPolicy = new CustomerPolicy();
				customerPolicy.setCustomerId(customerId);
				customerPolicy.setPolicyId(id);
				customerPolicy.setOverdue(BooleanEnum.NO);
				result = customerPolicyService.save(customerPolicy);
			}
		}
		return JSON;
	}
	
	public String view(){
		result = customerPolicyService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = customerPolicyService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		CustomerPolicy dbBean = customerPolicyService.getBeanById(customerPolicy.getId()).getValue();
		BeanUtil.copyProperties(customerPolicy, dbBean);
		result = customerPolicyService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = customerPolicyService.deleteById(id);
		} else if(ids!=null){
			result = customerPolicyService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(CustomerPolicy.class));
	}
	
	@Override
	protected List<CustomerPolicy> getListByFilter(Filter fitler) {
		return customerPolicyService.getListByFilter(fitler).getValue();
	}
	
	
	public CustomerPolicy getCustomerPolicy() {
		return customerPolicy;
	}

	public void setCustomerPolicy(CustomerPolicy customerPolicy) {
		this.customerPolicy = customerPolicy;
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

	public void setCustomerPolicyService(CustomerPolicyService customerPolicyService) {
		this.customerPolicyService = customerPolicyService;
	}
	
	public Result getResult() {
		return result;
	}

	public List<Policy> getPolicyList() {
		return policyList;
	}

	public void setPolicyService(PolicyService policyService) {
		this.policyService = policyService;
	}

	public boolean isService() {
		return service;
	}

	public void setService(boolean service) {
		this.service = service;
	}
}
