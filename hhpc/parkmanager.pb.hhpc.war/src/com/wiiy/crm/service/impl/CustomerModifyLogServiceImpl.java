package com.wiiy.crm.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.dao.CustomerModifyLogDao;
import com.wiiy.crm.entity.CustomerModifyLog;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.service.CustomerModifyLogService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class CustomerModifyLogServiceImpl implements CustomerModifyLogService{
	
	private CustomerModifyLogDao customerModifyLogDao;
	
	public void setCustomerModifyLogDao(CustomerModifyLogDao customerModifyLogDao) {
		this.customerModifyLogDao = customerModifyLogDao;
	}

	@Override
	public Result<CustomerModifyLog> save(CustomerModifyLog t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			customerModifyLogDao.save(t);
			return Result.success(R.CustomerModifyLog.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),CustomerModifyLog.class)));
		} catch (Exception e) {
			return Result.failure(R.CustomerModifyLog.SAVE_FAILURE);
		}
	}

	@Override
	public Result<CustomerModifyLog> delete(CustomerModifyLog t) {
		try {
			customerModifyLogDao.delete(t);
			return Result.success(R.CustomerModifyLog.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.CustomerModifyLog.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CustomerModifyLog> deleteById(Serializable id) {
		try {
			customerModifyLogDao.deleteById(id);
			return Result.success(R.CustomerModifyLog.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.CustomerModifyLog.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CustomerModifyLog> deleteByIds(String ids) {
		try {
			customerModifyLogDao.deleteByIds(ids);
			return Result.success(R.CustomerModifyLog.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.CustomerModifyLog.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CustomerModifyLog> update(CustomerModifyLog t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			customerModifyLogDao.update(t);
			return Result.success(R.CustomerModifyLog.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),CustomerModifyLog.class)));
		} catch (Exception e) {
			return Result.failure(R.CustomerModifyLog.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<CustomerModifyLog> getBeanById(Serializable id) {
		try {
			return Result.value(customerModifyLogDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.CustomerModifyLog.LOAD_FAILURE);
		}
	}

	@Override
	public Result<CustomerModifyLog> getBeanByFilter(Filter filter) {
		try {
			return Result.value(customerModifyLogDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.CustomerModifyLog.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<CustomerModifyLog>> getList() {
		try {
			return Result.value(customerModifyLogDao.getList());
		} catch (Exception e) {
			return Result.failure(R.CustomerModifyLog.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<CustomerModifyLog>> getListByFilter(Filter filter) {
		try {
			return Result.value(customerModifyLogDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.CustomerModifyLog.LOAD_FAILURE);
		}
	}

}
