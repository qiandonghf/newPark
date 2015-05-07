package com.wiiy.crm.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.crm.entity.IncubationInfo;
import com.wiiy.crm.dao.IncubationInfoDao;
import com.wiiy.crm.service.IncubationInfoService;
import com.wiiy.crm.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class IncubationInfoServiceImpl implements IncubationInfoService{
	
	private IncubationInfoDao incubationInfoDao;
	
	public void setIncubationInfoDao(IncubationInfoDao incubationInfoDao) {
		this.incubationInfoDao = incubationInfoDao;
	}

	@Override
	public Result<IncubationInfo> save(IncubationInfo t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			incubationInfoDao.save(t);
			return Result.success(R.IncubationInfo.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),IncubationInfo.class)));
		} catch (Exception e) {
			return Result.failure(R.IncubationInfo.SAVE_FAILURE);
		}
	}

	@Override
	public Result<IncubationInfo> delete(IncubationInfo t) {
		try {
			incubationInfoDao.delete(t);
			return Result.success(R.IncubationInfo.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.IncubationInfo.DELETE_FAILURE);
		}
	}

	@Override
	public Result<IncubationInfo> deleteById(Serializable id) {
		try {
			incubationInfoDao.deleteById(id);
			return Result.success(R.IncubationInfo.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.IncubationInfo.DELETE_FAILURE);
		}
	}

	@Override
	public Result<IncubationInfo> deleteByIds(String ids) {
		try {
			incubationInfoDao.deleteByIds(ids);
			return Result.success(R.IncubationInfo.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.IncubationInfo.DELETE_FAILURE);
		}
	}

	@Override
	public Result<IncubationInfo> update(IncubationInfo t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			incubationInfoDao.update(t);
			return Result.success(R.IncubationInfo.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),IncubationInfo.class)));
		} catch (Exception e) {
			return Result.failure(R.IncubationInfo.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<IncubationInfo> getBeanById(Serializable id) {
		try {
			return Result.value(incubationInfoDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.IncubationInfo.LOAD_FAILURE);
		}
	}

	@Override
	public Result<IncubationInfo> getBeanByFilter(Filter filter) {
		try {
			return Result.value(incubationInfoDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.IncubationInfo.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<IncubationInfo>> getList() {
		try {
			return Result.value(incubationInfoDao.getList());
		} catch (Exception e) {
			return Result.failure(R.IncubationInfo.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<IncubationInfo>> getListByFilter(Filter filter) {
		try {
			return Result.value(incubationInfoDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.IncubationInfo.LOAD_FAILURE);
		}
	}

}
