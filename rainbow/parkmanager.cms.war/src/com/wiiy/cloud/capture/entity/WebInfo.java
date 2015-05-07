package com.wiiy.cloud.capture.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.cloud.capture.entity.Column;
import com.wiiy.cloud.capture.entity.WebInfo;
import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.EntityStatus;

/**
 * <br/>class-description 网站信息
 * <br/>extends com.wiiy.commons.entity.TreeEntity
 */
public class WebInfo extends TreeEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 网站信息实体
	 */
	@FieldDescription("网站信息实体")
	private WebInfo parent;
	/**
	 * 栏目信息实体
	 */
	@FieldDescription("栏目信息实体")
	private Column column;
	/**
	 * 栏目外键id
	 */
	@FieldDescription("栏目外键id")
	private Long columnId;
	/**
	 * 网站名称
	 */
	@FieldDescription("网站名称")
	private String name;
	/**
	 * 子栏目名称
	 */
	@FieldDescription("子栏目名称")
	private String subName;
	/**
	 * 网址参数
	 */
	@FieldDescription("网址参数")
	private String params;
	/**
	 * 网址
	 */
	@FieldDescription("网址")
	private String url;
	/**
	 * 截取所有内容起始标志
	 */
	@FieldDescription("截取所有内容起始标志")
	private String beginFlag;
	/**
	 * 截取所有内容结束标志
	 */
	@FieldDescription("截取所有内容结束标志")
	private String endFlag;
	/**
	 * 首页链接
	 */
	@FieldDescription("首页链接")
	private String basePath;
	/**
	 * 匹配每个内容标志
	 */
	@FieldDescription("匹配每个内容标志")
	private String itemRegex;
	/**
	 * 匹配每个内容ID标志
	 */
	@FieldDescription("匹配每个内容ID标志")
	private String idRegex;
	/**
	 * 匹配每个内容截取时间
	 */
	@FieldDescription("匹配每个内容截取时间")
	private String dateRegex;
	/**
	 * 日期格式
	 */
	@FieldDescription("日期格式")
	private String datePattern;
	/**
	 * 是否栏目
	 */
	@FieldDescription("是否栏目")
	private BooleanEnum isCatLog;
	/**
	 * 抓取间隔
	 */
	@FieldDescription("抓取间隔")
	private Double period;
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
	 * 网站信息实体
	 */
	public WebInfo getParent(){
		return parent;
	}
	public void setParent(WebInfo parent){
		this.parent = parent;
	}
	/**
	 * 栏目信息实体
	 */
	public Column getColumn(){
		return column;
	}
	public void setColumn(Column column){
		this.column = column;
	}
	/**
	 * 栏目外键id
	 */
	public Long getColumnId(){
		return columnId;
	}
	public void setColumnId(Long columnId){
		this.columnId = columnId;
	}
	/**
	 * 网站名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 子栏目名称
	 */
	public String getSubName(){
		return subName;
	}
	public void setSubName(String subName){
		this.subName = subName;
	}
	/**
	 * 网址参数
	 */
	public String getParams(){
		return params;
	}
	public void setParams(String params){
		this.params = params;
	}
	/**
	 * 网址
	 */
	public String getUrl(){
		return url;
	}
	public void setUrl(String url){
		this.url = url;
	}
	/**
	 * 截取所有内容起始标志
	 */
	public String getBeginFlag(){
		return beginFlag;
	}
	public void setBeginFlag(String beginFlag){
		this.beginFlag = beginFlag;
	}
	/**
	 * 截取所有内容结束标志
	 */
	public String getEndFlag(){
		return endFlag;
	}
	public void setEndFlag(String endFlag){
		this.endFlag = endFlag;
	}
	/**
	 * 首页链接
	 */
	public String getBasePath(){
		return basePath;
	}
	public void setBasePath(String basePath){
		this.basePath = basePath;
	}
	/**
	 * 匹配每个内容标志
	 */
	public String getItemRegex(){
		return itemRegex;
	}
	public void setItemRegex(String itemRegex){
		this.itemRegex = itemRegex;
	}
	/**
	 * 匹配每个内容ID标志
	 */
	public String getIdRegex(){
		return idRegex;
	}
	public void setIdRegex(String idRegex){
		this.idRegex = idRegex;
	}
	/**
	 * 匹配每个内容截取时间
	 */
	public String getDateRegex(){
		return dateRegex;
	}
	public void setDateRegex(String dateRegex){
		this.dateRegex = dateRegex;
	}
	/**
	 * 日期格式
	 */
	public String getDatePattern(){
		return datePattern;
	}
	public void setDatePattern(String datePattern){
		this.datePattern = datePattern;
	}
	/**
	 * 是否栏目
	 */
	public BooleanEnum getIsCatLog(){
		return isCatLog;
	}
	public void setIsCatLog(BooleanEnum isCatLog){
		this.isCatLog = isCatLog;
	}
	/**
	 * 抓取间隔
	 */
	public Double getPeriod(){
		return period;
	}
	public void setPeriod(Double period){
		this.period = period;
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