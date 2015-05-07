package com.wiiy.pb.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.preferences.enums.EntityStatus;

/**
 * <br/>class-description 园区
 * <br/>extends com.wiiy.commons.entity.TreeEntity
 */
public class Park extends TreeEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 园区名称
	 */
	@FieldDescription("园区名称")
	private String name;
	/**
	 * 水费
	 */
	@FieldDescription("水费")
	private Double water;
	/**
	 * 电费
	 */
	@FieldDescription("电费")
	private Double electricity;
	/**
	 * 气费
	 */
	@FieldDescription("气费")
	private Double gas;
	/**
	 * 能源费
	 */
	@FieldDescription("能源费")
	private Double energyFee;
	/**
	 * 实体状态
	 */
	@FieldDescription("实体状态")
	private EntityStatus entityStatus;
	/**
	 * 创建时间
	 */
	@FieldDescription("创建时间")
	private Date createTime;
	/**
	 * 创建人姓名
	 */
	@FieldDescription("创建人姓名")
	private String creator;
	/**
	 * 创建人ID
	 */
	@FieldDescription("创建人ID")
	private Long creatorId;
	/**
	 * 修改时间
	 */
	@FieldDescription("修改时间")
	private Date modifyTime;
	/**
	 * 修改人姓名
	 */
	@FieldDescription("修改人姓名")
	private String modifier;
	/**
	 * 修改人ID
	 */
	@FieldDescription("修改人ID")
	private Long modifierId;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 园区名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 水费
	 */
	public Double getWater(){
		return water;
	}
	public void setWater(Double water){
		this.water = water;
	}
	/**
	 * 电费
	 */
	public Double getElectricity(){
		return electricity;
	}
	public void setElectricity(Double electricity){
		this.electricity = electricity;
	}
	/**
	 * 气费
	 */
	public Double getGas(){
		return gas;
	}
	public void setGas(Double gas){
		this.gas = gas;
	}
	/**
	 * 能源费
	 */
	public Double getEnergyFee(){
		return energyFee;
	}
	public void setEnergyFee(Double energyFee){
		this.energyFee = energyFee;
	}
	/**
	 * 实体状态
	 */
	public EntityStatus getEntityStatus(){
		return entityStatus;
	}
	public void setEntityStatus(EntityStatus entityStatus){
		this.entityStatus = entityStatus;
	}
	/**
	 * 创建时间
	 */
	public Date getCreateTime(){
		return createTime;
	}
	public void setCreateTime(Date createTime){
		this.createTime = createTime;
	}
	/**
	 * 创建人姓名
	 */
	public String getCreator(){
		return creator;
	}
	public void setCreator(String creator){
		this.creator = creator;
	}
	/**
	 * 创建人ID
	 */
	public Long getCreatorId(){
		return creatorId;
	}
	public void setCreatorId(Long creatorId){
		this.creatorId = creatorId;
	}
	/**
	 * 修改时间
	 */
	public Date getModifyTime(){
		return modifyTime;
	}
	public void setModifyTime(Date modifyTime){
		this.modifyTime = modifyTime;
	}
	/**
	 * 修改人姓名
	 */
	public String getModifier(){
		return modifier;
	}
	public void setModifier(String modifier){
		this.modifier = modifier;
	}
	/**
	 * 修改人ID
	 */
	public Long getModifierId(){
		return modifierId;
	}
	public void setModifierId(Long modifierId){
		this.modifierId = modifierId;
	}
}