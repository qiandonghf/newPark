package com.wiiy.oa.service.impl;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dao.WorkScheduleDao;
import com.wiiy.oa.entity.WorkSchedule;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.service.WorkScheduleService;

public class WorkScheduleServiceImpl implements WorkScheduleService{
	private WorkScheduleDao workScheduleDao;
	public void setWorkScheduleDao(WorkScheduleDao workScheduleDao) {
		this.workScheduleDao = workScheduleDao;
	}

	@Override
	public Result<WorkSchedule> save(WorkSchedule t) {
		Session session = null;
		Transaction tr = null;
		try{
			session = workScheduleDao.openSession();
			tr = session.beginTransaction();
			List<WorkSchedule> workSchedules = getListByFilter(new Filter(WorkSchedule.class).eq("name", t.getName())).getValue();
			if(workSchedules!=null&&workSchedules.size()>0){
				return Result.failure("班制名称已存在，请换个名称");
			}
			if(t.getIsDefault().equals(BooleanEnum.YES)){//缺省值等于"是"的，只能有一个，所以在新建时候要将表中的缺省字段进行修改
				WorkSchedule workSchedule = new WorkSchedule();
				workSchedule = getBeanByFilter(new Filter(WorkSchedule.class).eq("isDefault",BooleanEnum.YES)).getValue();
				if(workSchedule!=null){
					workSchedule.setIsDefault(BooleanEnum.NO);
					session.update(workSchedule);
				}
			}
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			workScheduleDao.save(t);
			OaActivator.getOperationLogService().logOP("添加班制【"+t.getName()+"】");
			tr.commit();
			return Result.success(R.WorkSchedule.SAVE_SUCCESS,t);
		}catch(UKConstraintException e){
			e.printStackTrace();
			return Result.failure(R.getFKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(), WorkSchedule.class)));
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.WorkSchedule.SAVE_FAILURE);
		}finally{
			session.close();
		}
	}

	@Override
	public Result<WorkSchedule> update(WorkSchedule t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = workScheduleDao.openSession();
			tr = session.beginTransaction();
			List<WorkSchedule> workSchedules = getListByFilter(new Filter(WorkSchedule.class).eq("name", t.getName()).ne("id", t.getId())).getValue();
			if(workSchedules!=null&&workSchedules.size()>0){
				return Result.failure("班制名称已存在，请换个名称");
			}
			if(t.getIsDefault().equals(BooleanEnum.YES)){//缺省值等于"是"的，只能有一个，所以在更新时候要将表中的缺省字段进行修改
				WorkSchedule workSchedule = new WorkSchedule();
				workSchedule = getBeanByFilter(new Filter(WorkSchedule.class).eq("isDefault",BooleanEnum.YES).ne("id", t.getId())).getValue();
				if(workSchedule!=null){
					workSchedule.setIsDefault(BooleanEnum.NO);
					session.update(workSchedule);
				}
			}
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			workScheduleDao.update(t);
			OaActivator.getOperationLogService().logOP("更新班制【"+t.getName()+"】");
			tr.commit();
			return Result.success(R.WorkSchedule.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),WorkSchedule.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.WorkSchedule.UPDATE_FAILURE);
		}finally{
			session.close();
		}
	}
	
	@Override
	public Result<WorkSchedule> delete(WorkSchedule t) {
		try{
			workScheduleDao.delete(t);
			OaActivator.getOperationLogService().logOP("删除班制【"+t.getName()+"】");
			return Result.success(R.WorkSchedule.DELETE_SUCCESS);
		}catch(FKConstraintException e){
			e.printStackTrace();
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.WorkSchedule.DELETE_FAILURE);
		}
	}

	@Override
	public Result<WorkSchedule> deleteById(Serializable id) {
		try{
			workScheduleDao.deleteById(id);
			OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的班制");
			return Result.success(R.WorkSchedule.DELETE_SUCCESS);
		}catch(FKConstraintException e){
			e.printStackTrace();
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.WorkSchedule.DELETE_FAILURE);
		}
	}

	@Override
	public Result<WorkSchedule> deleteByIds(String ids) {
		try{
			workScheduleDao.deleteByIds(ids);
			for(String id:ids.split(",")){
				OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的班制");
			}			
			return Result.success(R.WorkSchedule.DELETE_SUCCESS);
		}catch(FKConstraintException e){
			e.printStackTrace();
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.WorkSchedule.DELETE_FAILURE);
		}
	}

	@Override
	public Result<WorkSchedule> getBeanByFilter(Filter filter) {
		try{
			return Result.value(workScheduleDao.getBeanByFilter(filter));
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.WorkSchedule.LOAD_FAILURE);
		}
	}

	@Override
	public Result<WorkSchedule> getBeanById(Serializable id) {
		try{
			return Result.value(workScheduleDao.getBeanById(id));
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.WorkSchedule.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<WorkSchedule>> getList() {
		try{
			return Result.value(workScheduleDao.getList());
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.WorkSchedule.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<WorkSchedule>> getListByFilter(Filter filter) {
		try{
			return Result.value(workScheduleDao.getListByFilter(filter));
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.WorkSchedule.LOAD_FAILURE);
		}
	}

}
