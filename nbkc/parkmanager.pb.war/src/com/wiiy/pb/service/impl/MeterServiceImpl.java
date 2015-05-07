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
import com.wiiy.pb.dao.MeterDao;
import com.wiiy.pb.entity.Meter;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.service.MeterService;

public class MeterServiceImpl implements MeterService {
	private MeterDao meterDao;
	private int level = 0;
	public void setMeterDao(MeterDao meterDao) {
		this.meterDao = meterDao;
	}

	@Override
	public Result<Meter> save(Meter t) {
		try {
			List<Meter> list = getListByFilter(new Filter(Meter.class).eq("orderNo", t.getOrderNo())).getValue();
			if(list.size()>0 && list!=null){
				return Result.failure("编号已存在");
			}
			if(t.getParentId()!=null){
				Meter meter = getBeanById(t.getParentId()).getValue();
				t.setLevel(meter.getLevel()+1);
			}else{
				t.setLevel(level);
			}
			t.setRoomIds(",");
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			meterDao.save(t);
			PbActivator.getOperationLogService().logOP("添加id为【"+t.getId()+"】的水电表");
			return Result.success(R.Meter.SAVE_SUCCESS, t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Meter.class)));
		} catch (Exception e) {
			return Result.failure(R.Meter.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Meter> updateMeter(Meter t,Boolean change) {
		Session session = null;
		Transaction tr = null;
		try {
			session = meterDao.openSession();
			tr = session.beginTransaction();
			if(change==true){
				List<Meter> list = meterDao.getListByFilter(new Filter(Meter.class).eq("parentId",t.getId()));
				if(list!=null && list.size()>0){
					for(Meter m : list){
						m.setParentNo(t.getOrderNo());
						session.merge(m);
					}
				}
			}
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			session.merge(t);
			
			tr.commit();
			return Result.success(R.Meter.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Meter.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Meter.UPDATE_FAILURE);
		}finally{
			session.close();
		}
	}
	
	@Override
	public Result<Meter> delete(Meter t) {
		try {
			meterDao.delete(t);
			PbActivator.getOperationLogService().logOP("删除id为【"+t.getId()+"】的水电表");
			return Result.success(R.Meter.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Meter.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Meter> deleteById(Serializable id) {
		try {
			PbActivator.getOperationLogService().logOP("删除id为【"+id+"】的水电表");
			meterDao.deleteById(id);
			return Result.success(R.Meter.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Meter.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Meter> deleteByIds(String ids) {
		try {
			for(String id : ids.split(",")){
				PbActivator.getOperationLogService().logOP("删除id为【"+id+"】的水电表");
			}
			meterDao.deleteByIds(ids);
			return Result.success(R.Meter.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Meter.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Meter> getBeanByFilter(Filter filter) {
		try {
			return Result.value(meterDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Meter.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Meter> getBeanById(Serializable id) {
		try {
			return Result.value(meterDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Meter.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Meter>> getList() {
		try {
			return Result.value(meterDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Meter.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Meter>> getListByFilter(Filter filter) {
		try {
			return Result.value(meterDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Meter.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Meter> update(Meter t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = meterDao.openSession();
			tr = session.beginTransaction();
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			session.merge(t);
			tr.commit();
			return Result.success(R.Meter.UPDATE_SUCCESS);
		}catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Meter.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.Meter.UPDATE_FAILURE);
		}finally{
			session.close();
		}
	}

}
