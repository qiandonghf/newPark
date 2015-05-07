package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.entity.Investment;
import com.wiiy.crm.entity.InvestmentContractAtt;
import com.wiiy.crm.service.InvestmentContractAttService;
import com.wiiy.crm.service.InvestmentService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class InvestmentContractAttAction extends JqGridBaseAction<InvestmentContractAtt>{
	
	private InvestmentContractAttService investmentContractAttService;
	private InvestmentService investmentService;
	private Result result;
	private InvestmentContractAtt investmentContractAtt;
	private Investment investment;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = investmentContractAttService.save(investmentContractAtt);
		return JSON;
	}
	
	public String view(){
		result = investmentContractAttService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = investmentContractAttService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		InvestmentContractAtt dbBean = investmentContractAttService.getBeanById(investmentContractAtt.getId()).getValue();
		investmentContractAtt.setName(investmentContractAtt.getName()+dbBean.getNewName().substring(dbBean.getNewName().lastIndexOf(".")));
		BeanUtil.copyProperties(investmentContractAtt, dbBean);
		result = investmentContractAttService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = investmentContractAttService.deleteById(id);
		} else if(ids!=null){
			result = investmentContractAttService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		investment = investmentService.getBeanById(id).getValue();
		result = investmentContractAttService.getListByFilter(new Filter(InvestmentContractAtt.class).eq("investmentId", id));
		return LIST;
	}
	
	@Override
	protected List<InvestmentContractAtt> getListByFilter(Filter fitler) {
		return investmentContractAttService.getListByFilter(fitler).getValue();
	}
	
	
	
	
	
	public String mySave(){
		result = investmentContractAttService.save(investmentContractAtt);
		return JSON;
	}
	
	public String myView(){
		result = investmentContractAttService.getBeanById(id);
		return "my"+VIEW;
	}
	
	public String myEdit(){
		result = investmentContractAttService.getBeanById(id);
		return "my"+EDIT;
	}
	
	public String myUpdate(){
		InvestmentContractAtt dbBean = investmentContractAttService.getBeanById(investmentContractAtt.getId()).getValue();
		investmentContractAtt.setName(investmentContractAtt.getName()+dbBean.getNewName().substring(dbBean.getNewName().lastIndexOf(".")));
		BeanUtil.copyProperties(investmentContractAtt, dbBean);
		result = investmentContractAttService.update(dbBean);
		return JSON;
	}
	
	public String myDelete(){
		if(id!=null){
			result = investmentContractAttService.deleteById(id);
		} else if(ids!=null){
			result = investmentContractAttService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String myList(){
		investment = investmentService.getBeanById(id).getValue();
		result = investmentContractAttService.getListByFilter(new Filter(InvestmentContractAtt.class).eq("investmentId", id));
		return "my"+LIST;
	}
	
	
	
	
	
	public InvestmentContractAtt getInvestmentContractAtt() {
		return investmentContractAtt;
	}

	public void setInvestmentContractAtt(InvestmentContractAtt investmentContractAtt) {
		this.investmentContractAtt = investmentContractAtt;
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

	public void setInvestmentContractAttService(InvestmentContractAttService investmentContractAttService) {
		this.investmentContractAttService = investmentContractAttService;
	}
	
	public Result getResult() {
		return result;
	}
	
	public Investment getInvestment() {
		return investment;
	}

	public void setInvestmentService(InvestmentService investmentService) {
		this.investmentService = investmentService;
	}
	
}
