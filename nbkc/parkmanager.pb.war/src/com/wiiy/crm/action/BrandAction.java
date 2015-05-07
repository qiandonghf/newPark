package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.entity.Brand;
import com.wiiy.crm.service.BrandService;
import com.wiiy.crm.service.CustomerService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

public class BrandAction extends JqGridBaseAction<Brand>{
	private BrandService brandService;
	private CustomerService customerService;
	private Brand brand;
	private Long id;
	private String ids;
	private Result result;
	
	public String addByCustomerId(){
		result = customerService.getBeanById(id);
		return "addByCustomerId";
	}
	
	public String list(){
		Filter filter = new Filter(Brand.class);
		return refresh(filter);
	}
	
	public String save(){
		result = brandService.save(brand);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = brandService.deleteById(id); 
		}
		if(ids!=null){
			result = brandService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String edit(){
		result = brandService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		Brand dbean = brandService.getBeanById(brand.getId()).getValue();
		BeanUtil.copyProperties(brand, dbean);
		result = brandService.update(dbean);
		return JSON;
	}
	
	public String view(){
		result = brandService.getBeanById(id);
		return VIEW;
	}
	
	@Override
	protected List<Brand> getListByFilter(Filter filter) {
		return brandService.getListByFilter(filter).getValue();
	}

	public Brand getBrand() {
		return brand;
	}

	public void setBrand(Brand brand) {
		this.brand = brand;
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

	public void setBrandService(BrandService brandService) {
		this.brandService = brandService;
	}

	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}

}
