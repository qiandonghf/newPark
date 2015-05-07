package com.wiiy.pb.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.entity.DeviceMaintenance;
import com.wiiy.pb.dao.DeviceMaintenanceDao;
import com.wiiy.pb.service.DeviceMaintenanceService;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class DeviceMaintenanceServiceImpl implements DeviceMaintenanceService{
	
	private DeviceMaintenanceDao deviceMaintenanceDao;
	
	public void setDeviceMaintenanceDao(DeviceMaintenanceDao deviceMaintenanceDao) {
		this.deviceMaintenanceDao = deviceMaintenanceDao;
	}

	@Override
	public Result<DeviceMaintenance> save(DeviceMaintenance t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			deviceMaintenanceDao.save(t);
			return Result.success(R.DeviceMaintenance.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),DeviceMaintenance.class)));
		} catch (Exception e) {
			return Result.failure(R.DeviceMaintenance.SAVE_FAILURE);
		}
	}

	@Override
	public Result<DeviceMaintenance> delete(DeviceMaintenance t) {
		try {
			deviceMaintenanceDao.delete(t);
			return Result.success(R.DeviceMaintenance.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DeviceMaintenance.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DeviceMaintenance> deleteById(Serializable id) {
		try {
			deviceMaintenanceDao.deleteById(id);
			return Result.success(R.DeviceMaintenance.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DeviceMaintenance.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DeviceMaintenance> deleteByIds(String ids) {
		try {
			deviceMaintenanceDao.deleteByIds(ids);
			return Result.success(R.DeviceMaintenance.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DeviceMaintenance.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DeviceMaintenance> update(DeviceMaintenance t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			deviceMaintenanceDao.update(t);
			return Result.success(R.DeviceMaintenance.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),DeviceMaintenance.class)));
		} catch (Exception e) {
			return Result.failure(R.DeviceMaintenance.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<DeviceMaintenance> getBeanById(Serializable id) {
		try {
			return Result.value(deviceMaintenanceDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.DeviceMaintenance.LOAD_FAILURE);
		}
	}

	@Override
	public Result<DeviceMaintenance> getBeanByFilter(Filter filter) {
		try {
			return Result.value(deviceMaintenanceDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DeviceMaintenance.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<DeviceMaintenance>> getList() {
		try {
			return Result.value(deviceMaintenanceDao.getList());
		} catch (Exception e) {
			return Result.failure(R.DeviceMaintenance.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<DeviceMaintenance>> getListByFilter(Filter filter) {
		try {
			return Result.value(deviceMaintenanceDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DeviceMaintenance.LOAD_FAILURE);
		}
	}

}
