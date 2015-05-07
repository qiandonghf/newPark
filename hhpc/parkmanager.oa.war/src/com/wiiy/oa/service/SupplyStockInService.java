package com.wiiy.oa.service;

import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.SupplyStockIn;

public interface SupplyStockInService extends IService<SupplyStockIn> {

	Result updateSupply(SupplyStockIn supplyStockIn, Double count);

}
