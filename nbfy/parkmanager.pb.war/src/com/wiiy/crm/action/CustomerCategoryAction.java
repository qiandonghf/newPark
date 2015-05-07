package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.crm.entity.CustomerCategory;
import com.wiiy.crm.preferences.enums.OwnerEnum;
import com.wiiy.crm.service.CustomerCategoryService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class CustomerCategoryAction extends JqGridBaseAction<CustomerCategory>{
	
	private CustomerCategoryService customerCategoryService;
	private Result result;
	private CustomerCategory customerCategory;
	private Long id;
	private String ids;
	
	
	public String save(){
		customerCategory.setOwnerEnum(OwnerEnum.PUBLIC);
		customerCategory.setOwnerId(PbActivator.getSessionUser().getId());
		result = customerCategoryService.save(customerCategory);
		return JSON;
	}
	
	public String view(){
		result = customerCategoryService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = customerCategoryService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		CustomerCategory dbBean = customerCategoryService.getBeanById(customerCategory.getId()).getValue();
		BeanUtil.copyProperties(customerCategory, dbBean);
		result = customerCategoryService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = customerCategoryService.deleteById(id);
		} else if(ids!=null){
			result = customerCategoryService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(CustomerCategory.class));
	}
	
	@Override
	protected List<CustomerCategory> getListByFilter(Filter fitler) {
		return customerCategoryService.getListByFilter(fitler).getValue();
	}
	
	
	public CustomerCategory getCustomerCategory() {
		return customerCategory;
	}

	public void setCustomerCategory(CustomerCategory customerCategory) {
		this.customerCategory = customerCategory;
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

	public void setCustomerCategoryService(CustomerCategoryService customerCategoryService) {
		this.customerCategoryService = customerCategoryService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
