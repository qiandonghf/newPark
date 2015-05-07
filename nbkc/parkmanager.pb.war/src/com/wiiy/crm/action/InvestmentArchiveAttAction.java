package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.entity.Investment;
import com.wiiy.crm.entity.InvestmentArchiveAtt;
import com.wiiy.crm.service.InvestmentArchiveAttService;
import com.wiiy.crm.service.InvestmentService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class InvestmentArchiveAttAction extends JqGridBaseAction<InvestmentArchiveAtt>{
	
	private InvestmentArchiveAttService investmentArchiveAttService;
	private InvestmentService investmentService;
	private Result result;
	private InvestmentArchiveAtt investmentArchiveAtt;
	private Investment investment;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = investmentArchiveAttService.save(investmentArchiveAtt);
		return JSON;
	}
	
	public String view(){
		result = investmentArchiveAttService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = investmentArchiveAttService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		InvestmentArchiveAtt dbBean = investmentArchiveAttService.getBeanById(investmentArchiveAtt.getId()).getValue();
		investmentArchiveAtt.setName(investmentArchiveAtt.getName()+dbBean.getNewName().substring(dbBean.getNewName().lastIndexOf(".")));
		BeanUtil.copyProperties(investmentArchiveAtt, dbBean);
		result = investmentArchiveAttService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = investmentArchiveAttService.deleteById(id);
		} else if(ids!=null){
			result = investmentArchiveAttService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		investment = investmentService.getBeanById(id).getValue();
		result = investmentArchiveAttService.getListByFilter(new Filter(InvestmentArchiveAtt.class).eq("investmentId", id));
		return LIST;
	}
	
	@Override
	protected List<InvestmentArchiveAtt> getListByFilter(Filter fitler) {
		return investmentArchiveAttService.getListByFilter(fitler).getValue();
	}
	
	
	
	
	
	
	public String mySave(){
		result = investmentArchiveAttService.save(investmentArchiveAtt);
		return JSON;
	}
	
	public String myView(){
		result = investmentArchiveAttService.getBeanById(id);
		return "my"+VIEW;
	}
	
	public String myEdit(){
		result = investmentArchiveAttService.getBeanById(id);
		return "my"+EDIT;
	}
	
	public String myUpdate(){
		InvestmentArchiveAtt dbBean = investmentArchiveAttService.getBeanById(investmentArchiveAtt.getId()).getValue();
		investmentArchiveAtt.setName(investmentArchiveAtt.getName()+dbBean.getNewName().substring(dbBean.getNewName().lastIndexOf(".")));
		BeanUtil.copyProperties(investmentArchiveAtt, dbBean);
		result = investmentArchiveAttService.update(dbBean);
		return JSON;
	}
	
	public String myDelete(){
		if(id!=null){
			result = investmentArchiveAttService.deleteById(id);
		} else if(ids!=null){
			result = investmentArchiveAttService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String myList(){
		investment = investmentService.getBeanById(id).getValue();
		result = investmentArchiveAttService.getListByFilter(new Filter(InvestmentArchiveAtt.class).eq("investmentId", id));
		return "my"+LIST;
	}
	
	
	
	
	
	
	public InvestmentArchiveAtt getInvestmentArchiveAtt() {
		return investmentArchiveAtt;
	}

	public void setInvestmentArchiveAtt(InvestmentArchiveAtt investmentArchiveAtt) {
		this.investmentArchiveAtt = investmentArchiveAtt;
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

	public void setInvestmentArchiveAttService(InvestmentArchiveAttService investmentArchiveAttService) {
		this.investmentArchiveAttService = investmentArchiveAttService;
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
