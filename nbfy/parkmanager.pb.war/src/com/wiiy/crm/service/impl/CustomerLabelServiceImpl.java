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
import com.wiiy.crm.entity.CustomerLabel;
import com.wiiy.crm.dao.CustomerLabelDao;
import com.wiiy.crm.service.CustomerLabelService;
import com.wiiy.crm.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class CustomerLabelServiceImpl implements CustomerLabelService{
	
	private CustomerLabelDao customerLabelDao;
	
	public void setCustomerLabelDao(CustomerLabelDao customerLabelDao) {
		this.customerLabelDao = customerLabelDao;
	}

	@Override
	public Result<CustomerLabel> save(CustomerLabel t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			customerLabelDao.save(t);
			return Result.success(R.CustomerLabel.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),CustomerLabel.class)));
		} catch (Exception e) {
			return Result.failure(R.CustomerLabel.SAVE_FAILURE);
		}
	}

	@Override
	public Result<CustomerLabel> delete(CustomerLabel t) {
		try {
			customerLabelDao.delete(t);
			return Result.success(R.CustomerLabel.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.CustomerLabel.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CustomerLabel> deleteById(Serializable id) {
		try {
			customerLabelDao.deleteById(id);
			return Result.success(R.CustomerLabel.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.CustomerLabel.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CustomerLabel> deleteByIds(String ids) {
		try {
			customerLabelDao.deleteByIds(ids);
			return Result.success(R.CustomerLabel.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.CustomerLabel.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CustomerLabel> update(CustomerLabel t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			customerLabelDao.update(t);
			return Result.success(R.CustomerLabel.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),CustomerLabel.class)));
		} catch (Exception e) {
			return Result.failure(R.CustomerLabel.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<CustomerLabel> getBeanById(Serializable id) {
		try {
			return Result.value(customerLabelDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.CustomerLabel.LOAD_FAILURE);
		}
	}

	@Override
	public Result<CustomerLabel> getBeanByFilter(Filter filter) {
		try {
			return Result.value(customerLabelDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.CustomerLabel.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<CustomerLabel>> getList() {
		try {
			return Result.value(customerLabelDao.getList());
		} catch (Exception e) {
			return Result.failure(R.CustomerLabel.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<CustomerLabel>> getListByFilter(Filter filter) {
		try {
			return Result.value(customerLabelDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.CustomerLabel.LOAD_FAILURE);
		}
	}

	@Override
	public List<CustomerLabel> getCustomerLabelsByCustomerId(Long id) {
		return customerLabelDao.getListByHql("select ref.customerLabel from CustomerLabelRef ref where ref.customerId = "+id);
	}

}
