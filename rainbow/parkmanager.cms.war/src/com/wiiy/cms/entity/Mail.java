package com.wiiy.cms.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

import com.wiiy.cms.entity.ArticleAtt;
import com.wiiy.cms.entity.Param;
import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;

/**
 * <br/>class-description 邮件管理
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Mail extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 网站
	 */
	@FieldDescription("网站")
	private Param param;
	/**
	 * 网站外键
	 */
	@FieldDescription("网站外键")
	private Long paramId;
	/**
	 * 电子邮件
	 */
	@FieldDescription("电子邮件")
	private String email;
	/**
	 * 订阅时间
	 */
	@FieldDescription("订阅时间")
	private Date time;
	/**
	 * 文章外键Id
	 */
	@FieldDescription("文章外键Id")
	private Set<ArticleAtt> articleAtts;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 网站
	 */
	public Param getParam(){
		return param;
	}
	public void setParam(Param param){
		this.param = param;
	}
	/**
	 * 网站外键
	 */
	public Long getParamId(){
		return paramId;
	}
	public void setParamId(Long paramId){
		this.paramId = paramId;
	}
	/**
	 * 电子邮件
	 */
	public String getEmail(){
		return email;
	}
	public void setEmail(String email){
		this.email = email;
	}
	/**
	 * 订阅时间
	 */
	public Date getTime(){
		return time;
	}
	public void setTime(Date time){
		this.time = time;
	}
	/**
	 * 文章外键Id
	 */
	public Set<ArticleAtt> getArticleAtts(){
		return articleAtts;
	}
	public void setArticleAtts(Set<ArticleAtt> articleAtts){
		this.articleAtts = articleAtts;
	}
}