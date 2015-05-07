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
import com.wiiy.crm.entity.DataReportValue;
import com.wiiy.crm.dao.DataReportValueDao;
import com.wiiy.crm.service.DataReportValueService;
import com.wiiy.crm.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class DataReportValueServiceImpl implements DataReportValueService{
	
	private DataReportValueDao dataReportValueDao;
	
	public void setDataReportValueDao(DataReportValueDao dataReportValueDao) {
		this.dataReportValueDao = dataReportValueDao;
	}

	@Override
	public Result<DataReportValue> save(DataReportValue t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			dataReportValueDao.save(t);
			return Result.success(R.DataReportValue.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),DataReportValue.class)));
		} catch (Exception e) {
			return Result.failure(R.DataReportValue.SAVE_FAILURE);
		}
	}

	@Override
	public Result<DataReportValue> delete(DataReportValue t) {
		try {
			dataReportValueDao.delete(t);
			return Result.success(R.DataReportValue.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DataReportValue.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DataReportValue> deleteById(Serializable id) {
		try {
			dataReportValueDao.deleteById(id);
			return Result.success(R.DataReportValue.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DataReportValue.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DataReportValue> deleteByIds(String ids) {
		try {
			dataReportValueDao.deleteByIds(ids);
			return Result.success(R.DataReportValue.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DataReportValue.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DataReportValue> update(DataReportValue t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			dataReportValueDao.update(t);
			return Result.success(R.DataReportValue.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),DataReportValue.class)));
		} catch (Exception e) {
			return Result.failure(R.DataReportValue.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<DataReportValue> getBeanById(Serializable id) {
		try {
			return Result.value(dataReportValueDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.DataReportValue.LOAD_FAILURE);
		}
	}

	@Override
	public Result<DataReportValue> getBeanByFilter(Filter filter) {
		try {
			return Result.value(dataReportValueDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DataReportValue.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<DataReportValue>> getList() {
		try {
			return Result.value(dataReportValueDao.getList());
		} catch (Exception e) {
			return Result.failure(R.DataReportValue.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<DataReportValue>> getListByFilter(Filter filter) {
		try {
			return Result.value(dataReportValueDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DataReportValue.LOAD_FAILURE);
		}
	}

}
