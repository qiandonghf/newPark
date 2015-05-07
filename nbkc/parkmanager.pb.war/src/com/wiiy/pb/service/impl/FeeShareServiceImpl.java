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
import com.wiiy.pb.entity.FeeShare;
import com.wiiy.pb.dao.FeeShareDao;
import com.wiiy.pb.service.FeeShareService;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class FeeShareServiceImpl implements FeeShareService{
	
	private FeeShareDao feeShareDao;
	
	public void setFeeShareDao(FeeShareDao feeShareDao) {
		this.feeShareDao = feeShareDao;
	}

	@Override
	public Result<FeeShare> save(FeeShare t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			feeShareDao.save(t);
			return Result.success(R.FeeShare.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),FeeShare.class)));
		} catch (Exception e) {
			return Result.failure(R.FeeShare.SAVE_FAILURE);
		}
	}

	@Override
	public Result<FeeShare> delete(FeeShare t) {
		try {
			feeShareDao.delete(t);
			return Result.success(R.FeeShare.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.FeeShare.DELETE_FAILURE);
		}
	}

	@Override
	public Result<FeeShare> deleteById(Serializable id) {
		try {
			feeShareDao.deleteById(id);
			return Result.success(R.FeeShare.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.FeeShare.DELETE_FAILURE);
		}
	}

	@Override
	public Result<FeeShare> deleteByIds(String ids) {
		try {
			feeShareDao.deleteByIds(ids);
			return Result.success(R.FeeShare.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.FeeShare.DELETE_FAILURE);
		}
	}

	@Override
	public Result<FeeShare> update(FeeShare t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			feeShareDao.update(t);
			return Result.success(R.FeeShare.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),FeeShare.class)));
		} catch (Exception e) {
			return Result.failure(R.FeeShare.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<FeeShare> getBeanById(Serializable id) {
		try {
			return Result.value(feeShareDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.FeeShare.LOAD_FAILURE);
		}
	}

	@Override
	public Result<FeeShare> getBeanByFilter(Filter filter) {
		try {
			return Result.value(feeShareDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.FeeShare.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<FeeShare>> getList() {
		try {
			return Result.value(feeShareDao.getList());
		} catch (Exception e) {
			return Result.failure(R.FeeShare.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<FeeShare>> getListByFilter(Filter filter) {
		try {
			return Result.value(feeShareDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.FeeShare.LOAD_FAILURE);
		}
	}

}
