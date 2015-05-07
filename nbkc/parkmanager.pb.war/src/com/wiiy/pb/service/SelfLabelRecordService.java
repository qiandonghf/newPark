package com.wiiy.pb.service;

import java.util.List;

import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.entity.SelfLabelRecord;

public interface SelfLabelRecordService extends IService<SelfLabelRecord>{
	Result addMeter(Long labelId, List<String> existList, List<String> newList);
}
