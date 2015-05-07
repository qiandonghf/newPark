package com.wiiy.crm.action;

import java.util.ArrayList;
import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.crm.dto.CustomerCategoryDto;
import com.wiiy.crm.entity.CustomerCategory;
import com.wiiy.crm.entity.CustomerLabel;
import com.wiiy.crm.preferences.enums.OwnerEnum;
import com.wiiy.crm.service.CustomerCategoryService;
import com.wiiy.crm.service.CustomerLabelService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class CustomerLabelAction extends JqGridBaseAction<CustomerLabel>{
	
	private CustomerLabelService customerLabelService;
	private CustomerCategoryService customerCategoryService;
	private Result result;
	private CustomerLabel customerLabel;
	private List<CustomerLabel> customerLabelList;
	private Long id;
	private String ids;
	
	public String loadCustomerLabel(){
		List<CustomerCategory> customerCategoryList = customerCategoryService.getListByFilter(new Filter(CustomerCategory.class)).getValue();
		List<CustomerLabel> labelList = customerLabelService.getListByFilter(new Filter(CustomerLabel.class).or(Filter.Eq("ownerEnum", OwnerEnum.PUBLIC),Filter.Eq("ownerId", PbActivator.getSessionUser().getId()))).getValue();
		List<CustomerCategoryDto> dtoList = new ArrayList<CustomerCategoryDto>();
		for (CustomerCategory customerCategory : customerCategoryList) {
			CustomerCategoryDto customerCategoryDto = new CustomerCategoryDto();
			customerCategoryDto.setCustomerCategory(customerCategory);
			List<CustomerLabel> customerLabelList = new ArrayList<CustomerLabel>();
			for (CustomerLabel customerLabel : labelList) {
				if(customerLabel.getOwnerEnum().equals(OwnerEnum.PUBLIC) && customerLabel.getCategoryId().longValue()==customerCategory.getId()){
					customerLabelList.add(customerLabel);
				}
			}
			customerCategoryDto.setCustomerLabelList(customerLabelList);
			dtoList.add(customerCategoryDto);
		}
		customerLabelList = new ArrayList<CustomerLabel>();
		for (CustomerLabel customerLabel : labelList) {
			if(customerLabel.getOwnerEnum().equals(OwnerEnum.PRIVATE)){
				customerLabelList.add(customerLabel);
			}
		}
		result = Result.value(dtoList);
		return JSON;
	}
	
	public String loadCustomerLabelByCategoryId(){
		result = customerLabelService.getListByFilter(new Filter(CustomerLabel.class).eq("categoryId", id));
		return JSON;
	}
	
	public String loadMyLabel(){
		result = customerLabelService.getListByFilter(new Filter(CustomerLabel.class).eq("ownerEnum",OwnerEnum.PRIVATE).eq("ownerId", PbActivator.getSessionUser().getId()));
		return JSON;
	}
	
	public String addByCategoryId(){
		if(id!=null){
			result = customerCategoryService.getBeanById(id);
		}
		return "addByCategoryId";
	}
	
	public String save(){
		if(customerLabel.getOwnerEnum()==null)customerLabel.setOwnerEnum(OwnerEnum.PRIVATE);
		customerLabel.setOwnerId(PbActivator.getSessionUser().getId());
		result = customerLabelService.save(customerLabel);
		return JSON;
	}
	
	public String view(){
		result = customerLabelService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = customerLabelService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		CustomerLabel dbBean = customerLabelService.getBeanById(customerLabel.getId()).getValue();
		BeanUtil.copyProperties(customerLabel, dbBean);
		result = customerLabelService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = customerLabelService.deleteById(id);
		} else if(ids!=null){
			result = customerLabelService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(CustomerLabel.class));
	}
	
	@Override
	protected List<CustomerLabel> getListByFilter(Filter fitler) {
		return customerLabelService.getListByFilter(fitler).getValue();
	}
	
	
	public List<CustomerLabel> getCustomerLabelList() {
		return customerLabelList;
	}

	public CustomerLabel getCustomerLabel() {
		return customerLabel;
	}

	public void setCustomerLabel(CustomerLabel customerLabel) {
		this.customerLabel = customerLabel;
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

	public void setCustomerLabelService(CustomerLabelService customerLabelService) {
		this.customerLabelService = customerLabelService;
	}
	
	public void setCustomerCategoryService(
			CustomerCategoryService customerCategoryService) {
		this.customerCategoryService = customerCategoryService;
	}

	public Result getResult() {
		return result;
	}
	
}
