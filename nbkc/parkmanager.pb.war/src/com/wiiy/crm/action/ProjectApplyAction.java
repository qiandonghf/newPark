package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.entity.Product;
import com.wiiy.crm.entity.ProjectApply;
import com.wiiy.crm.service.CustomerService;
import com.wiiy.crm.service.ProductService;
import com.wiiy.crm.service.ProjectApplyService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class ProjectApplyAction extends JqGridBaseAction<ProjectApply>{
	
	private ProjectApplyService projectApplyService;
	private CustomerService customerService;
	private Result result;
	private ProjectApply projectApply;
	private Long id;
	private String ids;
	
	public String addByCustomerId(){
		result = customerService.getBeanById(id);
		return "addByCustomerId";
	}
	
	public String save(){
		result = projectApplyService.save(projectApply);
		return JSON;
	}
	
	public String view(){
		result = projectApplyService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = projectApplyService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		ProjectApply dbBean = projectApplyService.getBeanById(projectApply.getId()).getValue();
		BeanUtil.copyProperties(projectApply, dbBean);
		result = projectApplyService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = projectApplyService.deleteById(id);
		} else if(ids!=null){
			result = projectApplyService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(ProjectApply.class);
		filter.createAlias("customer", "customer");
		return refresh(filter);
	}
	
	@Override
	protected List<ProjectApply> getListByFilter(Filter fitler) {
		return projectApplyService.getListByFilter(fitler).getValue();
	}
	
	public ProjectApply getProjectApply() {
		return projectApply;
	}

	public void setProjectApply(ProjectApply projectApply) {
		this.projectApply = projectApply;
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

	public void setProjectApplyService(ProjectApplyService projectApplyService) {
		this.projectApplyService = projectApplyService;
	}
	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}

	public Result getResult() {
		return result;
	}
}
