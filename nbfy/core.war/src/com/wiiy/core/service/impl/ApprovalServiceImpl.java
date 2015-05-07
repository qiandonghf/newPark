package com.wiiy.core.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.dao.ApprovalDao;
import com.wiiy.core.entity.Approval;
import com.wiiy.core.preferences.R;
import com.wiiy.core.preferences.enums.ApprovalTypeEnum;
import com.wiiy.core.service.ApprovalService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;

/**
 * @author my
 */
public class ApprovalServiceImpl implements ApprovalService,com.wiiy.core.service.export.ApprovalService{
	
	private ApprovalDao approvalDao;
	
	public void setApprovalDao(ApprovalDao approvalDao) {
		this.approvalDao = approvalDao;
	}

	@Override
	public Result<Approval> save(Approval t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(CoreActivator.getSessionUser().getRealName());
			t.setCreatorId(CoreActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			approvalDao.save(t);
			return Result.success(R.Approval.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Approval.class)));
		} catch (Exception e) {
			return Result.failure(R.Approval.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Approval> delete(Approval t) {
		try {
			approvalDao.delete(t);
			return Result.success(R.Approval.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Approval.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Approval> deleteById(Serializable id) {
		try {
			approvalDao.deleteById(id);
			return Result.success(R.Approval.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Approval.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Approval> deleteByIds(String ids) {
		try {
			approvalDao.deleteByIds(ids);
			return Result.success(R.Approval.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Approval.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Approval> update(Approval t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CoreActivator.getSessionUser().getRealName());
			t.setModifierId(CoreActivator.getSessionUser().getId());
			approvalDao.update(t);
			return Result.success(R.Approval.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Approval.class)));
		} catch (Exception e) {
			return Result.failure(R.Approval.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Approval> getBeanById(Serializable id) {
		try {
			return Result.value(approvalDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Approval.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Approval> getBeanByFilter(Filter filter) {
		try {
			return Result.value(approvalDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Approval.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Approval>> getList() {
		try {
			return Result.value(approvalDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Approval.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Approval>> getListByFilter(Filter filter) {
		try {
			return Result.value(approvalDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Approval.LOAD_FAILURE);
		}
	}

	@Override
	public List<Approval> getApprovalList(Long groupId, ApprovalTypeEnum type) {
		return null;
	}

	@Override
	public Approval getApproval(Long groupId, ApprovalTypeEnum type, Long userId) {
		return approvalDao.getBeanByFilter(new Filter(Approval.class).eq("groupId", groupId).eq("type", type).eq("userId", userId));
	}

}
