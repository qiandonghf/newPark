package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.core.entity.DataDict;
import com.wiiy.oa.preferences.enums.CarStatusEnum;

/**
 * <br/>class-description 车辆
 * <br/>extends com.wiiy.commons.entity.TreeEntity
 */
public class Car extends TreeEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 车辆类型
	 */
	@FieldDescription("车辆类型")
	private DataDict carType;
	/**
	 * 车牌号码
	 */
	@FieldDescription("车牌号码")
	private String licenseNo;
	/**
	 * 状态
	 */
	@FieldDescription("状态")
	private CarStatusEnum status;
	/**
	 * 车辆类型外键
	 */
	@FieldDescription("车辆类型外键")
	private String carTypeId;
	/**
	 * 厂家型号
	 */
	@FieldDescription("厂家型号")
	private String factoryModel;
	/**
	 * 发动机号
	 */
	@FieldDescription("发动机号")
	private String engineNumber;
	/**
	 * 保险日期
	 */
	@FieldDescription("保险日期")
	private Date insuranceDate;
	/**
	 * 年审日期
	 */
	@FieldDescription("年审日期")
	private Date annualDate;
	/**
	 * 购置日期
	 */
	@FieldDescription("购置日期")
	private Date buyDate;
	/**
	 * 驾驶员
	 */
	@FieldDescription("驾驶员")
	private String pilot;
	/**
	 * 照片
	 */
	@FieldDescription("照片")
	private String photo;
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
	 * 车辆类型
	 */
	public DataDict getCarType(){
		return carType;
	}
	public void setCarType(DataDict carType){
		this.carType = carType;
	}
	/**
	 * 车牌号码
	 */
	public String getLicenseNo(){
		return licenseNo;
	}
	public void setLicenseNo(String licenseNo){
		this.licenseNo = licenseNo;
	}
	/**
	 * 状态
	 */
	public CarStatusEnum getStatus(){
		return status;
	}
	public void setStatus(CarStatusEnum status){
		this.status = status;
	}
	/**
	 * 车辆类型外键
	 */
	public String getCarTypeId(){
		return carTypeId;
	}
	public void setCarTypeId(String carTypeId){
		this.carTypeId = carTypeId;
	}
	/**
	 * 厂家型号
	 */
	public String getFactoryModel(){
		return factoryModel;
	}
	public void setFactoryModel(String factoryModel){
		this.factoryModel = factoryModel;
	}
	/**
	 * 发动机号
	 */
	public String getEngineNumber(){
		return engineNumber;
	}
	public void setEngineNumber(String engineNumber){
		this.engineNumber = engineNumber;
	}
	/**
	 * 保险日期
	 */
	public Date getInsuranceDate(){
		return insuranceDate;
	}
	public void setInsuranceDate(Date insuranceDate){
		this.insuranceDate = insuranceDate;
	}
	/**
	 * 年审日期
	 */
	public Date getAnnualDate(){
		return annualDate;
	}
	public void setAnnualDate(Date annualDate){
		this.annualDate = annualDate;
	}
	/**
	 * 购置日期
	 */
	public Date getBuyDate(){
		return buyDate;
	}
	public void setBuyDate(Date buyDate){
		this.buyDate = buyDate;
	}
	/**
	 * 驾驶员
	 */
	public String getPilot(){
		return pilot;
	}
	public void setPilot(String pilot){
		this.pilot = pilot;
	}
	/**
	 * 照片
	 */
	public String getPhoto(){
		return photo;
	}
	public void setPhoto(String photo){
		this.photo = photo;
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