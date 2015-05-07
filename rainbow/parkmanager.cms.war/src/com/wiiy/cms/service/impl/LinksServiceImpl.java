package com.wiiy.cms.service.impl;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.cms.activator.CmsActivator;
import com.wiiy.cms.dao.LinksDao;
import com.wiiy.cms.entity.Links;
import com.wiiy.cms.preferences.R;
import com.wiiy.cms.service.LinksService;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;

public class LinksServiceImpl implements LinksService{
	
	private LinksDao linksDao;
	public void setLinksDao(LinksDao linksDao) {
		this.linksDao = linksDao;
	}

	@Override
	public Result<Links> save(Links t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(CmsActivator.getSessionUser().getRealName());
			t.setCreatorId(CmsActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			if (t.getDisplay() == BooleanEnum.YES) {
				t.setOpenedTime(new Date());
			}
			linksDao.save(t);
			CmsActivator.getOperationLogService().logOP("添加id为【"+t.getId()+"】的链接");
			return Result.success(R.Links.SAVE_SUCCESS,t);
		} catch (Exception e) {
			return Result.failure(R.Links.SAVE_FAILURE);
		}
		
	}

	@Override
	public Result<Links> delete(Links t) {
		try {
			linksDao.delete(t);
			CmsActivator.getOperationLogService().logOP("删除id为【"+t.getId()+"】的链接");
			return Result.success(R.Links.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Links.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Links> deleteById(Serializable id) {
		try {
			linksDao.deleteById(id);
			CmsActivator.getOperationLogService().logOP("删除id为【"+id+"】的链接");
			return Result.success(R.Links.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Links.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Links> deleteByIds(String ids) {
		try {
			linksDao.deleteByIds(ids);
			for(String id : ids.split(",")){
				CmsActivator.getOperationLogService().logOP("删除id为【"+id+"】的链接");
			}
			return Result.success(R.Links.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Links.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Links> update(Links t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CmsActivator.getSessionUser().getRealName());
			t.setModifierId(CmsActivator.getSessionUser().getId());
			linksDao.update(t);
			CmsActivator.getOperationLogService().logOP("编辑id为【"+t.getId()+"】的链接");
			return Result.success(R.Links.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Links.class)));
		} catch (Exception e) {
			return Result.failure(R.Links.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Links> getBeanById(Serializable id) {
		try {
			return Result.value(linksDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Links.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Links> getBeanByFilter(Filter filter) {
		try {
			return Result.value(linksDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Links.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Links>> getList() {
		try {
			return Result.value(linksDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Links.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Links>> getListByFilter(Filter filter) {
		try {
			return Result.value(linksDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ArticleType.LOAD_FAILURE);
		}
	}

	@Override
	public void deleteByParamId(Long paramId) {
		Session session = null;
		Transaction tr = null;
		try {
			session = linksDao.openSession();
			tr = session.beginTransaction();
			String sql = "DELETE FROM cms_links WHERE param_id="+paramId;
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
