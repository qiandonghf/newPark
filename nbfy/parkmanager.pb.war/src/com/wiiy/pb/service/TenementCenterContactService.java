package com.wiiy.pb.service;

import com.wiiy.core.service.export.ContactBaseService;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.entity.TenementCenterContact;

/**
 * @author my
 */
public interface TenementCenterContactService extends ContactBaseService<TenementCenterContact> {
	
	Result<?> send(Long id, Long receiveId, String approvalType);

	Result<?> approval(String approvalType, Long id,String opinion);

	Result<?> update(TenementCenterContact dbBean, Long userId);
}
