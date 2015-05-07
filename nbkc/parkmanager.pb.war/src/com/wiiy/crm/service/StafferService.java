package com.wiiy.crm.service;

import java.util.List;

import com.wiiy.commons.service.IService;
import com.wiiy.crm.entity.Staffer;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public interface StafferService extends IService<Staffer> {

	Result<?> importCard(String ids);

	List<Object> getListBySql(String sql);
}
