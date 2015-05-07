package com.wiiy.crm.service;

import com.wiiy.commons.service.IService;
import com.wiiy.crm.entity.Staffer;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public interface StafferService extends IService<Staffer> {

	Result<?> importCard(String ids);
}
