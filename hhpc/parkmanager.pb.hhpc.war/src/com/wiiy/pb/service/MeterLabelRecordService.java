package com.wiiy.pb.service;

import java.util.List;

import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.dto.FeeStatementsDto;
import com.wiiy.pb.entity.MeterLabelRecord;

public interface MeterLabelRecordService extends IService<MeterLabelRecord>{

	Result addMeter(Long labelId, List<String> existList, List<String> newList);

	Result<FeeStatementsDto> generateReport(Long labelId,boolean isSetFee);

	Result waterEleFee(long labelId,String ids); 
	Result printFee(long labelId);
}
