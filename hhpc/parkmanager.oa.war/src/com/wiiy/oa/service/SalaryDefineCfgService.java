package com.wiiy.oa.service;

import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.SalaryDefineCfg;

public interface SalaryDefineCfgService extends IService<SalaryDefineCfg>{
	Result save2(String ids,Long salaryDefineId);
}
