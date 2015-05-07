package com.wiiy.pb.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;

/**
 * <br/>class-description 车辆管理
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class VehicleManagement extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 牌照
	 */
	@FieldDescription("牌照")
	private String licenseTag;
	/**
	 * 车主姓名
	 */
	@FieldDescription("车主姓名")
	private String name;
	/**
	 * 所在单位
	 */
	@FieldDescription("所在单位")
	private String unit;
	/**
	 * 联系电话
	 */
	@FieldDescription("联系电话")
	private String phone;
	/**
	 * 缴费情况
	 */
	@FieldDescription("缴费情况")
	private String payment;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 牌照
	 */
	public String getLicenseTag(){
		return licenseTag;
	}
	public void setLicenseTag(String licenseTag){
		this.licenseTag = licenseTag;
	}
	/**
	 * 车主姓名
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 所在单位
	 */
	public String getUnit(){
		return unit;
	}
	public void setUnit(String unit){
		this.unit = unit;
	}
	/**
	 * 联系电话
	 */
	public String getPhone(){
		return phone;
	}
	public void setPhone(String phone){
		this.phone = phone;
	}
	/**
	 * 缴费情况
	 */
	public String getPayment(){
		return payment;
	}
	public void setPayment(String payment){
		this.payment = payment;
	}
}