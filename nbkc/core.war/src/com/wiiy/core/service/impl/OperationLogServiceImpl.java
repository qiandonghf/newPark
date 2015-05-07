package com.wiiy.core.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.core.entity.OperationLog;
import com.wiiy.core.dao.OperationLogDao;
import com.wiiy.core.service.OperationLogService;
import com.wiiy.core.preferences.R;
import com.wiiy.core.activator.CoreActivator;

/**
 * @author my
 */
public class OperationLogServiceImpl implements OperationLogService{
	
	private OperationLogDao operationLogDao;
	
	public void setOperationLogDao(OperationLogDao operationLogDao) {
		this.operationLogDao = operationLogDao;
	}

	@Override
	public Result<OperationLog> save(OperationLog t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(CoreActivator.getSessionUser().getRealName());
			t.setCreatorId(CoreActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			operationLogDao.save(t);
			return Result.success(R.OperationLog.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),OperationLog.class)));
		} catch (Exception e) {
			return Result.failure(R.OperationLog.SAVE_FAILURE);
		}
	}

	@Override
	public Result<OperationLog> delete(OperationLog t) {
		try {
			operationLogDao.delete(t);
			return Result.success(R.OperationLog.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.OperationLog.DELETE_FAILURE);
		}
	}

	@Override
	public Result<OperationLog> deleteById(Serializable id) {
		try {
			operationLogDao.deleteById(id);
			return Result.success(R.OperationLog.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.OperationLog.DELETE_FAILURE);
		}
	}

	@Override
	public Result<OperationLog> deleteByIds(String ids) {
		try {
			operationLogDao.deleteByIds(ids);
			return Result.success(R.OperationLog.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.OperationLog.DELETE_FAILURE);
		}
	}

	@Override
	public Result<OperationLog> update(OperationLog t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CoreActivator.getSessionUser().getRealName());
			t.setModifierId(CoreActivator.getSessionUser().getId());
			operationLogDao.update(t);
			return Result.success(R.OperationLog.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),OperationLog.class)));
		} catch (Exception e) {
			return Result.failure(R.OperationLog.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<OperationLog> getBeanById(Serializable id) {
		try {
			return Result.value(operationLogDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.OperationLog.LOAD_FAILURE);
		}
	}

	@Override
	public Result<OperationLog> getBeanByFilter(Filter filter) {
		try {
			return Result.value(operationLogDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.OperationLog.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<OperationLog>> getList() {
		try {
			return Result.value(operationLogDao.getList());
		} catch (Exception e) {
			return Result.failure(R.OperationLog.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<OperationLog>> getListByFilter(Filter filter) {
		try {
			return Result.value(operationLogDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.OperationLog.LOAD_FAILURE);
		}
	}

}
