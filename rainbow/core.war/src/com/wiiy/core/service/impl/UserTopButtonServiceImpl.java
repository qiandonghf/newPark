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
import com.wiiy.core.entity.UserTopButton;
import com.wiiy.core.dao.UserTopButtonDao;
import com.wiiy.core.service.UserTopButtonService;
import com.wiiy.core.preferences.R;
import com.wiiy.core.activator.CoreActivator;

/**
 * @author my
 */
public class UserTopButtonServiceImpl implements UserTopButtonService{
	
	private UserTopButtonDao userTopButtonDao;
	
	public void setUserTopButtonDao(UserTopButtonDao userTopButtonDao) {
		this.userTopButtonDao = userTopButtonDao;
	}

	@Override
	public Result<UserTopButton> save(UserTopButton t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(CoreActivator.getSessionUser().getRealName());
			t.setCreatorId(CoreActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			userTopButtonDao.save(t);
			return Result.success(R.UserTopButton.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),UserTopButton.class)));
		} catch (Exception e) {
			return Result.failure(R.UserTopButton.SAVE_FAILURE);
		}
	}

	@Override
	public Result<UserTopButton> delete(UserTopButton t) {
		try {
			userTopButtonDao.delete(t);
			return Result.success(R.UserTopButton.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.UserTopButton.DELETE_FAILURE);
		}
	}

	@Override
	public Result<UserTopButton> deleteById(Serializable id) {
		try {
			userTopButtonDao.deleteById(id);
			return Result.success(R.UserTopButton.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.UserTopButton.DELETE_FAILURE);
		}
	}

	@Override
	public Result<UserTopButton> deleteByIds(String ids) {
		try {
			userTopButtonDao.deleteByIds(ids);
			return Result.success(R.UserTopButton.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.UserTopButton.DELETE_FAILURE);
		}
	}

	@Override
	public Result<UserTopButton> update(UserTopButton t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CoreActivator.getSessionUser().getRealName());
			t.setModifierId(CoreActivator.getSessionUser().getId());
			userTopButtonDao.update(t);
			return Result.success(R.UserTopButton.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),UserTopButton.class)));
		} catch (Exception e) {
			return Result.failure(R.UserTopButton.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<UserTopButton> getBeanById(Serializable id) {
		try {
			return Result.value(userTopButtonDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.UserTopButton.LOAD_FAILURE);
		}
	}

	@Override
	public Result<UserTopButton> getBeanByFilter(Filter filter) {
		try {
			return Result.value(userTopButtonDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.UserTopButton.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<UserTopButton>> getList() {
		try {
			return Result.value(userTopButtonDao.getList());
		} catch (Exception e) {
			return Result.failure(R.UserTopButton.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<UserTopButton>> getListByFilter(Filter filter) {
		try {
			return Result.value(userTopButtonDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.UserTopButton.LOAD_FAILURE);
		}
	}

}
