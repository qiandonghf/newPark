package com.wiiy.pb.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.entity.Complaint;
import com.wiiy.pb.dao.ComplaintDao;
import com.wiiy.pb.service.ComplaintService;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.preferences.enums.ComplaintAcceptStatusEnum;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class ComplaintServiceImpl implements ComplaintService{
	
	private ComplaintDao complaintDao;
	
	public void setComplaintDao(ComplaintDao complaintDao) {
		this.complaintDao = complaintDao;
	}

	@Override
	public Result<Complaint> save(Complaint t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			t.setComplaintTime(new Date());
			t.setStatus(ComplaintAcceptStatusEnum.UNSTART);
			complaintDao.save(t);
			return Result.success(R.Complaint.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Complaint.class)));
		} catch (Exception e) {
			return Result.failure(R.Complaint.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Complaint> delete(Complaint t) {
		try {
			complaintDao.delete(t);
			return Result.success(R.Complaint.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Complaint.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Complaint> deleteById(Serializable id) {
		try {
			complaintDao.deleteById(id);
			return Result.success(R.Complaint.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Complaint.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Complaint> deleteByIds(String ids) {
		try {
			complaintDao.deleteByIds(ids);
			return Result.success(R.Complaint.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Complaint.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Complaint> update(Complaint t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			complaintDao.update(t);
			return Result.success(R.Complaint.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Complaint.class)));
		} catch (Exception e) {
			return Result.failure(R.Complaint.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Complaint> getBeanById(Serializable id) {
		try {
			return Result.value(complaintDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Complaint.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Complaint> getBeanByFilter(Filter filter) {
		try {
			return Result.value(complaintDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Complaint.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Complaint>> getList() {
		try {
			return Result.value(complaintDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Complaint.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Complaint>> getListByFilter(Filter filter) {
		try {
			return Result.value(complaintDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Complaint.LOAD_FAILURE);
		}
	}

}
