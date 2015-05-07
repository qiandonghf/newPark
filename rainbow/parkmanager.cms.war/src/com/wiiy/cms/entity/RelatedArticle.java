package com.wiiy.cms.entity;

import java.io.Serializable;

import com.wiiy.cms.entity.Article;
import com.wiiy.commons.annotation.FieldDescription;

/**
 * <br/>class-description 关联文章
 */
public class RelatedArticle implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 文章
	 */
	@FieldDescription("文章")
	private Article article;
	/**
	 * 文章
	 */
	@FieldDescription("文章")
	private Article relatedArticle;
	/**
	 * 文章外键
	 */
	@FieldDescription("文章外键")
	private Long articleId;
	/**
	 * 文章外键
	 */
	@FieldDescription("文章外键")
	private Long relatedId;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 文章
	 */
	public Article getArticle(){
		return article;
	}
	public void setArticle(Article article){
		this.article = article;
	}
	/**
	 * 文章
	 */
	public Article getRelatedArticle(){
		return relatedArticle;
	}
	public void setRelatedArticle(Article relatedArticle){
		this.relatedArticle = relatedArticle;
	}
	/**
	 * 文章外键
	 */
	public Long getArticleId(){
		return articleId;
	}
	public void setArticleId(Long articleId){
		this.articleId = articleId;
	}
	/**
	 * 文章外键
	 */
	public Long getRelatedId(){
		return relatedId;
	}
	public void setRelatedId(Long relatedId){
		this.relatedId = relatedId;
	}
}