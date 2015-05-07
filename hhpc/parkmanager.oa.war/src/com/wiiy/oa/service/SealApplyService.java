package com.wiiy.oa.service;

import com.wiiy.commons.service.IService;
import com.wiiy.oa.entity.SealApply;

/**
 * @author my
 */
public interface SealApplyService extends IService<SealApply> {

	void sendMail(Long approverId, String ids, String email);
}
