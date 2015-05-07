package com.wiiy.core.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.dao.RoleDesktopDao;
import com.wiiy.core.entity.DesktopItem;
import com.wiiy.core.entity.RoleDesktop;
import com.wiiy.core.entity.UserRoleRef;
import com.wiiy.core.preferences.R;
import com.wiiy.core.service.RoleDesktopService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.ModulePrefixNamingStrategy;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;

public class RoleDesktopServiceImpl implements RoleDesktopService{
	private RoleDesktopDao roleDesktopDao;
	public void setRoleDesktopDao(RoleDesktopDao roleDesktopDao) {
		this.roleDesktopDao = roleDesktopDao;
	}

	@Override
	public Result<RoleDesktop> delete(RoleDesktop t) {
		try {
			roleDesktopDao.delete(t);
			return Result.success(R.RoleDesktop.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.RoleDesktop.DELETE_FAILURE);
		}
	}

	@Override
	public Result<RoleDesktop> deleteById(Serializable id) {
		try {
			roleDesktopDao.deleteById(id);
			return Result.success(R.RoleDesktop.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.RoleDesktop.DELETE_FAILURE);
		}
	}

	@Override
	public Result<RoleDesktop> deleteByIds(String ids) {
		try {
			roleDesktopDao.deleteByIds(ids);
			return Result.success(R.RoleDesktop.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.RoleDesktop.DELETE_FAILURE);
		}
	}

	@Override
	public Result<RoleDesktop> getBeanByFilter(Filter filter) {
		try {
			return Result.value(roleDesktopDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.RoleDesktop.LOAD_FAILURE);
		}
	}

	@Override
	public Result<RoleDesktop> getBeanById(Serializable id) {
		try {
			return Result.value(roleDesktopDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.RoleDesktop.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<RoleDesktop>> getList() {
		try {
			return Result.value(roleDesktopDao.getList());
		} catch (Exception e) {
			return Result.failure(R.RoleDesktop.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<RoleDesktop>> getListByFilter(Filter filter) {
		try {
			return Result.value(roleDesktopDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.RoleDesktop.LOAD_FAILURE);
		}
	}

	@Override
	public Result<RoleDesktop> save(RoleDesktop t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(CoreActivator.getSessionUser().getRealName());
			t.setCreatorId(CoreActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			roleDesktopDao.save(t);
			return Result.success(R.RoleDesktop.SAVE_SUCCESS, t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),RoleDesktop.class)));
		} catch (Exception e) {
			return Result.failure(R.RoleDesktop.SAVE_FAILURE);
		}
	}

	@Override
	public Result<RoleDesktop> update(RoleDesktop t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CoreActivator.getSessionUser().getRealName());
			t.setModifierId(CoreActivator.getSessionUser().getId());
			roleDesktopDao.update(t);
			return Result.success(R.RoleDesktop.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),RoleDesktop.class)));
		} catch (Exception e) {
			return Result.failure(R.RoleDesktop.UPDATE_FAILURE);
		}
	}

	@Override
	public List<DesktopItem> getUserDesktopItem(Long id) {
		
		Session session = null;
		try {
			session = roleDesktopDao.openSession();
			Criteria criteria = session.createCriteria(RoleDesktop.class);
			String sql = "this_.role_id in (select ur.role_id from "+ModulePrefixNamingStrategy.classToTableName(UserRoleRef.class)+" ur where ur.user_id = "+id+")";
			criteria.add(Restrictions.sqlRestriction(sql));
			criteria.addOrder(Order.asc("displayOrder"));
			List<RoleDesktop> roleDesktopList = criteria.list();
			ArrayList<DesktopItem> desktopItemList = new ArrayList<DesktopItem>();
			for (RoleDesktop roleDesktop : roleDesktopList) {
				desktopItemList.add(roleDesktop.getDesktopItem());
			}
			return desktopItemList;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			session.close();
		}
	}

}
