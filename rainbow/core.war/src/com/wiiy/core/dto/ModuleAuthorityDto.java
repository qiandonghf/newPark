package com.wiiy.core.dto;

public class ModuleAuthorityDto {
	
	private Long moduleId;
	
	private AuthorityDto[] authorityRefs;

	public Long getModuleId() {
		return moduleId;
	}

	public void setModuleId(Long moduleId) {
		this.moduleId = moduleId;
	}

	public AuthorityDto[] getAuthorityRefs() {
		return authorityRefs;
	}

	public void setAuthorityRefs(AuthorityDto[] authorityRefs) {
		this.authorityRefs = authorityRefs;
	}
	
	
}
