package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.oa.entity.CardCategory;
import com.wiiy.oa.preferences.enums.CardOwnerEnum;

/**
 * <br/>class-description 名片分类
 * <br/>extends com.wiiy.commons.entity.TreeEntity
 */
public class CardCategory extends TreeEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 文件夹实体
	 */
	@FieldDescription("文件夹实体")
	private CardCategory parent;
	/**
	 * 分类名称
	 */
	@FieldDescription("分类名称")
	private String name;
	/**
	 * 分类拥有者ID
	 */
	@FieldDescription("分类拥有者ID")
	private Long ownerId;
	/**
	 * 拥有类型
	 */
	@FieldDescription("拥有类型")
	private CardOwnerEnum ownerEnum;
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
	 * 文件夹实体
	 */
	public CardCategory getParent(){
		return parent;
	}
	public void setParent(CardCategory parent){
		this.parent = parent;
	}
	/**
	 * 分类名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 分类拥有者ID
	 */
	public Long getOwnerId(){
		return ownerId;
	}
	public void setOwnerId(Long ownerId){
		this.ownerId = ownerId;
	}
	/**
	 * 拥有类型
	 */
	public CardOwnerEnum getOwnerEnum(){
		return ownerEnum;
	}
	public void setOwnerEnum(CardOwnerEnum ownerEnum){
		this.ownerEnum = ownerEnum;
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