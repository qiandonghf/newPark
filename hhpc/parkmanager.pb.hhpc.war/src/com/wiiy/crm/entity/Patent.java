package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.core.entity.DataDict;
import com.wiiy.crm.preferences.enums.PatentSourceEnum;

/**
 * <br/>class-description 知识产权(专利)
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Patent extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 企业
	 */
	@FieldDescription("企业")
	private Customer customer;
	/**
	 * 专利类型
	 */
	@FieldDescription("专利类型")
	private DataDict type;
	/**
	 * 专利来源
	 */
	@FieldDescription("专利来源")
	private DataDict source;
	/**
	 * 专利来源(国内/外)
	 */
	@FieldDescription("专利来源(国内/外)")
	private PatentSourceEnum sourceFrom;
	/**
	 * 专利状态
	 */
	@FieldDescription("专利状态")
	private DataDict state;
	/**
	 * 企业外键
	 */
	@FieldDescription("企业外键")
	private Long customerId;
	/**
	 * 专利类型外键
	 */
	@FieldDescription("专利类型外键")
	private String typeId;
	/**
	 * 专利名称
	 */
	@FieldDescription("专利名称")
	private String name;
	/**
	 * 申请人
	 */
	@FieldDescription("申请人")
	private String appler;
	/**
	 * 申请时间
	 */
	@FieldDescription("申请时间")
	private Date applyTime;
	/**
	 * 专利号
	 */
	@FieldDescription("专利号")
	private String serialNo;
	/**
	 * 专利来源外键
	 */
	@FieldDescription("专利来源外键")
	private String sourceId;
	/**
	 * 专利状态外键
	 */
	@FieldDescription("专利状态外键")
	private String stateId;
	/**
	 * 购买时间
	 */
	@FieldDescription("购买时间")
	private Date buyTime;
	/**
	 * 失效时间
	 */
	@FieldDescription("失效时间")
	private Date expireTime;
	/**
	 * 摘要
	 */
	@FieldDescription("摘要")
	private String summery;
	/**
	 * 是否发布到网站
	 */
	@FieldDescription("是否发布到网站")
	private BooleanEnum pub;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 企业
	 */
	public Customer getCustomer(){
		return customer;
	}
	public void setCustomer(Customer customer){
		this.customer = customer;
	}
	/**
	 * 专利类型
	 */
	public DataDict getType(){
		return type;
	}
	public void setType(DataDict type){
		this.type = type;
	}
	/**
	 * 专利来源
	 */
	public DataDict getSource(){
		return source;
	}
	public void setSource(DataDict source){
		this.source = source;
	}
	/**
	 * 专利状态
	 */
	public DataDict getState(){
		return state;
	}
	public void setState(DataDict state){
		this.state = state;
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
	 * 专利类型外键
	 */
	public String getTypeId(){
		return typeId;
	}
	public void setTypeId(String typeId){
		this.typeId = typeId;
	}
	/**
	 * 专利名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 申请人
	 */
	public String getAppler(){
		return appler;
	}
	public void setAppler(String appler){
		this.appler = appler;
	}
	/**
	 * 申请时间
	 */
	public Date getApplyTime(){
		return applyTime;
	}
	public void setApplyTime(Date applyTime){
		this.applyTime = applyTime;
	}
	/**
	 * 专利号
	 */
	public String getSerialNo(){
		return serialNo;
	}
	public void setSerialNo(String serialNo){
		this.serialNo = serialNo;
	}
	/**
	 * 专利来源外键
	 */
	public String getSourceId(){
		return sourceId;
	}
	public void setSourceId(String sourceId){
		this.sourceId = sourceId;
	}
	/**
	 * 专利状态外键
	 */
	public String getStateId(){
		return stateId;
	}
	public void setStateId(String stateId){
		this.stateId = stateId;
	}
	/**
	 * 购买时间
	 */
	public Date getBuyTime(){
		return buyTime;
	}
	public void setBuyTime(Date buyTime){
		this.buyTime = buyTime;
	}
	/**
	 * 失效时间
	 */
	public Date getExpireTime(){
		return expireTime;
	}
	public void setExpireTime(Date expireTime){
		this.expireTime = expireTime;
	}
	/**
	 * 摘要
	 */
	public String getSummery(){
		return summery;
	}
	public void setSummery(String summery){
		this.summery = summery;
	}
	/**
	 * 是否发布到网站
	 */
	public BooleanEnum getPub(){
		return pub;
	}
	public void setPub(BooleanEnum pub){
		this.pub = pub;
	}
	public PatentSourceEnum getSourceFrom() {
		return sourceFrom;
	}
	public void setSourceFrom(PatentSourceEnum sourceFrom) {
		this.sourceFrom = sourceFrom;
	}
}