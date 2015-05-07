package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.EntityStatus;

/**
 * <br/>class-description 班制定义
 * <br/>extends com.wiiy.commons.entity.TreeEntity
 */
public class WorkSchedule extends TreeEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 班制名称
	 */
	@FieldDescription("班制名称")
	private String name;
	/**
	 * 是否缺省
	 */
	@FieldDescription("是否缺省")
	private BooleanEnum isDefault;
	/**
	 * 班次设置
	 */
	@FieldDescription("班次设置")
	private String workClassCfg;
	/**
	 * 周一
	 */
	@FieldDescription("周一")
	private String day1;
	/**
	 * 周二
	 */
	@FieldDescription("周二")
	private String day2;
	/**
	 * 周三
	 */
	@FieldDescription("周三")
	private String day3;
	/**
	 * 周四
	 */
	@FieldDescription("周四")
	private String day4;
	/**
	 * 周五
	 */
	@FieldDescription("周五")
	private String day5;
	/**
	 * 周六
	 */
	@FieldDescription("周六")
	private String day6;
	/**
	 * 周日
	 */
	@FieldDescription("周日")
	private String day7;
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
	 * 班制名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 是否缺省
	 */
	public BooleanEnum getIsDefault(){
		return isDefault;
	}
	public void setIsDefault(BooleanEnum isDefault){
		this.isDefault = isDefault;
	}
	/**
	 * 班次设置
	 */
	public String getWorkClassCfg(){
		return workClassCfg;
	}
	public void setWorkClassCfg(String workClassCfg){
		this.workClassCfg = workClassCfg;
	}
	/**
	 * 周一
	 */
	public String getDay1(){
		return day1;
	}
	public void setDay1(String day1){
		this.day1 = day1;
	}
	/**
	 * 周二
	 */
	public String getDay2(){
		return day2;
	}
	public void setDay2(String day2){
		this.day2 = day2;
	}
	/**
	 * 周三
	 */
	public String getDay3(){
		return day3;
	}
	public void setDay3(String day3){
		this.day3 = day3;
	}
	/**
	 * 周四
	 */
	public String getDay4(){
		return day4;
	}
	public void setDay4(String day4){
		this.day4 = day4;
	}
	/**
	 * 周五
	 */
	public String getDay5(){
		return day5;
	}
	public void setDay5(String day5){
		this.day5 = day5;
	}
	/**
	 * 周六
	 */
	public String getDay6(){
		return day6;
	}
	public void setDay6(String day6){
		this.day6 = day6;
	}
	/**
	 * 周日
	 */
	public String getDay7(){
		return day7;
	}
	public void setDay7(String day7){
		this.day7 = day7;
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