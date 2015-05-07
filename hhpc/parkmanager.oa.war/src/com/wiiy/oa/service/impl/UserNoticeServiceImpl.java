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
import com.wiiy.oa.entity.UserNotice;
import com.wiiy.oa.dao.UserNoticeDao;
import com.wiiy.oa.service.UserNoticeService;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.activator.OaActivator;

/**
 * @author my
 */
public class UserNoticeServiceImpl implements UserNoticeService{
	
	private UserNoticeDao userNoticeDao;
	
	public void setUserNoticeDao(UserNoticeDao userNoticeDao) {
		this.userNoticeDao = userNoticeDao;
	}

	@Override
	public Result<UserNotice> save(UserNotice t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			userNoticeDao.save(t);
			return Result.success(R.UserNotice.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),UserNotice.class)));
		} catch (Exception e) {
			return Result.failure(R.UserNotice.SAVE_FAILURE);
		}
	}

	@Override
	public Result<UserNotice> delete(UserNotice t) {
		try {
			userNoticeDao.delete(t);
			return Result.success(R.UserNotice.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.UserNotice.DELETE_FAILURE);
		}
	}

	@Override
	public Result<UserNotice> deleteById(Serializable id) {
		try {
			userNoticeDao.deleteById(id);
			return Result.success(R.UserNotice.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.UserNotice.DELETE_FAILURE);
		}
	}

	@Override
	public Result<UserNotice> deleteByIds(String ids) {
		try {
			userNoticeDao.deleteByIds(ids);
			return Result.success(R.UserNotice.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.UserNotice.DELETE_FAILURE);
		}
	}

	@Override
	public Result<UserNotice> update(UserNotice t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			userNoticeDao.update(t);
			return Result.success(R.UserNotice.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),UserNotice.class)));
		} catch (Exception e) {
			return Result.failure(R.UserNotice.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<UserNotice> getBeanById(Serializable id) {
		try {
			return Result.value(userNoticeDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.UserNotice.LOAD_FAILURE);
		}
	}

	@Override
	public Result<UserNotice> getBeanByFilter(Filter filter) {
		try {
			return Result.value(userNoticeDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.UserNotice.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<UserNotice>> getList() {
		try {
			return Result.value(userNoticeDao.getList());
		} catch (Exception e) {
			return Result.failure(R.UserNotice.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<UserNotice>> getListByFilter(Filter filter) {
		try {
			return Result.value(userNoticeDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.UserNotice.LOAD_FAILURE);
		}
	}

}
