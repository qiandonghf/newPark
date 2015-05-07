package com.wiiy.oa.service;

import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.WorkReportConfig;

public interface WorkReportConfigService extends IService<WorkReportConfig>{
	Result  configReporter(String ids);
}
