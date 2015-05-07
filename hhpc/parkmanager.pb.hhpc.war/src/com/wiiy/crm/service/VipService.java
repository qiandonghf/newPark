package com.wiiy.crm.service;

import com.wiiy.commons.service.IService;
import com.wiiy.crm.entity.Vip;
import com.wiiy.hibernate.Result;

public interface VipService extends IService<Vip>{
	Result<?> importCard();

	Result saveAccount(Long id, String username, String password, Long orgId);

	Result updateAccountPassword(Long id, String password);
}
