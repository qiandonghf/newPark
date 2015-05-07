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
import com.wiiy.crm.entity.DataReportGroup;
import com.wiiy.crm.dao.DataReportGroupDao;
import com.wiiy.crm.service.DataReportGroupService;
import com.wiiy.crm.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class DataReportGroupServiceImpl implements DataReportGroupService{
	
	private DataReportGroupDao dataReportGroupDao;
	
	public void setDataReportGroupDao(DataReportGroupDao dataReportGroupDao) {
		this.dataReportGroupDao = dataReportGroupDao;
	}

	@Override
	public Result<DataReportGroup> save(DataReportGroup t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			dataReportGroupDao.save(t);
			return Result.success(R.DataReportGroup.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),DataReportGroup.class)));
		} catch (Exception e) {
			return Result.failure(R.DataReportGroup.SAVE_FAILURE);
		}
	}

	@Override
	public Result<DataReportGroup> delete(DataReportGroup t) {
		try {
			dataReportGroupDao.delete(t);
			return Result.success(R.DataReportGroup.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DataReportGroup.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DataReportGroup> deleteById(Serializable id) {
		try {
			dataReportGroupDao.deleteById(id);
			return Result.success(R.DataReportGroup.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DataReportGroup.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DataReportGroup> deleteByIds(String ids) {
		try {
			dataReportGroupDao.deleteByIds(ids);
			return Result.success(R.DataReportGroup.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DataReportGroup.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DataReportGroup> update(DataReportGroup t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			dataReportGroupDao.update(t);
			return Result.success(R.DataReportGroup.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),DataReportGroup.class)));
		} catch (Exception e) {
			return Result.failure(R.DataReportGroup.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<DataReportGroup> getBeanById(Serializable id) {
		try {
			return Result.value(dataReportGroupDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.DataReportGroup.LOAD_FAILURE);
		}
	}

	@Override
	public Result<DataReportGroup> getBeanByFilter(Filter filter) {
		try {
			return Result.value(dataReportGroupDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DataReportGroup.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<DataReportGroup>> getList() {
		try {
			return Result.value(dataReportGroupDao.getList());
		} catch (Exception e) {
			return Result.failure(R.DataReportGroup.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<DataReportGroup>> getListByFilter(Filter filter) {
		try {
			return Result.value(dataReportGroupDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DataReportGroup.LOAD_FAILURE);
		}
	}

}
