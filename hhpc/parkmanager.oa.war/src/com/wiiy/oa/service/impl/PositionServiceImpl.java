package com.wiiy.oa.service.impl;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dao.PositionDao;
import com.wiiy.oa.entity.Position;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.service.PositionService;

public class PositionServiceImpl implements PositionService{
	private PositionDao positionDao;
	public void setPositionDao(PositionDao positionDao) {
		this.positionDao = positionDao;
	}

	@Override
	public Result<Position> save(Position t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			positionDao.save(t);
			OaActivator.getOperationLogService().logOP("添加职位【"+t.getName()+"】");
			return Result.success(R.Position.SAVE_SUCCESS, t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Position.class)));
		} catch (Exception e) {
			return Result.failure(R.Position.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Position> delete(Position t) {
		try {
			positionDao.delete(t);
			OaActivator.getOperationLogService().logOP("删除职位【"+t.getName()+"】");
			return Result.success(R.Position.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Position.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Position> deleteById(Serializable id) {
		try {
			OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的职位");
			positionDao.deleteById(id);
			return Result.success(R.Position.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Position.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Position> deleteByIds(String ids) {
		try {
			for(String id : ids.split(",")){
				OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的职位");
			}
			positionDao.deleteByIds(ids);
			return Result.success(R.Position.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Position.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Position> update(Position t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			positionDao.update(t);
			OaActivator.getOperationLogService().logOP("编辑职位【"+t.getName()+"】");
			return Result.success(R.Position.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Position.class)));
		} catch (Exception e) {
			return Result.failure(R.Position.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Position> getBeanById(Serializable id) {
		try {
			return Result.value(positionDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Position.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Position> getBeanByFilter(Filter filter) {
		try {
			return Result.value(positionDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Position.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Position>> getList() {
		try {
			return Result.value(positionDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Position.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Position>> getListByFilter(Filter filter) {
		try {
			return Result.value(positionDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Position.LOAD_FAILURE);
		}
	}

}
