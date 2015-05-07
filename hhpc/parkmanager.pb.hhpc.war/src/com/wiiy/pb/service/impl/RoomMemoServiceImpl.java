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
import com.wiiy.pb.dao.RoomMemoDao;
import com.wiiy.pb.entity.RoomMemo;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.service.RoomMemoService;

/**
 * @author my
 */
public class RoomMemoServiceImpl implements RoomMemoService{
	
	private RoomMemoDao roomMemoDao;
	
	public void setRoomMemoDao(RoomMemoDao roomMemoDao) {
		this.roomMemoDao = roomMemoDao;
	}

	@Override
	public Result<RoomMemo> save(RoomMemo t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			roomMemoDao.save(t);
			PbActivator.getOperationLogService().logLogout("添加房间备注信息【"+t.getMemo()+"】");
			return Result.success(R.RoomMemo.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),RoomMemo.class)));
		} catch (Exception e) {
			return Result.failure(R.RoomMemo.SAVE_FAILURE);
		}
	}

	@Override
	public Result<RoomMemo> delete(RoomMemo t) {
		try {
			PbActivator.getOperationLogService().logLogout("删除房间备注信息【"+t.getMemo()+"】");
			roomMemoDao.delete(t);
			return Result.success(R.RoomMemo.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.RoomMemo.DELETE_FAILURE);
		}
	}

	@Override
	public Result<RoomMemo> deleteById(Serializable id) {
		try {
			roomMemoDao.deleteById(id);
			PbActivator.getOperationLogService().logLogout("删除房间备注信息id为【"+id+"】");
			return Result.success(R.RoomMemo.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.RoomMemo.DELETE_FAILURE);
		}
	}

	@Override
	public Result<RoomMemo> deleteByIds(String ids) {
		try {
			roomMemoDao.deleteByIds(ids);
			PbActivator.getOperationLogService().logLogout("删除房间备注信息ids为【"+ids+"】");
			return Result.success(R.RoomMemo.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.RoomMemo.DELETE_FAILURE);
		}
	}

	@Override
	public Result<RoomMemo> update(RoomMemo t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			roomMemoDao.update(t);
			PbActivator.getOperationLogService().logLogout("更新房间备注信息【"+t.getMemo()+"】");
			return Result.success(R.RoomMemo.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),RoomMemo.class)));
		} catch (Exception e) {
			return Result.failure(R.RoomMemo.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<RoomMemo> getBeanById(Serializable id) {
		try {
			return Result.value(roomMemoDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.RoomMemo.LOAD_FAILURE);
		}
	}

	@Override
	public Result<RoomMemo> getBeanByFilter(Filter filter) {
		try {
			return Result.value(roomMemoDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.RoomMemo.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<RoomMemo>> getList() {
		try {
			return Result.value(roomMemoDao.getList());
		} catch (Exception e) {
			return Result.failure(R.RoomMemo.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<RoomMemo>> getListByFilter(Filter filter) {
		try {
			return Result.value(roomMemoDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.RoomMemo.LOAD_FAILURE);
		}
	}


}
