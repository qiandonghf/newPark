package com.wiiy.crm.service;

import com.wiiy.commons.service.IService;
import com.wiiy.crm.entity.Contract;
import com.wiiy.crm.entity.ContractExpireApproval;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public interface ContractExpireApprovalService extends IService<ContractExpireApproval> {

	Result approval(Long id, Long userId, String string);

	String setBusinessmanSuggestion(Contract contract);
}
