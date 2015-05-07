package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.crm.entity.InvestmentProcessAtt;
import com.wiiy.crm.service.InvestmentProcessAttService;

/**
 * @author my
 */
public class InvestmentProcessAttAction extends JqGridBaseAction<InvestmentProcessAtt>{
	
	private InvestmentProcessAttService investmentProcessAttService;
	private Result result;
	private InvestmentProcessAtt investmentProcessAtt;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = investmentProcessAttService.save(investmentProcessAtt);
		return JSON;
	}
	
	public String view(){
		result = investmentProcessAttService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = investmentProcessAttService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		InvestmentProcessAtt dbBean = investmentProcessAttService.getBeanById(investmentProcessAtt.getId()).getValue();
		BeanUtil.copyProperties(investmentProcessAtt, dbBean);
		result = investmentProcessAttService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = investmentProcessAttService.deleteById(id);
		} else if(ids!=null){
			result = investmentProcessAttService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(InvestmentProcessAtt.class));
	}
	
	@Override
	protected List<InvestmentProcessAtt> getListByFilter(Filter fitler) {
		return investmentProcessAttService.getListByFilter(fitler).getValue();
	}
	
	
	public InvestmentProcessAtt getInvestmentProcessAtt() {
		return investmentProcessAtt;
	}

	public void setInvestmentProcessAtt(InvestmentProcessAtt investmentProcessAtt) {
		this.investmentProcessAtt = investmentProcessAtt;
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

	public void setInvestmentProcessAttService(InvestmentProcessAttService investmentProcessAttService) {
		this.investmentProcessAttService = investmentProcessAttService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
