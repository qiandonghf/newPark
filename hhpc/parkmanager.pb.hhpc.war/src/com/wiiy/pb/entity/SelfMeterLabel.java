package com.wiiy.pb.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.pb.preferences.enums.MeterRecordStatusEnum;
import com.wiiy.pb.preferences.enums.MeterTypeEnum;

/**
 * <br/>class-description 自用表抄表
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class SelfMeterLabel extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 报表名
	 */
	@FieldDescription("报表名")
	private String name;
	/**
	 * 制表日期
	 */
	@FieldDescription("制表日期")
	private Date date;
	/**
	 * 报表类型
	 */
	@FieldDescription("报表类型")
	private MeterTypeEnum type;
	/**
	 * 抄表人
	 */
	@FieldDescription("抄表人")
	private String reader;
	/**
	 * 楼宇Ids
	 */
	@FieldDescription("楼宇Ids")
	private String buildingIds;
	/**
	 * 是否出账
	 */
	@FieldDescription("是否出账")
	private MeterRecordStatusEnum checkOut;
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
	 * 报表名
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 制表日期
	 */
	public Date getDate(){
		return date;
	}
	public void setDate(Date date){
		this.date = date;
	}
	/**
	 * 报表类型
	 */
	public MeterTypeEnum getType(){
		return type;
	}
	public void setType(MeterTypeEnum type){
		this.type = type;
	}
	/**
	 * 抄表人
	 */
	public String getReader(){
		return reader;
	}
	public void setReader(String reader){
		this.reader = reader;
	}
	/**
	 * 楼宇Ids
	 */
	public String getBuildingIds(){
		return buildingIds;
	}
	public void setBuildingIds(String buildingIds){
		this.buildingIds = buildingIds;
	}
	/**
	 * 是否出账
	 */
	public MeterRecordStatusEnum getCheckOut(){
		return checkOut;
	}
	public void setCheckOut(MeterRecordStatusEnum checkOut){
		this.checkOut = checkOut;
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