package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.entity.InvestmentInvestor;
import com.wiiy.crm.service.InvestmentInvestorService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class InvestmentInvestorAction extends JqGridBaseAction<InvestmentInvestor>{
	
	private InvestmentInvestorService investmentInvestorService;
	private Result result;
	private InvestmentInvestor investmentInvestor;
	private Long id;
	private String ids;
	
	
	public String save(){
		if(investmentInvestor.getCapitalId()!=null && investmentInvestor.getCapitalId().equals(""))investmentInvestor.setCapitalId(null);
		if(investmentInvestor.getDegreeId()!=null && investmentInvestor.getDegreeId().equals(""))investmentInvestor.setDegreeId(null);
		result = investmentInvestorService.save(investmentInvestor);
		return JSON;
	}
	
	public String view(){
		result = investmentInvestorService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = investmentInvestorService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		InvestmentInvestor dbBean = investmentInvestorService.getBeanById(investmentInvestor.getId()).getValue();
		if(investmentInvestor.getCapitalId()!=null && investmentInvestor.getCapitalId().equals("")) investmentInvestor.setCapitalId(dbBean.getCapitalId());
		if(investmentInvestor.getDegreeId()!=null && investmentInvestor.getDegreeId().equals("")) investmentInvestor.setDegreeId(dbBean.getDegreeId());
		BeanUtil.copyProperties(investmentInvestor, dbBean);
		result = investmentInvestorService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = investmentInvestorService.deleteById(id);
		} else if(ids!=null){
			result = investmentInvestorService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(InvestmentInvestor.class));
	}
	
	@Override
	protected List<InvestmentInvestor> getListByFilter(Filter fitler) {
		return investmentInvestorService.getListByFilter(fitler).getValue();
	}
	
	
	
	
	
	
	
	
	public String mySave(){
		if(investmentInvestor.getCapitalId()!=null && investmentInvestor.getCapitalId().equals(""))investmentInvestor.setCapitalId(null);
		if(investmentInvestor.getDegreeId()!=null && investmentInvestor.getDegreeId().equals(""))investmentInvestor.setDegreeId(null);
		result = investmentInvestorService.save(investmentInvestor);
		return JSON;
	}
	
	public String myView(){
		result = investmentInvestorService.getBeanById(id);
		return "my"+VIEW;
	}
	
	public String myEdit(){
		result = investmentInvestorService.getBeanById(id);
		return "my"+EDIT;
	}
	
	public String myUpdate(){
		InvestmentInvestor dbBean = investmentInvestorService.getBeanById(investmentInvestor.getId()).getValue();
		if(investmentInvestor.getCapitalId()!=null && investmentInvestor.getCapitalId().equals("")) investmentInvestor.setCapitalId(dbBean.getCapitalId());
		if(investmentInvestor.getDegreeId()!=null && investmentInvestor.getDegreeId().equals("")) investmentInvestor.setDegreeId(dbBean.getDegreeId());
		BeanUtil.copyProperties(investmentInvestor, dbBean);
		result = investmentInvestorService.update(dbBean);
		return JSON;
	}
	
	public String myDelete(){
		if(id!=null){
			result = investmentInvestorService.deleteById(id);
		} else if(ids!=null){
			result = investmentInvestorService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String myList(){
		return refresh(new Filter(InvestmentInvestor.class));
	}
	
	
	
	
	
	
	
	public InvestmentInvestor getInvestmentInvestor() {
		return investmentInvestor;
	}

	public void setInvestmentInvestor(InvestmentInvestor investmentInvestor) {
		this.investmentInvestor = investmentInvestor;
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

	public void setInvestmentInvestorService(InvestmentInvestorService investmentInvestorService) {
		this.investmentInvestorService = investmentInvestorService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
