package com.wiiy.cms.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.User;
import com.wiiy.cms.entity.Document;
import com.wiiy.cms.preferences.enums.DocTypeEnum;

/**
 * <br/>class-description 文档
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class DocShare extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 文档实体
	 */
	@FieldDescription("文档实体")
	private Document document;
	/**
	 * 用户实体
	 */
	@FieldDescription("用户实体")
	private User user;
	/**
	 * 文档外键
	 */
	@FieldDescription("文档外键")
	private Long documentId;
	/**
	 * 用户外键
	 */
	@FieldDescription("用户外键")
	private Long userId;
	/**
	 * 文档类型
	 */
	@FieldDescription("文档类型")
	private DocTypeEnum docType;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 文档实体
	 */
	public Document getDocument(){
		return document;
	}
	public void setDocument(Document document){
		this.document = document;
	}
	/**
	 * 用户实体
	 */
	public User getUser(){
		return user;
	}
	public void setUser(User user){
		this.user = user;
	}
	/**
	 * 文档外键
	 */
	public Long getDocumentId(){
		return documentId;
	}
	public void setDocumentId(Long documentId){
		this.documentId = documentId;
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
	 * 文档类型
	 */
	public DocTypeEnum getDocType() {
		return docType;
	}
	public void setDocType(DocTypeEnum docType) {
		this.docType = docType;
	}
}