package com.wiiy.cms.service;

import com.wiiy.commons.service.IService;
import com.wiiy.cms.entity.Resource;

/**
 * @author my
 */
public interface ResourceService extends IService<Resource> {
	void deleteByParamId(Long paramId);
}
