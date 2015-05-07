package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.core.entity.DataDict;
import com.wiiy.core.entity.Org;
import com.wiiy.oa.preferences.enums.DepreciationCycleEnum;
import com.wiiy.oa.preferences.enums.DepreciationEnum;
import com.wiiy.oa.preferences.enums.FixedAssetsStatusEnum;

/**
 * <br/>class-description 固定资产
 * <br/>extends com.wiiy.commons.entity.TreeEntity
 */
public class FixedAssets extends TreeEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 资产类别
	 */
	@FieldDescription("资产类别")
	private DataDict type;
	/**
	 * 所属部门
	 */
	@FieldDescription("所属部门")
	private Org org;
	/**
	 * 名称
	 */
	@FieldDescription("名称")
	private String name;
	/**
	 * 资产类别外键
	 */
	@FieldDescription("资产类别外键")
	private String typeId;
	/**
	 * 置办日期
	 */
	@FieldDescription("置办日期")
	private Date dealDate;
	/**
	 * 所属部门外键
	 */
	@FieldDescription("所属部门外键")
	private Long orgId;
	/**
	 * 使用人
	 */
	@FieldDescription("使用人")
	private String user;
	/**
	 * 保管人
	 */
	@FieldDescription("保管人")
	private String custodian;
	/**
	 * 状态
	 */
	@FieldDescription("状态")
	private FixedAssetsStatusEnum status;
	/**
	 * 折旧类型
	 */
	@FieldDescription("折旧类型")
	private DepreciationEnum depreciation;
	/**
	 * 折旧周期类型
	 */
	@FieldDescription("折旧周期类型")
	private DepreciationCycleEnum cycle;
	/**
	 * 预计净残值率
	 */
	@FieldDescription("预计净残值率")
	private Double residualValueRate;
	/**
	 * 折旧周期
	 */
	@FieldDescription("折旧周期")
	private Double cycleAmount;
	/**
	 * 开始折旧日期
	 */
	@FieldDescription("开始折旧日期")
	private Date startDate;
	/**
	 * 预计使用寿命
	 */
	@FieldDescription("预计使用寿命")
	private Double lifeTime;
	/**
	 * 原资产值
	 */
	@FieldDescription("原资产值")
	private Double originalValue;
	/**
	 * 现资产值
	 */
	@FieldDescription("现资产值")
	private Double newValue;
	/**
	 * 规格型号
	 */
	@FieldDescription("规格型号")
	private String spec;
	/**
	 * 厂商
	 */
	@FieldDescription("厂商")
	private String factory;
	/**
	 * 采购日期
	 */
	@FieldDescription("采购日期")
	private Date buyDate;
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
	 * 资产类别
	 */
	public DataDict getType(){
		return type;
	}
	public void setType(DataDict type){
		this.type = type;
	}
	/**
	 * 所属部门
	 */
	public Org getOrg(){
		return org;
	}
	public void setOrg(Org org){
		this.org = org;
	}
	/**
	 * 名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 资产类别外键
	 */
	public String getTypeId(){
		return typeId;
	}
	public void setTypeId(String typeId){
		this.typeId = typeId;
	}
	/**
	 * 置办日期
	 */
	public Date getDealDate(){
		return dealDate;
	}
	public void setDealDate(Date dealDate){
		this.dealDate = dealDate;
	}
	/**
	 * 所属部门外键
	 */
	public Long getOrgId(){
		return orgId;
	}
	public void setOrgId(Long orgId){
		this.orgId = orgId;
	}
	/**
	 * 使用人
	 */
	public String getUser(){
		return user;
	}
	public void setUser(String user){
		this.user = user;
	}
	/**
	 * 保管人
	 */
	public String getCustodian(){
		return custodian;
	}
	public void setCustodian(String custodian){
		this.custodian = custodian;
	}
	/**
	 * 状态
	 */
	public FixedAssetsStatusEnum getStatus(){
		return status;
	}
	public void setStatus(FixedAssetsStatusEnum status){
		this.status = status;
	}
	/**
	 * 折旧类型
	 */
	public DepreciationEnum getDepreciation(){
		return depreciation;
	}
	public void setDepreciation(DepreciationEnum depreciation){
		this.depreciation = depreciation;
	}
	/**
	 * 折旧周期类型
	 */
	public DepreciationCycleEnum getCycle(){
		return cycle;
	}
	public void setCycle(DepreciationCycleEnum cycle){
		this.cycle = cycle;
	}
	/**
	 * 预计净残值率
	 */
	public Double getResidualValueRate(){
		return residualValueRate;
	}
	public void setResidualValueRate(Double residualValueRate){
		this.residualValueRate = residualValueRate;
	}
	/**
	 * 折旧周期
	 */
	public Double getCycleAmount(){
		return cycleAmount;
	}
	public void setCycleAmount(Double cycleAmount){
		this.cycleAmount = cycleAmount;
	}
	/**
	 * 开始折旧日期
	 */
	public Date getStartDate(){
		return startDate;
	}
	public void setStartDate(Date startDate){
		this.startDate = startDate;
	}
	/**
	 * 预计使用寿命
	 */
	public Double getLifeTime(){
		return lifeTime;
	}
	public void setLifeTime(Double lifeTime){
		this.lifeTime = lifeTime;
	}
	/**
	 * 原资产值
	 */
	public Double getOriginalValue(){
		return originalValue;
	}
	public void setOriginalValue(Double originalValue){
		this.originalValue = originalValue;
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
	 * 规格型号
	 */
	public String getSpec(){
		return spec;
	}
	public void setSpec(String spec){
		this.spec = spec;
	}
	/**
	 * 厂商
	 */
	public String getFactory(){
		return factory;
	}
	public void setFactory(String factory){
		this.factory = factory;
	}
	/**
	 * 采购日期
	 */
	public Date getBuyDate(){
		return buyDate;
	}
	public void setBuyDate(Date buyDate){
		this.buyDate = buyDate;
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