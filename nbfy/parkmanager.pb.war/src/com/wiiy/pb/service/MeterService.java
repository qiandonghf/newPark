package com.wiiy.pb.service;

import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.entity.Meter;

public interface MeterService extends IService<Meter>{

	Result updateMeter(Meter dbean, Boolean change);

}
