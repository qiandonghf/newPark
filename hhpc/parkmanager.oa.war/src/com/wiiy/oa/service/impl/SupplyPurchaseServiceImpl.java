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
import com.wiiy.oa.entity.SupplyPurchase;
import com.wiiy.oa.dao.SupplyPurchaseDao;
import com.wiiy.oa.service.SupplyPurchaseService;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.activator.OaActivator;

/**
 * @author my
 */
public class SupplyPurchaseServiceImpl implements SupplyPurchaseService{
	
	private SupplyPurchaseDao supplyPurchaseDao;
	
	public void setSupplyPurchaseDao(SupplyPurchaseDao supplyPurchaseDao) {
		this.supplyPurchaseDao = supplyPurchaseDao;
	}

	@Override
	public Result<SupplyPurchase> save(SupplyPurchase t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			supplyPurchaseDao.save(t);
			return Result.success(R.SupplyPurchase.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),SupplyPurchase.class)));
		} catch (Exception e) {
			return Result.failure(R.SupplyPurchase.SAVE_FAILURE);
		}
	}

	@Override
	public Result<SupplyPurchase> delete(SupplyPurchase t) {
		try {
			supplyPurchaseDao.delete(t);
			return Result.success(R.SupplyPurchase.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SupplyPurchase.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SupplyPurchase> deleteById(Serializable id) {
		try {
			supplyPurchaseDao.deleteById(id);
			return Result.success(R.SupplyPurchase.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SupplyPurchase.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SupplyPurchase> deleteByIds(String ids) {
		try {
			supplyPurchaseDao.deleteByIds(ids);
			return Result.success(R.SupplyPurchase.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SupplyPurchase.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SupplyPurchase> update(SupplyPurchase t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			supplyPurchaseDao.update(t);
			return Result.success(R.SupplyPurchase.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),SupplyPurchase.class)));
		} catch (Exception e) {
			return Result.failure(R.SupplyPurchase.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<SupplyPurchase> getBeanById(Serializable id) {
		try {
			return Result.value(supplyPurchaseDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.SupplyPurchase.LOAD_FAILURE);
		}
	}

	@Override
	public Result<SupplyPurchase> getBeanByFilter(Filter filter) {
		try {
			return Result.value(supplyPurchaseDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.SupplyPurchase.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SupplyPurchase>> getList() {
		try {
			return Result.value(supplyPurchaseDao.getList());
		} catch (Exception e) {
			return Result.failure(R.SupplyPurchase.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SupplyPurchase>> getListByFilter(Filter filter) {
		try {
			return Result.value(supplyPurchaseDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.SupplyPurchase.LOAD_FAILURE);
		}
	}

}
