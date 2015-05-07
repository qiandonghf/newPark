package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.service.export.OsgiUserService;
import com.wiiy.crm.entity.Vip;
import com.wiiy.crm.service.VipService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.activator.PbActivator;

public class VipAction extends JqGridBaseAction<Vip>{
	private VipService vipService;
	private Vip vip;
	private Result result;
	private Long id;
	private String ids;
	
	private String username;
	private String password;
	private Long orgId;
	
	public String configAccount(){
		return "configAccount";
	}
	
	public String saveAccount(){
		result = vipService.saveAccount(id,username,password,orgId);
		return JSON;
	}

	public String updatePassword(){
		OsgiUserService userService = PbActivator.getService(OsgiUserService.class);
		result = Result.value(userService.getById(id));
		return "updatePassword";
	}
	
	public String updateAccountPassword(){
		result = vipService.updateAccountPassword(id,password);
		return JSON;
	}
	
	public String loadVip(){
		result = vipService.getListByFilter(new Filter(Vip.class).eq("creatorId", PbActivator.getSessionUser().getId()));
		return JSON;
	}
	
	public String save(){		
		result = vipService.save(vip);
		return JSON;
	}
	
	public String edit(){
		result = vipService.getBeanById(id);
		return EDIT;
	}
	
	public String view(){
		result = vipService.getBeanById(id);
		return VIEW;
	}
	
	public String delete(){
		if(id!=null){
			result = vipService.deleteById(id);
		}else if(ids!=null){
			result = vipService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String update(){
		Vip dbBean = vipService.getBeanById(vip.getId()).getValue();
		BeanUtil.copyProperties(vip, dbBean);
		result = vipService.update(dbBean);
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(Vip.class);
		filter.orderBy("orderId", Filter.ASC);
		return refresh(filter);
	}
	
	public String importCard(){
		result = vipService.importCard();
		return JSON;
	}
	@Override
	protected List<Vip> getListByFilter(Filter fitler) {
		return vipService.getListByFilter(fitler).getValue();
	}

	public Vip getVip() {
		return vip;
	}
	public void setVip(Vip vip) {
		this.vip = vip;
	}
	public Result getResult() {
		return result;
	}
	public void setResult(Result result) {
		this.result = result;
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
	public void setVipService(VipService vipService) {
		this.vipService = vipService;
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
