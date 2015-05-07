package com.wiiy.cms.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.cms.entity.FloatingWindow;
import com.wiiy.cms.dao.FloatingWindowDao;
import com.wiiy.cms.service.FloatingWindowService;
import com.wiiy.cms.preferences.R;
import com.wiiy.cms.activator.CmsActivator;

/**
 * @author my
 */
public class FloatingWindowServiceImpl implements FloatingWindowService{
	
	private FloatingWindowDao floatingWindowDao;
	
	public void setFloatingWindowDao(FloatingWindowDao floatingWindowDao) {
		this.floatingWindowDao = floatingWindowDao;
	}

	@Override
	public Result<FloatingWindow> save(FloatingWindow t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(CmsActivator.getSessionUser().getRealName());
			t.setCreatorId(CmsActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			floatingWindowDao.save(t);
			return Result.success(R.FloatingWindow.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),FloatingWindow.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.FloatingWindow.SAVE_FAILURE);
		}
	}

	@Override
	public Result<FloatingWindow> delete(FloatingWindow t) {
		try {
			floatingWindowDao.delete(t);
			return Result.success(R.FloatingWindow.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.FloatingWindow.DELETE_FAILURE);
		}
	}

	@Override
	public Result<FloatingWindow> deleteById(Serializable id) {
		try {
			floatingWindowDao.deleteById(id);
			return Result.success(R.FloatingWindow.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.FloatingWindow.DELETE_FAILURE);
		}
	}

	@Override
	public Result<FloatingWindow> deleteByIds(String ids) {
		try {
			floatingWindowDao.deleteByIds(ids);
			return Result.success(R.FloatingWindow.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.FloatingWindow.DELETE_FAILURE);
		}
	}

	@Override
	public Result<FloatingWindow> update(FloatingWindow t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CmsActivator.getSessionUser().getRealName());
			t.setModifierId(CmsActivator.getSessionUser().getId());
			floatingWindowDao.update(t);
			return Result.success(R.FloatingWindow.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),FloatingWindow.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.FloatingWindow.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<FloatingWindow> getBeanById(Serializable id) {
		try {
			return Result.value(floatingWindowDao.getBeanById(id));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.FloatingWindow.LOAD_FAILURE);
		}
	}

	@Override
	public Result<FloatingWindow> getBeanByFilter(Filter filter) {
		try {
			return Result.value(floatingWindowDao.getBeanByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.FloatingWindow.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<FloatingWindow>> getList() {
		try {
			return Result.value(floatingWindowDao.getList());
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.FloatingWindow.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<FloatingWindow>> getListByFilter(Filter filter) {
		try {
			return Result.value(floatingWindowDao.getListByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.FloatingWindow.LOAD_FAILURE);
		}
	}

}
