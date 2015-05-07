package com.wiiy.core.entity;

import com.wiiy.commons.entity.BaseEntity;

public class UserRoleRef extends BaseEntity {

	private static final long serialVersionUID = -1519394229629892576L;

	private User user;
	
	private Role role;
	
	@Override
	public Long getId() {
		return id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}
}
