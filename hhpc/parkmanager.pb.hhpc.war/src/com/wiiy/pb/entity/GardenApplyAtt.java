package com.wiiy.pb.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.pb.entity.GardenApply;
import com.wiiy.pb.preferences.enums.GardenApplyAttTypeEnum;

/**
 * <br/>class-description 苗圃申请附件
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class GardenApplyAtt extends BaseEntity implements Serializable {
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
	/**
	 * 附件类型
	 */
	@FieldDescription("附件类型")
	private GardenApplyAttTypeEnum type;

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
	/**
	 * 附件类型
	 */
	public GardenApplyAttTypeEnum getType(){
		return type;
	}
	public void setType(GardenApplyAttTypeEnum type){
		this.type = type;
	}
}