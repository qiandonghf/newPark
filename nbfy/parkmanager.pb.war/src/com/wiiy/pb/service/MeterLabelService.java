package com.wiiy.pb.service;

import com.wiiy.commons.service.IService;
import com.wiiy.pb.entity.MeterLabel;

public interface MeterLabelService extends IService<MeterLabel>{

	void updateRecord(Long id, String oldIds, String newIds);

}
