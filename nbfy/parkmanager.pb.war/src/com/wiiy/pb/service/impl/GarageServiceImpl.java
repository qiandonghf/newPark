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
import com.wiiy.pb.entity.Garage;
import com.wiiy.pb.dao.GarageDao;
import com.wiiy.pb.service.GarageService;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class GarageServiceImpl implements GarageService{
	
	private GarageDao garageDao;
	
	public void setGarageDao(GarageDao garageDao) {
		this.garageDao = garageDao;
	}

	@Override
	public Result<Garage> save(Garage t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			garageDao.save(t);
			return Result.success(R.Garage.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Garage.class)));
		} catch (Exception e) {
			return Result.failure(R.Garage.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Garage> delete(Garage t) {
		try {
			garageDao.delete(t);
			return Result.success(R.Garage.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Garage.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Garage> deleteById(Serializable id) {
		try {
			garageDao.deleteById(id);
			return Result.success(R.Garage.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Garage.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Garage> deleteByIds(String ids) {
		try {
			garageDao.deleteByIds(ids);
			return Result.success(R.Garage.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Garage.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Garage> update(Garage t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			garageDao.update(t);
			return Result.success(R.Garage.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Garage.class)));
		} catch (Exception e) {
			return Result.failure(R.Garage.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Garage> getBeanById(Serializable id) {
		try {
			return Result.value(garageDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Garage.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Garage> getBeanByFilter(Filter filter) {
		try {
			return Result.value(garageDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Garage.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Garage>> getList() {
		try {
			return Result.value(garageDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Garage.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Garage>> getListByFilter(Filter filter) {
		try {
			return Result.value(garageDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Garage.LOAD_FAILURE);
		}
	}

}
