package com.wiiy.oa.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.oa.entity.Notice;

/**
 * <br/>class-description 公告附件
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class NoticeAtt extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 公告
	 */
	@FieldDescription("公告")
	private Notice notice;
	/**
	 * 公告外键
	 */
	@FieldDescription("公告外键")
	private Long noticeId;
	/**
	 * 附件名称
	 */
	@FieldDescription("附件名称")
	private String name;
	/**
	 * 重命名名称
	 */
	@FieldDescription("重命名名称")
	private String newName;
	/**
	 * 附件大小
	 */
	@FieldDescription("附件大小")
	private Long size;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 公告
	 */
	public Notice getNotice(){
		return notice;
	}
	public void setNotice(Notice notice){
		this.notice = notice;
	}
	/**
	 * 公告外键
	 */
	public Long getNoticeId(){
		return noticeId;
	}
	public void setNoticeId(Long noticeId){
		this.noticeId = noticeId;
	}
	/**
	 * 附件名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 重命名名称
	 */
	public String getNewName(){
		return newName;
	}
	public void setNewName(String newName){
		this.newName = newName;
	}
	/**
	 * 附件大小
	 */
	public Long getSize(){
		return size;
	}
	public void setSize(Long size){
		this.size = size;
	}
}