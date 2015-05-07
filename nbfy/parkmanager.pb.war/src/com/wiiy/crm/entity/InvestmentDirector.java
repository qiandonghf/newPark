package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.GenderEnum;
import com.wiiy.core.entity.DataDict;
import com.wiiy.crm.entity.Investment;

/**
 * <br/>class-description 投资负责人
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class InvestmentDirector extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 学位
	 */
	@FieldDescription("学历")
	private DataDict degree;
	/**
	 * 招商项目
	 */
	@FieldDescription("招商项目")
	private Investment investment;
	/**
	 * 招商项目外键
	 */
	@FieldDescription("招商项目外键")
	private Long investmentId;
	/**
	 * 姓名
	 */
	@FieldDescription("姓名")
	private String name;
	/**
	 * 出生日期
	 */
	@FieldDescription("出生日期")
	private Date birthDay;
	/**
	 * 性别
	 */
	@FieldDescription("性别")
	private GenderEnum gender;
	/**
	 * 学位外键
	 */
	@FieldDescription("学位外键")
	private String degreeId;
	/**
	 * 固定电话
	 */
	@FieldDescription("固定电话")
	private String phone;
	/**
	 * 手机
	 */
	@FieldDescription("手机")
	private String mobile;
	/**
	 * 传真
	 */
	@FieldDescription("传真")
	private String fax;
	/**
	 * 专业
	 */
	@FieldDescription("专业")
	private String specialty;
	/**
	 * 职称
	 */
	@FieldDescription("职称")
	private String profession;
	/**
	 * 邮箱
	 */
	@FieldDescription("邮箱")
	private String email;
	/**
	 * 毕业学校
	 */
	@FieldDescription("毕业学校")
	private String school;
	/**
	 * 毕业年份
	 */
	@FieldDescription("毕业年份")
	private Integer graduateYear;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 招商项目外键
	 */
	public Long getInvestmentId() {
		return investmentId;
	}
	public void setInvestmentId(Long investmentId) {
		this.investmentId = investmentId;
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
	 * 招商项目
	 */
	public Investment getInvestment(){
		return investment;
	}
	public void setInvestment(Investment investment){
		this.investment = investment;
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
	 * 出生日期
	 */
	public Date getBirthDay(){
		return birthDay;
	}
	public void setBirthDay(Date birthDay){
		this.birthDay = birthDay;
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
	 * 学位外键
	 */
	public String getDegreeId(){
		return degreeId;
	}
	public void setDegreeId(String degreeId){
		this.degreeId = degreeId;
	}
	/**
	 * 固定电话
	 */
	public String getPhone(){
		return phone;
	}
	public void setPhone(String phone){
		this.phone = phone;
	}
	/**
	 * 手机
	 */
	public String getMobile(){
		return mobile;
	}
	public void setMobile(String mobile){
		this.mobile = mobile;
	}
	/**
	 * 传真
	 */
	public String getFax(){
		return fax;
	}
	public void setFax(String fax){
		this.fax = fax;
	}
	/**
	 * 专业
	 */
	public String getSpecialty() {
		return specialty;
	}
	public void setSpecialty(String specialty) {
		this.specialty = specialty;
	}
	/**
	 * 职称
	 */
	public String getProfession(){
		return profession;
	}
	public void setProfession(String profession){
		this.profession = profession;
	}
	/**
	 * 邮箱
	 */
	public String getEmail(){
		return email;
	}
	public void setEmail(String email){
		this.email = email;
	}
	/**
	 * 毕业学校
	 */
	public String getSchool(){
		return school;
	}
	public void setSchool(String school){
		this.school = school;
	}
	/**
	 * 毕业年份
	 */
	public Integer getGraduateYear(){
		return graduateYear;
	}
	public void setGraduateYear(Integer graduateYear){
		this.graduateYear = graduateYear;
	}
}