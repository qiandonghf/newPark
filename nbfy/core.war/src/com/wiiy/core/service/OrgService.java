package com.wiiy.core.service;

import java.util.List;

import com.wiiy.commons.service.IService;
import com.wiiy.core.entity.Org;
import com.wiiy.hibernate.Result;

public interface OrgService extends IService<Org>{

	Result<List<Org>> getOrgTree();

	Result<Org> saveOrUpdateOrg(Org org);

}
