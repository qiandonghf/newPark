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
import com.wiiy.oa.dao.LeaveRegisterDao;
import com.wiiy.oa.entity.LeaveRegister;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.service.LeaveRegisterService;

public class LeaveRegisterServiceImpl implements LeaveRegisterService{
	private LeaveRegisterDao leaveRegisterDao;
	public void setLeaveRegisterDao(LeaveRegisterDao leaveRegisterDao) {
		this.leaveRegisterDao = leaveRegisterDao;
	}

	@Override
	public Result<LeaveRegister> save(LeaveRegister t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = leaveRegisterDao.openSession();
			tr = session.beginTransaction();
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			session.save(t);
			OaActivator.getOperationLogService().logOP("添加id为【"+t.getId()+"】的请假登记");
			tr.commit();
			return Result.success(R.LeaveRegister.SAVE_SUCCESS, t);
		} catch (UKConstraintException e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),LeaveRegister.class)));
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.LeaveRegister.SAVE_FAILURE);
		} finally {
			session.close();
		}
	}

	@Override
	public Result<LeaveRegister> update(LeaveRegister t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			leaveRegisterDao.update(t);
			OaActivator.getOperationLogService().logOP("编辑id为【"+t.getId()+"】的请假登记");
			return Result.success(R.LeaveRegister.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),LeaveRegister.class)));
		} catch (Exception e) {
			return Result.failure(R.LeaveRegister.UPDATE_FAILURE);
		}
	}
	
	@Override
	public Result<LeaveRegister> delete(LeaveRegister t) {
		try {
			leaveRegisterDao.delete(t);
			OaActivator.getOperationLogService().logOP("删除id为【"+t.getId()+"】的请假登记");
			return Result.success(R.LeaveRegister.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.LeaveRegister.DELETE_FAILURE);
		}
	}


	@Override
	public Result<LeaveRegister> deleteById(Serializable id) {
		try {
			leaveRegisterDao.deleteById(id);
			OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的请假登记");
			return Result.success(R.LeaveRegister.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.LeaveRegister.DELETE_FAILURE);
		}
	}

	@Override
	public Result<LeaveRegister> deleteByIds(String ids) {
		try {
			leaveRegisterDao.deleteByIds(ids);
			for(String id : ids.split(",")){
				OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的请假登记");
			}
			return Result.success(R.LeaveRegister.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.LeaveRegister.DELETE_FAILURE);
		}
	}

	@Override
	public Result<LeaveRegister> getBeanByFilter(Filter filter) {
		try {
			return Result.value(leaveRegisterDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.LeaveRegister.LOAD_FAILURE);
		}
	}

	@Override
	public Result<LeaveRegister> getBeanById(Serializable id) {
		try {
			return Result.value(leaveRegisterDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.LeaveRegister.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<LeaveRegister>> getList() {
		try {
			return Result.value(leaveRegisterDao.getList());
		} catch (Exception e) {
			return Result.failure(R.LeaveRegister.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<LeaveRegister>> getListByFilter(Filter filter) {
		try {
			return Result.value(leaveRegisterDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.LeaveRegister.LOAD_FAILURE);
		}
	}
}
