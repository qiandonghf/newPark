package com.wiiy.core.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.core.entity.RoleAuthorityRef;
import com.wiiy.core.service.export.RoleAuthorityRefService;

/**
 * @author my
 */
public class RoleAuthorityRefAction extends JqGridBaseAction<RoleAuthorityRef>{
	
	private RoleAuthorityRefService roleAuthorityRefService;
	private Result result;
	private RoleAuthorityRef roleAuthorityRef;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = roleAuthorityRefService.save(roleAuthorityRef);
		return JSON;
	}
	
	public String view(){
		result = roleAuthorityRefService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = roleAuthorityRefService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		RoleAuthorityRef dbBean = roleAuthorityRefService.getBeanById(roleAuthorityRef.getId()).getValue();
		BeanUtil.copyProperties(roleAuthorityRef, dbBean);
		result = roleAuthorityRefService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = roleAuthorityRefService.deleteById(id);
		} else if(ids!=null){
			result = roleAuthorityRefService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(RoleAuthorityRef.class));
	}
	
	@Override
	protected List<RoleAuthorityRef> getListByFilter(Filter fitler) {
		return roleAuthorityRefService.getListByFilter(fitler).getValue();
	}
	
	
	public RoleAuthorityRef getRoleAuthorityRef() {
		return roleAuthorityRef;
	}

	public void setRoleAuthorityRef(RoleAuthorityRef roleAuthorityRef) {
		this.roleAuthorityRef = roleAuthorityRef;
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

	public void setRoleAuthorityRefService(RoleAuthorityRefService roleAuthorityRefService) {
		this.roleAuthorityRefService = roleAuthorityRefService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
