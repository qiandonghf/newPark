package com.wiiy.crm.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.dao.DataCheckLogDao;
import com.wiiy.crm.entity.DataCheckLog;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.service.DataCheckLogService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class DataCheckLogServiceImpl implements DataCheckLogService{
	
	private DataCheckLogDao dataCheckLogDao;
	
	public void setDataCheckLogDao(DataCheckLogDao dataCheckLogDao) {
		this.dataCheckLogDao = dataCheckLogDao;
	}

	@Override
	public Result<DataCheckLog> save(DataCheckLog t) {
		try {
			t.setCreateTime(new Date());
			/*t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());*/
			t.setEntityStatus(EntityStatus.NORMAL);
			dataCheckLogDao.save(t);
			return Result.success(R.DataCheckLog.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),DataCheckLog.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.DataCheckLog.SAVE_FAILURE);
		}
	}

	@Override
	public Result<DataCheckLog> delete(DataCheckLog t) {
		try {
			dataCheckLogDao.delete(t);
			return Result.success(R.DataCheckLog.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.DataCheckLog.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DataCheckLog> deleteById(Serializable id) {
		try {
			dataCheckLogDao.deleteById(id);
			return Result.success(R.DataCheckLog.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.DataCheckLog.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DataCheckLog> deleteByIds(String ids) {
		try {
			dataCheckLogDao.deleteByIds(ids);
			return Result.success(R.DataCheckLog.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.DataCheckLog.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DataCheckLog> update(DataCheckLog t) {
		try {
			t.setModifyTime(new Date());
			dataCheckLogDao.update(t);
			return Result.success(R.DataCheckLog.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),DataCheckLog.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.DataCheckLog.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<DataCheckLog> getBeanById(Serializable id) {
		try {
			return Result.value(dataCheckLogDao.getBeanById(id));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.DataCheckLog.LOAD_FAILURE);
		}
	}

	@Override
	public Result<DataCheckLog> getBeanByFilter(Filter filter) {
		try {
			return Result.value(dataCheckLogDao.getBeanByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.DataCheckLog.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<DataCheckLog>> getList() {
		try {
			return Result.value(dataCheckLogDao.getList());
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.DataCheckLog.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<DataCheckLog>> getListByFilter(Filter filter) {
		try {
			return Result.value(dataCheckLogDao.getListByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.DataCheckLog.LOAD_FAILURE);
		}
	}

}
