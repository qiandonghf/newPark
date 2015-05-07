package com.wiiy.pb.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.pb.entity.GardenApply;

/**
 * <br/>class-description 苗圃项目日志
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class GardenApplyLog extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 苗圃申请实体
	 */
	@FieldDescription("苗圃申请实体")
	private GardenApply gardenApply;
	/**
	 * 苗圃申请外键
	 */
	@FieldDescription("苗圃申请外键")
	private Long applyId;
	/**
	 * 内容
	 */
	@FieldDescription("内容")
	private String content;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 苗圃申请实体
	 */
	public GardenApply getGardenApply(){
		return gardenApply;
	}
	public void setGardenApply(GardenApply gardenApply){
		this.gardenApply = gardenApply;
	}
	/**
	 * 苗圃申请外键
	 */
	public Long getApplyId(){
		return applyId;
	}
	public void setApplyId(Long applyId){
		this.applyId = applyId;
	}
	/**
	 * 内容
	 */
	public String getContent(){
		return content;
	}
	public void setContent(String content){
		this.content = content;
	}
}