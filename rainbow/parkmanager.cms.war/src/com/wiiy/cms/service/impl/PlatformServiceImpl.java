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
import com.wiiy.cms.entity.Platform;
import com.wiiy.cms.dao.PlatformDao;
import com.wiiy.cms.service.PlatformService;
import com.wiiy.cms.preferences.R;
import com.wiiy.cms.activator.CmsActivator;

/**
 * @author my
 */
public class PlatformServiceImpl implements PlatformService{
	
	private PlatformDao platformDao;
	
	public void setPlatformDao(PlatformDao platformDao) {
		this.platformDao = platformDao;
	}

	@Override
	public Result<Platform> save(Platform t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(CmsActivator.getSessionUser().getRealName());
			t.setCreatorId(CmsActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			platformDao.save(t);
			return Result.success(R.Platform.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Platform.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Platform.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Platform> delete(Platform t) {
		try {
			platformDao.delete(t);
			return Result.success(R.Platform.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Platform.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Platform> deleteById(Serializable id) {
		try {
			platformDao.deleteById(id);
			return Result.success(R.Platform.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Platform.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Platform> deleteByIds(String ids) {
		try {
			platformDao.deleteByIds(ids);
			return Result.success(R.Platform.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Platform.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Platform> update(Platform t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CmsActivator.getSessionUser().getRealName());
			t.setModifierId(CmsActivator.getSessionUser().getId());
			platformDao.update(t);
			return Result.success(R.Platform.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Platform.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Platform.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Platform> getBeanById(Serializable id) {
		try {
			return Result.value(platformDao.getBeanById(id));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Platform.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Platform> getBeanByFilter(Filter filter) {
		try {
			return Result.value(platformDao.getBeanByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Platform.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Platform>> getList() {
		try {
			return Result.value(platformDao.getList());
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Platform.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Platform>> getListByFilter(Filter filter) {
		try {
			return Result.value(platformDao.getListByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Platform.LOAD_FAILURE);
		}
	}

}
