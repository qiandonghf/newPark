package com.wiiy.pb.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.crm.preferences.enums.PriceUnitEnum;
import com.wiiy.crm.preferences.enums.RentBillPlanFeeEnum;
import com.wiiy.pb.entity.Room;

/**
 * <br/>class-description 房间收费标准
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class RoomFee extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 房间
	 */
	@FieldDescription("房间")
	private Room room;
	/**
	 * 房间外键
	 */
	@FieldDescription("房间外键")
	private Long roomId;
	/**
	 * 费用类型
	 */
	@FieldDescription("费用类型")
	private RentBillPlanFeeEnum feeType;
	/**
	 * 费用单位
	 */
	@FieldDescription("费用单位")
	private PriceUnitEnum unit;
	/**
	 * 费用值
	 */
	@FieldDescription("费用值")
	private Double amount;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
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
	 * 房间外键
	 */
	public Long getRoomId(){
		return roomId;
	}
	public void setRoomId(Long roomId){
		this.roomId = roomId;
	}
	/**
	 * 费用类型
	 */
	public RentBillPlanFeeEnum getFeeType(){
		return feeType;
	}
	public void setFeeType(RentBillPlanFeeEnum feeType){
		this.feeType = feeType;
	}
	/**
	 * 费用单位
	 */
	public PriceUnitEnum getUnit(){
		return unit;
	}
	public void setUnit(PriceUnitEnum unit){
		this.unit = unit;
	}
	/**
	 * 费用值
	 */
	public Double getAmount(){
		return amount;
	}
	public void setAmount(Double amount){
		this.amount = amount;
	}
}