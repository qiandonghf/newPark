package com.wiiy.pb.service;

import java.util.Date;

import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.entity.DeviceManagement;

/**
 * @author my
 */
public interface DeviceManagementService extends IService<DeviceManagement> {
	
	/**
	 * 保存DeviceManagement实体的同时保存关联的实体
	 * @param deviceManagement
	 * @param deviceMaintenance
	 * @param devicePatrol
	 * @param deviceYearly
	 * @param deviceWorkOrder
	 * @return
	 */
	Result<DeviceManagement> saveOrUpdate(DeviceManagement deviceManagement);
	
	
	Date getById(long id,String className);
}
