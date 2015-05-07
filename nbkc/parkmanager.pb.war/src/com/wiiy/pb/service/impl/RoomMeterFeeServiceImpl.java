package com.wiiy.pb.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.pb.dao.RoomMeterFeeDao;
import com.wiiy.pb.entity.Meter;
import com.wiiy.pb.entity.RoomMeterFee;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.service.MeterService;
import com.wiiy.pb.service.RoomMeterFeeService;

/**
 * @author my
 */
public class RoomMeterFeeServiceImpl implements RoomMeterFeeService{
	
	private RoomMeterFeeDao roomMeterFeeDao;
	
	private MeterService meterService;
	
	public void setMeterService(MeterService meterService) {
		this.meterService = meterService;
	}
	
	public void setRoomMeterFeeDao(RoomMeterFeeDao roomMeterFeeDao) {
		this.roomMeterFeeDao = roomMeterFeeDao;
	}

	@Override
	public Result<RoomMeterFee> save(RoomMeterFee t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = roomMeterFeeDao.openSession();
			tr = session.beginTransaction();
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			session.save(t);
			Meter meter = meterService.getBeanById(t.getMeterId()).getValue();
			meter.setRoomIds(meter.getRoomIds()+t.getRoomId()+",");
			session.update(meter);
			tr.commit();
			return Result.success(R.RoomMeterFee.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),RoomMeterFee.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.RoomMeterFee.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<RoomMeterFee> delete(RoomMeterFee t) {
		try {
			roomMeterFeeDao.delete(t);
			return Result.success(R.RoomMeterFee.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.RoomMeterFee.DELETE_FAILURE);
		}
	}

	@Override
	public Result<RoomMeterFee> deleteById(Serializable id) {
		Session session = null;
		Transaction tr = null;
		try {
			session = roomMeterFeeDao.openSession();
			tr = session.beginTransaction();
			RoomMeterFee t = getBeanById(id).getValue();
			session.delete(t);
			Meter meter = meterService.getBeanById(t.getMeterId()).getValue();
			meter.setRoomIds(",");
			session.update(meter);
			tr.commit();
			return Result.success(R.RoomMeterFee.DELETE_SUCCESS);
		}catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.RoomMeterFee.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<RoomMeterFee> deleteByIds(String ids) {
		try {
			roomMeterFeeDao.deleteByIds(ids);
			return Result.success(R.RoomMeterFee.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.RoomMeterFee.DELETE_FAILURE);
		}
	}

	@Override
	public Result<RoomMeterFee> update(RoomMeterFee t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			roomMeterFeeDao.update(t);
			return Result.success(R.RoomMeterFee.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),RoomMeterFee.class)));
		} catch (Exception e) {
			return Result.failure(R.RoomMeterFee.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<RoomMeterFee> getBeanById(Serializable id) {
		try {
			return Result.value(roomMeterFeeDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.RoomMeterFee.LOAD_FAILURE);
		}
	}

	@Override
	public Result<RoomMeterFee> getBeanByFilter(Filter filter) {
		try {
			return Result.value(roomMeterFeeDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.RoomMeterFee.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<RoomMeterFee>> getList() {
		try {
			return Result.value(roomMeterFeeDao.getList());
		} catch (Exception e) {
			return Result.failure(R.RoomMeterFee.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<RoomMeterFee>> getListByFilter(Filter filter) {
		try {
			return Result.value(roomMeterFeeDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.RoomMeterFee.LOAD_FAILURE);
		}
	}

}
