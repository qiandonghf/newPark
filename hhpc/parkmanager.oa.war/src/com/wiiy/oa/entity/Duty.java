package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;

/**
 * <br/>class-description 值班登记
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Duty extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 单位
	 */
	@FieldDescription("单位")
	private String company;
	/**
	 * 值班人员
	 */
	@FieldDescription("值班人员")
	private String woker;
	/**
	 * 值班日期
	 */
	@FieldDescription("值班日期")
	private Date dutyDate;
	/**
	 * 联系电话
	 */
	@FieldDescription("联系电话")
	private String phone;
	/**
	 * 来访情况
	 */
	@FieldDescription("来访情况")
	private String visitContent;
	/**
	 * 公共设施情况
	 */
	@FieldDescription("公共设施情况")
	private String facilitiesContent;
	/**
	 * 消防、安全情况
	 */
	@FieldDescription("消防、安全情况")
	private String safeContent;
	/**
	 * 门岗、消控情况
	 */
	@FieldDescription("门岗、消控情况")
	private String gateContent;
	/**
	 * 卫生情况
	 */
	@FieldDescription("卫生情况")
	private String healthContent;
	/**
	 * 其它
	 */
	@FieldDescription("其它")
	private String otherContent;
	/**
	 * 备注
	 */
	@FieldDescription("备注")
	private String comment;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 单位
	 */
	public String getCompany(){
		return company;
	}
	public void setCompany(String company){
		this.company = company;
	}
	/**
	 * 值班人员
	 */
	public String getWoker(){
		return woker;
	}
	public void setWoker(String woker){
		this.woker = woker;
	}
	/**
	 * 值班日期
	 */
	public Date getDutyDate(){
		return dutyDate;
	}
	public void setDutyDate(Date dutyDate){
		this.dutyDate = dutyDate;
	}
	/**
	 * 联系电话
	 */
	public String getPhone(){
		return phone;
	}
	public void setPhone(String phone){
		this.phone = phone;
	}
	/**
	 * 来访情况
	 */
	public String getVisitContent(){
		return visitContent;
	}
	public void setVisitContent(String visitContent){
		this.visitContent = visitContent;
	}
	/**
	 * 公共设施情况
	 */
	public String getFacilitiesContent(){
		return facilitiesContent;
	}
	public void setFacilitiesContent(String facilitiesContent){
		this.facilitiesContent = facilitiesContent;
	}
	/**
	 * 消防、安全情况
	 */
	public String getSafeContent(){
		return safeContent;
	}
	public void setSafeContent(String safeContent){
		this.safeContent = safeContent;
	}
	/**
	 * 门岗、消控情况
	 */
	public String getGateContent(){
		return gateContent;
	}
	public void setGateContent(String gateContent){
		this.gateContent = gateContent;
	}
	/**
	 * 卫生情况
	 */
	public String getHealthContent(){
		return healthContent;
	}
	public void setHealthContent(String healthContent){
		this.healthContent = healthContent;
	}
	/**
	 * 其它
	 */
	public String getOtherContent(){
		return otherContent;
	}
	public void setOtherContent(String otherContent){
		this.otherContent = otherContent;
	}
	/**
	 * 备注
	 */
	public String getComment(){
		return comment;
	}
	public void setComment(String comment){
		this.comment = comment;
	}
}