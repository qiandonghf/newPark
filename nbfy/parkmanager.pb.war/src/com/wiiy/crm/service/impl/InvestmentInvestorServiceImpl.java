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
import com.wiiy.crm.entity.InvestmentInvestor;
import com.wiiy.crm.dao.InvestmentInvestorDao;
import com.wiiy.crm.service.InvestmentInvestorService;
import com.wiiy.crm.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class InvestmentInvestorServiceImpl implements InvestmentInvestorService{
	
	private InvestmentInvestorDao investmentInvestorDao;
	
	public void setInvestmentInvestorDao(InvestmentInvestorDao investmentInvestorDao) {
		this.investmentInvestorDao = investmentInvestorDao;
	}

	@Override
	public Result<InvestmentInvestor> save(InvestmentInvestor t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			investmentInvestorDao.save(t);
			return Result.success(R.InvestmentInvestor.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),InvestmentInvestor.class)));
		} catch (Exception e) {
			return Result.failure(R.InvestmentInvestor.SAVE_FAILURE);
		}
	}

	@Override
	public Result<InvestmentInvestor> delete(InvestmentInvestor t) {
		try {
			investmentInvestorDao.delete(t);
			return Result.success(R.InvestmentInvestor.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.InvestmentInvestor.DELETE_FAILURE);
		}
	}

	@Override
	public Result<InvestmentInvestor> deleteById(Serializable id) {
		try {
			investmentInvestorDao.deleteById(id);
			return Result.success(R.InvestmentInvestor.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.InvestmentInvestor.DELETE_FAILURE);
		}
	}

	@Override
	public Result<InvestmentInvestor> deleteByIds(String ids) {
		try {
			investmentInvestorDao.deleteByIds(ids);
			return Result.success(R.InvestmentInvestor.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.InvestmentInvestor.DELETE_FAILURE);
		}
	}

	@Override
	public Result<InvestmentInvestor> update(InvestmentInvestor t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			investmentInvestorDao.update(t);
			return Result.success(R.InvestmentInvestor.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),InvestmentInvestor.class)));
		} catch (Exception e) {
			return Result.failure(R.InvestmentInvestor.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<InvestmentInvestor> getBeanById(Serializable id) {
		try {
			return Result.value(investmentInvestorDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.InvestmentInvestor.LOAD_FAILURE);
		}
	}

	@Override
	public Result<InvestmentInvestor> getBeanByFilter(Filter filter) {
		try {
			return Result.value(investmentInvestorDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.InvestmentInvestor.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<InvestmentInvestor>> getList() {
		try {
			return Result.value(investmentInvestorDao.getList());
		} catch (Exception e) {
			return Result.failure(R.InvestmentInvestor.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<InvestmentInvestor>> getListByFilter(Filter filter) {
		try {
			return Result.value(investmentInvestorDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.InvestmentInvestor.LOAD_FAILURE);
		}
	}

}
