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
import com.wiiy.crm.entity.ContractReviewAtt;
import com.wiiy.crm.dao.ContractReviewAttDao;
import com.wiiy.crm.service.ContractReviewAttService;
import com.wiiy.crm.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class ContractReviewAttServiceImpl implements ContractReviewAttService{
	
	private ContractReviewAttDao contractReviewAttDao;
	
	public void setContractReviewAttDao(ContractReviewAttDao contractReviewAttDao) {
		this.contractReviewAttDao = contractReviewAttDao;
	}

	@Override
	public Result<ContractReviewAtt> save(ContractReviewAtt t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			contractReviewAttDao.save(t);
			return Result.success(R.ContractReviewAtt.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContractReviewAtt.class)));
		} catch (Exception e) {
			return Result.failure(R.ContractReviewAtt.SAVE_FAILURE);
		}
	}

	@Override
	public Result<ContractReviewAtt> delete(ContractReviewAtt t) {
		try {
			contractReviewAttDao.delete(t);
			return Result.success(R.ContractReviewAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractReviewAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractReviewAtt> deleteById(Serializable id) {
		try {
			Result<ContractReviewAtt> result = getBeanById(id);
			String path = result.getValue().getNewName();
			PbActivator.getResourcesService().delete(path);
			contractReviewAttDao.deleteById(id);
			return Result.success(R.ContractReviewAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractReviewAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractReviewAtt> deleteByIds(String ids) {
		try {
			contractReviewAttDao.deleteByIds(ids);
			return Result.success(R.ContractReviewAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractReviewAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractReviewAtt> update(ContractReviewAtt t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			contractReviewAttDao.update(t);
			return Result.success(R.ContractReviewAtt.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContractReviewAtt.class)));
		} catch (Exception e) {
			return Result.failure(R.ContractReviewAtt.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<ContractReviewAtt> getBeanById(Serializable id) {
		try {
			return Result.value(contractReviewAttDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.ContractReviewAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<ContractReviewAtt> getBeanByFilter(Filter filter) {
		try {
			return Result.value(contractReviewAttDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ContractReviewAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContractReviewAtt>> getList() {
		try {
			return Result.value(contractReviewAttDao.getList());
		} catch (Exception e) {
			return Result.failure(R.ContractReviewAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContractReviewAtt>> getListByFilter(Filter filter) {
		try {
			return Result.value(contractReviewAttDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ContractReviewAtt.LOAD_FAILURE);
		}
	}

}
