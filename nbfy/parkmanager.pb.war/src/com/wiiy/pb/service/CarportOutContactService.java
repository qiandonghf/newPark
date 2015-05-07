package com.wiiy.pb.service;

import com.wiiy.core.service.export.ContactBaseService;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.entity.CarportOutContact;

/**
 * @author my
 */
public interface CarportOutContactService extends ContactBaseService<CarportOutContact> {
	
	Result<?> send(Long id, Long receiveId, String approvalType);

	Result<?> approval(String approvalType, Long id,String opinion);

	Result<?> update(CarportOutContact dbBean, Long userId);
}
