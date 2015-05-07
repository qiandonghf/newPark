package com.wiiy.core.service.impl;

import java.io.Serializable;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.util.StringUtil;
import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.dao.RoleDao;
import com.wiiy.core.entity.Role;
import com.wiiy.core.entity.RoleDesktop;
import com.wiiy.core.preferences.R;
import com.wiiy.core.service.RoleService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

public class RoleServiceImpl implements RoleService {
	
	private RoleDao roleDao;
	
	public void setRoleDao(RoleDao roleDao) {
		this.roleDao = roleDao;
	}

	@Override
	public Result<Role> save(Role t) {
		try {
    		if (roleDao.getBeanByFilter(new Filter(Role.class).eq("name", t.getName()))!=null) {
    			return Result.failure(R.Role.SAVE_FAILURE_DUPLICATED_NAME);
    		}
			roleDao.save(t);
			return Result.success(R.Role.SAVE_SUCCESS);
		} catch (Exception e) {
			return Result.failure(R.Role.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Role> delete(Role t) {
		try {
			roleDao.delete(t);
			return Result.success(R.Role.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Role.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Role> deleteById(Serializable id) {
		try {
			roleDao.deleteById(id);
			return Result.success(R.Role.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Role.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Role> deleteByIds(String ids) {
		try {
			roleDao.deleteByIds(ids);
			return Result.success(R.Role.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CoreActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Role.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Role> update(Role t) {
		try {
			roleDao.update(t);
			return Result.success(R.Role.UPDATE_SUCCESS);
		} catch (Exception e) {
			return Result.failure(R.Role.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Role> getBeanById(Serializable id) {
		try {
			return Result.value(roleDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Role.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Role> getBeanByFilter(Filter filter) {
		try {
			return Result.value(roleDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Role.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Role>> getList() {
		try {
			return Result.value(roleDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Role.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Role>> getListByFilter(Filter filter) {
		try {
			return Result.value(roleDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Role.LOAD_FAILURE);
		}
	}

	@Override
	public List<Role> getByUserRef(Long userId) {
		return roleDao.getListByFilter(new Filter(Role.class).eq("user.id", userId));
	}

	@Override
	public Result<Role> submitConfigRoleDesktop(Long id, String ids, String orderIds) {
		Session session = null;
		Transaction tr = null;
		try {
			session = roleDao.openSession();
			tr = session.beginTransaction();
			session.createQuery("delete from RoleDesktop where roleId = "+id).executeUpdate();
			Long[] idArray = StringUtil.splitToLongArray(ids);
			Integer[] orderArray = StringUtil.splitToIntegerArray(orderIds);
			for (int i = 0; i < orderArray.length; i++) {
				RoleDesktop rd = new RoleDesktop();
				rd.setRoleId(id);
				rd.setDisplayOrder(orderArray[i]);
				rd.setItemId(idArray[i]);
				session.save(rd);
			}
			tr.commit();
			return Result.success("配置成功");
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure("配置失败");
		} finally {
			session.close();
		}
	}
}
