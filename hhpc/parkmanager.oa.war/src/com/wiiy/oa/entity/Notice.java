package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.oa.preferences.enums.NoticeStatusEnum;

/**
 * <br/>class-description 公告
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Notice extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 公告标题
	 */
	@FieldDescription("公告标题")
	private String name;
	/**
	 * 公告内容
	 */
	@FieldDescription("公告内容")
	private String content;
	/**
	 * 发布者
	 */
	@FieldDescription("发布者")
	private String issuer;
	/**
	 * 发布来源
	 */
	@FieldDescription("发布来源")
	private String incubator;
	/**
	 * 是否是中心人员
	 */
	@FieldDescription("是否是中心人员")
	private BooleanEnum center;
	/**
	 * 发布状态
	 */
	@FieldDescription("发布状态")
	private NoticeStatusEnum state;
	/**
	 * 发布日期
	 */
	@FieldDescription("发布日期")
	private Date issueTime;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 公告标题
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 公告内容
	 */
	public String getContent(){
		return content;
	}
	public void setContent(String content){
		this.content = content;
	}
	/**
	 * 发布者
	 */
	public String getIssuer(){
		return issuer;
	}
	public void setIssuer(String issuer){
		this.issuer = issuer;
	}
	/**
	 * 发布来源
	 */
	public String getIncubator() {
		return incubator;
	}
	public void setIncubator(String incubator) {
		this.incubator = incubator;
	}
	/**
	 * 是否是中心人员
	 */
	public BooleanEnum getCenter() {
		return center;
	}
	public void setCenter(BooleanEnum center) {
		this.center = center;
	}
	/**
	 * 发布状态
	 */
	public NoticeStatusEnum getState(){
		return state;
	}
	public void setState(NoticeStatusEnum state){
		this.state = state;
	}
	/**
	 * 发布日期
	 */
	public Date getIssueTime(){
		return issueTime;
	}
	public void setIssueTime(Date issueTime){
		this.issueTime = issueTime;
	}
}