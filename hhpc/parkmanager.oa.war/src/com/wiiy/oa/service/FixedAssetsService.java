package com.wiiy.oa.service;

import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.FixedAssets;

public interface FixedAssetsService extends IService<FixedAssets>{	
	Result convert (Long id);
}
