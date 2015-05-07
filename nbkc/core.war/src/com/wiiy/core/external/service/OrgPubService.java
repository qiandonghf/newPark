package com.wiiy.core.external.service;

import java.util.List;

import com.wiiy.core.entity.Org;

public interface OrgPubService {
	public List<Org> getOrgList();
	
	public Org getOrgById(Long id);
}
