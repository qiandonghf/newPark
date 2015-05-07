package com.wiiy.crm.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.core.entity.DataDict;

/**
 * <br/>class-description 企业产品
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Product extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 企业
	 */
	@FieldDescription("企业")
	private Customer customer;
	/**
	 * 产品阶段
	 */
	@FieldDescription("产品阶段")
	private DataDict stage;
	/**
	 * 技术领域
	 */
	@FieldDescription("技术领域")
	private DataDict technic;
	/**
	 * 企业外键
	 */
	@FieldDescription("企业外键")
	private Long customerId;
	/**
	 * 产品阶段外键
	 */
	@FieldDescription("产品阶段外键")
	private String stageId;
	/**
	 * 技术领域外键
	 */
	@FieldDescription("技术领域外键")
	private String technicId;
	/**
	 * 产品名称
	 */
	@FieldDescription("产品名称")
	private String name;
	/**
	 * 产品简介
	 */
	@FieldDescription("产品简介")
	private String introduction;
	/**
	 * 是否发布到网站
	 */
	@FieldDescription("是否发布到网站")
	private BooleanEnum pub;
	/**
	 * 产品照片
	 */
	@FieldDescription("产品照片")
	private String photos;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 企业
	 */
	public Customer getCustomer(){
		return customer;
	}
	public void setCustomer(Customer customer){
		this.customer = customer;
	}
	/**
	 * 产品阶段
	 */
	public DataDict getStage(){
		return stage;
	}
	public void setStage(DataDict stage){
		this.stage = stage;
	}
	/**
	 * 技术领域
	 */
	public DataDict getTechnic(){
		return technic;
	}
	public void setTechnic(DataDict technic){
		this.technic = technic;
	}
	/**
	 * 企业外键
	 */
	public Long getCustomerId(){
		return customerId;
	}
	public void setCustomerId(Long customerId){
		this.customerId = customerId;
	}
	/**
	 * 产品阶段外键
	 */
	public String getStageId(){
		return stageId;
	}
	public void setStageId(String stageId){
		this.stageId = stageId;
	}
	/**
	 * 技术领域外键
	 */
	public String getTechnicId(){
		return technicId;
	}
	public void setTechnicId(String technicId){
		this.technicId = technicId;
	}
	/**
	 * 产品名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 产品简介
	 */
	public String getIntroduction(){
		return introduction;
	}
	public void setIntroduction(String introduction){
		this.introduction = introduction;
	}
	/**
	 * 是否发布到网站
	 */
	public BooleanEnum getPub(){
		return pub;
	}
	public void setPub(BooleanEnum pub){
		this.pub = pub;
	}
	/**
	 * 产品照片
	 */
	public String getPhotos(){
		return photos;
	}
	public void setPhotos(String photos){
		this.photos = photos;
	}
}