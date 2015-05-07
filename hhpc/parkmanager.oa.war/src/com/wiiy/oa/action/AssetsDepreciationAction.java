package com.wiiy.oa.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.entity.AssetsDepreciation;
import com.wiiy.oa.service.AssetsDepreciationService;

public class AssetsDepreciationAction extends JqGridBaseAction<AssetsDepreciation>{
	private AssetsDepreciationService assetsDepreciationService;	
	private AssetsDepreciation assetsDepreciation;	
	private Result result;
	private Long id;
	private String ids;
	
	public String loadAssetsDepreciation(){
		result = assetsDepreciationService.getListByFilter(new Filter(AssetsDepreciation.class).eq("creatorId", OaActivator.getSessionUser().getId()));
		return JSON;
	}	
	public String save(){		
		result = assetsDepreciationService.save(assetsDepreciation);
		return JSON;
	}
	
	public String edit(){
		result = assetsDepreciationService.getBeanById(id);
		return EDIT;
	}
	
	public String delete(){
		if(id!=null){
			result = assetsDepreciationService.deleteById(id);
		}else if(ids!=null){
			result = assetsDepreciationService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String update(){
		AssetsDepreciation dbBean = assetsDepreciationService.getBeanById(assetsDepreciation.getId()).getValue();
		BeanUtil.copyProperties(assetsDepreciation, dbBean);
		result = assetsDepreciationService.update(dbBean);
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(AssetsDepreciation.class);		
		return refresh(filter);
	}
	
	
	protected List<AssetsDepreciation> getListByFilter(Filter fitler) {
		return assetsDepreciationService.getListByFilter(fitler).getValue();
	}
	
	public AssetsDepreciation getAssetsDepreciation() {
		return assetsDepreciation;
	}
	public void setAssetsDepreciation(AssetsDepreciation assetsDepreciation) {
		this.assetsDepreciation = assetsDepreciation;
	}
	public Result getResult() {
		return result;
	}
	public void setResult(Result result) {
		this.result = result;
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
	public void setAssetsDepreciationService(
			AssetsDepreciationService assetsDepreciationService) {
		this.assetsDepreciationService = assetsDepreciationService;
	}
}
