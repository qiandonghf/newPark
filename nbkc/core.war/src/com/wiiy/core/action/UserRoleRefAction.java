package com.wiiy.core.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.core.entity.UserRoleRef;
import com.wiiy.core.service.UserRoleRefService;

/**
 * @author my
 */
public class UserRoleRefAction extends JqGridBaseAction<UserRoleRef>{
	
	private UserRoleRefService userRoleRefService;
	private Result result;
	private UserRoleRef userRoleRef;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = userRoleRefService.save(userRoleRef);
		return JSON;
	}
	
	public String view(){
		result = userRoleRefService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = userRoleRefService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		UserRoleRef dbBean = userRoleRefService.getBeanById(userRoleRef.getId()).getValue();
		BeanUtil.copyProperties(userRoleRef, dbBean);
		result = userRoleRefService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = userRoleRefService.deleteById(id);
		} else if(ids!=null){
			result = userRoleRefService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(UserRoleRef.class));
	}
	
	@Override
	protected List<UserRoleRef> getListByFilter(Filter fitler) {
		return userRoleRefService.getListByFilter(fitler).getValue();
	}
	
	
	public UserRoleRef getUserRoleRef() {
		return userRoleRef;
	}

	public void setUserRoleRef(UserRoleRef userRoleRef) {
		this.userRoleRef = userRoleRef;
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

	public void setUserRoleRefService(UserRoleRefService userRoleRefService) {
		this.userRoleRefService = userRoleRefService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
