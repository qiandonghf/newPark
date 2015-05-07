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
import com.wiiy.crm.entity.ContractAtt;
import com.wiiy.crm.dao.ContractAttDao;
import com.wiiy.crm.service.ContractAttService;
import com.wiiy.crm.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class ContractAttServiceImpl implements ContractAttService{
	
	private ContractAttDao contractAttDao;
	
	public void setContractAttDao(ContractAttDao contractAttDao) {
		this.contractAttDao = contractAttDao;
	}

	@Override
	public Result<ContractAtt> save(ContractAtt t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			contractAttDao.save(t);
			return Result.success(R.ContractAtt.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContractAtt.class)));
		} catch (Exception e) {
			return Result.failure(R.ContractAtt.SAVE_FAILURE);
		}
	}

	@Override
	public Result<ContractAtt> delete(ContractAtt t) {
		try {
			contractAttDao.delete(t);
			return Result.success(R.ContractAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractAtt> deleteById(Serializable id) {
		try {
			contractAttDao.deleteById(id);
			return Result.success(R.ContractAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractAtt> deleteByIds(String ids) {
		try {
			contractAttDao.deleteByIds(ids);
			return Result.success(R.ContractAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ContractAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ContractAtt> update(ContractAtt t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			contractAttDao.update(t);
			return Result.success(R.ContractAtt.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ContractAtt.class)));
		} catch (Exception e) {
			return Result.failure(R.ContractAtt.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<ContractAtt> getBeanById(Serializable id) {
		try {
			return Result.value(contractAttDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.ContractAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<ContractAtt> getBeanByFilter(Filter filter) {
		try {
			return Result.value(contractAttDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ContractAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContractAtt>> getList() {
		try {
			return Result.value(contractAttDao.getList());
		} catch (Exception e) {
			return Result.failure(R.ContractAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ContractAtt>> getListByFilter(Filter filter) {
		try {
			return Result.value(contractAttDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ContractAtt.LOAD_FAILURE);
		}
	}

}
