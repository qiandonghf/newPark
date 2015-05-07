package com.wiiy.cms.service.impl;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.cms.entity.Resource;
import com.wiiy.cms.dao.ResourceDao;
import com.wiiy.cms.service.ResourceService;
import com.wiiy.cms.preferences.R;
import com.wiiy.cms.activator.CmsActivator;

/**
 * @author my
 */
public class ResourceServiceImpl implements ResourceService{
	
	private ResourceDao resourceDao;
	
	public void setResourceDao(ResourceDao resourceDao) {
		this.resourceDao = resourceDao;
	}

	@Override
	public Result<Resource> save(Resource t) {
		try {
			t.setCreateTime(new Date());
			try {
				t.setCreator(CmsActivator.getSessionUser().getRealName());
				t.setCreatorId(CmsActivator.getSessionUser().getId());
			} catch (Exception e) {
			}
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			resourceDao.save(t);
			return Result.success(R.Resource.SAVE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Resource.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Resource.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Resource> delete(Resource t) {
		try {
			resourceDao.delete(t);
			return Result.success(R.Resource.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Resource.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Resource> deleteById(Serializable id) {
		try {
			resourceDao.deleteById(id);
			return Result.success(R.Resource.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Resource.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Resource> deleteByIds(String ids) {
		try {
			resourceDao.deleteByIds(ids);
			return Result.success(R.Resource.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Resource.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Resource> update(Resource t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CmsActivator.getSessionUser().getRealName());
			t.setModifierId(CmsActivator.getSessionUser().getId());
			resourceDao.update(t);
			return Result.success(R.Resource.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Resource.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Resource.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Resource> getBeanById(Serializable id) {
		try {
			return Result.value(resourceDao.getBeanById(id));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Resource.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Resource> getBeanByFilter(Filter filter) {
		try {
			return Result.value(resourceDao.getBeanByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Resource.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Resource>> getList() {
		try {
			return Result.value(resourceDao.getList());
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Resource.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Resource>> getListByFilter(Filter filter) {
		try {
			return Result.value(resourceDao.getListByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Resource.LOAD_FAILURE);
		}
	}

	@Override
	public void deleteByParamId(Long paramId) {
		Session session = null;
		Transaction tr = null;
		try {
			session = resourceDao.openSession();
			tr = session.beginTransaction();
			String sql = "DELETE FROM cms_resource WHERE param_id="+paramId;
			session.createSQLQuery(sql).executeUpdate();
			tr.commit();
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
		}finally{
			if (session != null) {
				session.close();
			}
		}
	}

}
