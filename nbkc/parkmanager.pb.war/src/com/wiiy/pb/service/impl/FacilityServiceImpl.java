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
import com.wiiy.pb.entity.Facility;
import com.wiiy.pb.dao.FacilityDao;
import com.wiiy.pb.service.FacilityService;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class FacilityServiceImpl implements FacilityService{
	
	private FacilityDao facilityDao;
	
	public void setFacilityDao(FacilityDao facilityDao) {
		this.facilityDao = facilityDao;
	}

	@Override
	public Result<Facility> save(Facility t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			facilityDao.save(t);
			return Result.success(R.Facility.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Facility.class)));
		} catch (Exception e) {
			return Result.failure(R.Facility.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Facility> delete(Facility t) {
		try {
			facilityDao.delete(t);
			return Result.success(R.Facility.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Facility.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Facility> deleteById(Serializable id) {
		try {
			facilityDao.deleteById(id);
			return Result.success(R.Facility.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Facility.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Facility> deleteByIds(String ids) {
		try {
			facilityDao.deleteByIds(ids);
			return Result.success(R.Facility.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Facility.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Facility> update(Facility t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			facilityDao.update(t);
			return Result.success(R.Facility.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Facility.class)));
		} catch (Exception e) {
			return Result.failure(R.Facility.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Facility> getBeanById(Serializable id) {
		try {
			return Result.value(facilityDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Facility.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Facility> getBeanByFilter(Filter filter) {
		try {
			return Result.value(facilityDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Facility.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Facility>> getList() {
		try {
			return Result.value(facilityDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Facility.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Facility>> getListByFilter(Filter filter) {
		try {
			return Result.value(facilityDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Facility.LOAD_FAILURE);
		}
	}

}
