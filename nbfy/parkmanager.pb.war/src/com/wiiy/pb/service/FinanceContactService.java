package com.wiiy.pb.service;

import com.wiiy.core.service.export.ContactBaseService;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.entity.FinanceContact;

/**
 * @author my
 */
public interface FinanceContactService extends ContactBaseService<FinanceContact> {

	Result<?> send(Long id, Long receiveId, String approvalType);

	Result<?> approval(String approvalType, Long id,String opinion);

	Result<?> update(FinanceContact dbBean, Long userId);
}
