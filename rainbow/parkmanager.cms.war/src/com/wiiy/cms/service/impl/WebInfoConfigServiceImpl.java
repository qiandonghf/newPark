package com.wiiy.cms.service.impl;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.cms.activator.CmsActivator;
import com.wiiy.cms.dao.WebInfoConfigDao;
import com.wiiy.cms.entity.Article;
import com.wiiy.cms.entity.WebInfoConfig;
import com.wiiy.cms.preferences.R;
import com.wiiy.cms.service.WebInfoConfigService;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;

public class WebInfoConfigServiceImpl implements WebInfoConfigService {
	private WebInfoConfigDao webInfoConfigDao;
	public void setWebInfoConfigDao(WebInfoConfigDao webInfoConfigDao) {
		this.webInfoConfigDao = webInfoConfigDao;
	}

	@Override
	public Result<WebInfoConfig> save(WebInfoConfig t) {
		try{
			t.setCreateTime(new Date());
			t.setCreator(CmsActivator.getSessionUser().getRealName());
			t.setCreatorId(CmsActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			webInfoConfigDao.save(t);
			return Result.success(R.WebInfoConfig.SAVE_SUCCESS,t);
		}catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),WebInfoConfig.class)));
		}catch (Exception e) {
			return Result.failure(R.WebInfoConfig.SAVE_FAILURE);
		}
	}

	@Override
	public Result<WebInfoConfig> update(WebInfoConfig t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CmsActivator.getSessionUser().getRealName());
			t.setModifierId(CmsActivator.getSessionUser().getId());
			webInfoConfigDao.update(t);
			return Result.success(R.WebInfoConfig.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),WebInfoConfig.class)));
		} catch (Exception e) {
			return Result.failure(R.WebInfoConfig.UPDATE_FAILURE);
		}
	}
	
	@Override
	public Result<WebInfoConfig> delete(WebInfoConfig t) {
		try {
			webInfoConfigDao.delete(t);
			return Result.success(R.WebInfoConfig.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.WebInfoConfig.DELETE_FAILURE);
		}
	}

	@Override
	public Result<WebInfoConfig> deleteById(Serializable id) {
		try {
			webInfoConfigDao.deleteById(id);
			return Result.success(R.WebInfoConfig.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.WebInfoConfig.DELETE_FAILURE);
		}
	}

	@Override
	public Result<WebInfoConfig> deleteByIds(String ids) {
		try {
			webInfoConfigDao.deleteByIds(ids);
			return Result.success(R.WebInfoConfig.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.WebInfoConfig.DELETE_FAILURE);
		}
	}

	@Override
	public Result<WebInfoConfig> getBeanByFilter(Filter filter) {
		try {
			return Result.value(webInfoConfigDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.WebInfoConfig.LOAD_FAILURE);
		}
	}

	@Override
	public Result<WebInfoConfig> getBeanById(Serializable id) {
		try {
			return Result.value(webInfoConfigDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.WebInfoConfig.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<WebInfoConfig>> getList() {
		try {
			return Result.value(webInfoConfigDao.getList());
		} catch (Exception e) {
			return Result.failure(R.WebInfoConfig.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<WebInfoConfig>> getListByFilter(Filter filter) {
		try {
			return Result.value(webInfoConfigDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.WebInfoConfig.LOAD_FAILURE);
		}
	}

}
