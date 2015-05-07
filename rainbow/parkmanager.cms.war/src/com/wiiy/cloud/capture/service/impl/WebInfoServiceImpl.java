package com.wiiy.cloud.capture.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.cloud.capture.dao.WebInfoDao;
import com.wiiy.cloud.capture.entity.WebContent;
import com.wiiy.cloud.capture.entity.WebInfo;
import com.wiiy.cloud.capture.preferences.R;
import com.wiiy.cloud.capture.service.WebInfoService;
import com.wiiy.cms.activator.CmsActivator;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.entity.Org;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.ModulePrefixNamingStrategy;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;

public class WebInfoServiceImpl implements WebInfoService{
	private WebInfoDao webInfoDao;
	int level = 0;
	public void setWebInfoDao(WebInfoDao webInfoDao) {
		this.webInfoDao = webInfoDao;
	}

	@Override
	public Result<WebInfo> save(WebInfo t) {
		try{
			List<WebInfo> list = getListByFilter(new Filter(WebInfo.class).eq("name", t.getName())).getValue();
			if(list!=null && list.size()>0){
				return Result.failure("网站名称已存在");
			}
			if(t.getParentId()!=null){
				WebInfo parent = getBeanByFilter(new Filter(WebInfo.class).eq("id", t.getParentId())).getValue();
				if(parent!=null){
					level = parent.getLevel()+1;
				}
			}
			t.setLevel(level);
			t.setCreateTime(new Date());
			t.setCreator(CmsActivator.getSessionUser().getRealName());
			t.setCreatorId(CmsActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			webInfoDao.save(t);
			return Result.success(R.WebInfo.SAVE_SUCCESS);
		}catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),WebInfo.class)));
		}catch (Exception e) {
			return Result.failure(R.WebInfo.SAVE_FAILURE);
		}
	}

	@Override
	public Result<WebInfo> update(WebInfo t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CmsActivator.getSessionUser().getRealName());
			t.setModifierId(CmsActivator.getSessionUser().getId());
			webInfoDao.update(t);
			return Result.success(R.WebInfo.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),WebInfo.class)));
		} catch (Exception e) {
			return Result.failure(R.WebInfo.UPDATE_FAILURE);
		}
	}
	
	@Override
	public Result<WebInfo> delete(WebInfo t) {
		try {
			webInfoDao.delete(t);
			return Result.success(R.WebInfo.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.WebInfo.DELETE_FAILURE);
		}
	}

	@Override
	public Result<WebInfo> deleteById(Serializable id) {
		try {
			webInfoDao.deleteById(id);
			return Result.success(R.WebInfo.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.WebInfo.DELETE_FAILURE);
		}
	}

	@Override
	public Result<WebInfo> deleteByIds(String ids) {
		try {
			webInfoDao.deleteByIds(ids);
			return Result.success(R.WebInfo.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.WebInfo.DELETE_FAILURE);
		}
	}

	@Override
	public Result<WebInfo> getBeanByFilter(Filter filter) {
		try {			
			return Result.value(webInfoDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.WebInfo.LOAD_FAILURE);
		}
	}

	@Override
	public Result<WebInfo> getBeanById(Serializable id) {
		try {
			return Result.value(webInfoDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.WebInfo.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<WebInfo>> getList() {
		try {
			return Result.value(webInfoDao.getList());
		} catch (Exception e) {
			return Result.failure(R.WebInfo.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<WebInfo>> getListByFilter(Filter filter) {
		try {
			System.out.println(webInfoDao.getListByFilter(filter).size());
			return Result.value(webInfoDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.WebInfo.LOAD_FAILURE);
		}
	}

	@Override
	public void saveContent(WebContent webContent) {
		Session session = null;
		Transaction tr = null;
		try{
			session = webInfoDao.openSession();
			tr = session.beginTransaction();
			webContent.setCreateTime(new Date());
			webContent.setEntityStatus(EntityStatus.NORMAL);
			session.save(webContent);
			tr.commit();
		}catch (Exception e) {
			tr.rollback();
		}finally{
			session.close();
		}
	}

	@Override
	public List<WebContent> getWebContentListByIdRegex(String id) {
		Session session = null;
		Transaction tr = null;
		try{
			session = webInfoDao.openSession();
			tr = session.beginTransaction();
			List<WebContent> list = new ArrayList<WebContent>();
			String sql = "SELECT c.title FROM "+ModulePrefixNamingStrategy.classToTableName(WebContent.class)+
					" c WHERE c.contentId ='"+id+"' GROUP BY c.title";
			list = webInfoDao.getObjectListBySql(sql);
			tr.commit();
			return list;
		}catch (Exception e) {
			tr.rollback();
			return null;
		}finally{
			session.close();
		}
	}

	@Override
	public void updateContent(WebContent webContent) {
		Session session = null;
		Transaction tr = null;
		try{
			session = webInfoDao.openSession();
			tr = session.beginTransaction();
			webContent.setCreateTime(new Date());
			webContent.setEntityStatus(EntityStatus.NORMAL);
			session.update(webContent);
			tr.commit();
		}catch (Exception e) {
			tr.rollback();
		}finally{
			session.close();
		}
	}

	@Override
	public List<WebContent> getContentById(Long id) {
		Session session = null;
		Transaction tr = null;
		try{
			session = webInfoDao.openSession();
			tr = session.beginTransaction();
			List<WebContent> list = new ArrayList<WebContent>();
			String sql = "SELECT c.title FROM "+ModulePrefixNamingStrategy.classToTableName(WebContent.class)+
					" c WHERE c.webInfo_id ='"+id+"' GROUP BY c.title";
			list = webInfoDao.getObjectListBySql(sql);
			tr.commit();
			return list;
		}catch (Exception e) {
			tr.rollback();
			return null;
		}finally{
			session.close();
		}
	}

}