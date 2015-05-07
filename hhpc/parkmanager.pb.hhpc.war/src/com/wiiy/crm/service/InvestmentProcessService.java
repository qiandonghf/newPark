package com.wiiy.crm.service;


import java.io.OutputStream;

import com.wiiy.commons.service.IService;
import com.wiiy.crm.entity.InvestmentProcess;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public interface InvestmentProcessService extends IService<InvestmentProcess> {

	Result approval(Long id, Long userId, String string);

	Result<InvestmentProcess> print(Long id,OutputStream out);
}
