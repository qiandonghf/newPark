package com.wiiy.cms.entity;

import java.io.Serializable;

import com.wiiy.cms.entity.Article;
import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;

/**
 * <br/>class-description 文章附件
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class ArticleAtt extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 文章外键Id
	 */
	@FieldDescription("文章外键Id")
	private Article article;
	/**
	 * 附件原始文件名
	 */
	@FieldDescription("附件原始文件名")
	private String oldName;
	/**
	 * 附件新文件名
	 */
	@FieldDescription("附件新文件名")
	private String newName;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 文章外键Id
	 */
	public Article getArticle(){
		return article;
	}
	public void setArticle(Article article){
		this.article = article;
	}
	/**
	 * 附件原始文件名
	 */
	public String getOldName(){
		return oldName;
	}
	public void setOldName(String oldName){
		this.oldName = oldName;
	}
	/**
	 * 附件新文件名
	 */
	public String getNewName(){
		return newName;
	}
	public void setNewName(String newName){
		this.newName = newName;
	}
}