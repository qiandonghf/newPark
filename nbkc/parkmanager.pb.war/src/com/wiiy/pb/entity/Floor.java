package com.wiiy.pb.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.pb.entity.Building;

/**
 * <br/>class-description 楼层
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Floor extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 楼宇实体
	 */
	@FieldDescription("楼宇实体")
	private Building building;
	/**
	 * 楼宇外键
	 */
	@FieldDescription("楼宇外键")
	private Long buildingId;
	/**
	 * 楼层名称
	 */
	@FieldDescription("楼层名称")
	private String name;
	/**
	 * 楼层照片
	 */
	@FieldDescription("楼层照片")
	private String photo;
	/**
	 * 楼层显示顺序(数字小的在下面）
	 */
	@FieldDescription("楼层显示顺序(数字小的在下面）")
	private Integer orderNo;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 楼宇实体
	 */
	public Building getBuilding(){
		return building;
	}
	public void setBuilding(Building building){
		this.building = building;
	}
	/**
	 * 楼宇外键
	 */
	public Long getBuildingId(){
		return buildingId;
	}
	public void setBuildingId(Long buildingId){
		this.buildingId = buildingId;
	}
	/**
	 * 楼层名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 楼层照片
	 */
	public String getPhoto(){
		return photo;
	}
	public void setPhoto(String photo){
		this.photo = photo;
	}
	/**
	 * 楼层显示顺序(数字小的在下面）
	 */
	public Integer getOrderNo(){
		return orderNo;
	}
	public void setOrderNo(Integer orderNo){
		this.orderNo = orderNo;
	}
}