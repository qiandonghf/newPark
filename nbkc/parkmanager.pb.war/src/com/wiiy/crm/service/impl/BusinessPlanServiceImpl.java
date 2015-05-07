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
import com.wiiy.crm.entity.BusinessPlan;
import com.wiiy.crm.dao.BusinessPlanDao;
import com.wiiy.crm.service.BusinessPlanService;
import com.wiiy.crm.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class BusinessPlanServiceImpl implements BusinessPlanService{
	
	private BusinessPlanDao businessPlanDao;
	
	public void setBusinessPlanDao(BusinessPlanDao businessPlanDao) {
		this.businessPlanDao = businessPlanDao;
	}

	@Override
	public Result<BusinessPlan> save(BusinessPlan t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			businessPlanDao.save(t);
			return Result.success(R.BusinessPlan.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),BusinessPlan.class)));
		} catch (Exception e) {
			return Result.failure(R.BusinessPlan.SAVE_FAILURE);
		}
	}

	@Override
	public Result<BusinessPlan> delete(BusinessPlan t) {
		try {
			businessPlanDao.delete(t);
			return Result.success(R.BusinessPlan.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.BusinessPlan.DELETE_FAILURE);
		}
	}

	@Override
	public Result<BusinessPlan> deleteById(Serializable id) {
		try {
			businessPlanDao.deleteById(id);
			return Result.success(R.BusinessPlan.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.BusinessPlan.DELETE_FAILURE);
		}
	}

	@Override
	public Result<BusinessPlan> deleteByIds(String ids) {
		try {
			businessPlanDao.deleteByIds(ids);
			return Result.success(R.BusinessPlan.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.BusinessPlan.DELETE_FAILURE);
		}
	}

	@Override
	public Result<BusinessPlan> update(BusinessPlan t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			businessPlanDao.update(t);
			return Result.success(R.BusinessPlan.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),BusinessPlan.class)));
		} catch (Exception e) {
			return Result.failure(R.BusinessPlan.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<BusinessPlan> getBeanById(Serializable id) {
		try {
			return Result.value(businessPlanDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.BusinessPlan.LOAD_FAILURE);
		}
	}

	@Override
	public Result<BusinessPlan> getBeanByFilter(Filter filter) {
		try {
			return Result.value(businessPlanDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.BusinessPlan.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<BusinessPlan>> getList() {
		try {
			return Result.value(businessPlanDao.getList());
		} catch (Exception e) {
			return Result.failure(R.BusinessPlan.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<BusinessPlan>> getListByFilter(Filter filter) {
		try {
			return Result.value(businessPlanDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.BusinessPlan.LOAD_FAILURE);
		}
	}

}
