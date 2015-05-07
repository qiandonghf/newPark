package com.wiiy.oa.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.core.entity.Org;

/**
 * <br/>class-description 任务部门
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class TaskDepart extends TreeEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 关联部门
	 */
	@FieldDescription("关联部门")
	private Org org;
	/**
	 * 部门名称
	 */
	@FieldDescription("部门名称")
	private String name;
	/**
	 * 关联部门ID
	 */
	@FieldDescription("关联部门ID")
	private Long orgId;
	/**
	 * 备注
	 */
	@FieldDescription("备注")
	private String memo;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 关联部门
	 */
	public Org getOrg(){
		return org;
	}
	public void setOrg(Org org){
		this.org = org;
	}
	/**
	 * 部门名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 关联部门ID
	 */
	public Long getOrgId(){
		return orgId;
	}
	public void setOrgId(Long orgId){
		this.orgId = orgId;
	}
	/**
	 * 备注
	 */
	public String getMemo(){
		return memo;
	}
	public void setMemo(String memo){
		this.memo = memo;
	}
}