package com.wiiy.cms.service;

import com.wiiy.cms.entity.ContactInfo;
import com.wiiy.cms.entity.Param;
import com.wiiy.cms.entity.WaterMark;
import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;

public interface ParamService extends IService<Param>{
	
	Result<Param> saveOrUpdate(
			Param param,WaterMark waterMark,ContactInfo contactInfo);
}
