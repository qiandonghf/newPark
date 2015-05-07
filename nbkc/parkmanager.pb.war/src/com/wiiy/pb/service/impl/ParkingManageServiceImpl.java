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
import com.wiiy.pb.entity.ParkingManage;
import com.wiiy.pb.dao.ParkingManageDao;
import com.wiiy.pb.service.ParkingManageService;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class ParkingManageServiceImpl implements ParkingManageService{
	
	private ParkingManageDao parkingManageDao;
	
	public void setParkingManageDao(ParkingManageDao parkingManageDao) {
		this.parkingManageDao = parkingManageDao;
	}

	@Override
	public Result<ParkingManage> save(ParkingManage t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			parkingManageDao.save(t);
			return Result.success(R.ParkingManage.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ParkingManage.class)));
		} catch (Exception e) {
			return Result.failure(R.ParkingManage.SAVE_FAILURE);
		}
	}

	@Override
	public Result<ParkingManage> delete(ParkingManage t) {
		try {
			parkingManageDao.delete(t);
			return Result.success(R.ParkingManage.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ParkingManage.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ParkingManage> deleteById(Serializable id) {
		try {
			parkingManageDao.deleteById(id);
			return Result.success(R.ParkingManage.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ParkingManage.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ParkingManage> deleteByIds(String ids) {
		try {
			parkingManageDao.deleteByIds(ids);
			return Result.success(R.ParkingManage.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ParkingManage.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ParkingManage> update(ParkingManage t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			parkingManageDao.update(t);
			return Result.success(R.ParkingManage.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ParkingManage.class)));
		} catch (Exception e) {
			return Result.failure(R.ParkingManage.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<ParkingManage> getBeanById(Serializable id) {
		try {
			return Result.value(parkingManageDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.ParkingManage.LOAD_FAILURE);
		}
	}

	@Override
	public Result<ParkingManage> getBeanByFilter(Filter filter) {
		try {
			return Result.value(parkingManageDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ParkingManage.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ParkingManage>> getList() {
		try {
			return Result.value(parkingManageDao.getList());
		} catch (Exception e) {
			return Result.failure(R.ParkingManage.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ParkingManage>> getListByFilter(Filter filter) {
		try {
			return Result.value(parkingManageDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ParkingManage.LOAD_FAILURE);
		}
	}

}
