package com.wiiy.crm.service;

import com.wiiy.commons.service.IService;
import com.wiiy.crm.entity.Contect;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public interface ContectService extends IService<Contect> {

	Result<?> importCard(String ids);
}
