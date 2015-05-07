package com.wiiy.oa.service;

import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.TaskLog;

/**
 * @author my
 */
public interface TaskLogService extends IService<TaskLog> {
	
	Result save(String memo,long id,Integer progress);
	Result save(String memo,long id);
	Result save(String memo,long id,Integer progress,Long userId);
	
}
