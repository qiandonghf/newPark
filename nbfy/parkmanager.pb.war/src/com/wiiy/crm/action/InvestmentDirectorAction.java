package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.crm.entity.InvestmentDirector;
import com.wiiy.crm.service.InvestmentDirectorService;

/**
 * @author my
 */
public class InvestmentDirectorAction extends JqGridBaseAction<InvestmentDirector>{
	
	private InvestmentDirectorService investmentDirectorService;
	private Result result;
	private InvestmentDirector investmentDirector;
	private Long id;
	private String ids;
	private Long investmentId;
	
	public String selectList(){
		return refresh(new Filter(InvestmentDirector.class).eq("investmentId",investmentId));
	}
	public String save(){
		if("".equals(investmentDirector.getDegreeId())){
			investmentDirector.setDegreeId(null);
		}
		result = investmentDirectorService.save(investmentDirector);
		return JSON;
	}
	
	public String view(){
		result = investmentDirectorService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = investmentDirectorService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		if("".equals(investmentDirector.getDegreeId())){
			investmentDirector.setDegreeId(null);
		}
		InvestmentDirector dbBean = investmentDirectorService.getBeanById(investmentDirector.getId()).getValue();
		BeanUtil.copyProperties(investmentDirector, dbBean);
		result = investmentDirectorService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = investmentDirectorService.deleteById(id);
		} else if(ids!=null){
			result = investmentDirectorService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		System.out.println(id);
		return refresh(new Filter(InvestmentDirector.class).eq("investmentId", id));
	}
	
	public String listByInvestment(){
		System.out.println(id);
		return refresh(new Filter(InvestmentDirector.class).eq("id", id));
	}
	
	@Override
	protected List<InvestmentDirector> getListByFilter(Filter fitler) {
		return investmentDirectorService.getListByFilter(fitler).getValue();
	}
	
	
	
	
	public String mySave(){
		if("".equals(investmentDirector.getDegreeId())){
			investmentDirector.setDegreeId(null);
		}
		result = investmentDirectorService.save(investmentDirector);
		return JSON;
	}
	
	public String myView(){
		result = investmentDirectorService.getBeanById(id);
		return "my"+VIEW;
	}
	
	public String myEdit(){
		result = investmentDirectorService.getBeanById(id);
		return "my"+EDIT;
	}
	
	public String myUpdate(){
		if("".equals(investmentDirector.getDegreeId())){
			investmentDirector.setDegreeId(null);
		}
		InvestmentDirector dbBean = investmentDirectorService.getBeanById(investmentDirector.getId()).getValue();
		BeanUtil.copyProperties(investmentDirector, dbBean);
		result = investmentDirectorService.update(dbBean);
		return JSON;
	}
	
	public String myDelete(){
		if(id!=null){
			result = investmentDirectorService.deleteById(id);
		} else if(ids!=null){
			result = investmentDirectorService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String myList(){
		System.out.println(id);
		return refresh(new Filter(InvestmentDirector.class).eq("investmentId", id));
	}
	
	public String myListByInvestment(){
		System.out.println(id);
		return refresh(new Filter(InvestmentDirector.class).eq("id", id));
	}
	
	
	
	
	
	public InvestmentDirector getInvestmentDirector() {
		return investmentDirector;
	}

	public void setInvestmentDirector(InvestmentDirector investmentDirector) {
		this.investmentDirector = investmentDirector;
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

	public void setInvestmentDirectorService(InvestmentDirectorService investmentDirectorService) {
		this.investmentDirectorService = investmentDirectorService;
	}
	
	public Result getResult() {
		return result;
	}
	public Long getInvestmentId() {
		return investmentId;
	}
	public void setInvestmentId(Long investmentId) {
		this.investmentId = investmentId;
	}
	
}
