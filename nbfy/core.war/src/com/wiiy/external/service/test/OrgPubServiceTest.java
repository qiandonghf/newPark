package com.wiiy.external.service.test;

import java.util.List;

import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.entity.Org;
import com.wiiy.core.external.service.OrgPubService;

public class OrgPubServiceTest {
	public void Test(){
		OrgPubService orgPubService = CoreActivator.getService(OrgPubService.class);
		List<Org> list = orgPubService.getOrgList();
		System.out.println("OrgList:"+list.size());
	}
}
