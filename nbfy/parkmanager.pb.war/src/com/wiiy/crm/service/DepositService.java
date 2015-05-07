package com.wiiy.crm.service;

import com.wiiy.commons.service.IService;
import com.wiiy.crm.entity.Deposit;
import com.wiiy.crm.preferences.enums.BillPlanStatusEnum;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public interface DepositService extends IService<Deposit> {

	Result checkoutById(Long id, BillPlanStatusEnum billPlanStatus);

	Integer getRowCount(Filter le);

	Result batchCheckout(String ids, String[] split, boolean autoRemind);
}
