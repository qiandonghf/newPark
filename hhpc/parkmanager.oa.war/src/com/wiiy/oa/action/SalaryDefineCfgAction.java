package com.wiiy.oa.action;

import java.util.List;
import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.SalaryDefineCfg;
import com.wiiy.oa.service.SalaryDefineCfgService;

public class SalaryDefineCfgAction extends JqGridBaseAction<SalaryDefineCfg>{
	private SalaryDefineCfgService salaryDefineCfgService;
	private SalaryDefineCfg salaryDefineCfg;
	private Result result;
	private Long id;
	private String ids;
	private Long salaryDefineId;
	
	public String list(){
		Filter filter = new Filter(SalaryDefineCfg.class);
		if(salaryDefineId==null){			
			filter.eq("salaryDefineId", Long.MAX_VALUE);
		}else{			
			filter.eq("salaryDefineId",salaryDefineId);
		}
		return refresh(filter);
	}
	public String save(){		
		result = salaryDefineCfgService.save(salaryDefineCfg);
		return JSON;
	}
	public String save2(){
		result = salaryDefineCfgService.save2(ids,salaryDefineId);
		return JSON;
	}
	public String delete(){
		if(id!=null){
			result = salaryDefineCfgService.deleteById(id);
		}else if(ids!=null){
			result = salaryDefineCfgService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String edit(){
		result = salaryDefineCfgService.getBeanByFilter(new Filter(SalaryDefineCfg.class).eq("salaryDefineId", salaryDefineId));
		return EDIT;
	}
	
	public String update(){
		SalaryDefineCfg dbBean = salaryDefineCfgService.getBeanById(salaryDefineCfg.getId()).getValue();
		BeanUtil.copyProperties(salaryDefineCfg, dbBean);
		result = salaryDefineCfgService.update(dbBean);
		return JSON;
	}
	
	@Override
	protected List<SalaryDefineCfg> getListByFilter(Filter fitler) {
		return salaryDefineCfgService.getListByFilter(fitler).getValue();
	}

	public SalaryDefineCfg getSalaryDefineCfg() {
		return salaryDefineCfg;
	}
	public void setSalaryDefineCfg(SalaryDefineCfg salaryDefineCfg) {
		this.salaryDefineCfg = salaryDefineCfg;
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
	public void setSalaryDefineCfgService(
			SalaryDefineCfgService salaryDefineCfgService) {
		this.salaryDefineCfgService = salaryDefineCfgService;
	}

	public Long getSalaryDefineId() {
		return salaryDefineId;
	}

	public void setSalaryDefineId(Long salaryDefineId) {
		this.salaryDefineId = salaryDefineId;
	}
}
