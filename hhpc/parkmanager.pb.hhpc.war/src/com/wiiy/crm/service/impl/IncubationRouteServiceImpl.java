package com.wiiy.crm.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.dao.IncubationRouteDao;
import com.wiiy.crm.entity.IncubationRoute;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.service.IncubationRouteService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class IncubationRouteServiceImpl implements IncubationRouteService{
	
	private IncubationRouteDao incubationRouteDao;
	
	public void setIncubationRouteDao(IncubationRouteDao incubationRouteDao) {
		this.incubationRouteDao = incubationRouteDao;
	}

	@Override
	public Result<IncubationRoute> save(IncubationRoute t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			incubationRouteDao.save(t);
			return Result.success(R.IncubationRoute.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),IncubationRoute.class)));
		} catch (Exception e) {
			return Result.failure(R.IncubationRoute.SAVE_FAILURE);
		}
	}

	@Override
	public Result<IncubationRoute> delete(IncubationRoute t) {
		try {
			incubationRouteDao.delete(t);
			return Result.success(R.IncubationRoute.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.IncubationRoute.DELETE_FAILURE);
		}
	}

	@Override
	public Result<IncubationRoute> deleteById(Serializable id) {
		try {
			incubationRouteDao.deleteById(id);
			return Result.success(R.IncubationRoute.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.IncubationRoute.DELETE_FAILURE);
		}
	}

	@Override
	public Result<IncubationRoute> deleteByIds(String ids) {
		try {
			incubationRouteDao.deleteByIds(ids);
			return Result.success(R.IncubationRoute.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.IncubationRoute.DELETE_FAILURE);
		}
	}

	@Override
	public Result<IncubationRoute> update(IncubationRoute t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			incubationRouteDao.update(t);
			return Result.success(R.IncubationRoute.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),IncubationRoute.class)));
		} catch (Exception e) {
			return Result.failure(R.IncubationRoute.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<IncubationRoute> getBeanById(Serializable id) {
		try {
			return Result.value(incubationRouteDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.IncubationRoute.LOAD_FAILURE);
		}
	}

	@Override
	public Result<IncubationRoute> getBeanByFilter(Filter filter) {
		try {
			return Result.value(incubationRouteDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.IncubationRoute.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<IncubationRoute>> getList() {
		try {
			return Result.value(incubationRouteDao.getList());
		} catch (Exception e) {
			return Result.failure(R.IncubationRoute.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<IncubationRoute>> getListByFilter(Filter filter) {
		try {
			return Result.value(incubationRouteDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.IncubationRoute.LOAD_FAILURE);
		}
	}

}
