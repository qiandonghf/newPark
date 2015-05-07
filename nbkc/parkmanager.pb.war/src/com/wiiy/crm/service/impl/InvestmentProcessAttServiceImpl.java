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
import com.wiiy.crm.entity.InvestmentProcessAtt;
import com.wiiy.crm.dao.InvestmentProcessAttDao;
import com.wiiy.crm.service.InvestmentProcessAttService;
import com.wiiy.crm.preferences.R;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.pb.entity.RoomAtt;

/**
 * @author my
 */
public class InvestmentProcessAttServiceImpl implements InvestmentProcessAttService{
	
	private InvestmentProcessAttDao investmentProcessAttDao;
	
	public void setInvestmentProcessAttDao(InvestmentProcessAttDao investmentProcessAttDao) {
		this.investmentProcessAttDao = investmentProcessAttDao;
	}

	@Override
	public Result<InvestmentProcessAtt> save(InvestmentProcessAtt t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			investmentProcessAttDao.save(t);
			return Result.success(R.InvestmentProcessAtt.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),InvestmentProcessAtt.class)));
		} catch (Exception e) {
			return Result.failure(R.InvestmentProcessAtt.SAVE_FAILURE);
		}
	}

	@Override
	public Result<InvestmentProcessAtt> delete(InvestmentProcessAtt t) {
		try {
			investmentProcessAttDao.delete(t);
			return Result.success(R.InvestmentProcessAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.InvestmentProcessAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<InvestmentProcessAtt> deleteById(Serializable id) {
		try {
			Result<InvestmentProcessAtt> result = getBeanById(id);
			String path = result.getValue().getNewName();
			PbActivator.getResourcesService().delete(path);
			investmentProcessAttDao.deleteById(id);
			return Result.success(R.InvestmentProcessAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.InvestmentProcessAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<InvestmentProcessAtt> deleteByIds(String ids) {
		try {
			investmentProcessAttDao.deleteByIds(ids);
			return Result.success(R.InvestmentProcessAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.InvestmentProcessAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<InvestmentProcessAtt> update(InvestmentProcessAtt t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			investmentProcessAttDao.update(t);
			return Result.success(R.InvestmentProcessAtt.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),InvestmentProcessAtt.class)));
		} catch (Exception e) {
			return Result.failure(R.InvestmentProcessAtt.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<InvestmentProcessAtt> getBeanById(Serializable id) {
		try {
			return Result.value(investmentProcessAttDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.InvestmentProcessAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<InvestmentProcessAtt> getBeanByFilter(Filter filter) {
		try {
			return Result.value(investmentProcessAttDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.InvestmentProcessAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<InvestmentProcessAtt>> getList() {
		try {
			return Result.value(investmentProcessAttDao.getList());
		} catch (Exception e) {
			return Result.failure(R.InvestmentProcessAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<InvestmentProcessAtt>> getListByFilter(Filter filter) {
		try {
			return Result.value(investmentProcessAttDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.InvestmentProcessAtt.LOAD_FAILURE);
		}
	}

}
