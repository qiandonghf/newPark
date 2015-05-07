package com.wiiy.cms.service.impl;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.imageio.ImageIO;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.cms.activator.CmsActivator;
import com.wiiy.cms.dao.ArticleDao;
import com.wiiy.cms.entity.Article;
import com.wiiy.cms.entity.ArticleAtt;
import com.wiiy.cms.preferences.R;
import com.wiiy.cms.preferences.enums.NewsTypeEnum;
import com.wiiy.cms.service.ArticleService;
import com.wiiy.cms.util.ImageUtil;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;

public class ArticleServiceImpl implements ArticleService {
	private ArticleDao articleDao;
	public void setArticleDao(ArticleDao articleDao) {
		this.articleDao = articleDao;
	}

	@Override
	public Result<Article> save(Article t) {
		try{
			t.setDeleted(BooleanEnum.NO);
			t.setCreateTime(new Date());
			try {
				t.setEditor(CmsActivator.getSessionUser().getRealName());
				t.setCreator(CmsActivator.getSessionUser().getRealName());
				t.setCreatorId(CmsActivator.getSessionUser().getId());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				//e.printStackTrace();
			}
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			articleDao.save(t);
			CmsActivator.getOperationLogService().logOP("添加id为【"+t.getId()+"】的文章");
			return Result.success(R.Article.SAVE_SUCCESS,t);
		}catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Article.class)));
		}catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Article.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Article> update(Article t) {
		try {
			t.setModifyTime(new Date());
			try {
				t.setModifier(CmsActivator.getSessionUser().getRealName());
				t.setModifierId(CmsActivator.getSessionUser().getId());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				//e.printStackTrace();
			}
			articleDao.update(t);
			if(t.getNewsType() !=null && t.getNewsType().equals(NewsTypeEnum.PHOTO) && t.getPhoto() !=null){
				ImageUtil.limitPhoto(t.getPhoto());
			}
			CmsActivator.getOperationLogService().logOP("编辑id为【"+t.getId()+"】的文章");
			return Result.success(R.Article.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Article.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Article.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Article> delete(Article t) {
		try {
			articleDao.delete(t);
			CmsActivator.getOperationLogService().logOP("删除id为【"+t.getId()+"】的文章");
			return Result.success(R.Article.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Article.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Article> deleteById(Serializable id) {
		try {
			articleDao.deleteById(id);
			CmsActivator.getOperationLogService().logOP("删除id为【"+id+"】的文章");
			return Result.success(R.Article.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Article.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Article> deleteByIds(String ids) {
		try {
			articleDao.deleteByIds(ids);
			for(String id : ids.split(",")){
				CmsActivator.getOperationLogService().logOP("删除id为【"+id+"】的文章");
			}
			return Result.success(R.Article.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			e.printStackTrace();
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Article.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Article> getBeanByFilter(Filter filter) {
		try {
			return Result.value(articleDao.getBeanByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Article.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Article> getBeanById(Serializable id) {
		try {
			return Result.value(articleDao.getBeanById(id));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Article.LOAD_FAILURE);
		}
	}
	@Override
	public Result<List<Article>> getList() {
		try {
			return Result.value(articleDao.getList());
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Article.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Article>> getListByFilter(Filter filter) {
		try {
			return Result.value(articleDao.getListByFilter(filter));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Article.LOAD_FAILURE);
		}
	}
	/***
	 * 文章还原
	 */
	@Override
	public Result restoreByIds(String ids) {
		Session session = null;
		Transaction tr = null;
		try {
			session = articleDao.openSession();
			tr = session.beginTransaction();
			for(String id : ids.split(",")){
				Article article = (Article) session.get(Article.class, Long.parseLong(id));
				article.setDeleted(BooleanEnum.NO);
				session.update(article);
				CmsActivator.getOperationLogService().logOP("还原id为【"+article.getId()+"】的文章");
			}
			tr.commit();
			return Result.success(R.Article.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Article.class)));
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.Article.UPDATE_FAILURE);
		} finally {
			session.close();
		}
	}
	
	@Override
	public Result restoreById(Long id) {
		try {
			Article t = getBeanById(id).getValue();
			t.setDeleted(BooleanEnum.NO);
			articleDao.update(t);
			CmsActivator.getOperationLogService().logOP("还原id为【"+t.getId()+"】的文章");
			return Result.success(R.Article.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Article.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Article.UPDATE_FAILURE);
		}
	}
	
	/***
	 * 统计点击次数
	 */
	@Override
	public Result<Article> view(Long id) {
		Session session = null;
		Transaction tr = null;
		try {
			session = articleDao.openSession();
			tr = session.beginTransaction();
			Article article = (Article) session.get(Article.class, id);
			int count = 0;
			if(article.getHits()!=null){
				count = article.getHits();
			}
			count++;
			article.setHits(count);
			session.update(article);
			tr.commit();
			return Result.success(R.Article.LOAD_SUCCESS,article);
		} catch (UKConstraintException e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Article.class)));
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.Article.LOAD_FAILURE);
		} finally {
			session.close();
		}
	}
	/***
	 * 文章放入回收站中
	 */
	@Override
	public Result recycleById(Long id) {
		try {
			Article t = getBeanById(id).getValue();
			t.setDeleted(BooleanEnum.YES);
			articleDao.update(t);
			return Result.success(R.Article.DELETE_SUCCESS,t);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Article.class)));
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure(R.Article.DELETE_FAILURE);
		}
	}

	@Override
	public Result recycleByIds(String ids) {
		Session session = null;
		Transaction tr = null;
		try {
			session = articleDao.openSession();
			tr = session.beginTransaction();
			for(String id : ids.split(",")){
				Article article = (Article) session.get(Article.class, Long.parseLong(id));
				article.setDeleted(BooleanEnum.YES);
				session.update(article);
			}
			tr.commit();
			return Result.success(R.Article.DELETE_SUCCESS);
		} catch (UKConstraintException e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Article.class)));
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure(R.Article.DELETE_FAILURE);
		} finally {
			session.close();
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Object> loadByTypeId(long typeId) {
		Session session = null;
		session = articleDao.openSession();
		String condition = "'%"+typeId+"%'";
		String sql = "SELECT id FROM cms_article_type WHERE parent_ids LIKE "+condition;
		return session.createSQLQuery(sql).list();
	}

	@Override
	public Result<Article> save(Article t, List<ArticleAtt> att) {
		Session session= null;
		Transaction tr = null;
		try{
			session= articleDao.openSession();
			tr = session.beginTransaction();
			t.setDeleted(BooleanEnum.NO);
			t.setCreateTime(new Date());
			try {
				t.setEditor(CmsActivator.getSessionUser().getRealName());
				t.setCreator(CmsActivator.getSessionUser().getRealName());
				t.setCreatorId(CmsActivator.getSessionUser().getId());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				//e.printStackTrace();
			}
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			articleDao.save(t);
			if(t.getNewsType() !=null && t.getNewsType().equals(NewsTypeEnum.PHOTO) && t.getPhoto() !=null){
				ImageUtil.limitPhoto(t.getPhoto());
			}
			long id = t.getId();
			for (int i = 0; i < att.size(); i++) {
				ArticleAtt a = att.get(0);
				String dt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
				String sql = "INSERT INTO cms_article_att(articleId,old_name,new_name,entity_status"
						+",create_time,creator,creator_id"
						+",modify_time,modifier,modifier_id)";
				sql += "VALUES ("+id+",'"+a.getOldName()+"','"+a.getNewName()+"','"+EntityStatus.NORMAL+"',";
				sql += "'"+dt+"','"+t.getCreator()+"',"+t.getCreatorId()+",";
				sql += "'"+dt+"','"+t.getCreator()+"',"+t.getCreatorId()+");";
				session.createSQLQuery(sql).executeUpdate();
			}
			CmsActivator.getOperationLogService().logOP("添加id为【"+t.getId()+"】的文章");
			tr.commit();
			return Result.success(R.Article.SAVE_SUCCESS,t);
		}catch (UKConstraintException e) {
			e.printStackTrace();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Article.class)));
		}catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(R.Article.SAVE_FAILURE);
		}
	}

	@Override
	public void deleteAttById(long id) {
		Session session = null;
		Transaction tr = null;
		try {
			session = articleDao.openSession();
			tr = session.beginTransaction();
			String sql = "DELETE FROM cms_article_att WHERE id="+id;
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

	@Override
	public Result<Article> update(Article t, List<ArticleAtt> att) {
		Session session = null;
		Transaction tr = null;
		try {
			session = articleDao.openSession();
			tr = session.beginTransaction();
			t.setModifyTime(new Date());
			try {
				t.setModifier(CmsActivator.getSessionUser().getRealName());
				t.setModifierId(CmsActivator.getSessionUser().getId());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				//e.printStackTrace();
			}
			//先删除所有的文章附件
			String sql = "DELETE FROM cms_article_att WHERE articleId="+t.getId();
			session.createSQLQuery(sql).executeUpdate();
			//将新的附件写入
			//Long id = t.getId();
			Set<ArticleAtt> set = new HashSet<ArticleAtt>();
			set.addAll(att);
			t.setArticleAtts(set);
			session.update(t);
			tr.commit();
			if (t.getNewsType() != null) {
				if (t.getNewsType() == NewsTypeEnum.PHOTO && t.getPhoto() != null) {
					ImageUtil.limitPhoto(t.getPhoto());
				}
			}
			CmsActivator.getOperationLogService().logOP("编辑id为【"+t.getId()+"】的文章");
			return Result.success(R.Article.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),Article.class)));
		} catch (Exception e) {
			e.printStackTrace();
			tr.rollback();
			return Result.failure(R.Article.UPDATE_FAILURE);
		}finally{
			if (session != null) {
				session.close();
			}
		}
	}
	
	public Result getRowCount(Filter filter){
		try{
			Integer counts = articleDao.getRowCount(filter);
			return Result.value(counts);
		}catch (Exception e) {
			e.printStackTrace();
			return Result.failure("查询记录数失败");
		}
	}
}
