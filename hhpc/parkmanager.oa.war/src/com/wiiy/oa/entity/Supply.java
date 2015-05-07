package com.wiiy.oa.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.oa.entity.SupplyCategory;

/**
 * <br/>class-description 办公用品
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Supply extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 分类实体
	 */
	@FieldDescription("分类实体")
	private SupplyCategory category;
	/**
	 * 分类外键
	 */
	@FieldDescription("分类外键")
	private Long categoryId;
	/**
	 * 所属分类ID
	 */
	@FieldDescription("所属分类ID")
	private String categoryIds;
	/**
	 * 名称
	 */
	@FieldDescription("名称")
	private String name;
	/**
	 * 计量单位
	 */
	@FieldDescription("计量单位")
	private String unit;
	/**
	 * 库存
	 */
	@FieldDescription("库存")
	private Double stock;
	/**
	 * 是否库存警示
	 */
	@FieldDescription("是否库存警示")
	private BooleanEnum alarm;
	/**
	 * 报警库存
	 */
	@FieldDescription("报警库存")
	private Double alarmStock;
	/**
	 * 规格
	 */
	@FieldDescription("规格")
	private String spec;
	/**
	 * 备注
	 */
	@FieldDescription("备注")
	private String memo;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 分类实体
	 */
	public SupplyCategory getCategory(){
		return category;
	}
	public void setCategory(SupplyCategory category){
		this.category = category;
	}
	/**
	 * 分类外键
	 */
	public Long getCategoryId(){
		return categoryId;
	}
	public void setCategoryId(Long categoryId){
		this.categoryId = categoryId;
	}
	/**
	 * 所属分类ID
	 */
	public String getCategoryIds(){
		return categoryIds;
	}
	public void setCategoryIds(String categoryIds){
		this.categoryIds = categoryIds;
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
	 * 计量单位
	 */
	public String getUnit(){
		return unit;
	}
	public void setUnit(String unit){
		this.unit = unit;
	}
	/**
	 * 库存
	 */
	public Double getStock(){
		return stock;
	}
	public void setStock(Double stock){
		this.stock = stock;
	}
	/**
	 * 是否库存警示
	 */
	public BooleanEnum getAlarm(){
		return alarm;
	}
	public void setAlarm(BooleanEnum alarm){
		this.alarm = alarm;
	}
	/**
	 * 报警库存
	 */
	public Double getAlarmStock(){
		return alarmStock;
	}
	public void setAlarmStock(Double alarmStock){
		this.alarmStock = alarmStock;
	}
	/**
	 * 规格
	 */
	public String getSpec(){
		return spec;
	}
	public void setSpec(String spec){
		this.spec = spec;
	}
	/**
	 * 备注
	 */
	public String getMemo(){
		return memo;
	}
	public void setMemo(String memo){
		this.memo = memo;
	}
}