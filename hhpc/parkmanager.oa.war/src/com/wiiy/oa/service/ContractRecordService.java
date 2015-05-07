package com.wiiy.oa.service;

import java.util.List;

import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.ContractRecord;
import com.wiiy.oa.entity.ContractRecordAtt;

/**
 * @author my
 */
public interface ContractRecordService extends IService<ContractRecord> {
	Result<ContractRecord> save(ContractRecord p,List<ContractRecordAtt> sessionContractRecordAttList);
}
