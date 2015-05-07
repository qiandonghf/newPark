package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.crm.entity.Investment;

/**
 * <br/>class-description 招商轨迹
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class InvestmentLog extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 招商项目实体
	 */
	@FieldDescription("招商项目实体")
	private Investment investment;
	/**
	 * 招商项目外键
	 */
	@FieldDescription("招商项目外键")
	private Long investmentId;
	/**
	 * 业务员外键
	 */
	@FieldDescription("业务员外键")
	private Long userId;
	/**
	 * 业务员姓名
	 */
	@FieldDescription("业务员姓名")
	private String userName;
	/**
	 * 联系人
	 */
	@FieldDescription("联系人")
	private String linkMan;
	/**
	 * 时间
	 */
	@FieldDescription("时间")
	private Date linkTime;
	/**
	 * 内容
	 */
	@FieldDescription("内容")
	private String content;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 招商项目实体
	 */
	public Investment getInvestment(){
		return investment;
	}
	public void setInvestment(Investment investment){
		this.investment = investment;
	}
	/**
	 * 招商项目外键
	 */
	public Long getInvestmentId(){
		return investmentId;
	}
	public void setInvestmentId(Long investmentId){
		this.investmentId = investmentId;
	}
	/**
	 * 业务员外键
	 */
	public Long getUserId(){
		return userId;
	}
	public void setUserId(Long userId){
		this.userId = userId;
	}
	/**
	 * 业务员姓名
	 */
	public String getUserName(){
		return userName;
	}
	public void setUserName(String userName){
		this.userName = userName;
	}
	/**
	 * 联系人
	 */
	public String getLinkMan(){
		return linkMan;
	}
	public void setLinkMan(String linkMan){
		this.linkMan = linkMan;
	}
	/**
	 * 时间
	 */
	public Date getLinkTime(){
		return linkTime;
	}
	public void setLinkTime(Date linkTime){
		this.linkTime = linkTime;
	}
	/**
	 * 内容
	 */
	public String getContent(){
		return content;
	}
	public void setContent(String content){
		this.content = content;
	}
}