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
import com.wiiy.core.entity.Countersign;
import com.wiiy.core.dao.CountersignDao;
import com.wiiy.core.service.export.CountersignService;
import com.wiiy.core.preferences.R;
import com.wiiy.core.activator.CoreActivator;

/**
 * @author my
 */
public class CountersignServiceImpl implements CountersignService{
	
	private CountersignDao countersignDao;
	
	public void setCountersignDao(CountersignDao countersignDao) {
		this.countersignDao = countersignDao;
	}

	@Override
	public Result<Countersign> save(Countersign t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(CoreActivator.getSessionUser().getRealName());
			t.setCreatorId(CoreActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			countersignDao.save(t);
			return Result.success(R.Countersign.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Countersign.class)));
		} catch (Exception e) {
			return Result.failure(R.Countersign.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Countersign> delete(Countersign t) {
		try {
			countersignDao.delete(t);
			return Result.success(R.Countersign.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Countersign.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Countersign> deleteById(Serializable id) {
		try {
			countersignDao.deleteById(id);
			return Result.success(R.Countersign.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Countersign.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Countersign> deleteByIds(String ids) {
		try {
			countersignDao.deleteByIds(ids);
			return Result.success(R.Countersign.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Countersign.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Countersign> update(Countersign t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CoreActivator.getSessionUser().getRealName());
			t.setModifierId(CoreActivator.getSessionUser().getId());
			countersignDao.update(t);
			return Result.success(R.Countersign.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Countersign.class)));
		} catch (Exception e) {
			return Result.failure(R.Countersign.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Countersign> getBeanById(Serializable id) {
		try {
			return Result.value(countersignDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Countersign.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Countersign> getBeanByFilter(Filter filter) {
		try {
			return Result.value(countersignDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Countersign.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Countersign>> getList() {
		try {
			return Result.value(countersignDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Countersign.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Countersign>> getListByFilter(Filter filter) {
		try {
			return Result.value(countersignDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Countersign.LOAD_FAILURE);
		}
	}

}
