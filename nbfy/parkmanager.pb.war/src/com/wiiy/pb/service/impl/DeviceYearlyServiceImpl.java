package com.wiiy.pb.service.impl;


import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.entity.DeviceYearly;
import com.wiiy.pb.dao.DeviceYearlyDao;
import com.wiiy.pb.service.DeviceYearlyService;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class DeviceYearlyServiceImpl implements DeviceYearlyService{
	
	private DeviceYearlyDao deviceYearlyDao;
	
	public void setDeviceYearlyDao(DeviceYearlyDao deviceYearlyDao) {
		this.deviceYearlyDao = deviceYearlyDao;
	}

	@Override
	public Result<DeviceYearly> save(DeviceYearly t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = deviceYearlyDao.openSession();
			tr = session.beginTransaction();
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			deviceYearlyDao.save(t);
			
			String sql = "SELECT operation_Date FROM pb_device_yearly " +
					"WHERE device_id=" +t.getDeviceId()+
					" ORDER BY operation_Date DESC";
			@SuppressWarnings("unchecked")
			List<Date> list = session.createSQLQuery(sql).list();
			if (list != null && list.size() > 0) {
				Date dt = list.get(0);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				sql = "UPDATE pb_device_management SET last_yearly_time= '"+sdf.format(dt)+"' WHERE id = "+t.getDeviceId();
				session.createSQLQuery(sql).executeUpdate();
			}
			tr.commit();
			return Result.success(R.DeviceYearly.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),DeviceYearly.class)));
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.DeviceYearly.SAVE_FAILURE);
		}
	}

	@Override
	public Result<DeviceYearly> delete(DeviceYearly t) {
		try {
			deviceYearlyDao.delete(t);
			return Result.success(R.DeviceYearly.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.DeviceYearly.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DeviceYearly> deleteById(Serializable id) {
		Session session = null;
		Transaction tr = null;
		try {
			session = deviceYearlyDao.openSession();
			tr = session.beginTransaction();
			DeviceYearly t = deviceYearlyDao.getBeanById(id);
			deviceYearlyDao.deleteById(id);
			
			String sql = "SELECT operation_Date FROM pb_device_yearly " +
					"WHERE device_id=" +t.getDeviceId()+
					" ORDER BY operation_Date DESC";
			@SuppressWarnings("unchecked")
			List<Date> list = session.createSQLQuery(sql).list();
			if (list != null && list.size() > 0) {
				Date dt = list.get(0);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				sql = "UPDATE pb_device_management SET last_yearly_time= '"+sdf.format(dt)+"' WHERE id = "+t.getDeviceId();
				session.createSQLQuery(sql).executeUpdate();
			}
			tr.commit();
			return Result.success(R.DeviceYearly.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.DeviceYearly.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DeviceYearly> deleteByIds(String ids) {
		Session session = null;
		Transaction tr = null;
		try {
			session = deviceYearlyDao.openSession();
			tr = session.beginTransaction();
			long id = Long.parseLong(ids.substring(0, ids.indexOf(",")));
			DeviceYearly t = deviceYearlyDao.getBeanById(id);
			deviceYearlyDao.deleteByIds(ids);
			
			String sql = "SELECT operation_Date FROM pb_device_yearly " +
					"WHERE device_id=" +t.getDeviceId()+
					" ORDER BY operation_Date DESC";
			@SuppressWarnings("unchecked")
			List<Date> list = session.createSQLQuery(sql).list();
			if (list != null && list.size() > 0) {
				Date dt = list.get(0);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				sql = "UPDATE pb_device_management SET last_yearly_time= '"+sdf.format(dt)+"' WHERE id = "+t.getDeviceId();
				session.createSQLQuery(sql).executeUpdate();
			}
			tr.commit();
			return Result.success(R.DeviceYearly.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.DeviceYearly.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DeviceYearly> update(DeviceYearly t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = deviceYearlyDao.openSession();
			tr = session.beginTransaction();
			
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			deviceYearlyDao.update(t);
			
			String sql = "SELECT operation_Date FROM pb_device_yearly " +
					"WHERE device_id=" +t.getDeviceId()+
					" ORDER BY operation_Date DESC";
			@SuppressWarnings("unchecked")
			List<Date> list = session.createSQLQuery(sql).list();
			if (list != null && list.size() > 0) {
				Date dt = list.get(0);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				sql = "UPDATE pb_device_management SET last_yearly_time= '"+sdf.format(dt)+"' WHERE id = "+t.getDeviceId();
				session.createSQLQuery(sql).executeUpdate();
			}
			tr.commit();
			return Result.success(R.DeviceYearly.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),DeviceYearly.class)));
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.DeviceYearly.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<DeviceYearly> getBeanById(Serializable id) {
		try {
			return Result.value(deviceYearlyDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.DeviceYearly.LOAD_FAILURE);
		}
	}

	@Override
	public Result<DeviceYearly> getBeanByFilter(Filter filter) {
		try {
			return Result.value(deviceYearlyDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DeviceYearly.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<DeviceYearly>> getList() {
		try {
			return Result.value(deviceYearlyDao.getList());
		} catch (Exception e) {
			return Result.failure(R.DeviceYearly.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<DeviceYearly>> getListByFilter(Filter filter) {
		try {
			return Result.value(deviceYearlyDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DeviceYearly.LOAD_FAILURE);
		}
	}

}
