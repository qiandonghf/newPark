package com.wiiy.crm.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.dao.ContractApprovalDao;
import com.wiiy.crm.entity.ContractApproval;
import com.wiiy.crm.preferences.R;
import com.wiiy.crm.service.ContractApprovalService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class ContractApprovalServiceImpl implements ContractApprovalService{
	
	private ContractApprovalDao contractApprovalDao;
	
	public void setContractApprovalDao(ContractApprovalDao contractApprovalDao) {
		this.contractApprovalDao = contractApprovalDao;
	}

	@Override
	public Result<ContractApproval> save(ContractApproval t) {
		Session session = null;
		Transaction tr = null;
		try {
			session = contractApprovalDao.openSession();
			tr = session.beginTransaction();
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			session.save(t);
			tr.commit();
			return Result.success(R.ContractApproval.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContractApproval.class)));
		} catch (Exception e) {
			tr.rollback();
			return Result.failure(R.ContractApproval.SAVE_FAILURE);
		}
	}

	@Override
	public Result<ContractApproval> delete(ContractApproval t) {
		try {
			contractApprovalDao.delete(t);
			return Result.success(R.ContractApproval.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractApproval.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractApproval> deleteById(Serializable id) {
		try {
			contractApprovalDao.deleteById(id);
			return Result.success(R.ContractApproval.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractApproval.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractApproval> deleteByIds(String ids) {
		try {
			contractApprovalDao.deleteByIds(ids);
			return Result.success(R.ContractApproval.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractApproval.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractApproval> update(ContractApproval t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			contractApprovalDao.update(t);
			return Result.success(R.ContractApproval.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContractApproval.class)));
		} catch (Exception e) {
			return Result.failure(R.ContractApproval.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<ContractApproval> getBeanById(Serializable id) {
		try {
			return Result.value(contractApprovalDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.ContractApproval.LOAD_FAILURE);
		}
	}

	@Override
	public Result<ContractApproval> getBeanByFilter(Filter filter) {
		try {
			return Result.value(contractApprovalDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ContractApproval.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContractApproval>> getList() {
		try {
			return Result.value(contractApprovalDao.getList());
		} catch (Exception e) {
			return Result.failure(R.ContractApproval.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContractApproval>> getListByFilter(Filter filter) {
		try {
			return Result.value(contractApprovalDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ContractApproval.LOAD_FAILURE);
		}
	}

}
