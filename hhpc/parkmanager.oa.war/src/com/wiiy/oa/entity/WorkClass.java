package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.preferences.enums.EntityStatus;

/**
 * <br/>class-description 班次定义
 * <br/>extends com.wiiy.commons.entity.TreeEntity
 */
public class WorkClass extends TreeEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 班次名称
	 */
	@FieldDescription("班次名称")
	private String name;
	/**
	 * 签到开始时间
	 */
	@FieldDescription("签到开始时间")
	private String signInStartTime;
	/**
	 * 上班时间
	 */
	@FieldDescription("上班时间")
	private String startTime;
	/**
	 * 签到结束时间
	 */
	@FieldDescription("签到结束时间")
	private String signInEndTime;
	/**
	 * 签退开始时间
	 */
	@FieldDescription("签退开始时间")
	private String signOutStartTime;
	/**
	 * 下班时间
	 */
	@FieldDescription("下班时间")
	private String endTime;
	/**
	 * 签退结束时间
	 */
	@FieldDescription("签退结束时间")
	private String signOutEndTime;
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
	 * 班次名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 签到开始时间
	 */
	public String getSignInStartTime(){
		return signInStartTime;
	}
	public void setSignInStartTime(String signInStartTime){
		this.signInStartTime = signInStartTime;
	}
	/**
	 * 上班时间
	 */
	public String getStartTime(){
		return startTime;
	}
	public void setStartTime(String startTime){
		this.startTime = startTime;
	}
	/**
	 * 签到结束时间
	 */
	public String getSignInEndTime(){
		return signInEndTime;
	}
	public void setSignInEndTime(String signInEndTime){
		this.signInEndTime = signInEndTime;
	}
	/**
	 * 签退开始时间
	 */
	public String getSignOutStartTime(){
		return signOutStartTime;
	}
	public void setSignOutStartTime(String signOutStartTime){
		this.signOutStartTime = signOutStartTime;
	}
	/**
	 * 下班时间
	 */
	public String getEndTime(){
		return endTime;
	}
	public void setEndTime(String endTime){
		this.endTime = endTime;
	}
	/**
	 * 签退结束时间
	 */
	public String getSignOutEndTime(){
		return signOutEndTime;
	}
	public void setSignOutEndTime(String signOutEndTime){
		this.signOutEndTime = signOutEndTime;
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