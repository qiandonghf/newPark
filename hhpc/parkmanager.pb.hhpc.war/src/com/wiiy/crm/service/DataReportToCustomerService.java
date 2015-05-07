package com.wiiy.crm.service;

import java.util.List;

import com.wiiy.commons.service.IService;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.entity.DataReportToCustomer;
import com.wiiy.crm.preferences.enums.CustomerReportStatusEnum;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public interface DataReportToCustomerService extends IService<DataReportToCustomer> {

	Result<List<Customer>> getCustomerListByReportId(Long reportId);

	Result report(Long id, String propertyIds, String propertyValues);

	Result<Integer> countByFilter(Filter filter);

	Result report(Long id, CustomerReportStatusEnum status, String propertyIds,
			String propertyValues);

	Result reportProfit(Long id, CustomerReportStatusEnum status, String propertyIds,
			String propertyValues);
	
/*	Result reportDebt(Long id, CustomerReportStatusEnum status, String propertyIds,
			String propertyValues);*/

	Result reportPub(Long id);

	Result back(Long id, String suggestion);
}
