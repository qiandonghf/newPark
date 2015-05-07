package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.crm.entity.DataReport;
import com.wiiy.crm.preferences.enums.DataTypeEnum;

/**
 * <br/>class-description 报表数据项配置
 * <br/>extends com.wiiy.commons.entity.TreeEntity
 */
public class DataReportProperty extends TreeEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 报表
	 */
	@FieldDescription("报表")
	private DataReport report;
	/**
	 * 数据id
	 */
	@FieldDescription("数据id")
	private Long propertyId;
	/**
	 * 报表外键
	 */
	@FieldDescription("报表外键")
	private Long reportId;
	/**
	 * 叶子节点
	 */
	@FieldDescription("叶子节点")
	private Boolean leaf;
	/**
	 * 名称
	 */
	@FieldDescription("名称")
	private String name;
	/**
	 * 数据类型
	 */
	@FieldDescription("数据类型")
	private DataTypeEnum dataType;
	/**
	 * 数据类型扩展(JSON)
	 */
	@FieldDescription("数据类型扩展(JSON)")
	private String dataTypeExt;
	/**
	 * 单位
	 */
	@FieldDescription("单位")
	private String unit;
	/**
	 * 填报说明
	 */
	@FieldDescription("填报说明")
	private String note;
	/**
	 * 实体状态
	 */
	@FieldDescription("实体状态")
	private EntityStatus entityStatus;
	/**
	 * 创建时间
	 */
	@FieldDescription("创建时间")
	private Date createTime;
	/**
	 * 创建人姓名
	 */
	@FieldDescription("创建人姓名")
	private String creator;
	/**
	 * 创建人ID
	 */
	@FieldDescription("创建人ID")
	private Long creatorId;
	/**
	 * 修改时间
	 */
	@FieldDescription("修改时间")
	private Date modifyTime;
	/**
	 * 修改人姓名
	 */
	@FieldDescription("修改人姓名")
	private String modifier;
	/**
	 * 修改人ID
	 */
	@FieldDescription("修改人ID")
	private Long modifierId;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 报表
	 */
	public DataReport getReport(){
		return report;
	}
	public void setReport(DataReport report){
		this.report = report;
	}
	/**
	 * 数据id
	 */
	public Long getPropertyId(){
		return propertyId;
	}
	public void setPropertyId(Long propertyId){
		this.propertyId = propertyId;
	}
	/**
	 * 报表外键
	 */
	public Long getReportId(){
		return reportId;
	}
	public void setReportId(Long reportId){
		this.reportId = reportId;
	}
	/**
	 * 叶子节点
	 */
	public Boolean getLeaf(){
		return leaf;
	}
	public void setLeaf(Boolean leaf){
		this.leaf = leaf;
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
	 * 数据类型
	 */
	public DataTypeEnum getDataType(){
		return dataType;
	}
	public void setDataType(DataTypeEnum dataType){
		this.dataType = dataType;
	}
	/**
	 * 数据类型扩展(JSON)
	 */
	public String getDataTypeExt(){
		return dataTypeExt;
	}
	public void setDataTypeExt(String dataTypeExt){
		this.dataTypeExt = dataTypeExt;
	}
	/**
	 * 单位
	 */
	public String getUnit(){
		return unit;
	}
	public void setUnit(String unit){
		this.unit = unit;
	}
	/**
	 * 填报说明
	 */
	public String getNote(){
		return note;
	}
	public void setNote(String note){
		this.note = note;
	}
	/**
	 * 实体状态
	 */
	public EntityStatus getEntityStatus(){
		return entityStatus;
	}
	public void setEntityStatus(EntityStatus entityStatus){
		this.entityStatus = entityStatus;
	}
	/**
	 * 创建时间
	 */
	public Date getCreateTime(){
		return createTime;
	}
	public void setCreateTime(Date createTime){
		this.createTime = createTime;
	}
	/**
	 * 创建人姓名
	 */
	public String getCreator(){
		return creator;
	}
	public void setCreator(String creator){
		this.creator = creator;
	}
	/**
	 * 创建人ID
	 */
	public Long getCreatorId(){
		return creatorId;
	}
	public void setCreatorId(Long creatorId){
		this.creatorId = creatorId;
	}
	/**
	 * 修改时间
	 */
	public Date getModifyTime(){
		return modifyTime;
	}
	public void setModifyTime(Date modifyTime){
		this.modifyTime = modifyTime;
	}
	/**
	 * 修改人姓名
	 */
	public String getModifier(){
		return modifier;
	}
	public void setModifier(String modifier){
		this.modifier = modifier;
	}
	/**
	 * 修改人ID
	 */
	public Long getModifierId(){
		return modifierId;
	}
	public void setModifierId(Long modifierId){
		this.modifierId = modifierId;
	}
}