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
import com.wiiy.oa.dao.CarDao;
import com.wiiy.oa.entity.Car;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.service.CarService;

public class CarServiceImpl implements CarService{
	private CarDao carDao;
	public void setCarDao(CarDao carDao) {
		this.carDao = carDao;
	}

	@Override
	public Result<Car> save(Car t) {
		try {
			List<Car> carList = getListByFilter(new Filter(Car.class).eq("licenseNo", t.getLicenseNo())).getValue();
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
			carDao.save(t);
			OaActivator.getOperationLogService().logOP("添加车牌号为【"+t.getLicenseNo()+"】的车辆");
			return Result.success(R.Car.SAVE_SUCCESS, t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Car.class)));
		} catch (Exception e) {
			return Result.failure(R.Car.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Car> delete(Car t) {
		try {
			carDao.delete(t);
			OaActivator.getOperationLogService().logOP("删除id为【"+t.getId()+"】的车辆");
			return Result.success(R.Car.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Car.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Car> deleteById(Serializable id) {
		try {
			OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的车辆");
			carDao.deleteById(id);
			return Result.success(R.Car.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Car.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Car> deleteByIds(String ids) {
		try {
			for(String id : ids.split(",")){
				OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的车辆");
			}
			carDao.deleteByIds(ids);
			return Result.success(R.Car.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Car.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Car> update(Car t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			carDao.update(t);
			OaActivator.getOperationLogService().logOP("编辑id为【"+t.getId()+"】的车辆");
			return Result.success(R.Car.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Car.class)));
		} catch (Exception e) {
			return Result.failure(R.Car.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Car> getBeanById(Serializable id) {
		try {
			return Result.value(carDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Car.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Car> getBeanByFilter(Filter filter) {
		try {
			return Result.value(carDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Car.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Car>> getList() {
		try {
			return Result.value(carDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Car.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Car>> getListByFilter(Filter filter) {
		try {
			return Result.value(carDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Car.LOAD_FAILURE);
		}
	}
}
