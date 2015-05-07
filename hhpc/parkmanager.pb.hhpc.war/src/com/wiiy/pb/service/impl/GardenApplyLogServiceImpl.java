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
import com.wiiy.pb.entity.GardenApplyLog;
import com.wiiy.pb.dao.GardenApplyLogDao;
import com.wiiy.pb.service.GardenApplyLogService;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class GardenApplyLogServiceImpl implements GardenApplyLogService{
	
	private GardenApplyLogDao gardenApplyLogDao;
	
	public void setGardenApplyLogDao(GardenApplyLogDao gardenApplyLogDao) {
		this.gardenApplyLogDao = gardenApplyLogDao;
	}

	@Override
	public Result<GardenApplyLog> save(GardenApplyLog t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			gardenApplyLogDao.save(t);
			return Result.success(R.GardenApplyLog.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),GardenApplyLog.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApplyLog.SAVE_FAILURE);
		}
	}

	@Override
	public Result<GardenApplyLog> delete(GardenApplyLog t) {
		try {
			gardenApplyLogDao.delete(t);
			return Result.success(R.GardenApplyLog.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApplyLog.DELETE_FAILURE);
		}
	}

	@Override
	public Result<GardenApplyLog> deleteById(Serializable id) {
		try {
			gardenApplyLogDao.deleteById(id);
			return Result.success(R.GardenApplyLog.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApplyLog.DELETE_FAILURE);
		}
	}

	@Override
	public Result<GardenApplyLog> deleteByIds(String ids) {
		try {
			gardenApplyLogDao.deleteByIds(ids);
			return Result.success(R.GardenApplyLog.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApplyLog.DELETE_FAILURE);
		}
	}

	@Override
	public Result<GardenApplyLog> update(GardenApplyLog t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			gardenApplyLogDao.update(t);
			return Result.success(R.GardenApplyLog.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),GardenApplyLog.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApplyLog.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<GardenApplyLog> getBeanById(Serializable id) {
		try {
			return Result.value(gardenApplyLogDao.getBeanById(id));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApplyLog.LOAD_FAILURE);
		}
	}

	@Override
	public Result<GardenApplyLog> getBeanByFilter(Filter filter) {
		try {
			return Result.value(gardenApplyLogDao.getBeanByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApplyLog.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<GardenApplyLog>> getList() {
		try {
			return Result.value(gardenApplyLogDao.getList());
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApplyLog.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<GardenApplyLog>> getListByFilter(Filter filter) {
		try {
			return Result.value(gardenApplyLogDao.getListByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.GardenApplyLog.LOAD_FAILURE);
		}
	}

}
