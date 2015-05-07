package com.wiiy.crm.service;

import com.wiiy.commons.service.IService;
import com.wiiy.crm.entity.ContractTemplate;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public interface ContractTemplateService extends IService<ContractTemplate> {

	Result chief(Long id);
}
