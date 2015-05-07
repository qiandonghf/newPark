package com.wiiy.core.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.preferences.enums.ApprovalStatusEnum;
import com.wiiy.core.preferences.enums.ApprovalTypeEnum;

/**
 * <br/>class-description 审批
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Approval extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 标题
	 */
	@FieldDescription("标题")
	private String title;
	/**
	 * 宽度
	 */
	@FieldDescription("宽度")
	private Integer width;
	/**
	 * 高度
	 */
	@FieldDescription("高度")
	private Integer height;
	/**
	 * 审批组ID(对应其它实体)
	 */
	@FieldDescription("审批组ID(对应其它实体)")
	private Long groupId;
	/**
	 * 审批人ID
	 */
	@FieldDescription("审批人ID")
	private Long userId;
	/**
	 * 审批人
	 */
	@FieldDescription("审批人")
	private String userName;
	/**
	 * 审批页面
	 */
	@FieldDescription("审批页面")
	private String url;
	/**
	 * 审批时间
	 */
	@FieldDescription("审批时间")
	private Date approvalTime;
	/**
	 * 审批意见
	 */
	@FieldDescription("审批意见")
	private String suggestion;
	/**
	 * 类型
	 */
	@FieldDescription("类型")
	private ApprovalTypeEnum type;
	/**
	 * 状态
	 */
	@FieldDescription("状态")
	private ApprovalStatusEnum status;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 标题
	 */
	public String getTitle(){
		return title;
	}
	public void setTitle(String title){
		this.title = title;
	}
	/**
	 * 宽度
	 */
	public Integer getWidth(){
		return width;
	}
	public void setWidth(Integer width){
		this.width = width;
	}
	/**
	 * 高度
	 */
	public Integer getHeight(){
		return height;
	}
	public void setHeight(Integer height){
		this.height = height;
	}
	/**
	 * 审批组ID(对应其它实体)
	 */
	public Long getGroupId(){
		return groupId;
	}
	public void setGroupId(Long groupId){
		this.groupId = groupId;
	}
	/**
	 * 审批人ID
	 */
	public Long getUserId(){
		return userId;
	}
	public void setUserId(Long userId){
		this.userId = userId;
	}
	/**
	 * 审批人
	 */
	public String getUserName(){
		return userName;
	}
	public void setUserName(String userName){
		this.userName = userName;
	}
	/**
	 * 审批页面
	 */
	public String getUrl(){
		return url;
	}
	public void setUrl(String url){
		this.url = url;
	}
	/**
	 * 审批时间
	 */
	public Date getApprovalTime(){
		return approvalTime;
	}
	public void setApprovalTime(Date approvalTime){
		this.approvalTime = approvalTime;
	}
	/**
	 * 审批意见
	 */
	public String getSuggestion(){
		return suggestion;
	}
	public void setSuggestion(String suggestion){
		this.suggestion = suggestion;
	}
	/**
	 * 类型
	 */
	public ApprovalTypeEnum getType(){
		return type;
	}
	public void setType(ApprovalTypeEnum type){
		this.type = type;
	}
	/**
	 * 状态
	 */
	public ApprovalStatusEnum getStatus(){
		return status;
	}
	public void setStatus(ApprovalStatusEnum status){
		this.status = status;
	}
}