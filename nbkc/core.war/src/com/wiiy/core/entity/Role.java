package com.wiiy.core.entity;

import java.util.List;
import java.util.Set;
import java.io.Serializable;

import org.apache.struts2.json.annotations.JSON;

import com.wiiy.commons.entity.BaseEntity;

public class Role extends BaseEntity implements Serializable {
	
	private static final long serialVersionUID = -2402331963815885998L;

	private String name;
	
	private String memo;
	
	
	private Set<RoleAuthorityRef> authorityRefs;
	
	public Long getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	
	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

    @JSON(serialize=false)
	public Set<RoleAuthorityRef> getAuthorityRefs() {
		return authorityRefs;
	}

	public void setAuthorityRefs(Set<RoleAuthorityRef> authorityRefs) {
		this.authorityRefs = authorityRefs;
	}
	
}
