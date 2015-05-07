package com.wiiy.oa.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.Org;
import com.wiiy.oa.preferences.enums.PositionConditionEnum;

/**
 * <br/>class-description 职位
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Position extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 姓名
	 */
	@FieldDescription("姓名")
	private String name;
	/**
	 * 职位
	 */
	@FieldDescription("职位")
	private String post;
	/**
	 * 所属部门
	 */
	@FieldDescription("所属部门")
	private Org org;
	
	/**
	 * 部门外键
	 */
	@FieldDescription("部门外键")
	private Long orgId;
	
	/**
	 * 职责
	 */
	@FieldDescription("职责")
	private String memo;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	
	/**
	 * 所属部门
	 */
	public Org getOrg() {
		return org;
	}
	public void setOrg(Org org) {
		this.org = org;
	}
	/**
	 * 部门外键
	 */
	public Long getOrgId() {
		return orgId;
	}
	public void setOrgId(Long orgId) {
		this.orgId = orgId;
	}
	/**
	 * 姓名
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 职位
	 */
	public String getPost(){
		return post;
	}
	public void setPost(String post){
		this.post = post;
	}
	/**
	 * 职责
	 */
	public String getMemo(){
		return memo;
	}
	public void setMemo(String memo){
		this.memo = memo;
	}
}