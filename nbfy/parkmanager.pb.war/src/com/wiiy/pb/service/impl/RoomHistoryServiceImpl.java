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
import com.wiiy.pb.entity.RoomHistory;
import com.wiiy.pb.dao.RoomHistoryDao;
import com.wiiy.pb.service.RoomHistoryService;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class RoomHistoryServiceImpl implements RoomHistoryService{
	
	private RoomHistoryDao roomHistoryDao;
	
	public void setRoomHistoryDao(RoomHistoryDao roomHistoryDao) {
		this.roomHistoryDao = roomHistoryDao;
	}

	@Override
	public Result<RoomHistory> save(RoomHistory t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			roomHistoryDao.save(t);
			return Result.success(R.RoomHistory.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),RoomHistory.class)));
		} catch (Exception e) {
			return Result.failure(R.RoomHistory.SAVE_FAILURE);
		}
	}

	@Override
	public Result<RoomHistory> delete(RoomHistory t) {
		try {
			roomHistoryDao.delete(t);
			return Result.success(R.RoomHistory.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.RoomHistory.DELETE_FAILURE);
		}
	}

	@Override
	public Result<RoomHistory> deleteById(Serializable id) {
		try {
			roomHistoryDao.deleteById(id);
			return Result.success(R.RoomHistory.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.RoomHistory.DELETE_FAILURE);
		}
	}

	@Override
	public Result<RoomHistory> deleteByIds(String ids) {
		try {
			roomHistoryDao.deleteByIds(ids);
			return Result.success(R.RoomHistory.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.RoomHistory.DELETE_FAILURE);
		}
	}

	@Override
	public Result<RoomHistory> update(RoomHistory t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			roomHistoryDao.update(t);
			return Result.success(R.RoomHistory.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),RoomHistory.class)));
		} catch (Exception e) {
			return Result.failure(R.RoomHistory.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<RoomHistory> getBeanById(Serializable id) {
		try {
			return Result.value(roomHistoryDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.RoomHistory.LOAD_FAILURE);
		}
	}

	@Override
	public Result<RoomHistory> getBeanByFilter(Filter filter) {
		try {
			return Result.value(roomHistoryDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.RoomHistory.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<RoomHistory>> getList() {
		try {
			return Result.value(roomHistoryDao.getList());
		} catch (Exception e) {
			return Result.failure(R.RoomHistory.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<RoomHistory>> getListByFilter(Filter filter) {
		try {
			return Result.value(roomHistoryDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.RoomHistory.LOAD_FAILURE);
		}
	}

}
