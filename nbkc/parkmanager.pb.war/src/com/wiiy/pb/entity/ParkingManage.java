package com.wiiy.pb.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.pb.entity.Garage;
import com.wiiy.pb.preferences.enums.ParkingManageEnum;

/**
 * <br/>class-description 车位管理
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class ParkingManage extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 车库实体
	 */
	@FieldDescription("车库实体")
	private Garage garage;
	/**
	 * 车位号
	 */
	@FieldDescription("车位号")
	private String parkingId;
	/**
	 * 状态
	 */
	@FieldDescription("状态")
	private ParkingManageEnum status;
	/**
	 * 描述
	 */
	@FieldDescription("描述")
	private String description;
	/**
	 * 车库外键
	 */
	@FieldDescription("车库外键")
	private Long garageId;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 车库实体
	 */
	public Garage getGarage(){
		return garage;
	}
	public void setGarage(Garage garage){
		this.garage = garage;
	}
	/**
	 * 车位号
	 */
	public String getParkingId(){
		return parkingId;
	}
	public void setParkingId(String parkingId){
		this.parkingId = parkingId;
	}
	/**
	 * 状态
	 */
	public ParkingManageEnum getStatus(){
		return status;
	}
	public void setStatus(ParkingManageEnum status){
		this.status = status;
	}
	/**
	 * 描述
	 */
	public String getDescription(){
		return description;
	}
	public void setDescription(String description){
		this.description = description;
	}
	/**
	 * 车库外键
	 */
	public Long getGarageId(){
		return garageId;
	}
	public void setGarageId(Long garageId){
		this.garageId = garageId;
	}
}