package com.wiiy.cms.service.impl;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.cms.activator.CmsActivator;
import com.wiiy.cms.dao.ArticleTypeDao;
import com.wiiy.cms.entity.ArticleType;
import com.wiiy.cms.preferences.R;
import com.wiiy.cms.preferences.enums.ArticleKindEnum;
import com.wiiy.cms.service.ArticleTypeService;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;

public class ArticleTypeServiceImpl implements ArticleTypeService {
	private ArticleTypeDao articleTypeDao;
	public void setArticleTypeDao(ArticleTypeDao articleTypeDao) {
		this.articleTypeDao = articleTypeDao;
	}
	
	@Override
	public Result<ArticleType> save(ArticleType t) {
		try{
			t.setCreateTime(new Date());
			try {
				t.setCreator(CmsActivator.getSessionUser().getRealName());
				t.setCreatorId(CmsActivator.getSessionUser().getId());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			String parentIds = ",";
			if(t.getParentId()!=null){
				parentIds = addParentIds(parentIds,t.getParentId());
			}
			t.setParentIds(parentIds);
			articleTypeDao.save(t);
			CmsActivator.getOperationLogService().logOP("添加id为【"+t.getId()+"】的文章栏目");
			return Result.success(R.ArticleType.SAVE_SUCCESS,t);
		}catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ArticleType.class)));
		}catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.ArticleType.SAVE_FAILURE);
		}
	}
	
	public String addParentIds(String parentIds,Long id){
		ArticleType articleType = articleTypeDao.getBeanById(id);
		if(!articleType.getParentIds().equals(",")){
			parentIds = articleType.getParentIds()+id+",";
		}else{
			parentIds = ","+id+",";
		}
		return parentIds;
	}
	
	@Override
	public Result<ArticleType> update(ArticleType t) {
		try {
			if(t.getParentId()!=null){
				ArticleType articleType = getBeanByFilter(new Filter(ArticleType.class).eq("id", t.getParentId())).getValue();
				t.setLevel(articleType.getLevel()+1);
				String parentIds = ",";
				if(t.getParentId()!=null){
					parentIds = addParentIds(parentIds,t.getParentId());
				}
				t.setParentIds(parentIds);
			}
			t.setModifyTime(new Date());
			try {
				t.setModifier(CmsActivator.getSessionUser().getRealName());
				t.setModifierId(CmsActivator.getSessionUser().getId());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			Session session = articleTypeDao.openSession();
			session.beginTransaction();
			String sql = "UPDATE cms_article SET kind='"+t.getKind()+"' WHERE type_id="+t.getId();
			SQLQuery query = session.createSQLQuery(sql);
			query.executeUpdate();
			sql = "select id from cms_article where type_id = "+t.getId();
			List list = session.createSQLQuery(sql).list();
			//单页
			ArticleKindEnum kind = t.getKind();
			if (list == null || list.size() == 0) {
				if (kind == ArticleKindEnum.SINGLE ) {
					String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
					sql = "insert into cms_article (type_id,param_id,title,pubed,hits,kind,deleted,create_time,entity_status) values(";
					sql += t.getId()+","+t.getParamId()+",'"+t.getTypeName()+"','NO',0,'"+kind+"','NO','"+date+"','NORMAL')";
					session.createSQLQuery(sql).executeUpdate();
				}
			}
			
			session.getTransaction().commit();
			articleTypeDao.update(t);
			CmsActivator.getOperationLogService().logOP("编辑id为【"+t.getId()+"】的文章栏目");
			return Result.success(R.ArticleType.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ArticleType.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.ArticleType.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<ArticleType> delete(ArticleType t) {
		try {
			articleTypeDao.delete(t);
			CmsActivator.getOperationLogService().logOP("删除id为【"+t.getId()+"】的文章栏目");
			return Result.success(R.ArticleType.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure("请先删除相关的子栏目或相关栏目的文章");
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.ArticleType.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ArticleType> deleteById(Serializable id) {
		try {
			articleTypeDao.deleteById(id);
			CmsActivator.getOperationLogService().logOP("删除id为【"+id+"】的文章栏目");
			return Result.success(R.ArticleType.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure("请先删除相关的子栏目或相关栏目的文章");
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.ArticleType.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ArticleType> deleteByIds(String ids) {
		try {
			articleTypeDao.deleteByIds(ids);
			for(String id : ids.split(",")){
				CmsActivator.getOperationLogService().logOP("删除id为【"+id+"】的文章栏目");
			}
			return Result.success(R.ArticleType.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure("请先删除相关的子栏目或相关栏目的文章");
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.ArticleType.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ArticleType> getBeanByFilter(Filter filter) {
		try {
			return Result.value(articleTypeDao.getBeanByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.ArticleType.LOAD_FAILURE);
		}
	}

	@Override
	public Result<ArticleType> getBeanById(Serializable id) {
		try {
			return Result.value(articleTypeDao.getBeanById(id));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.ArticleType.LOAD_FAILURE);
		}
	}
	@Override
	public Result<List<ArticleType>> getList() {
		try {
			return Result.value(articleTypeDao.getList());
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.ArticleType.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ArticleType>> getListByFilter(Filter filter) {
		try {
			return Result.value(articleTypeDao.getListByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.ArticleType.LOAD_FAILURE);
		}
	}

	@Override
	public Result<ArticleType> AddManageIdsAndNames(
			String ids,
			String managerIds,
			String managerNames) {
		Session session = null;
		Transaction tr = null;
		try {
			session = articleTypeDao.openSession();
			tr = session.beginTransaction();
			String sql = null;
			if (managerIds == null && managerNames == null) {
				sql = "UPDATE cms_article_type SET " +
						"manager_ids=null,manager_names=null WHERE id in("+ids+")";
			}else {
				sql = "UPDATE cms_article_type SET " +
						"manager_ids='"+managerIds+"',manager_names='" +managerNames+
						"' WHERE id in("+ids+")";
			}
			session.createSQLQuery(sql).executeUpdate();
			tr.commit();
			return Result.success("管理员设置成功");
		} catch (UKConstraintException e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.
					getFieldDescriptionByColumnName(e.getUK(),ArticleType.class)));
		} catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure("管理员设置失败");
		}finally{
			if (session != null) {
				session.close();
			}
		}
	}

	@SuppressWarnings("rawtypes")
	@Override
	public Result updateFieldById(String field, Long value, Long id) {
		Session session = null;
		Transaction tr = null;
		try {
			session = articleTypeDao.openSession();
			tr = session.beginTransaction();
			String sql = "UPDATE cms_article_type SET "+field+"="+value+" WHERE parent_ids LIKE '%,"+id+",%'";
			session.createSQLQuery(sql).executeUpdate();
			tr.commit();
			return Result.success("更新成功");
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure("更新失败");
		}finally{
			if (session != null) {
				session.close();
			}
		}
	}

	@Override
	public void executeSQLUpdate(String sql) {
		try {
			articleTypeDao.executeSQLUpdate(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List createSqlQuery(String sql) {
		Session session = null;
		try{
			session = articleTypeDao.openSession();
			return session.createSQLQuery(sql).list();
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}


}
