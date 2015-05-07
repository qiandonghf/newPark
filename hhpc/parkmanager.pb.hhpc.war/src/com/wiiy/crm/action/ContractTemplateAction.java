package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.crm.entity.ContractTemplate;
import com.wiiy.crm.service.ContractTemplateService;

/**
 * @author my
 */
public class ContractTemplateAction extends JqGridBaseAction<ContractTemplate>{
	
	private ContractTemplateService contractTemplateService;
	private Result result;
	private ContractTemplate contractTemplate;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = contractTemplateService.save(contractTemplate);
		return JSON;
	}
	
	public String view(){
		result = contractTemplateService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = contractTemplateService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		ContractTemplate dbBean = contractTemplateService.getBeanById(contractTemplate.getId()).getValue();
		BeanUtil.copyProperties(contractTemplate, dbBean);
		result = contractTemplateService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = contractTemplateService.deleteById(id);
		} else if(ids!=null){
			result = contractTemplateService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(ContractTemplate.class));
	}
	
	@Override
	protected List<ContractTemplate> getListByFilter(Filter fitler) {
		return contractTemplateService.getListByFilter(fitler).getValue();
	}
	
	
	public ContractTemplate getContractTemplate() {
		return contractTemplate;
	}

	public void setContractTemplate(ContractTemplate contractTemplate) {
		this.contractTemplate = contractTemplate;
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

	public void setContractTemplateService(ContractTemplateService contractTemplateService) {
		this.contractTemplateService = contractTemplateService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
