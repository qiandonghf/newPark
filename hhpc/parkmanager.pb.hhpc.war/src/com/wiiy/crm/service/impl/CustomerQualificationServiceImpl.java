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
import com.wiiy.crm.entity.CustomerQualification;
import com.wiiy.crm.dao.CustomerQualificationDao;
import com.wiiy.crm.service.CustomerQualificationService;
import com.wiiy.crm.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class CustomerQualificationServiceImpl implements CustomerQualificationService{
	
	private CustomerQualificationDao customerQualificationDao;
	
	public void setCustomerQualificationDao(CustomerQualificationDao customerQualificationDao) {
		this.customerQualificationDao = customerQualificationDao;
	}

	@Override
	public Result<CustomerQualification> save(CustomerQualification t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			customerQualificationDao.save(t);
			return Result.success(R.CustomerQualification.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),CustomerQualification.class)));
		} catch (Exception e) {
			return Result.failure(R.CustomerQualification.SAVE_FAILURE);
		}
	}

	@Override
	public Result<CustomerQualification> delete(CustomerQualification t) {
		try {
			customerQualificationDao.delete(t);
			return Result.success(R.CustomerQualification.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.CustomerQualification.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CustomerQualification> deleteById(Serializable id) {
		try {
			customerQualificationDao.deleteById(id);
			return Result.success(R.CustomerQualification.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.CustomerQualification.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CustomerQualification> deleteByIds(String ids) {
		try {
			customerQualificationDao.deleteByIds(ids);
			return Result.success(R.CustomerQualification.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.CustomerQualification.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CustomerQualification> update(CustomerQualification t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			customerQualificationDao.update(t);
			return Result.success(R.CustomerQualification.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),CustomerQualification.class)));
		} catch (Exception e) {
			return Result.failure(R.CustomerQualification.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<CustomerQualification> getBeanById(Serializable id) {
		try {
			return Result.value(customerQualificationDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.CustomerQualification.LOAD_FAILURE);
		}
	}

	@Override
	public Result<CustomerQualification> getBeanByFilter(Filter filter) {
		try {
			return Result.value(customerQualificationDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.CustomerQualification.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<CustomerQualification>> getList() {
		try {
			return Result.value(customerQualificationDao.getList());
		} catch (Exception e) {
			return Result.failure(R.CustomerQualification.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<CustomerQualification>> getListByFilter(Filter filter) {
		try {
			return Result.value(customerQualificationDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.CustomerQualification.LOAD_FAILURE);
		}
	}

}
