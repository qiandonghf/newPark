package com.wiiy.core.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.dao.UserDao;
import com.wiiy.core.dao.UserEmailParamDao;
import com.wiiy.core.entity.User;
import com.wiiy.core.entity.UserEmailParam;
import com.wiiy.core.preferences.R;
import com.wiiy.core.service.UserEmailParamService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;

/**
 * @author my
 */
public class UserEmailParamServiceImpl implements UserEmailParamService{
	
	private UserEmailParamDao userEmailParamDao;
	
	public void setUserEmailParamDao(UserEmailParamDao userEmailParamDao) {
		this.userEmailParamDao = userEmailParamDao;
	}

	@Override
	public Result<UserEmailParam> save(UserEmailParam t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = userEmailParamDao.openSession();
			tr = session.beginTransaction();
			t.setUser(CoreActivator.getSessionUser())
;			t.setCreateTime(new Date());
			t.setCreator(CoreActivator.getSessionUser().getRealName());
			t.setCreatorId(CoreActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			session.save(t);
			tr.commit();
			return Result.success(R.UserEmailParam.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),UserEmailParam.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.UserEmailParam.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<UserEmailParam> delete(UserEmailParam t) {
		try {
			userEmailParamDao.delete(t);
			return Result.success(R.UserEmailParam.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.UserEmailParam.DELETE_FAILURE);
		}
	}

	@Override
	public Result<UserEmailParam> deleteById(Serializable id) {
		try {
			userEmailParamDao.deleteById(id);
			return Result.success(R.UserEmailParam.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.UserEmailParam.DELETE_FAILURE);
		}
	}

	@Override
	public Result<UserEmailParam> deleteByIds(String ids) {
		try {
			userEmailParamDao.deleteByIds(ids);
			return Result.success(R.UserEmailParam.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.UserEmailParam.DELETE_FAILURE);
		}
	}

	@Override
	public Result<UserEmailParam> update(UserEmailParam t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = userEmailParamDao.openSession();
			tr = session.beginTransaction();
			t.setModifyTime(new Date());
			t.setModifier(CoreActivator.getSessionUser().getRealName());
			t.setModifierId(CoreActivator.getSessionUser().getId());
			session.update(t);
			tr.commit();
			return Result.success(R.UserEmailParam.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),UserEmailParam.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.UserEmailParam.UPDATE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<UserEmailParam> getBeanById(Serializable id) {
		try {
			return Result.value(userEmailParamDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.UserEmailParam.LOAD_FAILURE);
		}
	}

	@Override
	public Result<UserEmailParam> getBeanByFilter(Filter filter) {
		try {
			return Result.value(userEmailParamDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.UserEmailParam.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<UserEmailParam>> getList() {
		try {
			return Result.value(userEmailParamDao.getList());
		} catch (Exception e) {
			return Result.failure(R.UserEmailParam.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<UserEmailParam>> getListByFilter(Filter filter) {
		try {
			return Result.value(userEmailParamDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.UserEmailParam.LOAD_FAILURE);
		}
	}

}
