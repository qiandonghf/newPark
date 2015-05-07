package com.wiiy.oa.service;

import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.Sms;

/**
 * @author my
 */
public interface SmsService extends IService<Sms> {
	
	Result updateSmsToSended(Sms t);

	Result save(Sms sms, String receiverName);
}
