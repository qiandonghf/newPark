package com.wiiy.core.entity;

import com.wiiy.commons.entity.BaseEntity;

public class RoleAuthorityRef extends BaseEntity {
	
	private static final long serialVersionUID = 4926945038552837352L;

	private Role role;
	
	private String moduleId;

	private String authorityId;
	
	private String authorityType;
	
	public RoleAuthorityRef() {}

	public RoleAuthorityRef(Long roleId, String moduleId, String authorityId, String authorityType) {
		this.role = new Role();
		this.role.setId(roleId);
		this.moduleId = moduleId;
		this.authorityId = authorityId;
		this.authorityType = authorityType;
	}

	public RoleAuthorityRef(String moduleId, String authorityId, String authorityType) {
		this.moduleId = moduleId;
		this.authorityId = authorityId;
		this.authorityType = authorityType;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public String getModuleId() {
		return moduleId;
	}

	public void setModuleId(String moduleId) {
		this.moduleId = moduleId;
	}

	public String getAuthorityId() {
		return authorityId;
	}

	public void setAuthorityId(String authorityId) {
		this.authorityId = authorityId;
	}

	public String getAuthorityType() {
		return authorityType;
	}

	public void setAuthorityType(String authorityType) {
		this.authorityType = authorityType;
	}

	@Override
	public Long getId() {
		return id;
	}
}
