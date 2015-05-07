package com.wiiy.core.action;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ModelDriven;
import com.wiiy.commons.action.BaseAction;
import com.wiiy.core.entity.User;
import com.wiiy.core.service.UserService;
import com.wiiy.hibernate.Result;

public class SelfAction extends BaseAction implements ModelDriven<User> {
	
	private UserService userService;

	private User user;
	
	private String oldPassword;
	
	private String newPassword;
	
	private Result<?> result;
	
	public User getUser() {
		return user;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	public Result<?> getResult() {
		return result;
	}

	public String execute() {
		user = userService.getBeanById(getCurrentUser().getId()).getValue();
		return EDIT;
	}

	public String update() {
//		user = getCurrentUser();
		result = userService.update(user);
		return JSON;
	}
	
	public String passwordReset() {
		user = getCurrentUser();
		return "password";
	}
	
	public String passwordResetDone() {
		user = getCurrentUser();
		result = userService.updatePassword(user, oldPassword, newPassword);
		return JSON;
	}
	
	public User getCurrentUser() {
		return (User) ServletActionContext.getRequest().getSession().getAttribute("login_user");
	}

	@Override
	public User getModel() {
		String userId = ServletActionContext.getRequest().getParameter("user.id");
		if (userId != null) {
			user = userService.getBeanById(Long.valueOf(userId)).getValue();
			return user;
		}
		return null;
	}
}
