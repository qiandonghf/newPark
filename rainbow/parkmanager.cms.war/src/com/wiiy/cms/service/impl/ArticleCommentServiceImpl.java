package com.wiiy.cms.service.impl;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import com.wiiy.cms.activator.CmsActivator;
import com.wiiy.cms.dao.ArticleCommentDao;
import com.wiiy.cms.entity.ArticleComment;
import com.wiiy.cms.preferences.R;
import com.wiiy.cms.service.ArticleCommentService;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;

public class ArticleCommentServiceImpl implements ArticleCommentService{
	private ArticleCommentDao articleCommentDao;
	@Override
	public Result<ArticleComment> save(ArticleComment t) {
		try{
			t.setCreateTime(new Date());
			t.setCreator(CmsActivator.getSessionUser().getRealName());
			t.setCreatorId(CmsActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			articleCommentDao.save(t);
			CmsActivator.getOperationLogService().logOP("添加id为【"+t.getId()+"】的文章评论");
			return Result.success(R.ArticleComment.SAVE_SUCCESS,t);
		}catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ArticleComment.class)));
		}catch (Exception e) {
			return Result.failure(R.ArticleComment.SAVE_FAILURE);
		}
	}

	@Override
	public Result<ArticleComment> update(ArticleComment t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(CmsActivator.getSessionUser().getRealName());
			t.setModifierId(CmsActivator.getSessionUser().getId());
			articleCommentDao.update(t);
			CmsActivator.getOperationLogService().logOP("编辑id为【"+t.getId()+"】的文章评论");
			return Result.success(R.ArticleComment.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),ArticleComment.class)));
		} catch (Exception e) {
			return Result.failure(R.ArticleComment.UPDATE_FAILURE);
		}
	}
	
	@Override
	public Result<ArticleComment> delete(ArticleComment t) {
		try {
			articleCommentDao.delete(t);
			CmsActivator.getOperationLogService().logOP("删除id为【"+t.getId()+"】的文章评论");
			return Result.success(R.ArticleComment.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ArticleComment.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ArticleComment> deleteById(Serializable id) {
		try {
			articleCommentDao.deleteById(id);
			CmsActivator.getOperationLogService().logOP("删除id为【"+id+"】的文章评论");
			return Result.success(R.ArticleComment.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ArticleComment.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ArticleComment> deleteByIds(String ids) {
		try {
			articleCommentDao.deleteByIds(ids);
			for(String id : ids.split(",")){
				CmsActivator.getOperationLogService().logOP("删除id为【"+id+"】的文章评论");
			}
			return Result.success(R.ArticleComment.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(CmsActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.ArticleComment.DELETE_FAILURE);
		}
	}

	@Override
	public Result<ArticleComment> getBeanByFilter(Filter filter) {
		try {
			return Result.value(articleCommentDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ArticleComment.LOAD_FAILURE);
		}
	}

	@Override
	public Result<ArticleComment> getBeanById(Serializable id) {
		try {
			return Result.value(articleCommentDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.ArticleComment.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ArticleComment>> getList() {
		try {
			return Result.value(articleCommentDao.getList());
		} catch (Exception e) {
			return Result.failure(R.ArticleComment.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<ArticleComment>> getListByFilter(Filter filter) {
		try {
			return Result.value(articleCommentDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.ArticleComment.LOAD_FAILURE);
		}
	}

	public void setArticleCommentDao(ArticleCommentDao articleCommentDao) {
		this.articleCommentDao = articleCommentDao;
	}

}
