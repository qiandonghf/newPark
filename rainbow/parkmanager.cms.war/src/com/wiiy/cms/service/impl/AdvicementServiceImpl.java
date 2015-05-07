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
import com.wiiy.cms.entity.Advicement;
import com.wiiy.cms.dao.AdvicementDao;
import com.wiiy.cms.service.AdvicementService;
import com.wiiy.cms.preferences.R;
import com.wiiy.cms.activator.CmsActivator;

/**
 * @author my
 */
public class AdvicementServiceImpl implements AdvicementService{
	
	private AdvicementDao advicementDao;
	
	public void setAdvicementDao(AdvicementDao advicementDao) {
		this.advicementDao = advicementDao;
	}

	@Override
	public Result<Advicement> save(Advicement t) {
		try {
			t.setCreateTime(new Date());
			//t.setCreator(CmsActivator.getSessionUser().getRealName());
			//t.setCreatorId(CmsActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			//t.setModifier(t.getCreator());
			//t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			advicementDao.save(t);
			return Result.success(R.Advicement.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Advicement.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Advicement.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Advicement> delete(Advicement t) {
		try {
			advicementDao.delete(t);
			return Result.success(R.Advicement.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Advicement.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Advicement> deleteById(Serializable id) {
		try {
			advicementDao.deleteById(id);
			return Result.success(R.Advicement.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Advicement.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Advicement> deleteByIds(String ids) {
		try {
			advicementDao.deleteByIds(ids);
			return Result.success(R.Advicement.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Advicement.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Advicement> update(Advicement t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CmsActivator.getSessionUser().getRealName());
			t.setModifierId(CmsActivator.getSessionUser().getId());
			advicementDao.update(t);
			return Result.success(R.Advicement.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Advicement.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Advicement.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Advicement> getBeanById(Serializable id) {
		try {
			return Result.value(advicementDao.getBeanById(id));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Advicement.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Advicement> getBeanByFilter(Filter filter) {
		try {
			return Result.value(advicementDao.getBeanByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Advicement.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Advicement>> getList() {
		try {
			return Result.value(advicementDao.getList());
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Advicement.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Advicement>> getListByFilter(Filter filter) {
		try {
			return Result.value(advicementDao.getListByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Advicement.LOAD_FAILURE);
		}
	}

}
