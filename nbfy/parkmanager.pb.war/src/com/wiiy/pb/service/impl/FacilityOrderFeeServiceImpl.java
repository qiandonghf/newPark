package com.wiiy.pb.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.entity.FacilityOrderFee;
import com.wiiy.pb.dao.FacilityOrderFeeDao;
import com.wiiy.pb.service.FacilityOrderFeeService;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class FacilityOrderFeeServiceImpl implements FacilityOrderFeeService{
	
	private FacilityOrderFeeDao facilityOrderFeeDao;
	
	public void setFacilityOrderFeeDao(FacilityOrderFeeDao facilityOrderFeeDao) {
		this.facilityOrderFeeDao = facilityOrderFeeDao;
	}

	@Override
	public Result<FacilityOrderFee> save(FacilityOrderFee t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			facilityOrderFeeDao.save(t);
			return Result.success(R.FacilityOrderFee.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),FacilityOrderFee.class)));
		} catch (Exception e) {
			return Result.failure(R.FacilityOrderFee.SAVE_FAILURE);
		}
	}

	@Override
	public Result<FacilityOrderFee> delete(FacilityOrderFee t) {
		try {
			facilityOrderFeeDao.delete(t);
			return Result.success(R.FacilityOrderFee.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.FacilityOrderFee.DELETE_FAILURE);
		}
	}

	@Override
	public Result<FacilityOrderFee> deleteById(Serializable id) {
		try {
			facilityOrderFeeDao.deleteById(id);
			return Result.success(R.FacilityOrderFee.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.FacilityOrderFee.DELETE_FAILURE);
		}
	}

	@Override
	public Result<FacilityOrderFee> deleteByIds(String ids) {
		try {
			facilityOrderFeeDao.deleteByIds(ids);
			return Result.success(R.FacilityOrderFee.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.FacilityOrderFee.DELETE_FAILURE);
		}
	}

	@Override
	public Result<FacilityOrderFee> update(FacilityOrderFee t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			facilityOrderFeeDao.update(t);
			return Result.success(R.FacilityOrderFee.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),FacilityOrderFee.class)));
		} catch (Exception e) {
			return Result.failure(R.FacilityOrderFee.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<FacilityOrderFee> getBeanById(Serializable id) {
		try {
			return Result.value(facilityOrderFeeDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.FacilityOrderFee.LOAD_FAILURE);
		}
	}

	@Override
	public Result<FacilityOrderFee> getBeanByFilter(Filter filter) {
		try {
			return Result.value(facilityOrderFeeDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.FacilityOrderFee.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<FacilityOrderFee>> getList() {
		try {
			return Result.value(facilityOrderFeeDao.getList());
		} catch (Exception e) {
			return Result.failure(R.FacilityOrderFee.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<FacilityOrderFee>> getListByFilter(Filter filter) {
		try {
			return Result.value(facilityOrderFeeDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.FacilityOrderFee.LOAD_FAILURE);
		}
	}

}
