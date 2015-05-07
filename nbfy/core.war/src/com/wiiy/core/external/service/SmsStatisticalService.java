package com.wiiy.core.external.service;

import java.util.List;

import com.wiiy.external.service.dto.SMSDto;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

/**
 * 短信统计服务
 * @author my
 *
 */
public interface SmsStatisticalService {
	
	Result<List<SMSDto>> getListByFilter(Filter filter);
	
}
