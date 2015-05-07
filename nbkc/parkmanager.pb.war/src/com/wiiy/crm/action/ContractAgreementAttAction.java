package com.wiiy.crm.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.entity.ContractAgreementAtt;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.service.ContractAgreementAttService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class ContractAgreementAttAction extends JqGridBaseAction<ContractAgreementAtt>{
	
	private ContractAgreementAttService contractAgreementAttService;
	private Result result;
	private ContractAgreementAtt contractAgreementAtt;
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
	
	public String saveToSession(){
		if(getSessionContractAgreementAttList()==null){
			List<ContractAgreementAtt> contractAgreementAttList = new ArrayList<ContractAgreementAtt>();
			getSession().setAttribute("contractAgreementAttList", contractAgreementAttList);
		}
		contractAgreementAtt.setId((new Date()).getTime());
		getSessionContractAgreementAttList().add(contractAgreementAtt);
		result = Result.success(R.ContractAgreementAtt.SAVE_SUCCESS,contractAgreementAtt);
		return JSON;
	}
	
	public String deleteFromSession(){
		List<ContractAgreementAtt> list = getSessionContractAgreementAttList();
		ContractAgreementAtt delete = null;
		if(list!=null){
			for (ContractAgreementAtt task : list) {
				if(task.getId().longValue()==id.longValue()){
					delete = task;
					break;
				}
			}
			if(delete!=null){
				PbActivator.getResourcesService().delete(delete.getNewName());
				list.remove(delete);
			}
		}
		result = Result.success(R.ContractAgreementAtt.DELETE_SUCCESS);
		return JSON;
	}
	
	
	public String save(){
		result = contractAgreementAttService.save(contractAgreementAtt);
		return JSON;
	}
	
	public String view(){
		result = contractAgreementAttService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = contractAgreementAttService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		ContractAgreementAtt dbBean = contractAgreementAttService.getBeanById(contractAgreementAtt.getId()).getValue();
		BeanUtil.copyProperties(contractAgreementAtt, dbBean);
		result = contractAgreementAttService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = contractAgreementAttService.deleteById(id);
		} else if(ids!=null){
			result = contractAgreementAttService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(ContractAgreementAtt.class));
	}
	
	@Override
	protected List<ContractAgreementAtt> getListByFilter(Filter fitler) {
		return contractAgreementAttService.getListByFilter(fitler).getValue();
	}
	
	
	public ContractAgreementAtt getContractAgreementAtt() {
		return contractAgreementAtt;
	}

	public void setContractAgreementAtt(ContractAgreementAtt contractAgreementAtt) {
		this.contractAgreementAtt = contractAgreementAtt;
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

	public void setContractAgreementAttService(ContractAgreementAttService contractAgreementAttService) {
		this.contractAgreementAttService = contractAgreementAttService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
