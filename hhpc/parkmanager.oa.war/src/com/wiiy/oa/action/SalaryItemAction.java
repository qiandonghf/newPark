package com.wiiy.oa.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.SalaryItem;
import com.wiiy.oa.service.SalaryItemService;

public class SalaryItemAction extends JqGridBaseAction<SalaryItem>{
	private SalaryItemService salaryItemService;
	private SalaryItem salaryItem;
	private Long id;
	private String ids;
	private Result result;
	
	public String list(){
		Filter filter = new Filter(SalaryItem.class);
		return refresh(filter);
	}
	
	public String save(){
		result = salaryItemService.save(salaryItem);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = salaryItemService.deleteById(id);
		}else if(ids!=null){
			result = salaryItemService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String edit(){
		result = salaryItemService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		SalaryItem dbBean = salaryItemService.getBeanById(salaryItem.getId()).getValue();
		BeanUtil.copyProperties(salaryItem, dbBean);
		result = salaryItemService.update(dbBean);
		return JSON;
	}
		
	@Override
	protected List<SalaryItem> getListByFilter(Filter fitler) {
		return salaryItemService.getListByFilter(fitler).getValue();
	}

	public SalaryItem getSalaryItem() {
		return salaryItem;
	}

	public void setSalaryItem(SalaryItem salaryItem) {
		this.salaryItem = salaryItem;
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

	public void setSalaryItemService(SalaryItemService salaryItemService) {
		this.salaryItemService = salaryItemService;
	}

}
