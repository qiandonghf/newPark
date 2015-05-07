package com.wiiy.crm.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.entity.User;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.crm.entity.BusinessPlanAtt;
import com.wiiy.crm.entity.InvestmentArchiveAtt;
import com.wiiy.crm.dao.InvestmentArchiveAttDao;
import com.wiiy.crm.service.InvestmentArchiveAttService;
import com.wiiy.crm.preferences.R;
import com.wiiy.pb.activator.PbActivator;

/**
 * @author my
 */
public class InvestmentArchiveAttServiceImpl implements InvestmentArchiveAttService{
	
	private InvestmentArchiveAttDao investmentArchiveAttDao;
	
	public void setInvestmentArchiveAttDao(InvestmentArchiveAttDao investmentArchiveAttDao) {
		this.investmentArchiveAttDao = investmentArchiveAttDao;
	}

	@Override
	public Result<InvestmentArchiveAtt> save(InvestmentArchiveAtt t) {
		try {
			t.setCreateTime(new Date());
			User user = PbActivator.getSessionUser();
			if (user != null) {
				t.setCreator(user.getRealName());
				t.setCreatorId(user.getId());
			}
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			investmentArchiveAttDao.save(t);
			return Result.success(R.InvestmentArchiveAtt.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),InvestmentArchiveAtt.class)));
		} catch (Exception e) {
			return Result.failure(R.InvestmentArchiveAtt.SAVE_FAILURE);
		}
	}

	@Override
	public Result<InvestmentArchiveAtt> delete(InvestmentArchiveAtt t) {
		try {
			investmentArchiveAttDao.delete(t);
			return Result.success(R.InvestmentArchiveAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.InvestmentArchiveAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<InvestmentArchiveAtt> deleteById(Serializable id) {
		try {
			InvestmentArchiveAtt att = (InvestmentArchiveAtt) investmentArchiveAttDao.getBeanById(id);
			String path = att.getNewName();
			PbActivator.getResourcesService().delete(path);
			investmentArchiveAttDao.deleteById(id);
			return Result.success(R.InvestmentArchiveAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.InvestmentArchiveAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<InvestmentArchiveAtt> deleteByIds(String ids) {
		try {
			investmentArchiveAttDao.deleteByIds(ids);
			List<String> newNames = investmentArchiveAttDao.getObjectListByHql("select new_name from InvestmentArchiveAtt where id in ("+ids+")");
			for(String newName : newNames){
				PbActivator.getResourcesService().delete(newName);
			}
			return Result.success(R.InvestmentArchiveAtt.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.InvestmentArchiveAtt.DELETE_FAILURE);
		}
	}

	@Override
	public Result<InvestmentArchiveAtt> update(InvestmentArchiveAtt t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			investmentArchiveAttDao.update(t);
			return Result.success(R.InvestmentArchiveAtt.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),InvestmentArchiveAtt.class)));
		} catch (Exception e) {
			return Result.failure(R.InvestmentArchiveAtt.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<InvestmentArchiveAtt> getBeanById(Serializable id) {
		try {
			return Result.value(investmentArchiveAttDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.InvestmentArchiveAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<InvestmentArchiveAtt> getBeanByFilter(Filter filter) {
		try {
			return Result.value(investmentArchiveAttDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.InvestmentArchiveAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<InvestmentArchiveAtt>> getList() {
		try {
			return Result.value(investmentArchiveAttDao.getList());
		} catch (Exception e) {
			return Result.failure(R.InvestmentArchiveAtt.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<InvestmentArchiveAtt>> getListByFilter(Filter filter) {
		try {
			return Result.value(investmentArchiveAttDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.InvestmentArchiveAtt.LOAD_FAILURE);
		}
	}

}
