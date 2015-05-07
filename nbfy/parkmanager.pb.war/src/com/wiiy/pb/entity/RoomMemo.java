package com.wiiy.pb.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;

/**
 * <br/>class-description 房间备注信息
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class RoomMemo extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 房间外键
	 */
	@FieldDescription("房间外键")
	private Long roomId;
	/**
	 * 备注内容
	 */
	@FieldDescription("备注内容")
	private String memo;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
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
	 * 备注内容
	 */
	public String getMemo(){
		return memo;
	}
	public void setMemo(String memo){
		this.memo = memo;
	}
}