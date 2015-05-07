package com.wiiy.crm.service;

import java.util.List;

import com.wiiy.commons.service.IService;
import com.wiiy.crm.entity.SubjectRent;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public interface SubjectRentService extends IService<SubjectRent> {

	Result<List> getListBySql(String string);
}
