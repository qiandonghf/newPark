package com.wiiy.pb.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.pb.entity.MeterLabel;
import com.wiiy.pb.preferences.enums.MeterRecordStatusEnum;
import com.wiiy.pb.preferences.enums.MeterTypeEnum;

/**
 * <br/>class-description 分户表抄表记录
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class MeterLabelRecord extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 分户表抄表
	 */
	@FieldDescription("分户表抄表")
	private MeterLabel meterLabel;
	/**
	 * 分户表抄表外键
	 */
	@FieldDescription("分户表抄表外键")
	private Long labelId;
	/**
	 * 水电表id
	 */
	@FieldDescription("水电表id")
	private Long meterId;
	/**
	 * 表编号
	 */
	@FieldDescription("表编号")
	private String meterOrderNo;
	/**
	 * 楼宇名称
	 */
	@FieldDescription("楼宇名称")
	private String buildingName;
	/**
	 * 房间名称
	 */
	@FieldDescription("房间名称")
	private String roomName;
	/**
	 * 客户名称
	 */
	@FieldDescription("客户名称")
	private String customerName;
	/**
	 * 表类型
	 */
	@FieldDescription("表类型")
	private MeterTypeEnum meterType;
	/**
	 * 表倍数
	 */
	@FieldDescription("表倍数")
	private Integer meterFactor;
	/**
	 * 上期读数
	 */
	@FieldDescription("上期读数")
	private Double preReading;
	/**
	 * 上期抄表日期
	 */
	@FieldDescription("上期抄表日期")
	private Date preDate;
	/**
	 * 本期读数
	 */
	@FieldDescription("本期读数")
	private Double curReading;
	/**
	 * 走字数
	 */
	@FieldDescription("走字数")
	private Double amount;
	/**
	 * 实用读数
	 */
	@FieldDescription("实用读数")
	private Double syAmount;
	/**
	 * 峰电
	 */
	@FieldDescription("峰电")
	private Double fdAmount;
	/**
	 * 谷电
	 */
	@FieldDescription("谷电")
	private Double gdAmount;
	/**
	 * 尖电
	 */
	@FieldDescription("尖电")
	private Double jdAmount;
	/**
	 * 耗电
	 */
	@FieldDescription("耗电")
	private Double hdAmount;
	/**
	 * 合计
	 */
	@FieldDescription("合计")
	private Double totalAmount;
	/**
	 * 单价
	 */
	@FieldDescription("单价")
	private Double price;
	/**
	 * 金额
	 */
	@FieldDescription("金额")
	private Double bill;
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
	 * 合计电费
	 */
	@FieldDescription("合计电费")
	private Double totalBill;
	/**
	 * 是否出账
	 */
	@FieldDescription("是否出账")
	private MeterRecordStatusEnum checkOut;
	/**
	 * 本期抄表日期
	 */
	@FieldDescription("本期抄表日期")
	private Date curDate;
	/**
	 * 楼宇id
	 */
	@FieldDescription("楼宇id")
	private Long buildingId;
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
	 * 分户表抄表
	 */
	public MeterLabel getMeterLabel(){
		return meterLabel;
	}
	public void setMeterLabel(MeterLabel meterLabel){
		this.meterLabel = meterLabel;
	}
	/**
	 * 分户表抄表外键
	 */
	public Long getLabelId(){
		return labelId;
	}
	public void setLabelId(Long labelId){
		this.labelId = labelId;
	}
	/**
	 * 水电表id
	 */
	public Long getMeterId(){
		return meterId;
	}
	public void setMeterId(Long meterId){
		this.meterId = meterId;
	}
	/**
	 * 表编号
	 */
	public String getMeterOrderNo(){
		return meterOrderNo;
	}
	public void setMeterOrderNo(String meterOrderNo){
		this.meterOrderNo = meterOrderNo;
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
	 * 房间名称
	 */
	public String getRoomName(){
		return roomName;
	}
	public void setRoomName(String roomName){
		this.roomName = roomName;
	}
	/**
	 * 客户名称
	 */
	public String getCustomerName(){
		return customerName;
	}
	public void setCustomerName(String customerName){
		this.customerName = customerName;
	}
	/**
	 * 表类型
	 */
	public MeterTypeEnum getMeterType(){
		return meterType;
	}
	public void setMeterType(MeterTypeEnum meterType){
		this.meterType = meterType;
	}
	/**
	 * 表倍数
	 */
	public Integer getMeterFactor(){
		return meterFactor;
	}
	public void setMeterFactor(Integer meterFactor){
		this.meterFactor = meterFactor;
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
	 * 上期抄表日期
	 */
	public Date getPreDate(){
		return preDate;
	}
	public void setPreDate(Date preDate){
		this.preDate = preDate;
	}
	/**
	 * 本期读数
	 */
	public Double getCurReading(){
		return curReading;
	}
	public void setCurReading(Double curReading){
		this.curReading = curReading;
	}
	/**
	 * 走字数
	 */
	public Double getAmount(){
		return amount;
	}
	public void setAmount(Double amount){
		this.amount = amount;
	}
	/**
	 * 实用读数
	 */
	public Double getSyAmount(){
		return syAmount;
	}
	public void setSyAmount(Double syAmount){
		this.syAmount = syAmount;
	}
	/**
	 * 峰电
	 */
	public Double getFdAmount(){
		return fdAmount;
	}
	public void setFdAmount(Double fdAmount){
		this.fdAmount = fdAmount;
	}
	/**
	 * 谷电
	 */
	public Double getGdAmount(){
		return gdAmount;
	}
	public void setGdAmount(Double gdAmount){
		this.gdAmount = gdAmount;
	}
	/**
	 * 尖电
	 */
	public Double getJdAmount(){
		return jdAmount;
	}
	public void setJdAmount(Double jdAmount){
		this.jdAmount = jdAmount;
	}
	/**
	 * 耗电
	 */
	public Double getHdAmount(){
		return hdAmount;
	}
	public void setHdAmount(Double hdAmount){
		this.hdAmount = hdAmount;
	}
	/**
	 * 合计
	 */
	public Double getTotalAmount(){
		return totalAmount;
	}
	public void setTotalAmount(Double totalAmount){
		this.totalAmount = totalAmount;
	}
	/**
	 * 单价
	 */
	public Double getPrice(){
		return price;
	}
	public void setPrice(Double price){
		this.price = price;
	}
	/**
	 * 金额
	 */
	public Double getBill(){
		return bill;
	}
	public void setBill(Double bill){
		this.bill = bill;
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
	 * 合计电费
	 */
	public Double getTotalBill(){
		return totalBill;
	}
	public void setTotalBill(Double totalBill){
		this.totalBill = totalBill;
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
	 * 本期抄表日期
	 */
	public Date getCurDate(){
		return curDate;
	}
	public void setCurDate(Date curDate){
		this.curDate = curDate;
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
	 * 备注
	 */
	public String getMemo(){
		return memo;
	}
	public void setMemo(String memo){
		this.memo = memo;
	}
}