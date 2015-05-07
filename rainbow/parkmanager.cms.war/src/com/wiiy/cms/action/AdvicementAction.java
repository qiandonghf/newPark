package com.wiiy.cms.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.cms.entity.Advicement;
import com.wiiy.cms.service.AdvicementService;

/**
 * @author my
 */
public class AdvicementAction extends JqGridBaseAction<Advicement>{
	
	private AdvicementService advicementService;
	private Result result;
	private Advicement advicement;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = advicementService.save(advicement);
		return JSON;
	}
	
	public String view(){
		result = advicementService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = advicementService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		Advicement dbBean = advicementService.getBeanById(advicement.getId()).getValue();
		BeanUtil.copyProperties(advicement, dbBean);
		result = advicementService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = advicementService.deleteById(id);
		} else if(ids!=null){
			result = advicementService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(Advicement.class));
	}
	
	@Override
	protected List<Advicement> getListByFilter(Filter fitler) {
		return advicementService.getListByFilter(fitler).getValue();
	}
	
	
	public Advicement getAdvicement() {
		return advicement;
	}

	public void setAdvicement(Advicement advicement) {
		this.advicement = advicement;
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

	public void setAdvicementService(AdvicementService advicementService) {
		this.advicementService = advicementService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
