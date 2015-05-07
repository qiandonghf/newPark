package com.wiiy.cms.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.cms.entity.Federation;
import com.wiiy.cms.dao.FederationDao;
import com.wiiy.cms.service.FederationService;
import com.wiiy.cms.preferences.R;
import com.wiiy.cms.activator.CmsActivator;

/**
 * @author my
 */
public class FederationServiceImpl implements FederationService{
	
	private FederationDao federationDao;
	
	public void setFederationDao(FederationDao federationDao) {
		this.federationDao = federationDao;
	}

	@Override
	public Result<Federation> save(Federation t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(CmsActivator.getSessionUser().getRealName());
			t.setCreatorId(CmsActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			federationDao.save(t);
			return Result.success(R.Federation.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Federation.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Federation.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Federation> delete(Federation t) {
		try {
			federationDao.delete(t);
			return Result.success(R.Federation.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Federation.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Federation> deleteById(Serializable id) {
		try {
			federationDao.deleteById(id);
			return Result.success(R.Federation.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Federation.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Federation> deleteByIds(String ids) {
		try {
			federationDao.deleteByIds(ids);
			return Result.success(R.Federation.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Federation.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Federation> update(Federation t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CmsActivator.getSessionUser().getRealName());
			t.setModifierId(CmsActivator.getSessionUser().getId());
			federationDao.update(t);
			return Result.success(R.Federation.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Federation.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Federation.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Federation> getBeanById(Serializable id) {
		try {
			return Result.value(federationDao.getBeanById(id));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Federation.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Federation> getBeanByFilter(Filter filter) {
		try {
			return Result.value(federationDao.getBeanByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Federation.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Federation>> getList() {
		try {
			return Result.value(federationDao.getList());
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Federation.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Federation>> getListByFilter(Filter filter) {
		try {
			return Result.value(federationDao.getListByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Federation.LOAD_FAILURE);
		}
	}

}
