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
import com.wiiy.oa.dao.CarFixDao;
import com.wiiy.oa.entity.Car;
import com.wiiy.oa.entity.CarFix;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.service.CarFixService;

public class CarFixServiceImpl implements CarFixService{
	private CarFixDao carFixDao;
	public void setCarFixDao(CarFixDao carFixDao) {
		this.carFixDao = carFixDao;
	}

	@Override
	public Result<CarFix> save(CarFix t) {
		try {
			List<CarFix> carList = getListByFilter(new Filter(CarFix.class).eq("licenseNo", t.getLicenseNo())).getValue();
			if(carList!=null && carList.size()>0){
				return Result.failure("车牌号已存在");
			}
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			carFixDao.save(t);
			OaActivator.getOperationLogService().logOP("添加id为【"+t.getId()+"】的车辆维修单");
			return Result.success(R.CarFix.SAVE_SUCCESS, t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),CarFix.class)));
		} catch (Exception e) {
			return Result.failure(R.CarFix.SAVE_FAILURE);
		}
	}

	@Override
	public Result<CarFix> delete(CarFix t) {
		try {
			carFixDao.delete(t);
			OaActivator.getOperationLogService().logOP("删除id为【"+t.getId()+"】的车辆维修单");
			return Result.success(R.CarFix.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.CarFix.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CarFix> deleteById(Serializable id) {
		try {
			OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的车辆维修单");
			carFixDao.deleteById(id);
			return Result.success(R.CarFix.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.CarFix.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CarFix> deleteByIds(String ids) {
		try {
			for(String id : ids.split(",")){
				OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的车辆维修单");
			}
			carFixDao.deleteByIds(ids);
			return Result.success(R.CarFix.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.CarFix.DELETE_FAILURE);
		}
	}

	@Override
	public Result<CarFix> update(CarFix t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			carFixDao.update(t);
			OaActivator.getOperationLogService().logOP("编辑id为【"+t.getId()+"】的车辆维修单");
			return Result.success(R.CarFix.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),CarFix.class)));
		} catch (Exception e) {
			return Result.failure(R.CarFix.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<CarFix> getBeanById(Serializable id) {
		try {
			return Result.value(carFixDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.CarFix.LOAD_FAILURE);
		}
	}

	@Override
	public Result<CarFix> getBeanByFilter(Filter filter) {
		try {
			return Result.value(carFixDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.CarFix.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<CarFix>> getList() {
		try {
			return Result.value(carFixDao.getList());
		} catch (Exception e) {
			return Result.failure(R.CarFix.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<CarFix>> getListByFilter(Filter filter) {
		try {
			return Result.value(carFixDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.CarFix.LOAD_FAILURE);
		}
	}
}
