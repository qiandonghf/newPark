package com.wiiy.pb.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.entity.Park;
import com.wiiy.pb.dao.ParkDao;
import com.wiiy.pb.service.ParkService;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class ParkServiceImpl implements ParkService{
	
	private ParkDao parkDao;
	
	public void setParkDao(ParkDao parkDao) {
		this.parkDao = parkDao;
	}

	@Override
	public Result<Park> save(Park t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			parkDao.save(t);
			return Result.success(R.Park.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Park.class)));
		} catch (Exception e) {
			return Result.failure(R.Park.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Park> delete(Park t) {
		try {
			parkDao.delete(t);
			return Result.success(R.Park.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Park.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Park> deleteById(Serializable id) {
		try {
			parkDao.deleteById(id);
			return Result.success(R.Park.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Park.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Park> deleteByIds(String ids) {
		try {
			parkDao.deleteByIds(ids);
			return Result.success(R.Park.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Park.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Park> update(Park t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			parkDao.update(t);
			return Result.success(R.Park.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Park.class)));
		} catch (Exception e) {
			return Result.failure(R.Park.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Park> getBeanById(Serializable id) {
		try {
			return Result.value(parkDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Park.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Park> getBeanByFilter(Filter filter) {
		try {
			return Result.value(parkDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Park.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Park>> getList() {
		try {
			return Result.value(parkDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Park.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Park>> getListByFilter(Filter filter) {
		try {
			return Result.value(parkDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Park.LOAD_FAILURE);
		}
	}

}
