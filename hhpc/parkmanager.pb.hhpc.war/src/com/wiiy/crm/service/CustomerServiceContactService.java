package com.wiiy.crm.service;

import com.wiiy.core.service.export.ContactBaseService;
import com.wiiy.crm.entity.CustomerServiceContact;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public interface CustomerServiceContactService extends ContactBaseService<CustomerServiceContact> {
	
	Result<?> send(Long id, Long receiveId);
	
	Result<?> approval(String approvalType, Long id,String opinion);

	Result<?> update(CustomerServiceContact dbBean, Long userId);
	
}
