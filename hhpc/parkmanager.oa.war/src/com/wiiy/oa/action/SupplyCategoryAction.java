package com.wiiy.oa.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.TreeUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.Supply;
import com.wiiy.oa.entity.SupplyCategory;
import com.wiiy.oa.service.SupplyCategoryService;

public class SupplyCategoryAction extends JqGridBaseAction<SupplyCategory>{
	private SupplyCategoryService supplyCategoryService;
	private SupplyCategory supplyCategory;	
	private Supply supply;
	private Long id;
	private Result result;
	private List<SupplyCategory> supplyCategories;


	public String loadSupplyLabelByCategoryId(){
		result = supplyCategoryService.getListByFilter(new Filter(Supply.class).eq("categoryId", id));
		return JSON;
	}
	
	public String addSupplyCategoryByParentId(){
		result = supplyCategoryService.getBeanById(id);
		return "addByCategoryId";
	}
	
	public String save(){
		result = supplyCategoryService.save(supplyCategory);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = supplyCategoryService.deleteById(id);
		}
		return JSON;
	}
	
	public String edit(){
		supplyCategory = supplyCategoryService.getBeanById(id).getValue();
		result = Result.value(supplyCategory);
		return EDIT;
	}
	
	public String update(){
		SupplyCategory dbBean = supplyCategoryService.getBeanById(supplyCategory.getId()).getValue();
		BeanUtil.copyProperties(supplyCategory, dbBean);
		result = supplyCategoryService.update(dbBean);
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(SupplyCategory.class);
		supplyCategories = supplyCategoryService.getListByFilter(filter).getValue();
		result = supplyCategoryService.getList();
		return LIST;
	}
	
	public String treeList(){
		supplyCategories = supplyCategoryService.getListByFilter(new Filter(SupplyCategory.class)).getValue();
		for(SupplyCategory sc : supplyCategories){
			if(sc.getParentId() == null){
				sc.setState(TreeEntity.STATE_CLOSED);
				sc.setText(sc.getName());
				sc.setLevel(sc.getLevel());
			}else{
				sc.setText(sc.getName());
				sc.setLevel(sc.getLevel());
			}
		}
		supplyCategories = TreeUtil.generateTree(supplyCategories);
		return JSON;
	}
	
	public List<SupplyCategory> getSupplyCategories() {
		return supplyCategories;
	}

	public void setSupplyCategories(List<SupplyCategory> supplyCategories) {
		this.supplyCategories = supplyCategories;
	}

	@Override
	protected List<SupplyCategory> getListByFilter(Filter fitler) {
		return supplyCategoryService.getListByFilter(fitler).getValue();
	}

	public SupplyCategoryService getSupplyCategoryService() {
		return supplyCategoryService;
	}

	public void setSupplyCategoryService(SupplyCategoryService supplyCategoryService) {
		this.supplyCategoryService = supplyCategoryService;
	}

	public SupplyCategory getSupplyCategory() {
		return supplyCategory;
	}

	public void setSupplyCategory(SupplyCategory supplyCategory) {
		this.supplyCategory = supplyCategory;
	}
	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}
	public Result getResult() {
		return result;
	}

	public void setResult(Result result) {
		this.result = result;
	}

	public Supply getSupply() {
		return supply;
	}

	public void setSupply(Supply supply) {
		this.supply = supply;
	}

}
