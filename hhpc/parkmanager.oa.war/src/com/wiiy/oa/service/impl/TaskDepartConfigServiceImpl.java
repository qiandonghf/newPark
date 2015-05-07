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
import com.wiiy.oa.entity.TaskDepartConfig;
import com.wiiy.oa.dao.TaskDepartConfigDao;
import com.wiiy.oa.service.TaskDepartConfigService;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.activator.OaActivator;

/**
 * @author my
 */
public class TaskDepartConfigServiceImpl implements TaskDepartConfigService{
	
	private TaskDepartConfigDao taskDepartConfigDao;
	
	public void setTaskDepartConfigDao(TaskDepartConfigDao taskDepartConfigDao) {
		this.taskDepartConfigDao = taskDepartConfigDao;
	}

	@Override
	public Result<TaskDepartConfig> save(TaskDepartConfig t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			taskDepartConfigDao.save(t);
			return Result.success(R.TaskDepartConfig.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),TaskDepartConfig.class)));
		} catch (Exception e) {
			return Result.failure(R.TaskDepartConfig.SAVE_FAILURE);
		}
	}

	@Override
	public Result<TaskDepartConfig> delete(TaskDepartConfig t) {
		try {
			taskDepartConfigDao.delete(t);
			return Result.success(R.TaskDepartConfig.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.TaskDepartConfig.DELETE_FAILURE);
		}
	}

	@Override
	public Result<TaskDepartConfig> deleteById(Serializable id) {
		try {
			taskDepartConfigDao.deleteById(id);
			return Result.success(R.TaskDepartConfig.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.TaskDepartConfig.DELETE_FAILURE);
		}
	}

	@Override
	public Result<TaskDepartConfig> deleteByIds(String ids) {
		try {
			taskDepartConfigDao.deleteByIds(ids);
			return Result.success(R.TaskDepartConfig.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.TaskDepartConfig.DELETE_FAILURE);
		}
	}

	@Override
	public Result<TaskDepartConfig> update(TaskDepartConfig t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			taskDepartConfigDao.update(t);
			return Result.success(R.TaskDepartConfig.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),TaskDepartConfig.class)));
		} catch (Exception e) {
			return Result.failure(R.TaskDepartConfig.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<TaskDepartConfig> getBeanById(Serializable id) {
		try {
			return Result.value(taskDepartConfigDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.TaskDepartConfig.LOAD_FAILURE);
		}
	}

	@Override
	public Result<TaskDepartConfig> getBeanByFilter(Filter filter) {
		try {
			return Result.value(taskDepartConfigDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.TaskDepartConfig.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<TaskDepartConfig>> getList() {
		try {
			return Result.value(taskDepartConfigDao.getList());
		} catch (Exception e) {
			return Result.failure(R.TaskDepartConfig.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<TaskDepartConfig>> getListByFilter(Filter filter) {
		try {
			return Result.value(taskDepartConfigDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.TaskDepartConfig.LOAD_FAILURE);
		}
	}

}
