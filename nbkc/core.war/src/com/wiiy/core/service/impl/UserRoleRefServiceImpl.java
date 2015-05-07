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
import com.wiiy.core.entity.UserRoleRef;
import com.wiiy.core.dao.UserRoleRefDao;
import com.wiiy.core.service.UserRoleRefService;
import com.wiiy.core.preferences.R;
import com.wiiy.core.activator.CoreActivator;

/**
 * @author my
 */
public class UserRoleRefServiceImpl implements UserRoleRefService{
	
	private UserRoleRefDao userRoleRefDao;
	
	public void setUserRoleRefDao(UserRoleRefDao userRoleRefDao) {
		this.userRoleRefDao = userRoleRefDao;
	}

	@Override
	public Result<UserRoleRef> save(UserRoleRef t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(CoreActivator.getSessionUser().getRealName());
			t.setCreatorId(CoreActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			userRoleRefDao.save(t);
			return Result.success(R.UserRoleRef.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),UserRoleRef.class)));
		} catch (Exception e) {
			return Result.failure(R.UserRoleRef.SAVE_FAILURE);
		}
	}

	@Override
	public Result<UserRoleRef> delete(UserRoleRef t) {
		try {
			userRoleRefDao.delete(t);
			return Result.success(R.UserRoleRef.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.UserRoleRef.DELETE_FAILURE);
		}
	}

	@Override
	public Result<UserRoleRef> deleteById(Serializable id) {
		try {
			userRoleRefDao.deleteById(id);
			return Result.success(R.UserRoleRef.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.UserRoleRef.DELETE_FAILURE);
		}
	}

	@Override
	public Result<UserRoleRef> deleteByIds(String ids) {
		try {
			userRoleRefDao.deleteByIds(ids);
			return Result.success(R.UserRoleRef.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.UserRoleRef.DELETE_FAILURE);
		}
	}

	@Override
	public Result<UserRoleRef> update(UserRoleRef t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CoreActivator.getSessionUser().getRealName());
			t.setModifierId(CoreActivator.getSessionUser().getId());
			userRoleRefDao.update(t);
			return Result.success(R.UserRoleRef.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),UserRoleRef.class)));
		} catch (Exception e) {
			return Result.failure(R.UserRoleRef.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<UserRoleRef> getBeanById(Serializable id) {
		try {
			return Result.value(userRoleRefDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.UserRoleRef.LOAD_FAILURE);
		}
	}

	@Override
	public Result<UserRoleRef> getBeanByFilter(Filter filter) {
		try {
			return Result.value(userRoleRefDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.UserRoleRef.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<UserRoleRef>> getList() {
		try {
			return Result.value(userRoleRefDao.getList());
		} catch (Exception e) {
			return Result.failure(R.UserRoleRef.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<UserRoleRef>> getListByFilter(Filter filter) {
		try {
			return Result.value(userRoleRefDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.UserRoleRef.LOAD_FAILURE);
		}
	}

}
