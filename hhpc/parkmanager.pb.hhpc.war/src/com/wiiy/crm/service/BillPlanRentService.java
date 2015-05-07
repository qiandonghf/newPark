package com.wiiy.crm.service;

import java.util.Date;
import java.util.List;

import org.hibernate.Session;

import com.wiiy.commons.service.IService;
import com.wiiy.crm.entity.BillPlanRent;
import com.wiiy.crm.preferences.enums.BillPlanStatusEnum;
import com.wiiy.crm.preferences.enums.BillingMethodEnum;
import com.wiiy.crm.preferences.enums.PriceUnitEnum;
import com.wiiy.crm.preferences.enums.RentBillPlanEnum;
import com.wiiy.crm.preferences.enums.RentBillPlanFeeEnum;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public interface BillPlanRentService extends IService<BillPlanRent> {

	Result<List<BillPlanRent>> autoGenerate(RentBillPlanFeeEnum feeType,
			RentBillPlanEnum rentBillPlan, BillingMethodEnum billingMethod,
			Date startDate, Date endDate, Double roomArea, Double price,
			PriceUnitEnum priceUnit);

	Result save(List<BillPlanRent> billPlanRentList);

	Result checkout(List<BillPlanRent> list);

	Result checkoutById(Long id, BillPlanStatusEnum billPlanStatus);
	
	Result checkoutById(Long id, BillPlanStatusEnum billPlanStatus,Session session);

	Result batchCheckout(String ids, String[] types, boolean autoRemind);

	Integer getRowCount(Filter filter);

	Result<List<BillPlanRent>> getListHql(String string);
}
