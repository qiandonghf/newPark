package com.wiiy.core.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.core.entity.RoleDesktop;
import com.wiiy.core.service.RoleDesktopService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

public class RoleDesktopAction extends JqGridBaseAction<RoleDesktop>{
	private RoleDesktopService roleDesktopService;
	private Result result;
	
	private Boolean isCheck;
	
	public String saveRoleDesktopConfig(){
		
		return JSON;
	}
	
	
	@Override
	protected List<RoleDesktop> getListByFilter(Filter filter) {
		return roleDesktopService.getListByFilter(filter).getValue();
	}
	public void setRoleDesktopService(RoleDesktopService roleDesktopService) {
		this.roleDesktopService = roleDesktopService;
	}
	public Result getResult() {
		return result;
	}
	public void setResult(Result result) {
		this.result = result;
	}	
	public Boolean getIsCheck() {
		return isCheck;
	}
	public void setIsCheck(Boolean isCheck) {
		this.isCheck = isCheck;
	}
	
}
