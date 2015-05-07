package com.wiiy.pb.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.ModulePrefixNamingStrategy;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.pb.dao.SelfLabelRecordDao;
import com.wiiy.pb.entity.Building;
import com.wiiy.pb.entity.Meter;
import com.wiiy.pb.entity.MeterLabelRecord;
import com.wiiy.pb.entity.Room;
import com.wiiy.pb.entity.SelfLabelRecord;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.preferences.enums.MeterTypeEnum;
import com.wiiy.pb.service.SelfLabelRecordService;

public class SelfLabelRecordServiceImpl implements SelfLabelRecordService{
	private SelfLabelRecordDao selfLabelRecordDao;
	public void setSelfLabelRecordDao(SelfLabelRecordDao selfLabelRecordDao) {
		this.selfLabelRecordDao = selfLabelRecordDao;
	}

	@Override
	public Result<SelfLabelRecord> save(SelfLabelRecord t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			selfLabelRecordDao.save(t);
			return Result.success(R.SelfLabelRecord.SAVE_SUCCESS, t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),SelfLabelRecord.class)));
		} catch (Exception e) {
			return Result.failure(R.SelfLabelRecord.SAVE_FAILURE);
		}
	}

	@Override
	public Result<SelfLabelRecord> update(SelfLabelRecord t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			selfLabelRecordDao.update(t);
			return Result.success(R.SelfLabelRecord.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),SelfLabelRecord.class)));
		} catch (Exception e) {
			return Result.failure(R.SelfLabelRecord.UPDATE_FAILURE);
		}
	}
	
	@Override
	public Result<SelfLabelRecord> delete(SelfLabelRecord t) {
		try {
			selfLabelRecordDao.delete(t);
			return Result.success(R.SelfLabelRecord.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SelfLabelRecord.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SelfLabelRecord> deleteById(Serializable id) {
		try {
			selfLabelRecordDao.deleteById(id);
			return Result.success(R.SelfLabelRecord.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SelfLabelRecord.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SelfLabelRecord> deleteByIds(String ids) {
		try {
			selfLabelRecordDao.deleteByIds(ids);
			return Result.success(R.SelfLabelRecord.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.SelfLabelRecord.DELETE_FAILURE);
		}
	}

	@Override
	public Result<SelfLabelRecord> getBeanByFilter(Filter filter) {
		try {
			return Result.value(selfLabelRecordDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.SelfLabelRecord.LOAD_FAILURE);
		}
	}

	@Override
	public Result<SelfLabelRecord> getBeanById(Serializable id) {
		try {
			return Result.value(selfLabelRecordDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.SelfLabelRecord.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SelfLabelRecord>> getList() {
		try {
			return Result.value(selfLabelRecordDao.getList());
		} catch (Exception e) {
			return Result.failure(R.SelfLabelRecord.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<SelfLabelRecord>> getListByFilter(Filter filter) {
		try {
			return Result.value(selfLabelRecordDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.SelfLabelRecord.LOAD_FAILURE);
		}
	}

	@Override
	public Result addMeter(Long labelId, List<String> existList, List<String> newList) {
		Session session = null;
		Transaction tr = null;
		try{
			session = selfLabelRecordDao.openSession();
			tr = session.beginTransaction();
			String sql = "";
			String addIds = "";
			String delIds = "";
			for (String id : newList) {
				if(!existList.contains(id)){
					addIds += id + ",";
				}
			}
			if(addIds.endsWith(",")){
				addIds = addIds.substring(0,addIds.length()-1);
			}
			
			for(String oldId : existList){
				if(!newList.contains(oldId)){
					delIds += oldId+",";
				}
			}
			if(delIds.endsWith(",")){
				delIds = delIds.substring(0,delIds.length()-1);
			}
			
			
			
			if(addIds.length()>0){
			sql = "SELECT m.id, m.pre_reading, m.reading_date,m.room_ids,m.orderNo,m.type,m.meter_factor,m.building_id,m.park_id  FROM "+ModulePrefixNamingStrategy.classToTableName(Meter.class)+" m " +
					"WHERE m.id in ("+addIds+")" +
					"GROUP BY m.id, m.pre_reading, m.reading_date,m.room_ids,m.orderNo,m.type,m.meter_factor,m.building_id,m.park_id ";
			List<Object> list = new ArrayList<Object>();
			list = selfLabelRecordDao.getObjectListBySql(sql);
			for (Object object : list) {
				Object[] objects = (Object[])object;
				Long meterId =  Long.parseLong(String.valueOf(objects[0]));
				Double preReading = null;
				if(String.valueOf(objects[1])!="null"){
					 preReading = Double.parseDouble(String.valueOf(objects[1]));
				}
				Date readingDate = DateUtil.parse(String.valueOf(objects[2]));
				String roomIds = String.valueOf(objects[3]);
				String orderNo = String.valueOf(objects[4]);
				MeterTypeEnum type = MeterTypeEnum.valueOf(String.valueOf(objects[5]));
				Integer meterFactor = Integer.parseInt(String.valueOf(objects[6]));
				SelfLabelRecord mlr = new SelfLabelRecord();
				mlr.setLabelId(labelId);
				mlr.setMeterId(meterId);
				mlr.setPreReading(preReading);
				mlr.setPreDate(readingDate);
				mlr.setMeterOrderNo(orderNo);
				mlr.setMeterType(type);
				mlr.setMeterFactor(meterFactor);
				mlr.setCurDate(new Date());
				
				Meter meter = (Meter) session.get(Meter.class, meterId);
				meter.setReadingDate(new Date());
				session.merge(meter);
				
				String bId = String.valueOf(objects[7]);
				if(bId!="null"){
					Long buildingId = Long.parseLong(String.valueOf(objects[7]));
					if(buildingId!=null){
						Building building = (Building)session.load(Building.class, buildingId);
						mlr.setBuildingId(buildingId);
						mlr.setBuildingName(building.getPark().getName()+"-"+building.getName());
					}
				}
				mlr.setCreateTime(new Date());
				mlr.setCreator(PbActivator.getSessionUser().getRealName());
				mlr.setCreatorId(PbActivator.getSessionUser().getId());
				mlr.setModifyTime(mlr.getCreateTime());
				mlr.setModifier(mlr.getCreator());
				mlr.setModifierId(mlr.getCreatorId());
				mlr.setEntityStatus(EntityStatus.NORMAL);
				session.save(mlr);
			}
			}
			if(delIds.length()>0){
				sql = "DELETE FROM "+ModulePrefixNamingStrategy.classToTableName(SelfLabelRecord.class)+
						" WHERE meter_id in ("+delIds+")";
						session.createSQLQuery(sql).executeUpdate();
			}
			tr.commit();
			return Result.success("操作成功");
		}catch (Exception e) {
			tr.rollback();
			return Result.failure("操作失败");
		}finally{
			session.close();
		}
	}


}
