package com.wiiy.crm.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.crm.entity.Contract;
import com.wiiy.pb.preferences.enums.RoomAttTypeEnum;

/**
 * <br/>class-description 合同附件
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class ContractAtt extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 合同
	 */
	@FieldDescription("合同")
	private Contract contract;
	/**
	 * 合同外键
	 */
	@FieldDescription("合同外键")
	private Long contractId;
	/**
	 * 附件名称
	 */
	@FieldDescription("附件名称")
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
	 * 备注说明
	 */
	@FieldDescription("备注说明")
	private String memo;

	/**
	 * 附件类型
	 */
	@FieldDescription("附件类型")
	private RoomAttTypeEnum type;
	
	public RoomAttTypeEnum getType() {
		return type;
	}
	public void setType(RoomAttTypeEnum type) {
		this.type = type;
	}
	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 合同
	 */
	public Contract getContract(){
		return contract;
	}
	public void setContract(Contract contract){
		this.contract = contract;
	}
	/**
	 * 合同外键
	 */
	public Long getContractId(){
		return contractId;
	}
	public void setContractId(Long contractId){
		this.contractId = contractId;
	}
	/**
	 * 附件名称
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
}