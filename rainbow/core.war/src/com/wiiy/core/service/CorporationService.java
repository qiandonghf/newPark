package com.wiiy.core.service;

import com.wiiy.commons.service.IService;
import com.wiiy.core.entity.Corporation;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public interface CorporationService extends IService<Corporation> {
	Result<String> generateCode();
}
