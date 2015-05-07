package com.wiiy.cloud.capture.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.cloud.capture.dao.WebContentConfigDao;
import com.wiiy.cloud.capture.entity.WebContentConfig;
import com.wiiy.cloud.capture.preferences.R;
import com.wiiy.cloud.capture.service.WebContentConfigService;
import com.wiiy.cms.activator.CmsActivator;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;

/**
 * @author my
 */
public class WebContentConfigServiceImpl implements WebContentConfigService{
	
	private WebContentConfigDao webContentConfigDao;
	
	public void setWebContentConfigDao(WebContentConfigDao webContentConfigDao) {
		this.webContentConfigDao = webContentConfigDao;
	}

	@Override
	public Result<WebContentConfig> save(WebContentConfig t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(CmsActivator.getSessionUser().getRealName());
			t.setCreatorId(CmsActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			webContentConfigDao.save(t);
			return Result.success(R.WebContentConfig.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),WebContentConfig.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.WebContentConfig.SAVE_FAILURE);
		}
	}

	@Override
	public Result<WebContentConfig> delete(WebContentConfig t) {
		try {
			webContentConfigDao.delete(t);
			return Result.success(R.WebContentConfig.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.WebContentConfig.DELETE_FAILURE);
		}
	}

	@Override
	public Result<WebContentConfig> deleteById(Serializable id) {
		try {
			webContentConfigDao.deleteById(id);
			return Result.success(R.WebContentConfig.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.WebContentConfig.DELETE_FAILURE);
		}
	}

	@Override
	public Result<WebContentConfig> deleteByIds(String ids) {
		try {
			webContentConfigDao.deleteByIds(ids);
			return Result.success(R.WebContentConfig.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.WebContentConfig.DELETE_FAILURE);
		}
	}

	@Override
	public Result<WebContentConfig> update(WebContentConfig t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CmsActivator.getSessionUser().getRealName());
			t.setModifierId(CmsActivator.getSessionUser().getId());
			webContentConfigDao.update(t);
			return Result.success(R.WebContentConfig.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),WebContentConfig.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.WebContentConfig.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<WebContentConfig> getBeanById(Serializable id) {
		try {
			return Result.value(webContentConfigDao.getBeanById(id));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.WebContentConfig.LOAD_FAILURE);
		}
	}

	@Override
	public Result<WebContentConfig> getBeanByFilter(Filter filter) {
		try {
			return Result.value(webContentConfigDao.getBeanByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.WebContentConfig.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<WebContentConfig>> getList() {
		try {
			return Result.value(webContentConfigDao.getList());
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.WebContentConfig.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<WebContentConfig>> getListByFilter(Filter filter) {
		try {
			return Result.value(webContentConfigDao.getListByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.WebContentConfig.LOAD_FAILURE);
		}
	}

}
