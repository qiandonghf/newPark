package com.wiiy.crm.service;

import java.util.List;

import com.wiiy.commons.service.IService;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.entity.CustomerInfo;
import com.wiiy.crm.entity.IncubationInfo;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public interface CustomerService extends IService<Customer> {
	/**
	 * 保存企业
	 * @param customer 基本信息
	 * @param customerInfo 详细信息
	 * @param incubationInfo 孵化信息
	 * @param ids 标签
	 * @return
	 */
	Result<Customer> save(Customer customer,CustomerInfo customerInfo,IncubationInfo incubationInfo,String ids,String[] incubationRouteIds,String[] incubationRouteTimes,String[] customerQualificationIds,String[] custimerQualificationTimes,String[] enterpriseTypeIds);
	/**
	 * 更新企业
	 * @param customer 基本信息
	 * @param customerInfo 详细信息
	 * @param incubationInfo 孵化信息
	 * @param ids 标签
	 * @return
	 */
	Result<Customer> update(Customer customer,CustomerInfo customerInfo,IncubationInfo incubationInfo,String labelIds,String[] incubationRouteIds,String[] incubationRouteTimes,String[] customerQualificationIds,String[] custimerQualificationTimes,String[] enterpriseTypeIds);
	/**
	 * 企业标签ids
	 * @param id
	 * @return
	 */
	String getCustomerLabelIdsByCustomerId(Long id);
	/**
	 * 生成企业编号
	 * @return
	 */
	Result<String> generateCode();
	
	Result saveAccount(Long id, String username, String password);
	
	Result updateAccountPassword(Long id, String password);
	
	Result<Customer> getSessionUserCustomer();
	
	Result<?> importCard(String ids);
	
	List getObjectListBySql(String sql);
	
	void createCustomerAccount();
	Result getListByLimitNum(int i);
	
	Result<List<Customer>> getListByHql(String string);
	
	Result<Customer> getBeanByHql(String string);
}
