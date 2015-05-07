package com.wiiy.core.dto;

import com.wiiy.core.entity.AuthorityType;

public class AuthorityDto {
	
	private String authorityId;
	
	private AuthorityType authorityType;

	public String getAuthorityId() {
		return authorityId;
	}

	public void setAuthorityId(String authorityId) {
		this.authorityId = authorityId;
	}

	public AuthorityType getAuthorityType() {
		return authorityType;
	}

	public void setAuthorityType(AuthorityType authorityType) {
		this.authorityType = authorityType;
	}
	
}
