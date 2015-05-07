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
import com.wiiy.pb.entity.FacilityOrder;
import com.wiiy.pb.dao.FacilityOrderDao;
import com.wiiy.pb.service.FacilityOrderService;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class FacilityOrderServiceImpl implements FacilityOrderService{
	
	private FacilityOrderDao facilityOrderDao;
	
	public void setFacilityOrderDao(FacilityOrderDao facilityOrderDao) {
		this.facilityOrderDao = facilityOrderDao;
	}

	@Override
	public Result<FacilityOrder> save(FacilityOrder t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			facilityOrderDao.save(t);
			return Result.success(R.FacilityOrder.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),FacilityOrder.class)));
		} catch (Exception e) {
			return Result.failure(R.FacilityOrder.SAVE_FAILURE);
		}
	}

	@Override
	public Result<FacilityOrder> delete(FacilityOrder t) {
		try {
			facilityOrderDao.delete(t);
			return Result.success(R.FacilityOrder.DELETE_SUCCESS,t);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.FacilityOrder.DELETE_FAILURE);
		}
	}

	@Override
	public Result<FacilityOrder> deleteById(Serializable id) {
		try {
			facilityOrderDao.deleteById(id);
			return Result.success(R.FacilityOrder.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.FacilityOrder.DELETE_FAILURE);
		}
	}

	@Override
	public Result<FacilityOrder> deleteByIds(String ids) {
		try {
			facilityOrderDao.deleteByIds(ids);
			return Result.success(R.FacilityOrder.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.FacilityOrder.DELETE_FAILURE);
		}
	}

	@Override
	public Result<FacilityOrder> update(FacilityOrder t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			facilityOrderDao.update(t);
			return Result.success(R.FacilityOrder.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),FacilityOrder.class)));
		} catch (Exception e) {
			return Result.failure(R.FacilityOrder.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<FacilityOrder> getBeanById(Serializable id) {
		try {
			return Result.value(facilityOrderDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.FacilityOrder.LOAD_FAILURE);
		}
	}

	@Override
	public Result<FacilityOrder> getBeanByFilter(Filter filter) {
		try {
			return Result.value(facilityOrderDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.FacilityOrder.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<FacilityOrder>> getList() {
		try {
			return Result.value(facilityOrderDao.getList());
		} catch (Exception e) {
			return Result.failure(R.FacilityOrder.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<FacilityOrder>> getListByFilter(Filter filter) {
		try {
			return Result.value(facilityOrderDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.FacilityOrder.LOAD_FAILURE);
		}
	}

}
