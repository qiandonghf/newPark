package com.wiiy.oa.external.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.wiiy.core.external.service.SmsStatisticalService;
import com.wiiy.external.service.dto.SMSDto;
import com.wiiy.external.service.dto.SMSReceiverDto;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.dao.SmsDao;
import com.wiiy.oa.dao.SmsReceiverDao;
import com.wiiy.oa.entity.Sms;
import com.wiiy.oa.entity.SmsReceiver;

public class SmsStatisticalServiceImpl implements SmsStatisticalService {
	
	private SmsDao smsDao;
	private SmsReceiverDao smsReceiverDao;
	
	public void setSmsDao(SmsDao smsDao) {
		this.smsDao = smsDao;
	}

	public void setSmsReceiverDao(SmsReceiverDao smsReceiverDao) {
		this.smsReceiverDao = smsReceiverDao;
	}

	@Override
	public Result<List<SMSDto>> getListByFilter(Filter filter) {
		filter.setClass(Sms.class);
		List<Sms> smsList = smsDao.getListByFilter(filter);
		List<SMSDto> dtoList = new ArrayList<SMSDto>();
		if(smsList!=null && smsList.size()>0){
			Long[] smsIds = new Long[smsList.size()];
			int i = 0;
			for (Sms sms : smsList) {
				smsIds[i++] = sms.getId();
			}
			List<SmsReceiver> receiverList = smsReceiverDao.getListByFilter(new Filter(SmsReceiver.class).in("smsId", (Object[])smsIds));
			Map<Long,SMSDto> dtoMap = new HashMap<Long,SMSDto>();
			for (Sms sms : smsList) {
				dtoMap.put(sms.getId(), new SMSDto(sms.getCreator(),sms.getCreatorId(),sms.getContent(),sms.getTimeType(),sms.getSendTime()));
			}
			for (SmsReceiver smsReceiver : receiverList) {
				dtoMap.get(smsReceiver.getSmsId()).getReceiverList().add(new SMSReceiverDto(smsReceiver.getReceiverName(),smsReceiver.getPhone()));
			}
/*			String receivers = "";
			if(receiverList!=null && receiverList.size()>0){
				for (SmsReceiver smsReceiver : receiverList) {
					receivers += smsReceiver.getReceiverName()+","; 
				}
				if(receivers.length()>0){
					receivers = receivers.substring(0, receivers.length()-1);
				}
			}*/
			for (SMSDto smsDto : dtoMap.values()) {
				dtoList.add(smsDto);
			}
			
		}
		return Result.value(dtoList);
	}

}
