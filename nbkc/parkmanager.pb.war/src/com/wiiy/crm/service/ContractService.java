package com.wiiy.crm.service;

import java.io.File;
import java.io.OutputStream;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.wiiy.commons.service.IService;
import com.wiiy.crm.entity.Contract;
import com.wiiy.crm.entity.SubjectRent;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public interface ContractService extends IService<Contract> {

	Result<String> generateCode(String contractModel);

	Result save(Contract contract, List<SubjectRent> sessionSubjectRentList);

	Result submitApproval(Long id);

	Result submitSubtract(Long contractId, Long subjectRentId, Date executeTime,Double checkoutMoney,Boolean checkoutNow, String memo);

	Result submitSurrender(Long contractId, Date executeTime,List<Double> checkoutMoney,Boolean checkoutNow, String memo);

	/*Result approval(Long contractId);*/
	
	Result approval(Long contractId,Long approvalUserId);

	Result executeContract(Long contractId);
	
	Result closeContract(Long contractId);

	Result submitRelet(Contract contract);

	Result print(Long id, File template, OutputStream out);

	Result saveRentContract1(Contract contract,Map<String,String[]> roomRent,Map<String,String[]> billPlanRent,Map<String,String[]> deposit);

	Result saveNetContract1(Contract contract, String[] netIds, String[] prices, String[] ips,
			String[] ports, String[] ipPubs, String[] roomStartDates,
			String[] roomEndDates, String[] feeTypes, String[] planFees,String[] realFees,
			String[] playPayDates, String[] planStartDates,
			String[] planEndDates, String autocheck,String[] priceUnits,String[] planFacilityIds,String[] memos);

	Result print(Long id);

	Result<List<Contract>> getListByHql(String string);


}
