package com.wiiy.cms.service;

import com.wiiy.cms.entity.Links;
import com.wiiy.commons.service.IService;

public interface LinksService extends IService<Links>{
	void deleteByParamId(Long paramId);
}
