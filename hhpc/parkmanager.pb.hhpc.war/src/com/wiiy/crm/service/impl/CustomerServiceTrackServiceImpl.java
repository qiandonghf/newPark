package com.wiiy.crm.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.dao.CustomerServiceTrackDao;
import com.wiiy.crm.entity.CustomerServiceTrack;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.service.CustomerServiceTrackService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class CustomerServiceTrackServiceImpl implements CustomerServiceTrackService{
	
	private CustomerServiceTrackDao customerServiceTrackDao;
	
	public void setCustomerServiceTrackDao(CustomerServiceTrackDao customerServiceTrackDao) {
		this.customerServiceTrackDao = customerServiceTrackDao;
	}

	@Override
	public Result<CustomerServiceTrack> save(CustomerServiceTrack t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			customerServiceTrackDao.save(t);
			return Result.success(R.CustomerServiceTrack.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),CustomerServiceTrack.class)));
		} catch (Exception e) {
			return Result.failure(R.CustomerServiceTrack.SAVE_FAILURE);
		}
	}

	@Override
	public Result<CustomerServiceTrack> delete(CustomerServiceTrack t) {
		try {
			customerServiceTrackDao.delete(t);
			return Result.success(R.CustomerServiceTrack.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.CustomerServiceTrack.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CustomerServiceTrack> deleteById(Serializable id) {
		try {
			customerServiceTrackDao.deleteById(id);
			return Result.success(R.CustomerServiceTrack.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.CustomerServiceTrack.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CustomerServiceTrack> deleteByIds(String ids) {
		try {
			customerServiceTrackDao.deleteByIds(ids);
			return Result.success(R.CustomerServiceTrack.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.CustomerServiceTrack.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CustomerServiceTrack> update(CustomerServiceTrack t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			customerServiceTrackDao.update(t);
			return Result.success(R.CustomerServiceTrack.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),CustomerServiceTrack.class)));
		} catch (Exception e) {
			return Result.failure(R.CustomerServiceTrack.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<CustomerServiceTrack> getBeanById(Serializable id) {
		try {
			return Result.value(customerServiceTrackDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.CustomerServiceTrack.LOAD_FAILURE);
		}
	}

	@Override
	public Result<CustomerServiceTrack> getBeanByFilter(Filter filter) {
		try {
			return Result.value(customerServiceTrackDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.CustomerServiceTrack.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<CustomerServiceTrack>> getList() {
		try {
			return Result.value(customerServiceTrackDao.getList());
		} catch (Exception e) {
			return Result.failure(R.CustomerServiceTrack.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<CustomerServiceTrack>> getListByFilter(Filter filter) {
		try {
			return Result.value(customerServiceTrackDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.CustomerServiceTrack.LOAD_FAILURE);
		}
	}

}
