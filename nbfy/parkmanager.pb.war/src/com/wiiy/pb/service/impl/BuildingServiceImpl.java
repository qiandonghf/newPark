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
import com.wiiy.pb.entity.Building;
import com.wiiy.pb.dao.BuildingDao;
import com.wiiy.pb.service.BuildingService;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class BuildingServiceImpl implements BuildingService{
	
	private BuildingDao buildingDao;
	
	public void setBuildingDao(BuildingDao buildingDao) {
		this.buildingDao = buildingDao;
	}

	@Override
	public Result<Building> save(Building t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			buildingDao.save(t);
			return Result.success(R.Building.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Building.class)));
		} catch (Exception e) {
			return Result.failure(R.Building.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Building> delete(Building t) {
		try {
			buildingDao.delete(t);
			return Result.success(R.Building.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Building.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Building> deleteById(Serializable id) {
		try {
			buildingDao.deleteById(id);
			return Result.success(R.Building.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Building.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Building> deleteByIds(String ids) {
		try {
			buildingDao.deleteByIds(ids);
			return Result.success(R.Building.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Building.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Building> update(Building t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			buildingDao.update(t);
			return Result.success(R.Building.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Building.class)));
		} catch (Exception e) {
			return Result.failure(R.Building.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Building> getBeanById(Serializable id) {
		try {
			return Result.value(buildingDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Building.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Building> getBeanByFilter(Filter filter) {
		try {
			return Result.value(buildingDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Building.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Building>> getList() {
		try {
			return Result.value(buildingDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Building.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Building>> getListByFilter(Filter filter) {
		try {
			return Result.value(buildingDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Building.LOAD_FAILURE);
		}
	}
	@Override
	public Result<List<Building>> getListByHql(String hql) {
		try {
			return Result.value(buildingDao.getListByHql(hql));
			
		} catch (Exception e) {
			return Result.failure(R.Building.LOAD_FAILURE);
		}
	}

}
