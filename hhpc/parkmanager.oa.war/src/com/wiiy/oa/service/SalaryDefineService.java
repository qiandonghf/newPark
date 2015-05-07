package com.wiiy.oa.service;

import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.SalaryDefine;

public interface SalaryDefineService extends IService<SalaryDefine>{
	Result<String> generateCode();
}
