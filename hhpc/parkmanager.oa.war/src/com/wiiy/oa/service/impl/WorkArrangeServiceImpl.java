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
import com.wiiy.oa.dao.WorkArrangeDao;
import com.wiiy.oa.entity.WorkArrange;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.service.WorkArrangeService;

public class WorkArrangeServiceImpl implements WorkArrangeService{
	private WorkArrangeDao workArrangeDao;
	public void setWorkArrangeDao(WorkArrangeDao workArrangeDao) {
		this.workArrangeDao = workArrangeDao;
	}

	@Override
	public Result<WorkArrange> save(WorkArrange t) {
		try{
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			workArrangeDao.save(t);
			OaActivator.getOperationLogService().logOP("新建id为【"+t.getId()+"】的排班");
			return Result.success(R.WorkArrange.SAVE_SUCCESS,t);
		}catch(UKConstraintException e){
			e.printStackTrace();
			return Result.failure(R.getFKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(), WorkArrange.class)));
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.WorkArrange.SAVE_FAILURE);
		}
	}

	@Override
	public Result<WorkArrange> update(WorkArrange t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			workArrangeDao.update(t);
			OaActivator.getOperationLogService().logOP("更新id为【"+t.getId()+"】的排班");
			return Result.success(R.WorkArrange.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),WorkArrange.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.WorkArrange.UPDATE_FAILURE);
		}
	}
	
	@Override
	public Result<WorkArrange> delete(WorkArrange t) {
		try{
			workArrangeDao.delete(t);
			OaActivator.getOperationLogService().logOP("删除id为【"+t.getId()+"】的排班");
			return Result.success(R.WorkArrange.DELETE_SUCCESS);
		}catch(FKConstraintException e){
			e.printStackTrace();
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.WorkArrange.DELETE_FAILURE);
		}
	}

	@Override
	public Result<WorkArrange> deleteById(Serializable id) {
		try{
			workArrangeDao.deleteById(id);
			OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的排班");
			return Result.success(R.WorkArrange.DELETE_SUCCESS);
		}catch(FKConstraintException e){
			e.printStackTrace();
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.WorkArrange.DELETE_FAILURE);
		}
	}

	@Override
	public Result<WorkArrange> deleteByIds(String ids) {
		try{
			workArrangeDao.deleteByIds(ids);
			for(String id:ids.split(",")){
				OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的排班");
			}			
			return Result.success(R.WorkArrange.DELETE_SUCCESS);
		}catch(FKConstraintException e){
			e.printStackTrace();
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.WorkArrange.DELETE_FAILURE);
		}
	}

	@Override
	public Result<WorkArrange> getBeanByFilter(Filter filter) {
		try{
			return Result.value(workArrangeDao.getBeanByFilter(filter));
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.WorkArrange.LOAD_FAILURE);
		}
	}

	@Override
	public Result<WorkArrange> getBeanById(Serializable id) {
		try{
			return Result.value(workArrangeDao.getBeanById(id));
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.WorkArrange.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<WorkArrange>> getList() {
		try{
			return Result.value(workArrangeDao.getList());
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.WorkArrange.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<WorkArrange>> getListByFilter(Filter filter) {
		try{
			return Result.value(workArrangeDao.getListByFilter(filter));
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.WorkArrange.LOAD_FAILURE);
		}
	}

}
