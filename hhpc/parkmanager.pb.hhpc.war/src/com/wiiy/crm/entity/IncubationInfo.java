package com.wiiy.crm.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.core.entity.DataDict;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.entity.IncubationRoute;

/**
 * <br/>class-description 孵化信息
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class IncubationInfo extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 孵化器配置
	 */
	@FieldDescription("孵化器配置")
	private DataDict incubateConfig;
	/**
	 * 孵化状态
	 */
	@FieldDescription("孵化状态")
	private IncubationRoute status;
	/**
	 * 孵化面积
	 */
	@FieldDescription("孵化面积")
	private BigDecimal incubatorAreas;
	/**
	 * 企业实体
	 */
	@FieldDescription("企业实体")
	private Customer customer;
	/**
	 * 孵化协议（附件）
	 */
	@FieldDescription("孵化协议（附件）")
	private String agreementDocu;
	/**
	 * 孵化协议（附件）
	 */
	@FieldDescription("孵化协议（附件）")
	private String agreementName;
	/**
	 * 孵化日期起
	 */
	@FieldDescription("孵化日期起")
	private Date incubationStartDate;
	/**
	 * 孵化日期止
	 */
	@FieldDescription("孵化日期止")
	private Date incubationEndDate;
	/**
	 * 毕业日期
	 */
	@FieldDescription("毕业日期")
	private Date graduationDate;
	/**
	 * 是否高新技术企业
	 */
	@FieldDescription("是否高新技术企业")
	private BooleanEnum highTechEnterprise;
	/**
	 * 是否建立创业导师
	 */
	@FieldDescription("是否建立创业导师")
	private BooleanEnum tutorSupport;
	/**
	 * 是否大学生创业
	 */
	@FieldDescription("是否大学生创业")
	private BooleanEnum undergraduateEnterprise;
	/**
	 * 是否留学生创业
	 */
	@FieldDescription("是否留学生创业")
	private BooleanEnum overseaEnterprise;
	/**
	 * 孵化器配置外键
	 */
	@FieldDescription("孵化器配置外键")
	private String incubateConfigId;
	/**
	 * 孵化状态外键
	 */
	@FieldDescription("孵化状态外键")
	private Long statusId;
	/**
	 * 孵化状态名称
	 */
	@FieldDescription("孵化状态名称")
	private String statusName;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 孵化器配置
	 */
	public DataDict getIncubateConfig(){
		return incubateConfig;
	}
	public void setIncubateConfig(DataDict incubateConfig){
		this.incubateConfig = incubateConfig;
	}
	/**
	 * 孵化状态
	 */
	public IncubationRoute getStatus(){
		return status;
	}
	public void setStatus(IncubationRoute status){
		this.status = status;
	}
	/**
	 * 企业实体
	 */
	public Customer getCustomer(){
		return customer;
	}
	public void setCustomer(Customer customer){
		this.customer = customer;
	}
	/**
	 * 孵化协议（附件）
	 */
	public String getAgreementDocu(){
		return agreementDocu;
	}
	public void setAgreementDocu(String agreementDocu){
		this.agreementDocu = agreementDocu;
	}
	/**
	 * 孵化协议（附件）
	 */
	public String getAgreementName(){
		return agreementName;
	}
	public void setAgreementName(String agreementName){
		this.agreementName = agreementName;
	}
	/**
	 * 孵化日期起
	 */
	public Date getIncubationStartDate(){
		return incubationStartDate;
	}
	public void setIncubationStartDate(Date incubationStartDate){
		this.incubationStartDate = incubationStartDate;
	}
	/**
	 * 孵化日期止
	 */
	public Date getIncubationEndDate(){
		return incubationEndDate;
	}
	public void setIncubationEndDate(Date incubationEndDate){
		this.incubationEndDate = incubationEndDate;
	}
	/**
	 * 毕业日期
	 */
	public Date getGraduationDate(){
		return graduationDate;
	}
	public void setGraduationDate(Date graduationDate){
		this.graduationDate = graduationDate;
	}
	/**
	 * 是否高新技术企业
	 */
	public BooleanEnum getHighTechEnterprise(){
		return highTechEnterprise;
	}
	public void setHighTechEnterprise(BooleanEnum highTechEnterprise){
		this.highTechEnterprise = highTechEnterprise;
	}
	/**
	 * 是否建立创业导师
	 */
	public BooleanEnum getTutorSupport(){
		return tutorSupport;
	}
	public void setTutorSupport(BooleanEnum tutorSupport){
		this.tutorSupport = tutorSupport;
	}
	/**
	 * 是否大学生创业
	 */
	public BooleanEnum getUndergraduateEnterprise(){
		return undergraduateEnterprise;
	}
	public void setUndergraduateEnterprise(BooleanEnum undergraduateEnterprise){
		this.undergraduateEnterprise = undergraduateEnterprise;
	}
	/**
	 * 是否留学生创业
	 */
	public BooleanEnum getOverseaEnterprise(){
		return overseaEnterprise;
	}
	public void setOverseaEnterprise(BooleanEnum overseaEnterprise){
		this.overseaEnterprise = overseaEnterprise;
	}
	/**
	 * 孵化器配置外键
	 */
	public String getIncubateConfigId(){
		return incubateConfigId;
	}
	public void setIncubateConfigId(String incubateConfigId){
		this.incubateConfigId = incubateConfigId;
	}
	/**
	 * 孵化状态外键
	 */
	public Long getStatusId(){
		return statusId;
	}
	public void setStatusId(Long statusId){
		this.statusId = statusId;
	}
	/**
	 * 孵化状态名称
	 */
	public String getStatusName(){
		return statusName;
	}
	public void setStatusName(String statusName){
		this.statusName = statusName;
	}
	/**
	 * 孵化面积
	 */
	public BigDecimal getIncubatorAreas() {
		return incubatorAreas;
	}
	public void setIncubatorAreas(BigDecimal incubatorAreas) {
		this.incubatorAreas = incubatorAreas;
	}
}