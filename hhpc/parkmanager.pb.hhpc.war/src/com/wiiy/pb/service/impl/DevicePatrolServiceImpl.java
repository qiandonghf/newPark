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
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.pb.dao.DevicePatrolDao;
import com.wiiy.pb.entity.DevicePatrol;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.service.DevicePatrolService;

/**
 * @author my
 */
public class DevicePatrolServiceImpl implements DevicePatrolService{
	
	private DevicePatrolDao devicePatrolDao;
	
	public void setDevicePatrolDao(DevicePatrolDao devicePatrolDao) {
		this.devicePatrolDao = devicePatrolDao;
	}

	@Override
	public Result<DevicePatrol> save(DevicePatrol t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = devicePatrolDao.openSession();
			tr = session.beginTransaction();
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			devicePatrolDao.save(t);
			
			String sql = "SELECT operation_Date FROM pb_device_patrol " +
					"WHERE device_id=" +t.getDeviceId()+
					" ORDER BY operation_Date DESC";
			@SuppressWarnings("unchecked")
			List<Date> list = session.createSQLQuery(sql).list();
			if (list != null && list.size() > 0) {
				Date dt = list.get(0);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				sql = "UPDATE pb_device_management SET last_patrol_time= '"+sdf.format(dt)+"' WHERE id = "+t.getDeviceId();
				session.createSQLQuery(sql).executeUpdate();
			}
			tr.commit();
			return Result.success(R.DevicePatrol.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),DevicePatrol.class)));
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.DevicePatrol.SAVE_FAILURE);
		}
	}

	@Override
	public Result<DevicePatrol> delete(DevicePatrol t) {
		try {
			devicePatrolDao.delete(t);
			return Result.success(R.DevicePatrol.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DevicePatrol.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DevicePatrol> deleteById(Serializable id) {
		Session session = null;
		Transaction tr = null;
		try {
			session = devicePatrolDao.openSession();
			tr = session.beginTransaction();
			DevicePatrol patrol = devicePatrolDao.getBeanById(id);
			devicePatrolDao.deleteById(id);
			
			String sql = "SELECT operation_Date FROM pb_device_patrol " +
					"WHERE device_id=" +patrol.getDeviceId()+
					" ORDER BY operation_Date DESC";
			@SuppressWarnings("unchecked")
			List<Date> list = session.createSQLQuery(sql).list();
			if (list != null && list.size() > 0) {
				Date dt = list.get(0);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				sql = "UPDATE pb_device_management SET last_patrol_time= '"+sdf.format(dt)+"' WHERE id = "+patrol.getDeviceId();
				session.createSQLQuery(sql).executeUpdate();
			}
			tr.commit();
			return Result.success(R.DevicePatrol.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.DevicePatrol.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DevicePatrol> deleteByIds(String ids) {
		Session session = null;
		Transaction tr = null;
		try {
			session = devicePatrolDao.openSession();
			tr = session.beginTransaction();
			long id = Long.parseLong(ids.substring(0, ids.indexOf(",")));
			DevicePatrol patrol = devicePatrolDao.getBeanById(id);
			devicePatrolDao.deleteByIds(ids);
			
			String sql = "SELECT operation_Date FROM pb_device_patrol " +
					"WHERE device_id=" +patrol.getDeviceId()+
					" ORDER BY operation_Date DESC";
			@SuppressWarnings("unchecked")
			List<Date> list = session.createSQLQuery(sql).list();
			if (list != null && list.size() > 0) {
				Date dt = list.get(0);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				sql = "UPDATE pb_device_management SET last_patrol_time= '"+sdf.format(dt)+"' WHERE id = "+patrol.getDeviceId();
				session.createSQLQuery(sql).executeUpdate();
			}
			tr.commit();
			return Result.success(R.DevicePatrol.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.DevicePatrol.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DevicePatrol> update(DevicePatrol t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = devicePatrolDao.openSession();
			tr = session.beginTransaction();
			
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			devicePatrolDao.update(t);
			
			String sql = "SELECT operation_Date FROM pb_device_patrol " +
					"WHERE device_id=" +t.getDeviceId()+
					" ORDER BY operation_Date DESC";
			@SuppressWarnings("unchecked")
			List<Date> list = session.createSQLQuery(sql).list();
			if (list != null && list.size() > 0) {
				Date dt = list.get(0);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				sql = "UPDATE pb_device_management SET last_patrol_time= '"+sdf.format(dt)+"' WHERE id = "+t.getDeviceId();
				session.createSQLQuery(sql).executeUpdate();
			}
			tr.commit();
			return Result.success(R.DevicePatrol.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),DevicePatrol.class)));
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.DevicePatrol.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<DevicePatrol> getBeanById(Serializable id) {
		try {
			return Result.value(devicePatrolDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.DevicePatrol.LOAD_FAILURE);
		}
	}

	@Override
	public Result<DevicePatrol> getBeanByFilter(Filter filter) {
		try {
			return Result.value(devicePatrolDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DevicePatrol.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<DevicePatrol>> getList() {
		try {
			return Result.value(devicePatrolDao.getList());
		} catch (Exception e) {
			return Result.failure(R.DevicePatrol.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<DevicePatrol>> getListByFilter(Filter filter) {
		try {
			return Result.value(devicePatrolDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DevicePatrol.LOAD_FAILURE);
		}
	}

}
