package com.wiiy.crm.dto;

import java.util.List;

public class InvestmentDto {
	
	private String code;
	private String year;
	private String month;
	private String day;
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	private String name;
	private String businessScope;
	private Integer staff;
	private Double officeArea;
	private String officeName;
	public String getOfficeName() {
		return officeName;
	}
	public void setOfficeName(String officeName) {
		this.officeName = officeName;
	}
	private Double regCapital;
	private Double investCapital;
	private Double outputValue;
	private String memo;
	private String managerView;
	private String businessmanView;
	private String enterpriseTypes;
	private String departmentView;
	private String officeView;//领导审批意见（原来叫做主任办公室意见）
	private String technic;
	private String address;
    private List<InvestorDto> list;
    private List<DirectorDto> directorList;
    public List<DirectorDto> getDirectorList() {
		return directorList;
	}
	public void setDirectorList(List<DirectorDto> directorList) {
		this.directorList = directorList;
	}
	public List<InvestorDto> getList() {
		return list;
	}
	private String projectMemo;
    
	public String getBusinessmanView() {
		return businessmanView;
	}
	public void setBusinessmanView(String businessmanView) {
		this.businessmanView = businessmanView;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
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
	public String getEnterpriseTypes() {
		return enterpriseTypes;
	}
	public void setEnterpriseTypes(String enterpriseTypes) {
		this.enterpriseTypes = enterpriseTypes;
	}
	public String getTechnic() {
		return technic;
	}
	public void setTechnic(String technic) {
		this.technic = technic;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBusinessScope() {
		return businessScope;
	}
	public void setBusinessScope(String businessScope) {
		this.businessScope = businessScope;
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
	public Double getRegCapital() {
		return regCapital;
	}
	public void setRegCapital(Double regCapital) {
		this.regCapital = regCapital;
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
	
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public void setList(List<InvestorDto> list) {
		this.list = list;
	}
	public String getManagerView() {
		return managerView;
	}
	public void setManagerView(String managerView) {
		this.managerView = managerView;
	}
	public String getProjectMemo() {
		return projectMemo;
	}
	public void setProjectMemo(String projectMemo) {
		this.projectMemo = projectMemo;
	}
	public String getDepartmentView() {
		return departmentView;
	}
	public void setDepartmentView(String departmentView) {
		this.departmentView = departmentView;
	}
	public String getOfficeView() {
		return officeView;
	}
	public void setOfficeView(String officeView) {
		this.officeView = officeView;
	}
}
