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
import com.wiiy.pb.entity.GardenApplyEval;
import com.wiiy.pb.dao.GardenApplyEvalDao;
import com.wiiy.pb.service.GardenApplyEvalService;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class GardenApplyEvalServiceImpl implements GardenApplyEvalService{
	
	private GardenApplyEvalDao gardenApplyEvalDao;
	
	public void setGardenApplyEvalDao(GardenApplyEvalDao gardenApplyEvalDao) {
		this.gardenApplyEvalDao = gardenApplyEvalDao;
	}

	@Override
	public Result<GardenApplyEval> save(GardenApplyEval t) {
		try {
			GardenApplyEval eval = gardenApplyEvalDao.getBeanByFilter(
					new Filter(GardenApplyEval.class).
					eq("applyId", t.getApplyId()).eq("evalUserId", t.getEvalUserId()));
			if (eval != null) {
				return Result.success(R.GardenApplyEval.SAVE_SUCCESS);
			}
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			gardenApplyEvalDao.save(t);
			return Result.success(R.GardenApplyEval.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),GardenApplyEval.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApplyEval.SAVE_FAILURE);
		}
	}

	@Override
	public Result<GardenApplyEval> delete(GardenApplyEval t) {
		try {
			gardenApplyEvalDao.delete(t);
			return Result.success(R.GardenApplyEval.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApplyEval.DELETE_FAILURE);
		}
	}

	@Override
	public Result<GardenApplyEval> deleteById(Serializable id) {
		try {
			gardenApplyEvalDao.deleteById(id);
			return Result.success(R.GardenApplyEval.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApplyEval.DELETE_FAILURE);
		}
	}

	@Override
	public Result<GardenApplyEval> deleteByIds(String ids) {
		try {
			gardenApplyEvalDao.deleteByIds(ids);
			return Result.success(R.GardenApplyEval.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApplyEval.DELETE_FAILURE);
		}
	}

	@Override
	public Result<GardenApplyEval> update(GardenApplyEval t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			gardenApplyEvalDao.update(t);
			return Result.success(R.GardenApplyEval.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),GardenApplyEval.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApplyEval.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<GardenApplyEval> getBeanById(Serializable id) {
		try {
			return Result.value(gardenApplyEvalDao.getBeanById(id));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApplyEval.LOAD_FAILURE);
		}
	}

	@Override
	public Result<GardenApplyEval> getBeanByFilter(Filter filter) {
		try {
			return Result.value(gardenApplyEvalDao.getBeanByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApplyEval.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<GardenApplyEval>> getList() {
		try {
			return Result.value(gardenApplyEvalDao.getList());
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApplyEval.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<GardenApplyEval>> getListByFilter(Filter filter) {
		try {
			return Result.value(gardenApplyEvalDao.getListByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApplyEval.LOAD_FAILURE);
		}
	}

}
