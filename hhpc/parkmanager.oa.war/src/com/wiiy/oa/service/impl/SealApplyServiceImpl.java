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
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dao.SealApplyDao;
import com.wiiy.oa.entity.SealApply;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.service.SealApplyService;

/**
 * @author my
 */
public class SealApplyServiceImpl implements SealApplyService{
	
	private SealApplyDao sealApplyDao;
	
	public void setSealApplyDao(SealApplyDao sealApplyDao) {
		this.sealApplyDao = sealApplyDao;
	}

	@Override
	public Result<SealApply> save(SealApply t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			sealApplyDao.save(t);
			return Result.success(R.SealApply.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),SealApply.class)));
		} catch (Exception e) {
			return Result.failure(R.SealApply.SAVE_FAILURE);
		}
	}

	@Override
	public Result<SealApply> delete(SealApply t) {
		try {
			sealApplyDao.delete(t);
			return Result.success(R.SealApply.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SealApply.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SealApply> deleteById(Serializable id) {
		try {
			sealApplyDao.deleteById(id);
			return Result.success(R.SealApply.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SealApply.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SealApply> deleteByIds(String ids) {
		try {
			sealApplyDao.deleteByIds(ids);
			return Result.success(R.SealApply.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SealApply.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SealApply> update(SealApply t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			sealApplyDao.update(t);
			return Result.success(R.SealApply.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),SealApply.class)));
		} catch (Exception e) {
			return Result.failure(R.SealApply.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<SealApply> getBeanById(Serializable id) {
		try {
			return Result.value(sealApplyDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.SealApply.LOAD_FAILURE);
		}
	}

	@Override
	public Result<SealApply> getBeanByFilter(Filter filter) {
		try {
			return Result.value(sealApplyDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.SealApply.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SealApply>> getList() {
		try {
			return Result.value(sealApplyDao.getList());
		} catch (Exception e) {
			return Result.failure(R.SealApply.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SealApply>> getListByFilter(Filter filter) {
		try {
			return Result.value(sealApplyDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.SealApply.LOAD_FAILURE);
		}
	}

	@Override
	public void sendMail(Long approverId, String ids, String email) {
		// TODO Auto-generated method stub
		
	}

}
