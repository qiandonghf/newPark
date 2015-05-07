package com.wiiy.crm.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.crm.entity.ContractAgreement;
import com.wiiy.crm.entity.ContractAgreementAtt;
import com.wiiy.crm.service.ContractAgreementService;

/**
 * @author my
 */
public class ContractAgreementAction extends JqGridBaseAction<ContractAgreement>{
	
	private ContractAgreementService contractAgreementService;
	private Result result;
	private ContractAgreement contractAgreement;
	private Long id;
	private String ids;
	
	private HttpSession getSession(){
		return ServletActionContext.getRequest().getSession();
	}
	@SuppressWarnings("unchecked")
	private List<ContractAgreementAtt> getSessionContractAgreementAttList(){
		HttpSession session = getSession();
		return (List<ContractAgreementAtt>) session.getAttribute("contractAgreementAttList");
	}
	
	public String save(){
		result = contractAgreementService.save(contractAgreement,getSessionContractAgreementAttList());
		return JSON;
	}
	
	public String view(){
		getSession().removeAttribute("copyrightAttList");
		contractAgreement = contractAgreementService.getBeanById(id).getValue();
		result = Result.value(contractAgreement);
		getSession().setAttribute("contractAgreementAttList", new ArrayList<ContractAgreementAtt>(contractAgreement.getAtts()));
		return VIEW;
	}
	
	public String edit(){
		getSession().removeAttribute("contractAgreementAttList");
		contractAgreement = contractAgreementService.getBeanById(id).getValue();
		result = Result.value(contractAgreement);
		getSession().setAttribute("contractAgreementAttList", new ArrayList<ContractAgreementAtt>(contractAgreement.getAtts()));
		return EDIT;
	}
	
	public String update(){
		ContractAgreement dbBean = contractAgreementService.getBeanById(contractAgreement.getId()).getValue();
		BeanUtil.copyProperties(contractAgreement, dbBean);
		result = contractAgreementService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = contractAgreementService.deleteById(id);
		} else if(ids!=null){
			result = contractAgreementService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(ContractAgreement.class));
	}
	
	@Override
	protected List<ContractAgreement> getListByFilter(Filter fitler) {
		return contractAgreementService.getListByFilter(fitler).getValue();
	}
	
	
	public ContractAgreement getContractAgreement() {
		return contractAgreement;
	}

	public void setContractAgreement(ContractAgreement contractAgreement) {
		this.contractAgreement = contractAgreement;
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

	public void setContractAgreementService(ContractAgreementService contractAgreementService) {
		this.contractAgreementService = contractAgreementService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
