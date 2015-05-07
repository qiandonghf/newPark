package com.wiiy.crm.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.core.entity.ContactEntity;

/**
 * <br/>class-description 创业服务中心工作联系单
 * <br/>extends com.wiiy.core.entity.ContactEntity
 */
public class BusinessCenterContact extends ContactEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 部门外键
	 */
	@FieldDescription("部门外键")
	private Long orgId;
	/**
	 * 部门名称
	 */
	@FieldDescription("部门名称")
	private String org;
	/**
	 * 联系内容
	 */
	@FieldDescription("联系内容")
	private String content;
	/**
	 * 处理意见
	 */
	@FieldDescription("处理意见")
	private String opinion1;
	/**
	 * 处理意见ID
	 */
	@FieldDescription("处理意见ID")
	private Long opinion1Id;
	/**
	 * 被联系单位 或部门意见
	 */
	@FieldDescription("被联系单位 或部门意见")
	private String opinion2;
	/**
	 * 被联系单位 或部门意见ID
	 */
	@FieldDescription("被联系单位 或部门意见ID")
	private Long opinion2Id;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 部门外键
	 */
	public Long getOrgId(){
		return orgId;
	}
	public void setOrgId(Long orgId){
		this.orgId = orgId;
	}
	/**
	 * 部门名称
	 */
	public String getOrg(){
		return org;
	}
	public void setOrg(String org){
		this.org = org;
	}
	/**
	 * 联系内容
	 */
	public String getContent(){
		return content;
	}
	public void setContent(String content){
		this.content = content;
	}
	/**
	 * 处理意见
	 */
	public String getOpinion1(){
		return opinion1;
	}
	public void setOpinion1(String opinion1){
		this.opinion1 = opinion1;
	}
	/**
	 * 处理意见ID
	 */
	public Long getOpinion1Id(){
		return opinion1Id;
	}
	public void setOpinion1Id(Long opinion1Id){
		this.opinion1Id = opinion1Id;
	}
	/**
	 * 被联系单位 或部门意见
	 */
	public String getOpinion2(){
		return opinion2;
	}
	public void setOpinion2(String opinion2){
		this.opinion2 = opinion2;
	}
	/**
	 * 被联系单位 或部门意见ID
	 */
	public Long getOpinion2Id(){
		return opinion2Id;
	}
	public void setOpinion2Id(Long opinion2Id){
		this.opinion2Id = opinion2Id;
	}
}