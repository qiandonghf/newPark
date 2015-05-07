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
import com.wiiy.oa.dao.LeaveApprovalDao;
import com.wiiy.oa.entity.LeaveApproval;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.preferences.enums.LeaveApprovalStatusEnum;
import com.wiiy.oa.service.LeaveApprovalService;

public class LeaveApprovalServiceImpl implements LeaveApprovalService{
	private LeaveApprovalDao leaveApprovalDao;
	public void setLeaveApprovalDao(LeaveApprovalDao leaveApprovalDao) {
		this.leaveApprovalDao = leaveApprovalDao;
	}

	@Override
	public Result<LeaveApproval> save(LeaveApproval t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(OaActivator.getSessionUser().getRealName());
			t.setCreatorId(OaActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			t.setStatus(LeaveApprovalStatusEnum.PENDING);
			t.setMemo("");
			leaveApprovalDao.save(t);
			OaActivator.getOperationLogService().logOP("添加id为【"+t.getId()+"】的请假审批");
			return Result.success(R.LeaveApproval.SAVE_SUCCESS, t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),LeaveApproval.class)));
		} catch (Exception e) {
			return Result.failure(R.LeaveApproval.SAVE_FAILURE);
		}
	}

	@Override
	public Result<LeaveApproval> update(LeaveApproval t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(OaActivator.getSessionUser().getRealName());
			t.setModifierId(OaActivator.getSessionUser().getId());
			leaveApprovalDao.update(t);
			OaActivator.getOperationLogService().logOP("编辑id为【"+t.getId()+"】的请假审批");
			return Result.success(R.LeaveApproval.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),LeaveApproval.class)));
		} catch (Exception e) {
			return Result.failure(R.LeaveApproval.UPDATE_FAILURE);
		}
	}
	
	@Override
	public Result<LeaveApproval> delete(LeaveApproval t) {
		try {
			leaveApprovalDao.delete(t);
			OaActivator.getOperationLogService().logOP("删除id为【"+t.getId()+"】的请假审批");
			return Result.success(R.LeaveApproval.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.LeaveApproval.DELETE_FAILURE);
		}
	}

	@Override
	public Result<LeaveApproval> deleteById(Serializable id) {
		try {
			leaveApprovalDao.deleteById(id);
			OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的请假审批");
			return Result.success(R.LeaveApproval.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.LeaveApproval.DELETE_FAILURE);
		}
	}

	@Override
	public Result<LeaveApproval> deleteByIds(String ids) {
		try {
			leaveApprovalDao.deleteByIds(ids);
			for(String id : ids.split(",")){
				OaActivator.getOperationLogService().logOP("删除id为【"+id+"】的请假审批");
			}
			return Result.success(R.LeaveApproval.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(OaActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.LeaveApproval.DELETE_FAILURE);
		}
	}

	@Override
	public Result<LeaveApproval> getBeanByFilter(Filter filter) {
		try {
			return Result.value(leaveApprovalDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.LeaveApproval.LOAD_FAILURE);
		}
	}

	@Override
	public Result<LeaveApproval> getBeanById(Serializable id) {
		try {
			return Result.value(leaveApprovalDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.LeaveApproval.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<LeaveApproval>> getList() {
		try {
			return Result.value(leaveApprovalDao.getList());
		} catch (Exception e) {
			return Result.failure(R.LeaveApproval.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<LeaveApproval>> getListByFilter(Filter filter) {
		try {
			return Result.value(leaveApprovalDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.LeaveApproval.LOAD_FAILURE);
		}
	}

}
