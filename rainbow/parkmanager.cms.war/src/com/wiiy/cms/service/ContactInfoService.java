package com.wiiy.cms.service;

import com.wiiy.cms.entity.ContactInfo;
import com.wiiy.commons.service.IService;

public interface ContactInfoService extends IService<ContactInfo>{
	void deleteByParamId(Long paramId);
}
