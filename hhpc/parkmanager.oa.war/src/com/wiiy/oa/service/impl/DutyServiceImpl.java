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
import com.wiiy.oa.entity.Duty;
import com.wiiy.oa.dao.DutyDao;
import com.wiiy.oa.service.DutyService;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.activator.OaActivator;

/**
 * @author my
 */
public class DutyServiceImpl implements DutyService{
	
	private DutyDao dutyDao;
	
	public void setDutyDao(DutyDao dutyDao) {
		this.dutyDao = dutyDao;
	}

	@Override
	public Result<Duty> save(Duty t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			dutyDao.save(t);
			return Result.success(R.Duty.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Duty.class)));
		} catch (Exception e) {
			return Result.failure(R.Duty.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Duty> delete(Duty t) {
		try {
			dutyDao.delete(t);
			return Result.success(R.Duty.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Duty.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Duty> deleteById(Serializable id) {
		try {
			dutyDao.deleteById(id);
			return Result.success(R.Duty.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Duty.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Duty> deleteByIds(String ids) {
		try {
			dutyDao.deleteByIds(ids);
			return Result.success(R.Duty.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Duty.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Duty> update(Duty t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			dutyDao.update(t);
			return Result.success(R.Duty.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Duty.class)));
		} catch (Exception e) {
			return Result.failure(R.Duty.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Duty> getBeanById(Serializable id) {
		try {
			return Result.value(dutyDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Duty.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Duty> getBeanByFilter(Filter filter) {
		try {
			return Result.value(dutyDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Duty.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Duty>> getList() {
		try {
			return Result.value(dutyDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Duty.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Duty>> getListByFilter(Filter filter) {
		try {
			return Result.value(dutyDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Duty.LOAD_FAILURE);
		}
	}

}
