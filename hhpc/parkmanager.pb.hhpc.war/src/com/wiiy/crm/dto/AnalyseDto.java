package com.wiiy.crm.dto;

public class AnalyseDto {
	private Long templateId;//数据模板id
	private Long propertyId;//数据项id
	private String propertyName;//数据项id
	private Integer sYear;
	private Integer sMonth;
	private Integer eYear;
	private Integer eMonth;
	private String ids;
	public Integer getsYear() {
		return sYear;
	}
	public void setsYear(Integer sYear) {
		this.sYear = sYear;
	}
	public Integer getsMonth() {
		return sMonth;
	}
	public void setsMonth(Integer sMonth) {
		this.sMonth = sMonth;
	}
	public Integer geteYear() {
		return eYear;
	}
	public void seteYear(Integer eYear) {
		this.eYear = eYear;
	}
	public Integer geteMonth() {
		return eMonth;
	}
	public void seteMonth(Integer eMonth) {
		this.eMonth = eMonth;
	}
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
	public Long getPropertyId() {
		return propertyId;
	}
	public void setPropertyId(Long propertyId) {
		this.propertyId = propertyId;
	}
	public Long getTemplateId() {
		return templateId;
	}
	public void setTemplateId(Long templateId) {
		this.templateId = templateId;
	}
	public String getPropertyName() {
		return propertyName;
	}
	public void setPropertyName(String propertyName) {
		this.propertyName = propertyName;
	}
	
}
