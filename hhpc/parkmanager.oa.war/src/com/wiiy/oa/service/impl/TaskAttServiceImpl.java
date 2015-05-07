package com.wiiy.oa.service.impl;


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
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dao.TaskAttDao;
import com.wiiy.oa.entity.TaskAtt;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.service.TaskAttService;

/**
 * @author my
 */
public class TaskAttServiceImpl implements TaskAttService{
	
	private TaskAttDao taskAttDao;
	
	public void setTaskAttDao(TaskAttDao taskAttDao) {
		this.taskAttDao = taskAttDao;
	}

	@Override
	public Result<TaskAtt> save(TaskAtt t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			taskAttDao.save(t);
			return Result.success(R.TaskAtt.SAVE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),TaskAtt.class)));
		} catch (Exception e) {
			return Result.failure(R.TaskAtt.SAVE_FAILURE);
		}
	}

	@Override
	public Result<TaskAtt> delete(TaskAtt t) {
		try {
			taskAttDao.delete(t);
			return Result.success(R.TaskAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.TaskAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<TaskAtt> deleteById(Serializable id) {
		try {
			TaskAtt taskAtt = getBeanById(id).getValue();
			String path = taskAtt.getNewName();
			OaActivator.getResourcesService().delete(path);
			taskAttDao.deleteById(id);
			return Result.success(R.TaskAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.TaskAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<TaskAtt> deleteByIds(String ids) {
		Session session = null;
		Transaction tr = null;
		try {
			session = taskAttDao.openSession();
			tr = session.beginTransaction();
			List<TaskAtt> list = session.createQuery(
					"from TaskAtt where id in (" + ids+")").list();
			for (TaskAtt taskAtt : list) {
				String path = taskAtt.getNewName();
				OaActivator.getResourcesService().delete(path);
				session.delete(taskAtt);
			}
			tr.commit();
			return Result.success(R.TaskAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			tr.rollback();
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.TaskAtt.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<TaskAtt> update(TaskAtt t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			taskAttDao.update(t);
			return Result.success(R.TaskAtt.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),TaskAtt.class)));
		} catch (Exception e) {
			return Result.failure(R.TaskAtt.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<TaskAtt> getBeanById(Serializable id) {
		try {
			return Result.value(taskAttDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.TaskAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<TaskAtt> getBeanByFilter(Filter filter) {
		try {
			return Result.value(taskAttDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.TaskAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<TaskAtt>> getList() {
		try {
			return Result.value(taskAttDao.getList());
		} catch (Exception e) {
			return Result.failure(R.TaskAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<TaskAtt>> getListByFilter(Filter filter) {
		try {
			return Result.value(taskAttDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.TaskAtt.LOAD_FAILURE);
		}
	}

}
