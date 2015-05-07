package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.crm.entity.DataReportProperty;
import com.wiiy.crm.entity.DataReportToCustomer;

/**
 * <br/>class-description 上报数据值
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class DataReportValue extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 报表企业配置
	 */
	@FieldDescription("报表企业配置")
	private DataReportToCustomer reportCustomer;
	/**
	 * 报表数据项配置
	 */
	@FieldDescription("报表数据项配置")
	private DataReportProperty property;
	/**
	 * 报表企业配置外键
	 */
	@FieldDescription("报表企业配置外键")
	private Long reportCustomerId;
	/**
	 * 报表数据项配置外键
	 */
	@FieldDescription("报表数据项配置外键")
	private Long propertyId;
	/**
	 * 本期累计金额
	 *//*
	@FieldDescription("本期累计金额")
	private Double bqAmount;
	*//**
	 * 本月金额
	 *//*
	@FieldDescription("本月金额")
	private Double monthAmount;
	*//**
	 * 期末余额
	 *//*
	@FieldDescription("期末余额")
	private Double finalBalance;
	*//**
	 * 年初余额
	 *//*
	@FieldDescription("年初余额")
	private Double beginBalance;*/
	/**
	 * 整数值
	 */
	@FieldDescription("整数值")
	private Integer intVal;
	/**
	 * 字符串值
	 */
	@FieldDescription("字符串值")
	private String strVal;
	/**
	 * 小数值
	 */
	@FieldDescription("小数值")
	private Double doubleVal;
	/**
	 * 小数值2
	 */
	@FieldDescription("小数值2")
	private Double doubleVal2;
	/**
	 * 选择值
	 */
	@FieldDescription("选择值")
	private String selVal;
	/**
	 * 时间值
	 */
	@FieldDescription("时间值")
	private Date dateVal;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 报表企业配置
	 */
	public DataReportToCustomer getReportCustomer(){
		return reportCustomer;
	}
	public void setReportCustomer(DataReportToCustomer reportCustomer){
		this.reportCustomer = reportCustomer;
	}
	/**
	 * 报表数据项配置
	 */
	public DataReportProperty getProperty(){
		return property;
	}
	public void setProperty(DataReportProperty property){
		this.property = property;
	}
	/**
	 * 报表企业配置外键
	 */
	public Long getReportCustomerId(){
		return reportCustomerId;
	}
	public void setReportCustomerId(Long reportCustomerId){
		this.reportCustomerId = reportCustomerId;
	}
	/**
	 * 报表数据项配置外键
	 */
	public Long getPropertyId(){
		return propertyId;
	}
	public void setPropertyId(Long propertyId){
		this.propertyId = propertyId;
	}
	/**
	 * 本期累计金额
	 *//*
	public Double getBqAmount(){
		return bqAmount;
	}
	public void setBqAmount(Double bqAmount){
		this.bqAmount = bqAmount;
	}
	*//**
	 * 本月金额
	 *//*
	public Double getMonthAmount(){
		return monthAmount;
	}
	public void setMonthAmount(Double monthAmount){
		this.monthAmount = monthAmount;
	}
	*//**
	 * 期末余额
	 *//*
	public Double getFinalBalance(){
		return finalBalance;
	}
	public void setFinalBalance(Double finalBalance){
		this.finalBalance = finalBalance;
	}
	*//**
	 * 年初余额
	 *//*
	public Double getBeginBalance(){
		return beginBalance;
	}
	public void setBeginBalance(Double beginBalance){
		this.beginBalance = beginBalance;
	}*/
	/**
	 * 整数值
	 */
	public Integer getIntVal(){
		return intVal;
	}
	public void setIntVal(Integer intVal){
		this.intVal = intVal;
	}
	/**
	 * 字符串值
	 */
	public String getStrVal(){
		return strVal;
	}
	public void setStrVal(String strVal){
		this.strVal = strVal;
	}
	/**
	 * 小数值
	 */
	public Double getDoubleVal(){
		return doubleVal;
	}
	public void setDoubleVal(Double doubleVal){
		this.doubleVal = doubleVal;
	}
	/**
	 * 小数值2
	 */
	public Double getDoubleVal2(){
		return doubleVal2;
	}
	public void setDoubleVal2(Double doubleVal2){
		this.doubleVal2 = doubleVal2;
	}
	/**
	 * 选择值
	 */
	public String getSelVal(){
		return selVal;
	}
	public void setSelVal(String selVal){
		this.selVal = selVal;
	}
	/**
	 * 时间值
	 */
	public Date getDateVal(){
		return dateVal;
	}
	public void setDateVal(Date dateVal){
		this.dateVal = dateVal;
	}
}