package com.wiiy.pb.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.pb.entity.Meter;
import com.wiiy.pb.preferences.enums.MeterKindEnum;
import com.wiiy.pb.preferences.enums.MeterStatusEnum;
import com.wiiy.pb.preferences.enums.MeterTypeEnum;

/**
 * <br/>class-description 水电表
 * <br/>extends com.wiiy.commons.entity.TreeEntity
 */
public class Meter extends TreeEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 水电表实体
	 */
	@FieldDescription("水电表实体")
	private Meter parent;
	/**
	 * 名称
	 */
	@FieldDescription("名称")
	private String name;
	/**
	 * 倍数
	 */
	@FieldDescription("倍数")
	private Integer meterFactor;
	/**
	 * 编号
	 */
	@FieldDescription("编号")
	private String orderNo;
	/**
	 * 序列号
	 */
	@FieldDescription("序列号")
	private String sequenceNo;
	/**
	 * 上期读数
	 */
	@FieldDescription("上期读数")
	private Double preReading;
	/**
	 * 母表编号
	 */
	@FieldDescription("母表编号")
	private String parentNo;
	/**
	 * 装机容量
	 */
	@FieldDescription("装机容量")
	private Double capacity;
	/**
	 * 基本电费
	 */
	@FieldDescription("基本电费")
	private Double capacityBill;
	/**
	 * 房间Ids
	 */
	@FieldDescription("房间Ids")
	private String roomIds;
	/**
	 * 最后抄表日期
	 */
	@FieldDescription("最后抄表日期")
	private Date readingDate;
	/**
	 * 性质
	 */
	@FieldDescription("性质")
	private MeterKindEnum kind;
	/**
	 * 类型
	 */
	@FieldDescription("类型")
	private MeterTypeEnum type;
	/**
	 * 园区名称
	 */
	@FieldDescription("园区名称")
	private String parkName;
	/**
	 * 园区id
	 */
	@FieldDescription("园区id")
	private Long parkId;
	/**
	 * 楼宇名称
	 */
	@FieldDescription("楼宇名称")
	private String buildingName;
	/**
	 * 楼宇id
	 */
	@FieldDescription("楼宇id")
	private Long buildingId;
	/**
	 * 是否出表
	 */
	@FieldDescription("是否出表")
	private BooleanEnum checkOut;
	/**
	 * 状态
	 */
	@FieldDescription("状态")
	private MeterStatusEnum status;
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
	 * 水电表实体
	 */
	public Meter getParent(){
		return parent;
	}
	public void setParent(Meter parent){
		this.parent = parent;
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
	 * 倍数
	 */
	public Integer getMeterFactor(){
		return meterFactor;
	}
	public void setMeterFactor(Integer meterFactor){
		this.meterFactor = meterFactor;
	}
	/**
	 * 编号
	 */
	public String getOrderNo(){
		return orderNo;
	}
	public void setOrderNo(String orderNo){
		this.orderNo = orderNo;
	}
	/**
	 * 序列号
	 */
	public String getSequenceNo(){
		return sequenceNo;
	}
	public void setSequenceNo(String sequenceNo){
		this.sequenceNo = sequenceNo;
	}
	/**
	 * 上期读数
	 */
	public Double getPreReading(){
		return preReading;
	}
	public void setPreReading(Double preReading){
		this.preReading = preReading;
	}
	/**
	 * 母表编号
	 */
	public String getParentNo(){
		return parentNo;
	}
	public void setParentNo(String parentNo){
		this.parentNo = parentNo;
	}
	/**
	 * 装机容量
	 */
	public Double getCapacity(){
		return capacity;
	}
	public void setCapacity(Double capacity){
		this.capacity = capacity;
	}
	/**
	 * 基本电费
	 */
	public Double getCapacityBill(){
		return capacityBill;
	}
	public void setCapacityBill(Double capacityBill){
		this.capacityBill = capacityBill;
	}
	/**
	 * 房间Ids
	 */
	public String getRoomIds(){
		return roomIds;
	}
	public void setRoomIds(String roomIds){
		this.roomIds = roomIds;
	}
	/**
	 * 最后抄表日期
	 */
	public Date getReadingDate(){
		return readingDate;
	}
	public void setReadingDate(Date readingDate){
		this.readingDate = readingDate;
	}
	/**
	 * 性质
	 */
	public MeterKindEnum getKind(){
		return kind;
	}
	public void setKind(MeterKindEnum kind){
		this.kind = kind;
	}
	/**
	 * 类型
	 */
	public MeterTypeEnum getType(){
		return type;
	}
	public void setType(MeterTypeEnum type){
		this.type = type;
	}
	/**
	 * 园区名称
	 */
	public String getParkName(){
		return parkName;
	}
	public void setParkName(String parkName){
		this.parkName = parkName;
	}
	/**
	 * 园区id
	 */
	public Long getParkId(){
		return parkId;
	}
	public void setParkId(Long parkId){
		this.parkId = parkId;
	}
	/**
	 * 楼宇名称
	 */
	public String getBuildingName(){
		return buildingName;
	}
	public void setBuildingName(String buildingName){
		this.buildingName = buildingName;
	}
	/**
	 * 楼宇id
	 */
	public Long getBuildingId(){
		return buildingId;
	}
	public void setBuildingId(Long buildingId){
		this.buildingId = buildingId;
	}
	/**
	 * 是否出表
	 */
	public BooleanEnum getCheckOut(){
		return checkOut;
	}
	public void setCheckOut(BooleanEnum checkOut){
		this.checkOut = checkOut;
	}
	/**
	 * 状态
	 */
	public MeterStatusEnum getStatus(){
		return status;
	}
	public void setStatus(MeterStatusEnum status){
		this.status = status;
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