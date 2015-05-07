package com.wiiy.oa.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;

/**
 * <br/>class-description 用户公告
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class UserNotice extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 用户ID
	 */
	@FieldDescription("用户ID")
	private Long userId;
	/**
	 * 公告ID
	 */
	@FieldDescription("公告ID")
	private Long noticeId;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 用户ID
	 */
	public Long getUserId(){
		return userId;
	}
	public void setUserId(Long userId){
		this.userId = userId;
	}
	/**
	 * 公告ID
	 */
	public Long getNoticeId(){
		return noticeId;
	}
	public void setNoticeId(Long noticeId){
		this.noticeId = noticeId;
	}
}