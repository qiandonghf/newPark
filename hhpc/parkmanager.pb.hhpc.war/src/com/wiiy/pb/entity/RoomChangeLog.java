package com.wiiy.pb.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.DataDict;

/**
 * <br/>class-description 房间变更记录
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class RoomChangeLog extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 变更类型实体
	 */
	@FieldDescription("变更类型实体")
	private DataDict type;
	/**
	 * 房间外键
	 */
	@FieldDescription("房间外键")
	private Long roomId;
	/**
	 * 变更内容
	 */
	@FieldDescription("变更内容")
	private String content;
	/**
	 * 变更类型外键
	 */
	@FieldDescription("变更类型外键")
	private String typeId;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 变更类型实体
	 */
	public DataDict getType(){
		return type;
	}
	public void setType(DataDict type){
		this.type = type;
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
	 * 变更内容
	 */
	public String getContent(){
		return content;
	}
	public void setContent(String content){
		this.content = content;
	}
	/**
	 * 变更类型外键
	 */
	public String getTypeId(){
		return typeId;
	}
	public void setTypeId(String typeId){
		this.typeId = typeId;
	}
}