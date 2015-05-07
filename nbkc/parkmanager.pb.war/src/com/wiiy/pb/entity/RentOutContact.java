package com.wiiy.pb.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.core.entity.ContactEntity;
import com.wiiy.pb.entity.Room;

/**
 * <br/>class-description 退房联系单
 * <br/>extends com.wiiy.core.entity.ContactEntity
 */
public class RentOutContact extends ContactEntity implements Serializable {
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
	 * 企业外键
	 */
	@FieldDescription("企业外键")
	private Long customerId;
	/**
	 * 企业名称
	 */
	@FieldDescription("企业名称")
	private String customer;
	/**
	 * 房间外键
	 */
	@FieldDescription("房间外键")
	private Long roomId;
	/**
	 * 退房原因
	 */
	@FieldDescription("退房原因")
	private String reason;
	/**
	 * 管委会创业服务部初审意见
	 */
	@FieldDescription("管委会创业服务部初审意见")
	private String opinion1;
	/**
	 * 管委会创业服务部初审意见ID
	 */
	@FieldDescription("管委会创业服务部初审意见ID")
	private Long opinion1Id;
	/**
	 * 管委（公司）领导批复意见
	 */
	@FieldDescription("管委（公司）领导批复意见")
	private String opinion2;
	/**
	 * 管委（公司）领导批复意见ID
	 */
	@FieldDescription("管委（公司）领导批复意见ID")
	private Long opinion2Id;
	/**
	 * 管委会企业发展部注册变更审核意见
	 */
	@FieldDescription("管委会企业发展部注册变更审核意见")
	private String opinion3;
	/**
	 * 管委会企业发展部注册变更审核意见ID
	 */
	@FieldDescription("管委会企业发展部注册变更审核意见ID")
	private Long opinion3Id;
	/**
	 * 管委会财务部审核意见
	 */
	@FieldDescription("管委会财务部审核意见")
	private String opinion4;
	/**
	 * 管委会财务部审核意见ID
	 */
	@FieldDescription("管委会财务部审核意见ID")
	private Long opinion4Id;
	/**
	 * 南都物业服务中心验房审核意见
	 */
	@FieldDescription("南都物业服务中心验房审核意见")
	private String opinion5;
	/**
	 * 南都物业服务中心验房审核意见ID
	 */
	@FieldDescription("南都物业服务中心验房审核意见ID")
	private Long opinion5Id;
	/**
	 * 南都物业服务中心（财务）审核意见
	 */
	@FieldDescription("南都物业服务中心（财务）审核意见")
	private String opinion6;
	/**
	 * 南都物业服务中心（财务）审核意见ID
	 */
	@FieldDescription("南都物业服务中心（财务）审核意见ID")
	private Long opinion6Id;

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
	 * 企业外键
	 */
	public Long getCustomerId(){
		return customerId;
	}
	public void setCustomerId(Long customerId){
		this.customerId = customerId;
	}
	/**
	 * 企业名称
	 */
	public String getCustomer(){
		return customer;
	}
	public void setCustomer(String customer){
		this.customer = customer;
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
	 * 退房原因
	 */
	public String getReason(){
		return reason;
	}
	public void setReason(String reason){
		this.reason = reason;
	}
	/**
	 * 管委会创业服务部初审意见
	 */
	public String getOpinion1(){
		return opinion1;
	}
	public void setOpinion1(String opinion1){
		this.opinion1 = opinion1;
	}
	/**
	 * 管委会创业服务部初审意见ID
	 */
	public Long getOpinion1Id(){
		return opinion1Id;
	}
	public void setOpinion1Id(Long opinion1Id){
		this.opinion1Id = opinion1Id;
	}
	/**
	 * 管委（公司）领导批复意见
	 */
	public String getOpinion2(){
		return opinion2;
	}
	public void setOpinion2(String opinion2){
		this.opinion2 = opinion2;
	}
	/**
	 * 管委（公司）领导批复意见ID
	 */
	public Long getOpinion2Id(){
		return opinion2Id;
	}
	public void setOpinion2Id(Long opinion2Id){
		this.opinion2Id = opinion2Id;
	}
	/**
	 * 管委会企业发展部注册变更审核意见
	 */
	public String getOpinion3(){
		return opinion3;
	}
	public void setOpinion3(String opinion3){
		this.opinion3 = opinion3;
	}
	/**
	 * 管委会企业发展部注册变更审核意见ID
	 */
	public Long getOpinion3Id(){
		return opinion3Id;
	}
	public void setOpinion3Id(Long opinion3Id){
		this.opinion3Id = opinion3Id;
	}
	/**
	 * 管委会财务部审核意见
	 */
	public String getOpinion4(){
		return opinion4;
	}
	public void setOpinion4(String opinion4){
		this.opinion4 = opinion4;
	}
	/**
	 * 管委会财务部审核意见ID
	 */
	public Long getOpinion4Id(){
		return opinion4Id;
	}
	public void setOpinion4Id(Long opinion4Id){
		this.opinion4Id = opinion4Id;
	}
	/**
	 * 南都物业服务中心验房审核意见
	 */
	public String getOpinion5(){
		return opinion5;
	}
	public void setOpinion5(String opinion5){
		this.opinion5 = opinion5;
	}
	/**
	 * 南都物业服务中心验房审核意见ID
	 */
	public Long getOpinion5Id(){
		return opinion5Id;
	}
	public void setOpinion5Id(Long opinion5Id){
		this.opinion5Id = opinion5Id;
	}
	/**
	 * 南都物业服务中心（财务）审核意见
	 */
	public String getOpinion6(){
		return opinion6;
	}
	public void setOpinion6(String opinion6){
		this.opinion6 = opinion6;
	}
	/**
	 * 南都物业服务中心（财务）审核意见ID
	 */
	public Long getOpinion6Id(){
		return opinion6Id;
	}
	public void setOpinion6Id(Long opinion6Id){
		this.opinion6Id = opinion6Id;
	}
}