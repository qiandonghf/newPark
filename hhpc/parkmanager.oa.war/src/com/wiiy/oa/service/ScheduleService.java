package com.wiiy.oa.service;

import java.util.List;

import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.Schedule;

public interface ScheduleService extends IService<Schedule>{

	Result save(List<Schedule> insertList);

}
