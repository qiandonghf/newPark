package com.wiiy.crm.service;

import java.util.List;

import com.wiiy.commons.service.IService;
import com.wiiy.crm.entity.ContractAgreement;
import com.wiiy.crm.entity.ContractAgreementAtt;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public interface ContractAgreementService extends IService<ContractAgreement> {
	Result<ContractAgreement> save(ContractAgreement t,List<ContractAgreementAtt> sessionContractAgreementAttList);
}
