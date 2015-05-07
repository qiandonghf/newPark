package com.wiiy.pb.service;

import com.wiiy.commons.service.IService;
import com.wiiy.pb.entity.SelfMeterLabel;

public interface SelfMeterLabelService extends IService<SelfMeterLabel>{

	void updateRecord(Long id, String oldIds, String newIds);

}
