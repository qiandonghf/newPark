package com.wiiy.crm.service;

import com.wiiy.commons.service.IService;
import com.wiiy.crm.entity.ContractReview;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public interface ContractReviewService extends IService<ContractReview> {

	Result approval(Long id, Long userId, String string);
}
