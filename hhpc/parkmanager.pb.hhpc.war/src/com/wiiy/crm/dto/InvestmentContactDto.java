package com.wiiy.crm.dto;

import java.util.List;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.core.entity.User;

public class InvestmentContactDto {
	/**
	 * 填表日期-年
	 */
	@FieldDescription("填表日期-年")
	private String year;
	/**
	 * 填表日期-月
	 */
	@FieldDescription("填表日期-月")
	private String month;
	/**
	 * 填表日期-日
	 */
	@FieldDescription("填表日期-日")
	private String day;
	/**
	 * 项目名称
	 */
	@FieldDescription("项目名称")
	private String investmentName;
	/**
	 * 经营范围
	 */
	@FieldDescription("经营范围")
	private String businessScope;
	/**
	 * 注册资本
	 */
	@FieldDescription("注册资本")
	private Double regCapital;
	/**
	 * 企业人数
	 */
	@FieldDescription("企业人数")
	private Integer staff;
	/**
	 * 用房面积
	 */
	@FieldDescription("用房面积")
	private Double officeArea;
	/**
	 * 计划总投资
	 */
	@FieldDescription("计划总投资")
	private Double investCapital;
	/**
	 * 预计年产值
	 */
	@FieldDescription("预计年产值")
	private Double outputValue;
	/**
	 * 投资促进部意见
	 */
	@FieldDescription("投资促进部意见")
	private String departmentOpinion;
	/**
	 * 主任会议室意见
	 */
	@FieldDescription("主任会议室意见")
	private String headOpinion;
	/**
	 * 经办人意见
	 */
	@FieldDescription("经办人意见")
	private String handleOpinion;
	/**
	 * 招商人员意见
	 */
	@FieldDescription("招商人员意见")
	private String attractOpinion;
	public String getHandleOpinion() {
		return handleOpinion;
	}
	public void setHandleOpinion(String handleOpinion) {
		this.handleOpinion = handleOpinion;
	}
	public String getAttractOpinion() {
		return attractOpinion;
	}
	public void setAttractOpinion(String attractOpinion) {
		this.attractOpinion = attractOpinion;
	}
	/**
	 * 联系人
	 */
	@FieldDescription("联系人")
	private User linkman;
	/**
	 * 投资方
	 */
	@FieldDescription("投资方")
	private List<DirectorDto> directorList;
	/**
	 * 成果转化或开发项目概况
	 */
	@FieldDescription("成果转化或开发项目概况")
	private String description;
	public String getInvestmentName() {
		return investmentName;
	}
	public void setInvestmentName(String investmentName) {
		this.investmentName = investmentName;
	}
	public String getBusinessScope() {
		return businessScope;
	}
	public void setBusinessScope(String businessScope) {
		this.businessScope = businessScope;
	}
	public Double getRegCapital() {
		return regCapital;
	}
	public void setRegCapital(Double regCapital) {
		this.regCapital = regCapital;
	}
	public Integer getStaff() {
		return staff;
	}
	public void setStaff(Integer staff) {
		this.staff = staff;
	}
	public Double getOfficeArea() {
		return officeArea;
	}
	public void setOfficeArea(Double officeArea) {
		this.officeArea = officeArea;
	}
	public Double getInvestCapital() {
		return investCapital;
	}
	public void setInvestCapital(Double investCapital) {
		this.investCapital = investCapital;
	}
	public Double getOutputValue() {
		return outputValue;
	}
	public void setOutputValue(Double outputValue) {
		this.outputValue = outputValue;
	}
	public String getDepartmentOpinion() {
		return departmentOpinion;
	}
	public void setDepartmentOpinion(String departmentOpinion) {
		this.departmentOpinion = departmentOpinion;
	}
	public String getHeadOpinion() {
		return headOpinion;
	}
	public void setHeadOpinion(String headOpinion) {
		this.headOpinion = headOpinion;
	}
	public User getLinkman() {
		return linkman;
	}
	public void setLinkman(User linkman) {
		this.linkman = linkman;
	}
	public List<DirectorDto> getDirectorList() {
		return directorList;
	}
	public void setDirectorList(List<DirectorDto> directorList) {
		this.directorList = directorList;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}

}
