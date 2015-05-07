package com.wiiy.oa.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
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
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dao.TaskProjectDao;
import com.wiiy.oa.entity.TaskProject;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.service.TaskProjectService;

public class TaskProjectServiceImpl implements TaskProjectService{
	private TaskProjectDao taskProjectDao;
	@Override
	public Result<TaskProject> delete(TaskProject t) {
		try{
			taskProjectDao.delete(t);
			OaActivator.getOperationLogService().logOP("删除任务项目【"+t.getName()+"】");
			return Result.success(R.TaskProject.DELETE_SUCCESS);
		}catch(FKConstraintException e){
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		}catch(Exception e){
			return Result.failure(R.TaskProject.DELETE_FAILURE);
		}
	}

	@Override
	public Result<TaskProject> deleteById(Serializable id) {
		try{
			taskProjectDao.deleteById(id);
			OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的任务项目");
			return Result.success(R.TaskProject.DELETE_SUCCESS);
		}catch(FKConstraintException e){
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		}catch(Exception e){
			return Result.failure(R.TaskProject.DELETE_FAILURE);
		}
	}

	@Override
	public Result<TaskProject> deleteByIds(String ids) {
		try{
			taskProjectDao.deleteByIds(ids);
			for(String id:ids.split(",")){
				OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的任务项目");
			}			
			return Result.success(R.TaskProject.DELETE_SUCCESS);
		}catch(FKConstraintException e){
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		}catch(Exception e){
			return Result.failure(R.TaskProject.DELETE_FAILURE);
		}
	}

	@Override
	public Result<TaskProject> getBeanByFilter(Filter filter) {
		try{
			return Result.value(taskProjectDao.getBeanByFilter(filter));
		}catch(Exception e){
			return Result.failure(R.TaskProject.LOAD_FAILURE);
		}
	}

	@Override
	public Result<TaskProject> getBeanById(Serializable id) {
		try{
			return Result.value(taskProjectDao.getBeanById(id));
		}catch(Exception e){
			return Result.failure(R.TaskProject.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<TaskProject>> getList() {
		try{
			return Result.value(taskProjectDao.getList());
		}catch(Exception e){
			return Result.failure(R.TaskProject.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<TaskProject>> getListByFilter(Filter filter) {
		try{
			return Result.value(taskProjectDao.getListByFilter(filter));
		}catch(Exception e){
			return Result.failure(R.TaskProject.LOAD_FAILURE);
		}
	}

	@Override
	public Result<TaskProject> save(TaskProject t) {
		Session session = null;
		Transaction tr = null;
		//将新建的项目名称进行处理，方便与表中的对应字段进行比较
		String taskProjectName = t.getName().trim();
		try{
			session = taskProjectDao.openSession();
			tr = session.beginTransaction();
			//先将表中数据取出，判断与输入的名称是否重名
			List<TaskProject> taskProjectList = new ArrayList<TaskProject>();
			taskProjectList = session.createQuery("from TaskProject").list();
			for (TaskProject taskProject : taskProjectList) {
				if(taskProjectName.equals(taskProject.getName())){
					return Result.failure("该项目名称已存在，请重新输入");
				}
			}
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			taskProjectDao.save(t);
			tr.commit();
			OaActivator.getOperationLogService().logOP("添加任务项目【"+taskProjectName+"】");
			return Result.success(R.TaskProject.SAVE_SUCCESS,t);
		}catch(UKConstraintException e){
			return Result.failure(R.getFKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(), TaskProject.class)));
		}catch(Exception e){
			return Result.failure(R.TaskProject.SAVE_FAILURE);
		}finally{
			session.close();
		}
	}

	@Override
	public Result<TaskProject> update(TaskProject t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			taskProjectDao.update(t);
			OaActivator.getOperationLogService().logOP("修改id为【"+t.getId()+"】的任务项目信息");
			return Result.success(R.TaskDepart.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),TaskProject.class)));
		} catch (Exception e) {
			return Result.failure(R.TaskProject.UPDATE_FAILURE);
		}
	}

	public void setTaskProjectDao(TaskProjectDao taskProjectDao) {
		this.taskProjectDao = taskProjectDao;
	}

	public TaskProjectDao getTaskProjectDao() {
		return taskProjectDao;
	}

}
