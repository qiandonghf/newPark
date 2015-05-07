package com.wiiy.pb.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.exception.ConstraintViolationException;

import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.entity.Investment;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.pb.dao.DeviceManagementDao;
import com.wiiy.pb.entity.DeviceManagement;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.service.DeviceManagementService;

/**
 * @author my
 */
public class DeviceManagementServiceImpl implements DeviceManagementService{
	
	private DeviceManagementDao deviceManagementDao;
	
	public void setDeviceManagementDao(DeviceManagementDao deviceManagementDao) {
		this.deviceManagementDao = deviceManagementDao;
	}

	@Override
	public Result<DeviceManagement> save(DeviceManagement t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			deviceManagementDao.save(t);
			return Result.success(R.DeviceManagement.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),DeviceManagement.class)));
		} catch (Exception e) {
			return Result.failure(R.DeviceManagement.SAVE_FAILURE);
		}
	}

	@Override
	public Result<DeviceManagement> delete(DeviceManagement t) {
		try {
			deviceManagementDao.delete(t);
			return Result.success(R.DeviceManagement.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DeviceManagement.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DeviceManagement> deleteById(Serializable id) {
		try {
			deviceManagementDao.deleteById(id);
			return Result.success(R.DeviceManagement.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DeviceManagement.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DeviceManagement> deleteByIds(String ids) {
		try {
			deviceManagementDao.deleteByIds(ids);
			return Result.success(R.DeviceManagement.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DeviceManagement.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DeviceManagement> update(DeviceManagement t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			deviceManagementDao.update(t);
			return Result.success(R.DeviceManagement.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),DeviceManagement.class)));
		} catch (Exception e) {
			return Result.failure(R.DeviceManagement.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<DeviceManagement> getBeanById(Serializable id) {
		try {
			return Result.value(deviceManagementDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.DeviceManagement.LOAD_FAILURE);
		}
	}

	@Override
	public Result<DeviceManagement> getBeanByFilter(Filter filter) {
		try {
			return Result.value(deviceManagementDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DeviceManagement.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<DeviceManagement>> getList() {
		try {
			return Result.value(deviceManagementDao.getList());
		} catch (Exception e) {
			return Result.failure(R.DeviceManagement.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<DeviceManagement>> getListByFilter(Filter filter) {
		try {
			return Result.value(deviceManagementDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DeviceManagement.LOAD_FAILURE);
		}
	}

	@Override
	public Result<DeviceManagement> saveOrUpdate(DeviceManagement deviceManagement) {
		Session session = null;
		Transaction tr = null;
		try {
			session = deviceManagementDao.openSession();
			tr = session.beginTransaction();
			setCreator(deviceManagement);
			setModifier(deviceManagement);
			session.saveOrUpdate(deviceManagement);
			tr.commit();
			return Result.success(R.DeviceManagement.SAVE_SUCCESS, deviceManagement);
		}catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),DeviceManagement.class)));
		} catch (ConstraintViolationException e){
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(new UKConstraintException(e).getUK(),Investment.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.DeviceManagement.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}
	
	private void setCreator(BaseEntity entity){
		entity.setCreateTime(new Date());
		entity.setCreatorId(PbActivator.getSessionUser().getId());
		entity.setCreator(PbActivator.getSessionUser().getRealName());
		entity.setEntityStatus(EntityStatus.NORMAL);
	}
	
	private void setModifier(BaseEntity entity){
		entity.setModifyTime(entity.getCreateTime());
		entity.setModifier(entity.getCreator());
		entity.setModifierId(entity.getCreatorId());
	}

	@Override
	public Date getById(long id,String className) {
		Session session = deviceManagementDao.openSession();
		String sql = "SELECT operation_Date FROM pb_device_"+className+" WHERE device_id="+id+" ORDER BY operation_Date DESC";
		@SuppressWarnings("unchecked")
		List<Date> list= session.createSQLQuery(sql).list();
		session.close();
		if (list != null && list.size() > 0) {
			return list.get(0);
		}
		return null;
	}


}
