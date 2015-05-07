package com.wiiy.crm.service;

import com.wiiy.crm.entity.InvestmentContact;
import com.wiiy.core.service.export.ContactBaseService;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public interface InvestmentContactService extends ContactBaseService<InvestmentContact> {

	Result<?> send(Long id, Long receiveId, String approvalType);

	Result<?> approval(String approvalType, Long id,String opinion);

	Result<?> update(InvestmentContact dbBean, Long userId);
}
