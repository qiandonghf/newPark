package com.wiiy.crm.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.entity.Deposit;
import com.wiiy.crm.preferences.enums.BillPlanStatusEnum;
import com.wiiy.crm.service.ContractService;
import com.wiiy.crm.service.DepositService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public class DepositAction extends JqGridBaseAction<Deposit>{
	
	private DepositService depositService;
	private ContractService contractService;
	private Result result;
	private Deposit deposit;
	private Long id;
	private String ids;
	
	public String batchCheckout(){
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean autoRemind = request.getParameter("autoRemind") != null;
		String types = request.getParameter("types");
		result = depositService.batchCheckout(ids,types.split(","),autoRemind);
		return JSON;
	}
	
	public String add(){
		result = contractService.getBeanById(id);
		return "add";
	}
	
	public String checkinById(){
		result = depositService.checkoutById(id, BillPlanStatusEnum.INCHECKED);
		return JSON;
	}
	public String checkoutById(){
		result = depositService.checkoutById(id, BillPlanStatusEnum.OUTCHECKED);
		return JSON;
	}
	
	public String save(){
		deposit.setStatus(BillPlanStatusEnum.UNCHECK);
		result = depositService.save(deposit);
		return JSON;
	}
	
	public String view(){
		result = depositService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = depositService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		Deposit dbBean = depositService.getBeanById(deposit.getId()).getValue();
		BeanUtil.copyProperties(deposit, dbBean);
		result = depositService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = depositService.deleteById(id);
		} else if(ids!=null){
			result = depositService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(Deposit.class).createAlias("contract", "contract"));
	}
	
	@Override
	protected List<Deposit> getListByFilter(Filter fitler) {
		return depositService.getListByFilter(fitler).getValue();
	}
	
	
	public Deposit getDeposit() {
		return deposit;
	}

	public void setDeposit(Deposit deposit) {
		this.deposit = deposit;
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

	public void setDepositService(DepositService depositService) {
		this.depositService = depositService;
	}
	
	public Result getResult() {
		return result;
	}


	public void setContractService(ContractService contractService) {
		this.contractService = contractService;
	}
	
}
