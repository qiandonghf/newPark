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
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.pb.dao.RoomChangeLogDao;
import com.wiiy.pb.entity.RoomChangeLog;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.service.RoomChangeLogService;

/**
 * @author my
 */
public class RoomChangeLogServiceImpl implements RoomChangeLogService{
	
	private RoomChangeLogDao roomChangeLogDao;
	
	public void setRoomChangeLogDao(RoomChangeLogDao roomChangeLogDao) {
		this.roomChangeLogDao = roomChangeLogDao;
	}

	@Override
	public Result<RoomChangeLog> save(RoomChangeLog t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			roomChangeLogDao.save(t);
			return Result.success(R.RoomChangeLog.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),RoomChangeLog.class)));
		} catch (Exception e) {
			return Result.failure(R.RoomChangeLog.SAVE_FAILURE);
		}
	}

	@Override
	public Result<RoomChangeLog> delete(RoomChangeLog t) {
		try {
			roomChangeLogDao.delete(t);
			return Result.success(R.RoomChangeLog.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.RoomChangeLog.DELETE_FAILURE);
		}
	}

	@Override
	public Result<RoomChangeLog> deleteById(Serializable id) {
		try {
			roomChangeLogDao.deleteById(id);
			return Result.success(R.RoomChangeLog.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.RoomChangeLog.DELETE_FAILURE);
		}
	}

	@Override
	public Result<RoomChangeLog> deleteByIds(String ids) {
		try {
			roomChangeLogDao.deleteByIds(ids);
			return Result.success(R.RoomChangeLog.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.RoomChangeLog.DELETE_FAILURE);
		}
	}

	@Override
	public Result<RoomChangeLog> update(RoomChangeLog t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			roomChangeLogDao.update(t);
			return Result.success(R.RoomChangeLog.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),RoomChangeLog.class)));
		} catch (Exception e) {
			return Result.failure(R.RoomChangeLog.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<RoomChangeLog> getBeanById(Serializable id) {
		try {
			return Result.value(roomChangeLogDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.RoomChangeLog.LOAD_FAILURE);
		}
	}

	@Override
	public Result<RoomChangeLog> getBeanByFilter(Filter filter) {
		try {
			return Result.value(roomChangeLogDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.RoomChangeLog.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<RoomChangeLog>> getList() {
		try {
			return Result.value(roomChangeLogDao.getList());
		} catch (Exception e) {
			return Result.failure(R.RoomChangeLog.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<RoomChangeLog>> getListByFilter(Filter filter) {
		try {
			return Result.value(roomChangeLogDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.RoomChangeLog.LOAD_FAILURE);
		}
	}


}
