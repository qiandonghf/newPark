package com.wiiy.crm.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.crm.dao.BusinessPlanAttDao;
import com.wiiy.crm.entity.BusinessPlanAtt;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.service.BusinessPlanAttService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;

/**
 * @author my
 */
public class BusinessPlanAttServiceImpl implements BusinessPlanAttService{
	
	private BusinessPlanAttDao businessPlanAttDao;
	
	public void setBusinessPlanAttDao(BusinessPlanAttDao businessPlanAttDao) {
		this.businessPlanAttDao = businessPlanAttDao;
	}

	@Override
	public Result<BusinessPlanAtt> save(BusinessPlanAtt t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			businessPlanAttDao.save(t);
			return Result.success(R.BusinessPlanAtt.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),BusinessPlanAtt.class)));
		} catch (Exception e) {
			return Result.failure(R.BusinessPlanAtt.SAVE_FAILURE);
		}
	}

	@Override
	public Result<BusinessPlanAtt> delete(BusinessPlanAtt t) {
		try {
			businessPlanAttDao.delete(t);
			return Result.success(R.BusinessPlanAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.BusinessPlanAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<BusinessPlanAtt> deleteById(Serializable id) {
		try {
			BusinessPlanAtt att = (BusinessPlanAtt) businessPlanAttDao.getBeanById(id);
			String path = att.getNewName();
			PbActivator.getResourcesService().delete(path);
			businessPlanAttDao.deleteById(id);
			return Result.success(R.BusinessPlanAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.BusinessPlanAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<BusinessPlanAtt> deleteByIds(String ids) {
		try {
			businessPlanAttDao.deleteByIds(ids);
			return Result.success(R.BusinessPlanAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.BusinessPlanAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<BusinessPlanAtt> update(BusinessPlanAtt t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			businessPlanAttDao.update(t);
			return Result.success(R.BusinessPlanAtt.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),BusinessPlanAtt.class)));
		} catch (Exception e) {
			return Result.failure(R.BusinessPlanAtt.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<BusinessPlanAtt> getBeanById(Serializable id) {
		try {
			return Result.value(businessPlanAttDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.BusinessPlanAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<BusinessPlanAtt> getBeanByFilter(Filter filter) {
		try {
			return Result.value(businessPlanAttDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.BusinessPlanAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<BusinessPlanAtt>> getList() {
		try {
			return Result.value(businessPlanAttDao.getList());
		} catch (Exception e) {
			return Result.failure(R.BusinessPlanAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<BusinessPlanAtt>> getListByFilter(Filter filter) {
		try {
			return Result.value(businessPlanAttDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.BusinessPlanAtt.LOAD_FAILURE);
		}
	}

}
