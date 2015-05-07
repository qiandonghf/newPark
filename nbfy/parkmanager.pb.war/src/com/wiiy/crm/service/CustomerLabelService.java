package com.wiiy.crm.service;

import java.util.List;

import com.wiiy.commons.service.IService;
import com.wiiy.crm.entity.CustomerLabel;

/**
 * @author my
 */
public interface CustomerLabelService extends IService<CustomerLabel> {
	
	List<CustomerLabel> getCustomerLabelsByCustomerId(Long id);
}
