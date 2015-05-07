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
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.crm.entity.CustomerRiskCapital;
import com.wiiy.crm.dao.CustomerRiskCapitalDao;
import com.wiiy.crm.service.CustomerRiskCapitalService;
import com.wiiy.crm.preferences.R;

/**
 * @author my
 */
public class CustomerRiskCapitalServiceImpl implements CustomerRiskCapitalService{
	
	private CustomerRiskCapitalDao customerRiskCapitalDao;
	
	public void setCustomerRiskCapitalDao(CustomerRiskCapitalDao customerRiskCapitalDao) {
		this.customerRiskCapitalDao = customerRiskCapitalDao;
	}

	@Override
	public Result<CustomerRiskCapital> save(CustomerRiskCapital t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			customerRiskCapitalDao.save(t);
			return Result.success(R.CustomerRiskCapital.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),CustomerRiskCapital.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.CustomerRiskCapital.SAVE_FAILURE);
		}
	}

	@Override
	public Result<CustomerRiskCapital> delete(CustomerRiskCapital t) {
		try {
			customerRiskCapitalDao.delete(t);
			return Result.success(R.CustomerRiskCapital.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.CustomerRiskCapital.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CustomerRiskCapital> deleteById(Serializable id) {
		try {
			customerRiskCapitalDao.deleteById(id);
			return Result.success(R.CustomerRiskCapital.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.CustomerRiskCapital.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CustomerRiskCapital> deleteByIds(String ids) {
		try {
			customerRiskCapitalDao.deleteByIds(ids);
			return Result.success(R.CustomerRiskCapital.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.CustomerRiskCapital.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CustomerRiskCapital> update(CustomerRiskCapital t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			customerRiskCapitalDao.update(t);
			return Result.success(R.CustomerRiskCapital.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),CustomerRiskCapital.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.CustomerRiskCapital.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<CustomerRiskCapital> getBeanById(Serializable id) {
		try {
			return Result.value(customerRiskCapitalDao.getBeanById(id));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.CustomerRiskCapital.LOAD_FAILURE);
		}
	}

	@Override
	public Result<CustomerRiskCapital> getBeanByFilter(Filter filter) {
		try {
			return Result.value(customerRiskCapitalDao.getBeanByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.CustomerRiskCapital.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<CustomerRiskCapital>> getList() {
		try {
			return Result.value(customerRiskCapitalDao.getList());
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.CustomerRiskCapital.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<CustomerRiskCapital>> getListByFilter(Filter filter) {
		try {
			return Result.value(customerRiskCapitalDao.getListByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.CustomerRiskCapital.LOAD_FAILURE);
		}
	}

}
