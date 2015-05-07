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
import com.wiiy.crm.entity.CustomerCategory;
import com.wiiy.crm.dao.CustomerCategoryDao;
import com.wiiy.crm.service.CustomerCategoryService;
import com.wiiy.crm.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class CustomerCategoryServiceImpl implements CustomerCategoryService{
	
	private CustomerCategoryDao customerCategoryDao;
	
	public void setCustomerCategoryDao(CustomerCategoryDao customerCategoryDao) {
		this.customerCategoryDao = customerCategoryDao;
	}

	@Override
	public Result<CustomerCategory> save(CustomerCategory t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			customerCategoryDao.save(t);
			return Result.success(R.CustomerCategory.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),CustomerCategory.class)));
		} catch (Exception e) {
			return Result.failure(R.CustomerCategory.SAVE_FAILURE);
		}
	}

	@Override
	public Result<CustomerCategory> delete(CustomerCategory t) {
		try {
			customerCategoryDao.delete(t);
			return Result.success(R.CustomerCategory.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.CustomerCategory.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CustomerCategory> deleteById(Serializable id) {
		try {
			customerCategoryDao.deleteById(id);
			return Result.success(R.CustomerCategory.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.CustomerCategory.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CustomerCategory> deleteByIds(String ids) {
		try {
			customerCategoryDao.deleteByIds(ids);
			return Result.success(R.CustomerCategory.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.CustomerCategory.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CustomerCategory> update(CustomerCategory t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			customerCategoryDao.update(t);
			return Result.success(R.CustomerCategory.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),CustomerCategory.class)));
		} catch (Exception e) {
			return Result.failure(R.CustomerCategory.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<CustomerCategory> getBeanById(Serializable id) {
		try {
			return Result.value(customerCategoryDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.CustomerCategory.LOAD_FAILURE);
		}
	}

	@Override
	public Result<CustomerCategory> getBeanByFilter(Filter filter) {
		try {
			return Result.value(customerCategoryDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.CustomerCategory.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<CustomerCategory>> getList() {
		try {
			return Result.value(customerCategoryDao.getList());
		} catch (Exception e) {
			return Result.failure(R.CustomerCategory.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<CustomerCategory>> getListByFilter(Filter filter) {
		try {
			return Result.value(customerCategoryDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.CustomerCategory.LOAD_FAILURE);
		}
	}

}
