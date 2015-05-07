package com.wiiy.core.external.service.impl;

import java.util.List;

import com.wiiy.core.dao.OrgDao;
import com.wiiy.core.entity.Org;
import com.wiiy.core.external.service.OrgPubService;

public class OrgPubServiceImpl implements OrgPubService{
	private OrgDao orgDao;
	
	@Override
	public List<Org> getOrgList() {
		return orgDao.getListByHql("from Org");
	}
	public void setOrgDao(OrgDao orgDao) {
		this.orgDao = orgDao;
	}
	@Override
	public Org getOrgById(Long id) {
		return orgDao.getBeanById(id);
	}

}
