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
import com.wiiy.oa.dao.SalaryItemDao;
import com.wiiy.oa.entity.SalaryItem;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.service.SalaryItemService;

public class SalaryItemServiceImpl implements SalaryItemService{
	private SalaryItemDao salaryItemDao;
	public void setSalaryItemDao(SalaryItemDao salaryItemDao) {
		this.salaryItemDao = salaryItemDao;
	}

	@Override
	public Result<SalaryItem> save(SalaryItem t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			salaryItemDao.save(t);
			OaActivator.getOperationLogService().logOP("添加薪资项【"+t.getName()+"】");
			return Result.success(R.SalaryItem.SAVE_SUCCESS, t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),SalaryItem.class)));
		} catch (Exception e) {
			return Result.failure(R.SalaryItem.SAVE_FAILURE);
		}
	}

	@Override
	public Result<SalaryItem> delete(SalaryItem t) {
		try {
			salaryItemDao.delete(t);
			OaActivator.getOperationLogService().logOP("删除薪资项【"+t.getName()+"】");
			return Result.success(R.SalaryItem.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SalaryItem.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SalaryItem> deleteById(Serializable id) {
		try {
			OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的薪资项");
			salaryItemDao.deleteById(id);
			return Result.success(R.SalaryItem.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SalaryItem.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SalaryItem> deleteByIds(String ids) {
		try {
			for(String id : ids.split(",")){
				OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的薪资项");
			}
			salaryItemDao.deleteByIds(ids);
			return Result.success(R.SalaryItem.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SalaryItem.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SalaryItem> update(SalaryItem t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			salaryItemDao.update(t);
			OaActivator.getOperationLogService().logOP("编辑薪资项【"+t.getName()+"】");
			return Result.success(R.SalaryItem.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),SalaryItem.class)));
		} catch (Exception e) {
			return Result.failure(R.SalaryItem.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<SalaryItem> getBeanById(Serializable id) {
		try {
			return Result.value(salaryItemDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.SalaryItem.LOAD_FAILURE);
		}
	}

	@Override
	public Result<SalaryItem> getBeanByFilter(Filter filter) {
		try {
			return Result.value(salaryItemDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.SalaryItem.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SalaryItem>> getList() {
		try {
			return Result.value(salaryItemDao.getList());
		} catch (Exception e) {
			return Result.failure(R.SalaryItem.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SalaryItem>> getListByFilter(Filter filter) {
		try {
			return Result.value(salaryItemDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.SalaryItem.LOAD_FAILURE);
		}
	}

}
