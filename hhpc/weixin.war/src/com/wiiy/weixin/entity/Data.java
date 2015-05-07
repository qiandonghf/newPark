package com.wiiy.weixin.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;

/**
 * <br/>class-description Data
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Data extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 设备id
	 */
	@FieldDescription("设备id")
	private String did;
	/**
	 * 经度
	 */
	@FieldDescription("经度")
	private Double longitude;
	/**
	 * 纬度
	 */
	@FieldDescription("纬度")
	private Double latitude;
	/**
	 * 电压数据
	 */
	@FieldDescription("电压数据")
	private String batStr;
	/**
	 * 电话号码
	 */
	@FieldDescription("电话号码")
	private String tel;
	/**
	 * 数据字符串
	 */
	@FieldDescription("数据字符串")
	private String dataStr;
	/**
	 * 数据值
	 */
	@FieldDescription("数据值")
	private Double dataVal;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 设备id
	 */
	public String getDid(){
		return did;
	}
	public void setDid(String did){
		this.did = did;
	}
	/**
	 * 经度
	 */
	public Double getLongitude(){
		return longitude;
	}
	public void setLongitude(Double longitude){
		this.longitude = longitude;
	}
	/**
	 * 纬度
	 */
	public Double getLatitude(){
		return latitude;
	}
	public void setLatitude(Double latitude){
		this.latitude = latitude;
	}
	/**
	 * 电压数据
	 */
	public String getBatStr(){
		return batStr;
	}
	public void setBatStr(String batStr){
		this.batStr = batStr;
	}
	/**
	 * 电话号码
	 */
	public String getTel(){
		return tel;
	}
	public void setTel(String tel){
		this.tel = tel;
	}
	/**
	 * 数据字符串
	 */
	public String getDataStr(){
		return dataStr;
	}
	public void setDataStr(String dataStr){
		this.dataStr = dataStr;
	}
	/**
	 * 数据值
	 */
	public Double getDataVal(){
		return dataVal;
	}
	public void setDataVal(Double dataVal){
		this.dataVal = dataVal;
	}
}