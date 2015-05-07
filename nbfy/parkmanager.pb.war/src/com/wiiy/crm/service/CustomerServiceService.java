package com.wiiy.crm.service;

import java.io.OutputStream;

import com.wiiy.commons.service.IService;
import com.wiiy.crm.entity.CustomerService;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public interface CustomerServiceService extends IService<CustomerService> {

	Result<CustomerService> print(Long id, OutputStream out);

	int countYetCustomer();


}
