package com.wiiy.pb.entity;

import java.io.Serializable;
import java.math.BigDecimal;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.pb.entity.Building;
import com.wiiy.pb.preferences.enums.BillingMethodEnum;
import com.wiiy.pb.preferences.enums.CheckOutTypeEnum;
import com.wiiy.pb.preferences.enums.FacilityStatusEnum;
import com.wiiy.pb.preferences.enums.FacilityTypeEnum;

/**
 * <br/>class-description 公共设施
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Facility extends BaseEntity implements Serializable {
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
	 * 设施名称
	 */
	@FieldDescription("设施名称")
	private String name;
	/**
	 * 楼宇外键
	 */
	@FieldDescription("楼宇外键")
	private Long buildingId;
	/**
	 * 园区Id
	 */
	@FieldDescription("园区Id")
	private Long parkId;
	/**
	 * 设施名称
	 */
	@FieldDescription("设施名称")
	private String parkName;
	/**
	 * 设施类型
	 */
	@FieldDescription("设施类型")
	private FacilityTypeEnum type;
	/**
	 * 设施状态
	 */
	@FieldDescription("设施状态")
	private FacilityStatusEnum status;
	/**
	 * 是否收费
	 */
	@FieldDescription("是否收费")
	private BooleanEnum bcharge;
	/**
	 * 结算类型
	 */
	@FieldDescription("结算类型")
	private CheckOutTypeEnum checkType;
	/**
	 * 计费类型
	 */
	@FieldDescription("计费类型")
	private BillingMethodEnum billingMethod;
	/**
	 * 单价
	 */
	@FieldDescription("单价")
	private BigDecimal price;
	/**
	 * 是否独享资源
	 */
	@FieldDescription("是否独享资源")
	private BooleanEnum bshare;
	/**
	 * 设施介绍
	 */
	@FieldDescription("设施介绍")
	private String summary;
	/**
	 * 设施照片
	 */
	@FieldDescription("设施照片")
	private String photos;

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
	 * 设施名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
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
	 * 园区Id
	 */
	public Long getParkId(){
		return parkId;
	}
	public void setParkId(Long parkId){
		this.parkId = parkId;
	}
	/**
	 * 设施名称
	 */
	public String getParkName(){
		return parkName;
	}
	public void setParkName(String parkName){
		this.parkName = parkName;
	}
	/**
	 * 设施类型
	 */
	public FacilityTypeEnum getType(){
		return type;
	}
	public void setType(FacilityTypeEnum type){
		this.type = type;
	}
	/**
	 * 设施状态
	 */
	public FacilityStatusEnum getStatus(){
		return status;
	}
	public void setStatus(FacilityStatusEnum status){
		this.status = status;
	}
	/**
	 * 是否收费
	 */
	public BooleanEnum getBcharge(){
		return bcharge;
	}
	public void setBcharge(BooleanEnum bcharge){
		this.bcharge = bcharge;
	}
	/**
	 * 结算类型
	 */
	public CheckOutTypeEnum getCheckType(){
		return checkType;
	}
	public void setCheckType(CheckOutTypeEnum checkType){
		this.checkType = checkType;
	}
	/**
	 * 计费类型
	 */
	public BillingMethodEnum getBillingMethod(){
		return billingMethod;
	}
	public void setBillingMethod(BillingMethodEnum billingMethod){
		this.billingMethod = billingMethod;
	}
	/**
	 * 单价
	 */
	public BigDecimal getPrice(){
		return price;
	}
	public void setPrice(BigDecimal price){
		this.price = price;
	}
	/**
	 * 是否独享资源
	 */
	public BooleanEnum getBshare(){
		return bshare;
	}
	public void setBshare(BooleanEnum bshare){
		this.bshare = bshare;
	}
	/**
	 * 设施介绍
	 */
	public String getSummary(){
		return summary;
	}
	public void setSummary(String summary){
		this.summary = summary;
	}
	/**
	 * 设施照片
	 */
	public String getPhotos(){
		return photos;
	}
	public void setPhotos(String photos){
		this.photos = photos;
	}
}