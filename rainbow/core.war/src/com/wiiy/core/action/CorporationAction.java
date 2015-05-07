package com.wiiy.core.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.entity.Corporation;
import com.wiiy.core.service.CorporationService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class CorporationAction extends JqGridBaseAction<Corporation>{
	
	private CorporationService corporationService;
	@SuppressWarnings("rawtypes")
	private Result result;
	private Corporation corporation;
	private Long id;
	private String ids;
	
	public String generateCode() {
		result = corporationService.generateCode();
		return JSON;
	}
	
	public String save(){
		result = corporationService.save(corporation);
		return JSON;
	}
	
	public String view(){
		result = corporationService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = corporationService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		Corporation dbBean = corporationService.getBeanById(corporation.getId()).getValue();
		BeanUtil.copyProperties(corporation, dbBean);
		result = corporationService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = corporationService.deleteById(id);
		} else if(ids!=null){
			result = corporationService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String simpleList(){
		Filter filter = new Filter(Corporation.class);
		filter.include("id").include("name");
		return refresh(new Filter(Corporation.class));
	}
	
	public String list(){
		return refresh(new Filter(Corporation.class));
	}
	
	@Override
	protected List<Corporation> getListByFilter(Filter fitler) {
		return corporationService.getListByFilter(fitler).getValue();
	}
	
	
	public Corporation getCorporation() {
		return corporation;
	}

	public void setCorporation(Corporation corporation) {
		this.corporation = corporation;
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

	public void setCorporationService(CorporationService corporationService) {
		this.corporationService = corporationService;
	}
	
	@SuppressWarnings("rawtypes")
	public Result getResult() {
		return result;
	}
	
}
