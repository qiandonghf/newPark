package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.core.entity.DataDict;
import com.wiiy.crm.entity.Contract;
import com.wiiy.crm.preferences.enums.PriceUnitEnum;
import com.wiiy.pb.entity.Room;

/**
 * <br/>class-description 租赁合同标的
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class SubjectRent extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 合同
	 */
	@FieldDescription("合同")
	private Contract contract;
	/**
	 * 房间
	 */
	@FieldDescription("房间")
	private Room room;
	/**
	 * 优惠规则
	 */
	@FieldDescription("优惠规则")
	private DataDict rebateRule;
	/**
	 * 合同外键
	 */
	@FieldDescription("合同外键")
	private Long contractId;
	/**
	 * 房间外键
	 */
	@FieldDescription("房间外键")
	private Long roomId;
	/**
	 * 地址描述 如XX楼XX房间(程序自动填充)
	 */
	@FieldDescription("地址描述 如XX楼XX房间(程序自动填充)")
	private String roomName;
	/**
	 * 房间面积
	 */
	@FieldDescription("房间面积")
	private Double roomArea;
	/**
	 * 租金单价
	 */
	@FieldDescription("租金单价")
	private Double rentPrice;
	/**
	 * 租金单价单位
	 */
	@FieldDescription("租金单价单位")
	private PriceUnitEnum rentPriceUnit;
	/**
	 * 物管单价
	 */
	@FieldDescription("物管单价")
	private Double managePrice;
	/**
	 * 物管单价单位
	 */
	@FieldDescription("物管单价单位")
	private PriceUnitEnum managePriceUnit;
	/**
	 * 租用开始时间
	 */
	@FieldDescription("租用开始时间")
	private Date startDate;
	/**
	 * 租用结束时间
	 */
	@FieldDescription("租用结束时间")
	private Date endDate;
	/**
	 * 是否优惠
	 */
	@FieldDescription("是否优惠")
	private BooleanEnum rebate;
	/**
	 * 优惠规则外键
	 */
	@FieldDescription("优惠规则外键")
	private String rebateRuleId;
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
	 * 合同
	 */
	public Contract getContract(){
		return contract;
	}
	public void setContract(Contract contract){
		this.contract = contract;
	}
	/**
	 * 房间
	 */
	public Room getRoom(){
		return room;
	}
	public void setRoom(Room room){
		this.room = room;
	}
	/**
	 * 优惠规则
	 */
	public DataDict getRebateRule(){
		return rebateRule;
	}
	public void setRebateRule(DataDict rebateRule){
		this.rebateRule = rebateRule;
	}
	/**
	 * 合同外键
	 */
	public Long getContractId(){
		return contractId;
	}
	public void setContractId(Long contractId){
		this.contractId = contractId;
	}
	/**
	 * 房间外键
	 */
	public Long getRoomId(){
		return roomId;
	}
	public void setRoomId(Long roomId){
		this.roomId = roomId;
	}
	/**
	 * 地址描述 如XX楼XX房间(程序自动填充)
	 */
	public String getRoomName(){
		return roomName;
	}
	public void setRoomName(String roomName){
		this.roomName = roomName;
	}
	/**
	 * 房间面积
	 */
	public Double getRoomArea(){
		return roomArea;
	}
	public void setRoomArea(Double roomArea){
		this.roomArea = roomArea;
	}
	/**
	 * 租金单价
	 */
	public Double getRentPrice(){
		return rentPrice;
	}
	public void setRentPrice(Double rentPrice){
		this.rentPrice = rentPrice;
	}
	/**
	 * 租金单价单位
	 */
	public PriceUnitEnum getRentPriceUnit(){
		return rentPriceUnit;
	}
	public void setRentPriceUnit(PriceUnitEnum rentPriceUnit){
		this.rentPriceUnit = rentPriceUnit;
	}
	/**
	 * 物管单价
	 */
	public Double getManagePrice(){
		return managePrice;
	}
	public void setManagePrice(Double managePrice){
		this.managePrice = managePrice;
	}
	/**
	 * 物管单价单位
	 */
	public PriceUnitEnum getManagePriceUnit(){
		return managePriceUnit;
	}
	public void setManagePriceUnit(PriceUnitEnum managePriceUnit){
		this.managePriceUnit = managePriceUnit;
	}
	/**
	 * 租用开始时间
	 */
	public Date getStartDate(){
		return startDate;
	}
	public void setStartDate(Date startDate){
		this.startDate = startDate;
	}
	/**
	 * 租用结束时间
	 */
	public Date getEndDate(){
		return endDate;
	}
	public void setEndDate(Date endDate){
		this.endDate = endDate;
	}
	/**
	 * 是否优惠
	 */
	public BooleanEnum getRebate(){
		return rebate;
	}
	public void setRebate(BooleanEnum rebate){
		this.rebate = rebate;
	}
	/**
	 * 优惠规则外键
	 */
	public String getRebateRuleId(){
		return rebateRuleId;
	}
	public void setRebateRuleId(String rebateRuleId){
		this.rebateRuleId = rebateRuleId;
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