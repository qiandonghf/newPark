package com.wiiy.crm.service;

import java.util.Date;
import java.util.List;

import org.hibernate.Session;

import com.wiiy.commons.service.IService;
import com.wiiy.crm.entity.Bill;
import com.wiiy.crm.preferences.enums.BillInOutEnum;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public interface BillService extends IService<Bill> {
	
	List getObjectListBySql(String sql);
	
	Integer getRowCount(Filter filter);

	Result apart(Long id, double amount);

	Result pay(String ids, Date payTime);

	Result chargeoff(Long id);

	Result back(Long id);
	
	String generateNumber(Session session);
	
	String generateNumber();

	Result inInform(String urged, String email, String sms);

	Result outInform(String email, String sms);

	Result arrearAlertStatistics();

	Result measureStatistics();
	
	Result getProjectionResult(Filter filter);
	Long getCustomerCountInBill(BillInOutEnum inOrOut);

	Result<List<Bill>> getListByHql(String string);
}
