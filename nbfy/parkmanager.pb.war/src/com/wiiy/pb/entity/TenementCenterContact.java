package com.wiiy.pb.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.core.entity.ContactEntity;
import com.wiiy.pb.entity.Room;

/**
 * <br/>class-description 浙江大学国家大学科技园物业客户服务中心联系单(退房)
 * <br/>extends com.wiiy.core.entity.ContactEntity
 */
public class TenementCenterContact extends ContactEntity implements Serializable {
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
	 * 联系内容
	 */
	@FieldDescription("联系内容")
	private String content;
	/**
	 * 物业部门意见
	 */
	@FieldDescription("物业部门意见")
	private String opinion1;
	/**
	 * 物业部门意见ID
	 */
	@FieldDescription("物业部门意见ID")
	private Long opinion1Id;

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
	 * 联系内容
	 */
	public String getContent(){
		return content;
	}
	public void setContent(String content){
		this.content = content;
	}
	/**
	 * 物业部门意见
	 */
	public String getOpinion1(){
		return opinion1;
	}
	public void setOpinion1(String opinion1){
		this.opinion1 = opinion1;
	}
	/**
	 * 物业部门意见ID
	 */
	public Long getOpinion1Id(){
		return opinion1Id;
	}
	public void setOpinion1Id(Long opinion1Id){
		this.opinion1Id = opinion1Id;
	}
}