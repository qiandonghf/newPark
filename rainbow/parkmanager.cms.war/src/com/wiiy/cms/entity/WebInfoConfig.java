package com.wiiy.cms.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.User;

/**
 * <br/>class-description 网站信息配置
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class WebInfoConfig extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 用户
	 */
	@FieldDescription("用户")
	private User user;
	/**
	 * 用户外键
	 */
	@FieldDescription("用户外键")
	private Long userId;
	/**
	 * 网站ids
	 */
	@FieldDescription("网站ids")
	private String webInfoIds;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
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
	 * 用户外键
	 */
	public Long getUserId(){
		return userId;
	}
	public void setUserId(Long userId){
		this.userId = userId;
	}
	/**
	 * 网站ids
	 */
	public String getWebInfoIds(){
		return webInfoIds;
	}
	public void setWebInfoIds(String webInfoIds){
		this.webInfoIds = webInfoIds;
	}
}