package com.wiiy.oa.action;

import java.util.List;
import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.SalaryDefine;
import com.wiiy.oa.service.SalaryDefineService;

public class SalaryDefineAction extends JqGridBaseAction<SalaryDefine>{
	private SalaryDefineService salaryDefineService;
	private SalaryDefine salaryDefine;
	private Result result;
	private Long id;
	private String ids;
	
	
	public String generateCode(){
		result =  salaryDefineService.generateCode();
		return JSON;
	}
	
	public String config(){
		result = salaryDefineService.getBeanById(id);		
		return "config";
	}
	public String list(){
		Filter filter = new Filter(SalaryDefine.class);
		return refresh(filter);
	}
	
	public String save(){	
		result = salaryDefineService.save(salaryDefine);	
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = salaryDefineService.deleteById(id);
		}else if(ids!=null){
			result = salaryDefineService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String edit(){
		result = salaryDefineService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		SalaryDefine dbBean = salaryDefineService.getBeanById(salaryDefine.getId()).getValue();
		BeanUtil.copyProperties(salaryDefine, dbBean);
		result = salaryDefineService.update(dbBean);
		return JSON;
	}
	
	@Override
	protected List<SalaryDefine> getListByFilter(Filter fitler) {
		return salaryDefineService.getListByFilter(fitler).getValue();
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
	
	public SalaryDefine getSalaryDefine() {
		return salaryDefine;
	}

	public void setSalaryDefine(SalaryDefine salaryDefine) {
		this.salaryDefine = salaryDefine;
	}

	public Result getResult() {
		return result;
	}

	public void setResult(Result result) {
		this.result = result;
	}

	public void setSalaryDefineService(SalaryDefineService salaryDefineService) {
		this.salaryDefineService = salaryDefineService;
	}
}
