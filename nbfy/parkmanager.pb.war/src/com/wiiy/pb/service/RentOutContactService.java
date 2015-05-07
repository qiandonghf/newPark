package com.wiiy.pb.service;

import com.wiiy.core.service.export.ContactBaseService;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.entity.RentOutContact;

/**
 * @author my
 */
public interface RentOutContactService extends ContactBaseService<RentOutContact> {
	Result<?> send(Long id, Long receiveId, String approvalType);

	Result<?> approval(String approvalType, Long id,String opinion);

	Result<?> update(RentOutContact dbBean, Long userId);
}
