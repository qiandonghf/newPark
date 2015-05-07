package com.wiiy.crm.service;

import com.wiiy.core.service.export.ContactBaseService;
import com.wiiy.crm.entity.BusinessCenterContact;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public interface BusinessCenterContactService extends ContactBaseService<BusinessCenterContact> {
	
	Result<?> send(Long id, Long receiveId, String approvalType);

	Result<?> approval(String approvalType, Long id,String opinion);

	Result<?> update(BusinessCenterContact dbBean, Long userId);
}
