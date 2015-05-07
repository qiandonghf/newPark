package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.DataDict;
import com.wiiy.crm.entity.Investment;

/**
 * <br/>class-description 投资人
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class InvestmentInvestor extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 招商项目
	 */
	@FieldDescription("招商项目")
	private Investment investment;
	/**
	 * 出资方式
	 */
	@FieldDescription("出资方式")
	private DataDict capital;
	/**
	 * 学位
	 */
	@FieldDescription("学位")
	private DataDict degree;
	/**
	 * 招商项目外键
	 */
	@FieldDescription("招商项目外键")
	private Long investmentId;
	/**
	 * 出资方
	 */
	@FieldDescription("出资方")
	private String name;
	/**
	 * 出资比例
	 */
	@FieldDescription("出资比例")
	private Double rate;
	/**
	 * 出生日期
	 */
	@FieldDescription("出生日期")
	private Date birthDay;
	/**
	 * 出资方式外键
	 */
	@FieldDescription("出资方式外键")
	private String capitalId;
	/**
	 * 学位外键
	 */
	@FieldDescription("学位外键")
	private String degreeId;
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
	/**
	 * 职称
	 */
	@FieldDescription("职称")
	private String profession;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
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
	 * 出资方式
	 */
	public DataDict getCapital(){
		return capital;
	}
	public void setCapital(DataDict capital){
		this.capital = capital;
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
	 * 招商项目外键
	 */
	public Long getInvestmentId(){
		return investmentId;
	}
	public void setInvestmentId(Long investmentId){
		this.investmentId = investmentId;
	}
	/**
	 * 出资方
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 出资比例
	 */
	public Double getRate(){
		return rate;
	}
	public void setRate(Double rate){
		this.rate = rate;
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
	 * 出资方式外键
	 */
	public String getCapitalId(){
		return capitalId;
	}
	public void setCapitalId(String capitalId){
		this.capitalId = capitalId;
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
	/**
	 * 职称
	 */
	public String getProfession(){
		return profession;
	}
	public void setProfession(String profession){
		this.profession = profession;
	}
}