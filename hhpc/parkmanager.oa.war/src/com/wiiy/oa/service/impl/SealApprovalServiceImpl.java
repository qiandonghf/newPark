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
import com.wiiy.oa.entity.SealApproval;
import com.wiiy.oa.dao.SealApprovalDao;
import com.wiiy.oa.service.SealApprovalService;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.activator.OaActivator;

/**
 * @author my
 */
public class SealApprovalServiceImpl implements SealApprovalService{
	
	private SealApprovalDao sealApprovalDao;
	
	public void setSealApprovalDao(SealApprovalDao sealApprovalDao) {
		this.sealApprovalDao = sealApprovalDao;
	}

	@Override
	public Result<SealApproval> save(SealApproval t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			sealApprovalDao.save(t);
			return Result.success(R.SealApproval.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),SealApproval.class)));
		} catch (Exception e) {
			return Result.failure(R.SealApproval.SAVE_FAILURE);
		}
	}

	@Override
	public Result<SealApproval> delete(SealApproval t) {
		try {
			sealApprovalDao.delete(t);
			return Result.success(R.SealApproval.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SealApproval.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SealApproval> deleteById(Serializable id) {
		try {
			sealApprovalDao.deleteById(id);
			return Result.success(R.SealApproval.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SealApproval.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SealApproval> deleteByIds(String ids) {
		try {
			sealApprovalDao.deleteByIds(ids);
			return Result.success(R.SealApproval.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SealApproval.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SealApproval> update(SealApproval t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			sealApprovalDao.update(t);
			return Result.success(R.SealApproval.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),SealApproval.class)));
		} catch (Exception e) {
			return Result.failure(R.SealApproval.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<SealApproval> getBeanById(Serializable id) {
		try {
			return Result.value(sealApprovalDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.SealApproval.LOAD_FAILURE);
		}
	}

	@Override
	public Result<SealApproval> getBeanByFilter(Filter filter) {
		try {
			return Result.value(sealApprovalDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.SealApproval.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SealApproval>> getList() {
		try {
			return Result.value(sealApprovalDao.getList());
		} catch (Exception e) {
			return Result.failure(R.SealApproval.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SealApproval>> getListByFilter(Filter filter) {
		try {
			return Result.value(sealApprovalDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.SealApproval.LOAD_FAILURE);
		}
	}

}
