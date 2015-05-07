package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.entity.Investment;
import com.wiiy.crm.entity.InvestmentLog;
import com.wiiy.crm.service.InvestmentLogService;
import com.wiiy.crm.service.InvestmentService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class InvestmentLogAction extends JqGridBaseAction<InvestmentLog>{
	
	private InvestmentLogService investmentLogService;
	private InvestmentService investmentService;

	private Result result;
	private InvestmentLog investmentLog;
	private Long id;
	private String ids;
	
	
	public String add(){
		result = investmentService.getBeanById(id);
		return "add";
	}
	
	public String save(){
		result = investmentLogService.save(investmentLog);
		return JSON;
	}
	
	public String view(){
		result = investmentLogService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = investmentLogService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		InvestmentLog dbBean = investmentLogService.getBeanById(investmentLog.getId()).getValue();
		BeanUtil.copyProperties(investmentLog, dbBean);
		result = investmentLogService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = investmentLogService.deleteById(id);
		} else if(ids!=null){
			result = investmentLogService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(InvestmentLog.class).createAlias("investment", "investment");
		refresh(filter);
		if(root!=null){
			for (InvestmentLog log : root) {
				if(log.getInvestment()!=null){
					String investmentName = log.getInvestment().getName();
					Investment investment = new Investment();
					investment.setId(log.getInvestmentId());
					investment.setName(investmentName);
					log.setInvestment(investment);
				}
			}
		}
		return JSON;
	}
	
	@Override
	protected List<InvestmentLog> getListByFilter(Filter fitler) {
		return investmentLogService.getListByFilter(fitler).getValue();
	}
	
	
	
	
	public String add2(){
		result = investmentService.getBeanById(id);
		return "add2";
	}
	
	public String save2(){
		result = investmentLogService.save(investmentLog);
		return JSON;
	}
	
	public String view2(){
		result = investmentLogService.getBeanById(id);
		return VIEW+"2";
	}
	
	public String editLog(){
		result = investmentLogService.getBeanById(id);
		return "editLog";
	}
	public String edit2(){
		result = investmentLogService.getBeanById(id);
		return EDIT+"2";
	}
	
	public String update2(){
		InvestmentLog dbBean = investmentLogService.getBeanById(investmentLog.getId()).getValue();
		BeanUtil.copyProperties(investmentLog, dbBean);
		result = investmentLogService.update(dbBean);
		return JSON;
	}
	
	public String delete2(){
		if(id!=null){
			result = investmentLogService.deleteById(id);
		} else if(ids!=null){
			result = investmentLogService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list2(){
		Filter filter = new Filter(InvestmentLog.class).createAlias("investment", "investment");
		refresh(filter);
		if(root!=null){
			for (InvestmentLog log : root) {
				if(log.getInvestment()!=null){
					String investmentName = log.getInvestment().getName();
					Investment investment = new Investment();
					investment.setId(log.getInvestmentId());
					investment.setName(investmentName);
					log.setInvestment(investment);
				}
			}
		}
		return JSON;
	}
	
	
	
	
	
	
	
	public String myAdd(){
		result = investmentService.getBeanById(id);
		return "myadd";
	}
	
	public String mySave(){
		result = investmentLogService.save(investmentLog);
		return JSON;
	}
	
	public String myView(){
		result = investmentLogService.getBeanById(id);
		return "my"+VIEW;
	}
	
	public String myEdit(){
		result = investmentLogService.getBeanById(id);
		return "my"+EDIT;
	}
	
	public String myUpdate(){
		InvestmentLog dbBean = investmentLogService.getBeanById(investmentLog.getId()).getValue();
		BeanUtil.copyProperties(investmentLog, dbBean);
		result = investmentLogService.update(dbBean);
		return JSON;
	}
	
	public String myDelete(){
		if(id!=null){
			result = investmentLogService.deleteById(id);
		} else if(ids!=null){
			result = investmentLogService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String myList(){
		Filter filter = new Filter(InvestmentLog.class).createAlias("investment", "investment");
		refresh(filter);
		if(root!=null){
			for (InvestmentLog log : root) {
				if(log.getInvestment()!=null){
					String investmentName = log.getInvestment().getName();
					Investment investment = new Investment();
					investment.setId(log.getInvestmentId());
					investment.setName(investmentName);
					log.setInvestment(investment);
				}
			}
		}
		return JSON;
	}
	
	
	
	
	
	
	
	public InvestmentLog getInvestmentLog() {
		return investmentLog;
	}

	public void setInvestmentLog(InvestmentLog investmentLog) {
		this.investmentLog = investmentLog;
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

	public void setInvestmentLogService(InvestmentLogService investmentLogService) {
		this.investmentLogService = investmentLogService;
	}
	
	public Result getResult() {
		return result;
	}
	public void setInvestmentService(InvestmentService investmentService) {
		this.investmentService = investmentService;
	}
}
