package com.wiiy.oa.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.entity.Org;
import com.wiiy.core.external.service.OrgPubService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dao.TaskDepartDao;
import com.wiiy.oa.entity.TaskDepart;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.service.TaskDepartService;

public class TaskDepartServiceImpl implements TaskDepartService{
	private TaskDepartDao taskDepartDao;
	
	public void setTaskDepartDao(TaskDepartDao taskDepartDao) {
		this.taskDepartDao = taskDepartDao;
	}
	
	@Override
	public Result<TaskDepart> delete(TaskDepart t) {
		try{
			taskDepartDao.delete(t);
			OaActivator.getOperationLogService().logOP("删除任务部门【"+t.getName()+"】");
			return Result.success(R.TaskDepart.DELETE_SUCCESS);
		}catch(FKConstraintException e){
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		}catch(Exception e){
			return Result.failure(R.TaskDepart.DELETE_FAILURE);
		}
	}

	@Override
	public Result<TaskDepart> deleteById(Serializable id) {
		try {
			taskDepartDao.deleteById(id);
			OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的任务部门");
			return Result.success(R.TaskDepart.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.TaskDepart.DELETE_FAILURE);
		}
	}

	@Override
	public Result<TaskDepart> deleteByIds(String ids) {
		try {
			taskDepartDao.deleteByIds(ids);
			for(String id : ids.split(",")){
				OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的任务部门");
			}
			return Result.success(R.TaskDepart.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.TaskDepart.DELETE_FAILURE);
		}
	}

	@Override
	public Result<TaskDepart> getBeanByFilter(Filter filter) {
		try {
			return Result.value(taskDepartDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.TaskDepart.LOAD_FAILURE);
		}
	}

	@Override
	public Result<TaskDepart> getBeanById(Serializable id) {
		try {
			return Result.value(taskDepartDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.TaskDepart.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<TaskDepart>> getList() {
		try {
			return Result.value(taskDepartDao.getList());
		} catch (Exception e) {
			return Result.failure(R.TaskDepart.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<TaskDepart>> getListByFilter(Filter filter) {
		try {
			return Result.value(taskDepartDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.TaskDepart.LOAD_FAILURE);
		}
	}

	@Override
	public Result<TaskDepart> save(TaskDepart t) {
		Session session = null;
		Transaction tr = null;
		//将新建的部门名称进行处理，方便与表中的对应字段进行比较
		String taskDepartName = t.getName().trim();
		try{
			session = taskDepartDao.openSession();
			tr = session.beginTransaction();
			//将数据取出，判断是否重名
			List<TaskDepart> taskDepartList = new ArrayList<TaskDepart>();
			taskDepartList = session.createQuery("from TaskDepart").list();
			for (TaskDepart taskDepart : taskDepartList) {
				if(taskDepartName.equals(taskDepart.getName())){
					return Result.failure("该部门名称已存在，请重新输入");
				}
			}
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			taskDepartDao.save(t);
			tr.commit();
			OaActivator.getOperationLogService().logOP("添加任务部门【"+taskDepartName+"】");
			return Result.success(R.TaskDepart.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),TaskDepart.class)));
		} catch (Exception e) {
			return Result.failure(R.TaskDepart.SAVE_FAILURE);
		}finally{
			session.close();
		}
	}

	@Override
	public Result<TaskDepart> update(TaskDepart t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			taskDepartDao.update(t);
			OaActivator.getOperationLogService().logOP("修改id为【"+t.getId()+"】的任务部门信息");
			return Result.success(R.TaskDepart.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),TaskDepart.class)));
		} catch (Exception e) {
			return Result.failure(R.TaskDepart.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<TaskDepart> relatedDepartments(Long id, Long orgId) {
		try {
			List<TaskDepart> list = getListByFilter(new Filter(TaskDepart.class).eq("orgId", orgId)).getValue();
			if(list!=null && list.size()>0){
				return Result.failure("此部门已被关联,请重新选择");
			}
			TaskDepart t = getBeanById(id).getValue();
			OrgPubService orgPubService = OaActivator.getService(OrgPubService.class);
			Org org = orgPubService.getOrgById(orgId);
			t.setOrg(org);
			t.setOrgId(orgId);
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			taskDepartDao.update(t);
			return Result.success("部门关联成功");
		} catch (Exception e) {
			return Result.failure("部门关联失败");
		}
	}
	
}