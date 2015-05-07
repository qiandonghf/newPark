package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.GenderEnum;
import com.wiiy.core.entity.DataDict;
import com.wiiy.crm.entity.Customer;

/**
 * <br/>class-description 从业人员
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Staffer extends BaseEntity implements Serializable {
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
	 * 学位
	 */
	@FieldDescription("学位")
	private DataDict degree;
	/**
	 * 职位
	 */
	@FieldDescription("职位")
	private DataDict position;
	/**
	 * 政治面貌
	 */
	@FieldDescription("政治面貌")
	private DataDict political;
	/**
	 * 企业外键
	 */
	@FieldDescription("企业外键")
	private Long customerId;
	/**
	 * 学位外键
	 */
	@FieldDescription("学位外键")
	private String degreeId;
	/**
	 * 职位外键
	 */
	@FieldDescription("职位外键")
	private String positionId;
	/**
	 * 姓名
	 */
	@FieldDescription("姓名")
	private String name;
	/**
	 * 政治面貌外键
	 */
	@FieldDescription("政治面貌外键")
	private String politicalId;
	/**
	 * 性别
	 */
	@FieldDescription("性别")
	private GenderEnum gender;
	/**
	 * 学历
	 */
	@FieldDescription("学历")
	private String education;
	/**
	 * 留学国家
	 */
	@FieldDescription("留学国家")
	private String abroadCountry;
	/**
	 * 出生年月
	 */
	@FieldDescription("出生年月")
	private Date birth;
	/**
	 * 联系电话
	 */
	@FieldDescription("联系电话")
	private String phone;
	/**
	 * Email地址
	 */
	@FieldDescription("Email地址")
	private String email;
	/**
	 * 是否股东
	 */
	@FieldDescription("是否股东")
	private BooleanEnum stockHolder;
	/**
	 * 是否总经理
	 */
	@FieldDescription("是否总经理")
	private BooleanEnum manager;
	/**
	 * 否是留学人员
	 */
	@FieldDescription("否是留学人员")
	private BooleanEnum studyAbroad;
	/**
	 * 否是法人
	 */
	@FieldDescription("否是法人")
	private BooleanEnum legal;
	/**
	 * 毕业学校
	 */
	@FieldDescription("毕业学校")
	private String studySchool;
	/**
	 * 是否发布到网站
	 */
	@FieldDescription("是否发布到网站")
	private BooleanEnum pub;
	/**
	 * 备注
	 */
	@FieldDescription("备注")
	private String memo;

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
	 * 学位
	 */
	public DataDict getDegree(){
		return degree;
	}
	public void setDegree(DataDict degree){
		this.degree = degree;
	}
	/**
	 * 职位
	 */
	public DataDict getPosition(){
		return position;
	}
	public void setPosition(DataDict position){
		this.position = position;
	}
	/**
	 * 政治面貌
	 */
	public DataDict getPolitical(){
		return political;
	}
	public void setPolitical(DataDict political){
		this.political = political;
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
	 * 学位外键
	 */
	public String getDegreeId(){
		return degreeId;
	}
	public void setDegreeId(String degreeId){
		this.degreeId = degreeId;
	}
	/**
	 * 职位外键
	 */
	public String getPositionId(){
		return positionId;
	}
	public void setPositionId(String positionId){
		this.positionId = positionId;
	}
	/**
	 * 姓名
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 政治面貌外键
	 */
	public String getPoliticalId(){
		return politicalId;
	}
	public void setPoliticalId(String politicalId){
		this.politicalId = politicalId;
	}
	/**
	 * 性别
	 */
	public GenderEnum getGender(){
		return gender;
	}
	public void setGender(GenderEnum gender){
		this.gender = gender;
	}
	/**
	 * 学历
	 */
	public String getEducation(){
		return education;
	}
	public void setEducation(String education){
		this.education = education;
	}
	/**
	 * 留学国家
	 */
	public String getAbroadCountry(){
		return abroadCountry;
	}
	public void setAbroadCountry(String abroadCountry){
		this.abroadCountry = abroadCountry;
	}
	/**
	 * 出生年月
	 */
	public Date getBirth(){
		return birth;
	}
	public void setBirth(Date birth){
		this.birth = birth;
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
	 * Email地址
	 */
	public String getEmail(){
		return email;
	}
	public void setEmail(String email){
		this.email = email;
	}
	/**
	 * 是否股东
	 */
	public BooleanEnum getStockHolder(){
		return stockHolder;
	}
	public void setStockHolder(BooleanEnum stockHolder){
		this.stockHolder = stockHolder;
	}
	/**
	 * 是否总经理
	 */
	public BooleanEnum getManager(){
		return manager;
	}
	public void setManager(BooleanEnum manager){
		this.manager = manager;
	}
	/**
	 * 否是留学人员
	 */
	public BooleanEnum getStudyAbroad(){
		return studyAbroad;
	}
	public void setStudyAbroad(BooleanEnum studyAbroad){
		this.studyAbroad = studyAbroad;
	}
	/**
	 * 否是法人
	 */
	public BooleanEnum getLegal(){
		return legal;
	}
	public void setLegal(BooleanEnum legal){
		this.legal = legal;
	}
	/**
	 * 毕业学校
	 */
	public String getStudySchool(){
		return studySchool;
	}
	public void setStudySchool(String studySchool){
		this.studySchool = studySchool;
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
	/**
	 * 备注
	 */
	public String getMemo(){
		return memo;
	}
	public void setMemo(String memo){
		this.memo = memo;
	}
}