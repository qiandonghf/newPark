package com.wiiy.crm.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.crm.entity.ContractExpireApprovalAtt;
import com.wiiy.crm.dao.ContractExpireApprovalAttDao;
import com.wiiy.crm.service.ContractExpireApprovalAttService;
import com.wiiy.crm.preferences.R;


/**
 * @author my
 */
public class ContractExpireApprovalAttServiceImpl implements ContractExpireApprovalAttService{
	
	private ContractExpireApprovalAttDao contractExpireApprovalAttDao;
	
	public void setContractExpireApprovalAttDao(ContractExpireApprovalAttDao contractExpireApprovalAttDao) {
		this.contractExpireApprovalAttDao = contractExpireApprovalAttDao;
	}

	@Override
	public Result<ContractExpireApprovalAtt> save(ContractExpireApprovalAtt t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			contractExpireApprovalAttDao.save(t);
			return Result.success(R.ContractExpireApprovalAtt.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContractExpireApprovalAtt.class)));
		} catch (Exception e) {
			return Result.failure(R.ContractExpireApprovalAtt.SAVE_FAILURE);
		}
	}

	@Override
	public Result<ContractExpireApprovalAtt> delete(ContractExpireApprovalAtt t) {
		try {
			contractExpireApprovalAttDao.delete(t);
			return Result.success(R.ContractExpireApprovalAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractExpireApprovalAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractExpireApprovalAtt> deleteById(Serializable id) {
		try {
			Result<ContractExpireApprovalAtt> result = getBeanById(id);
			String path = result.getValue().getNewName();
			PbActivator.getResourcesService().delete(path);
			contractExpireApprovalAttDao.deleteById(id);
			return Result.success(R.ContractExpireApprovalAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractExpireApprovalAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractExpireApprovalAtt> deleteByIds(String ids) {
		try {
			contractExpireApprovalAttDao.deleteByIds(ids);
			return Result.success(R.ContractExpireApprovalAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractExpireApprovalAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractExpireApprovalAtt> update(ContractExpireApprovalAtt t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			contractExpireApprovalAttDao.update(t);
			return Result.success(R.ContractExpireApprovalAtt.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContractExpireApprovalAtt.class)));
		} catch (Exception e) {
			return Result.failure(R.ContractExpireApprovalAtt.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<ContractExpireApprovalAtt> getBeanById(Serializable id) {
		try {
			return Result.value(contractExpireApprovalAttDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.ContractExpireApprovalAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<ContractExpireApprovalAtt> getBeanByFilter(Filter filter) {
		try {
			return Result.value(contractExpireApprovalAttDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ContractExpireApprovalAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContractExpireApprovalAtt>> getList() {
		try {
			return Result.value(contractExpireApprovalAttDao.getList());
		} catch (Exception e) {
			return Result.failure(R.ContractExpireApprovalAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContractExpireApprovalAtt>> getListByFilter(Filter filter) {
		try {
			return Result.value(contractExpireApprovalAttDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ContractExpireApprovalAtt.LOAD_FAILURE);
		}
	}

}
