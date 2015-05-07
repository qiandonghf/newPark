package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.core.service.export.OsgiUserService;
import com.wiiy.crm.entity.Agency;
import com.wiiy.crm.service.AgencyService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.activator.PbActivator;

public class AgencyAction extends JqGridBaseAction<Agency>{
	private AgencyService agencyService;
	private Agency agency;
	private Long id;
	private String ids;
	private Result result;
	
	private String username;
	private String password;
	private Long orgId;
	
	public String configAccount(){
		return "configAccount";
	}
	
	public String saveAccount(){
		result = agencyService.saveAccount(id,username,password,orgId);
		return JSON;
	}

	public String updatePassword(){
		OsgiUserService userService = PbActivator.getService(OsgiUserService.class);
		result = Result.value(userService.getById(id));
		return "updatePassword";
	}
	
	public String updateAccountPassword(){
		result = agencyService.updateAccountPassword(id,password);
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(Agency.class);
		filter.orderBy("orderId", Filter.ASC);
		return refresh(filter);
	}
	
	public String save(){
		result = agencyService.save(agency);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = agencyService.deleteById(id);
		}else if(ids!=null){
			result = agencyService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String edit(){
		result = agencyService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		result = agencyService.update(agency);
		return JSON;
	}
	
	public String view(){
		result = agencyService.getBeanById(id);
		return VIEW;
	}
	
	public String importCard(){
		result = agencyService.importCard();
		return JSON;
	}
	
	@Override
	protected List<Agency> getListByFilter(Filter fitler) {
		return agencyService.getListByFilter(fitler).getValue();
	}

	public void setAgencyService(AgencyService agencyService) {
		this.agencyService = agencyService;
	}

	public Agency getAgency() {
		return agency;
	}

	public void setAgency(Agency agency) {
		this.agency = agency;
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

	public Result getResult() {
		return result;
	}

	public void setResult(Result result) {
		this.result = result;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Long getOrgId() {
		return orgId;
	}

	public void setOrgId(Long orgId) {
		this.orgId = orgId;
	}
	
}
