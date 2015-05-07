package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.crm.entity.DataReportGroup;
import com.wiiy.crm.entity.DataTemplate;
import com.wiiy.crm.preferences.enums.ReportStatusEnum;
import com.wiiy.crm.preferences.enums.ReportTypeEnum;

/**
 * <br/>class-description 报表
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class DataReport extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 报表分组
	 */
	@FieldDescription("报表分组")
	private DataReportGroup group;
	/**
	 * 报表模块
	 */
	@FieldDescription("报表模块")
	private DataTemplate template;
	/**
	 * 名称
	 */
	@FieldDescription("名称")
	private String name;
	/**
	 * 报表分组外键
	 */
	@FieldDescription("报表分组外键")
	private Long groupId;
	/**
	 * 报表模块外键
	 */
	@FieldDescription("报表模块外键")
	private Long templateId;
	/**
	 * 报表类型
	 */
	@FieldDescription("报表类型")
	private ReportTypeEnum reportType;
	/**
	 * 数据时间
	 */
	@FieldDescription("数据时间")
	private Date dataTime;
	/**
	 * 上报截止时间
	 */
	@FieldDescription("上报截止时间")
	private Date finishTime;
	/**
	 * 报表状态
	 */
	@FieldDescription("报表状态")
	private ReportStatusEnum status;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 报表分组
	 */
	public DataReportGroup getGroup(){
		return group;
	}
	public void setGroup(DataReportGroup group){
		this.group = group;
	}
	/**
	 * 报表模块
	 */
	public DataTemplate getTemplate(){
		return template;
	}
	public void setTemplate(DataTemplate template){
		this.template = template;
	}
	/**
	 * 名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 报表分组外键
	 */
	public Long getGroupId(){
		return groupId;
	}
	public void setGroupId(Long groupId){
		this.groupId = groupId;
	}
	/**
	 * 报表模块外键
	 */
	public Long getTemplateId(){
		return templateId;
	}
	public void setTemplateId(Long templateId){
		this.templateId = templateId;
	}
	/**
	 * 报表类型
	 */
	public ReportTypeEnum getReportType(){
		return reportType;
	}
	public void setReportType(ReportTypeEnum reportType){
		this.reportType = reportType;
	}
	/**
	 * 数据时间
	 */
	public Date getDataTime(){
		return dataTime;
	}
	public void setDataTime(Date dataTime){
		this.dataTime = dataTime;
	}
	/**
	 * 上报截止时间
	 */
	public Date getFinishTime(){
		return finishTime;
	}
	public void setFinishTime(Date finishTime){
		this.finishTime = finishTime;
	}
	/**
	 * 报表状态
	 */
	public ReportStatusEnum getStatus(){
		return status;
	}
	public void setStatus(ReportStatusEnum status){
		this.status = status;
	}
	
	
}