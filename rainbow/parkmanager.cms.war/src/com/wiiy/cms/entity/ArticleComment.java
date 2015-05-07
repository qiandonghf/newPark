package com.wiiy.cms.entity;

import java.io.Serializable;

import com.wiiy.cms.entity.Article;
import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;

/**
 * <br/>class-description 文章评论
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class ArticleComment extends BaseEntity implements Serializable {
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
	 * 文章外键
	 */
	@FieldDescription("文章外键")
	private Long articleId;
	/**
	 * IP
	 */
	@FieldDescription("IP")
	private String ip;
	/**
	 * 评论内容
	 */
	@FieldDescription("评论内容")
	private String content;

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
	 * 文章外键
	 */
	public Long getArticleId(){
		return articleId;
	}
	public void setArticleId(Long articleId){
		this.articleId = articleId;
	}
	/**
	 * IP
	 */
	public String getIp(){
		return ip;
	}
	public void setIp(String ip){
		this.ip = ip;
	}
	/**
	 * 评论内容
	 */
	public String getContent(){
		return content;
	}
	public void setContent(String content){
		this.content = content;
	}
}