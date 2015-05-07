package com.wiiy.crm.service;

import com.wiiy.commons.service.IService;
import com.wiiy.crm.entity.BillPlanFacility;
import com.wiiy.crm.preferences.enums.BillPlanStatusEnum;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

public interface BillPlanFacilityService extends IService<BillPlanFacility>{

	Result checkoutById(Long id, BillPlanStatusEnum inchecked);

	Result batchCheckout(String ids, String[] split, boolean autoRemind);

	Integer getRowCount(Filter filter);

}
