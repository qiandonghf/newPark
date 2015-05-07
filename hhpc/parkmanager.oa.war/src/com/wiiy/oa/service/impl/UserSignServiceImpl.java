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
import com.wiiy.oa.dao.UserSignDao;
import com.wiiy.oa.entity.UserSign;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.service.UserSignService;

public class UserSignServiceImpl implements UserSignService{
	private UserSignDao userSignDao;
	public void setUserSignDao(UserSignDao userSignDao) {
		this.userSignDao = userSignDao;
	}

	@Override
	public Result<UserSign> save(UserSign t) {
		try{
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			userSignDao.save(t);
			OaActivator.getOperationLogService().logOP("添加员工为【"+OaActivator.getSessionUser().getRealName()+"】考勤信息");
			return Result.success(R.UserSign.SAVE_SUCCESS,t);
		}catch(UKConstraintException e){
			e.printStackTrace();
			return Result.failure(R.getFKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(), UserSign.class)));
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.UserSign.SAVE_FAILURE);
		}
	}

	@Override
	public Result<UserSign> update(UserSign t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			userSignDao.update(t);
			OaActivator.getOperationLogService().logOP("编辑id为【"+t.getId()+"】的考勤信息");
			return Result.success(R.UserSign.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),UserSign.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.UserSign.UPDATE_FAILURE);
		}
	}
	
	@Override
	public Result<UserSign> delete(UserSign t) {
		try{
			userSignDao.delete(t);
			OaActivator.getOperationLogService().logOP("删除id为【"+t.getId()+"】的考勤信息");
			return Result.success(R.UserSign.DELETE_SUCCESS);
		}catch(FKConstraintException e){
			e.printStackTrace();
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.UserSign.DELETE_FAILURE);
		}
	}

	@Override
	public Result<UserSign> deleteById(Serializable id) {
		try{
			userSignDao.deleteById(id);
			OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的考勤信息");
			return Result.success(R.UserSign.DELETE_SUCCESS);
		}catch(FKConstraintException e){
			e.printStackTrace();
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.UserSign.DELETE_FAILURE);
		}
	}

	@Override
	public Result<UserSign> deleteByIds(String ids) {
		try{
			userSignDao.deleteByIds(ids);
			for(String id:ids.split(",")){
				OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的考勤信息");
			}			
			return Result.success(R.UserSign.DELETE_SUCCESS);
		}catch(FKConstraintException e){
			e.printStackTrace();
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.UserSign.DELETE_FAILURE);
		}
	}

	@Override
	public Result<UserSign> getBeanByFilter(Filter filter) {
		try{
			return Result.value(userSignDao.getBeanByFilter(filter));
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.UserSign.LOAD_FAILURE);
		}
	}

	@Override
	public Result<UserSign> getBeanById(Serializable id) {
		try{
			return Result.value(userSignDao.getBeanById(id));
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.UserSign.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<UserSign>> getList() {
		try{
			return Result.value(userSignDao.getList());
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.UserSign.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<UserSign>> getListByFilter(Filter filter) {
		try{
			return Result.value(userSignDao.getListByFilter(filter));
		}catch(Exception e){
			e.printStackTrace();
			return Result.failure(R.UserSign.LOAD_FAILURE);
		}
	}
}
