package com.wiiy.cloud.capture.entity;

import java.io.Serializable;

import com.wiiy.cloud.capture.entity.WebContent;
import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.User;

/**
 * <br/>class-description 网站内容收藏
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class WebContentConfig extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 网站内容
	 */
	@FieldDescription("网站内容")
	private WebContent webContent;
	/**
	 * 用户
	 */
	@FieldDescription("用户")
	private User user;
	/**
	 * 网站内容外键
	 */
	@FieldDescription("网站内容外键")
	private Long webContentId;
	/**
	 * 用户外键
	 */
	@FieldDescription("用户外键")
	private Long userId;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 网站内容
	 */
	public WebContent getWebContent(){
		return webContent;
	}
	public void setWebContent(WebContent webContent){
		this.webContent = webContent;
	}
	/**
	 * 用户
	 */
	public User getUser(){
		return user;
	}
	public void setUser(User user){
		this.user = user;
	}
	/**
	 * 网站内容外键
	 */
	public Long getWebContentId(){
		return webContentId;
	}
	public void setWebContentId(Long webContentId){
		this.webContentId = webContentId;
	}
	/**
	 * 用户外键
	 */
	public Long getUserId(){
		return userId;
	}
	public void setUserId(Long userId){
		this.userId = userId;
	}
}