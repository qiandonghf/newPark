package com.wiiy.core.service.impl;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.dao.DesktopItemDao;
import com.wiiy.core.entity.DesktopItem;
import com.wiiy.core.preferences.R;
import com.wiiy.core.service.DesktopItemService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;

public class DesktopItemServiceImpl implements DesktopItemService{
	private DesktopItemDao desktopItemDao;
	public void setDesktopItemDao(DesktopItemDao desktopItemDao) {
		this.desktopItemDao = desktopItemDao;
	}

	@Override
	public Result<DesktopItem> delete(DesktopItem t) {
		try {
			desktopItemDao.delete(t);
			return Result.success(R.DesktopItem.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DesktopItem.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DesktopItem> deleteById(Serializable id) {
		try {
			desktopItemDao.deleteById(id);
			return Result.success(R.DesktopItem.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DesktopItem.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DesktopItem> deleteByIds(String ids) {
		try {
			desktopItemDao.deleteByIds(ids);
			return Result.success(R.DesktopItem.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.DesktopItem.DELETE_FAILURE);
		}
	}

	@Override
	public Result<DesktopItem> getBeanByFilter(Filter filter) {
		try {
			return Result.value(desktopItemDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DesktopItem.LOAD_FAILURE);
		}
	}

	@Override
	public Result<DesktopItem> getBeanById(Serializable id) {
		try {
			return Result.value(desktopItemDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.DesktopItem.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<DesktopItem>> getList() {
		try {
			return Result.value(desktopItemDao.getList());
		} catch (Exception e) {
			return Result.failure(R.DesktopItem.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<DesktopItem>> getListByFilter(Filter filter) {
		try {
			return Result.value(desktopItemDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.DesktopItem.LOAD_FAILURE);
		}
	}

	@Override
	public Result<DesktopItem> save(DesktopItem t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(CoreActivator.getSessionUser().getRealName());
			t.setCreatorId(CoreActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			desktopItemDao.save(t);
			return Result.success(R.DesktopItem.SAVE_SUCCESS, t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),DesktopItem.class)));
		} catch (Exception e) {
			return Result.failure(R.DesktopItem.SAVE_FAILURE);
		}
	}

	@Override
	public Result<DesktopItem> update(DesktopItem t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CoreActivator.getSessionUser().getRealName());
			t.setModifierId(CoreActivator.getSessionUser().getId());
			desktopItemDao.update(t);
			return Result.success(R.DesktopItem.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),DesktopItem.class)));
		} catch (Exception e) {
			return Result.failure(R.DesktopItem.UPDATE_FAILURE);
		}
	}

}
