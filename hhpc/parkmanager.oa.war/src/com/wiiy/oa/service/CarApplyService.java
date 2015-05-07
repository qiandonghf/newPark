package com.wiiy.oa.service;

import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.CarApply;

public interface CarApplyService extends IService<CarApply>{

	Result<CarApply> approve(Long id, Long approverId, String approverl);

	Result<CarApply> approveCarApply(Long id, String applyCheck);

}
