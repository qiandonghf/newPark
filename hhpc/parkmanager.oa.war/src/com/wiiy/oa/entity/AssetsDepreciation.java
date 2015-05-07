package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.oa.entity.FixedAssets;

/**
 * <br/>class-description 固定资产折旧记录
 * <br/>extends com.wiiy.commons.entity.TreeEntity
 */
public class AssetsDepreciation extends TreeEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 资产类型
	 */
	@FieldDescription("资产类型")
	private FixedAssets fixedAssets;
	/**
	 * 资产类型外键
	 */
	@FieldDescription("资产类型外键")
	private Long fixedAssetsId;
	/**
	 * 折旧类型
	 */
	@FieldDescription("折旧类型")
	private String depreciation;
	/**
	 * 折旧开始日期
	 */
	@FieldDescription("折旧开始日期")
	private Date startDate;
	/**
	 * 折旧结束日期
	 */
	@FieldDescription("折旧结束日期")
	private Date endDate;
	/**
	 * 原资产值
	 */
	@FieldDescription("原资产值")
	private Double lastValue;
	/**
	 * 现资产值
	 */
	@FieldDescription("现资产值")
	private Double newValue;
	/**
	 * 备注
	 */
	@FieldDescription("备注")
	private String memo;
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
	 * 资产类型
	 */
	public FixedAssets getFixedAssets(){
		return fixedAssets;
	}
	public void setFixedAssets(FixedAssets fixedAssets){
		this.fixedAssets = fixedAssets;
	}
	/**
	 * 资产类型外键
	 */
	public Long getFixedAssetsId(){
		return fixedAssetsId;
	}
	public void setFixedAssetsId(Long fixedAssetsId){
		this.fixedAssetsId = fixedAssetsId;
	}
	/**
	 * 折旧类型
	 */
	public String getDepreciation(){
		return depreciation;
	}
	public void setDepreciation(String depreciation){
		this.depreciation = depreciation;
	}
	/**
	 * 折旧开始日期
	 */
	public Date getStartDate(){
		return startDate;
	}
	public void setStartDate(Date startDate){
		this.startDate = startDate;
	}
	/**
	 * 折旧结束日期
	 */
	public Date getEndDate(){
		return endDate;
	}
	public void setEndDate(Date endDate){
		this.endDate = endDate;
	}
	/**
	 * 原资产值
	 */
	public Double getLastValue(){
		return lastValue;
	}
	public void setLastValue(Double lastValue){
		this.lastValue = lastValue;
	}
	/**
	 * 现资产值
	 */
	public Double getNewValue(){
		return newValue;
	}
	public void setNewValue(Double newValue){
		this.newValue = newValue;
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