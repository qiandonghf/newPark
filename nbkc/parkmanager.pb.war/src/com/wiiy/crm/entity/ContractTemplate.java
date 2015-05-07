package com.wiiy.crm.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.crm.preferences.enums.ContractItemEnum;

/**
 * <br/>class-description 合同模板
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class ContractTemplate extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 合同类型
	 */
	@FieldDescription("合同类型")
	private ContractItemEnum type;
	/**
	 * 模板名称
	 */
	@FieldDescription("模板名称")
	private String name;
	/**
	 * 重命名名称
	 */
	@FieldDescription("重命名名称")
	private String newName;
	/**
	 * 附件大小
	 */
	@FieldDescription("附件大小")
	private Long size;
	/**
	 * 是否主要打印模板
	 */
	@FieldDescription("是否主要打印模板")
	private BooleanEnum chief;
	/**
	 * 备注说明
	 */
	@FieldDescription("备注说明")
	private String memo;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 合同类型
	 */
	public ContractItemEnum getType(){
		return type;
	}
	public void setType(ContractItemEnum type){
		this.type = type;
	}
	/**
	 * 模板名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 重命名名称
	 */
	public String getNewName(){
		return newName;
	}
	public void setNewName(String newName){
		this.newName = newName;
	}
	/**
	 * 附件大小
	 */
	public Long getSize(){
		return size;
	}
	public void setSize(Long size){
		this.size = size;
	}
	/**
	 * 备注说明
	 */
	public String getMemo(){
		return memo;
	}
	public void setMemo(String memo){
		this.memo = memo;
	}
	/**
	 * 是否主要打印模板
	 */
	public BooleanEnum getChief() {
		return chief;
	}
	public void setChief(BooleanEnum chief) {
		this.chief = chief;
	}
	
}