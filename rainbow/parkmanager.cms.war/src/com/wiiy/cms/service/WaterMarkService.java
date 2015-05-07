package com.wiiy.cms.service;

import java.io.FileInputStream;

import com.wiiy.cms.entity.WaterMark;
import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;

public interface WaterMarkService extends IService<WaterMark>{
   
Result<WaterMark> save(WaterMark t , FileInputStream fin) ;
Result<WaterMark> update(WaterMark t , FileInputStream fin) ;
void deleteByParamId(Long paramId);
}
