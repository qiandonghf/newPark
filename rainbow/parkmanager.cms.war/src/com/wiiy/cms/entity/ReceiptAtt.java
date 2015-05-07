package com.wiiy.cms.entity;

import java.io.Serializable;

import com.wiiy.cms.entity.Receipt;
import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;

/**
 * <br/>class-description 回执附件
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class ReceiptAtt extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 回执外键
	 */
	@FieldDescription("回执外键")
	private Receipt receipt;
	/**
	 * 回执外键Id
	 */
	@FieldDescription("回执外键Id")
	private Long receiptId;
	/**
	 * 附件原始文件名
	 */
	@FieldDescription("附件原始文件名")
	private String oldName;
	/**
	 * 附件新文件名
	 */
	@FieldDescription("附件新文件名")
	private String newName;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 回执外键Id
	 */
	public Receipt getReceipt(){
		return receipt;
	}
	public void setReceipt(Receipt receipt){
		this.receipt = receipt;
	}
	/**
	 * 附件原始文件名
	 */
	public String getOldName(){
		return oldName;
	}
	public void setOldName(String oldName){
		this.oldName = oldName;
	}
	/**
	 * 附件新文件名
	 */
	public String getNewName(){
		return newName;
	}
	public void setNewName(String newName){
		this.newName = newName;
	}
	/**
	 * 回执外键Id
	 */
	public Long getReceiptId() {
		return receiptId;
	}
	public void setReceiptId(Long receiptId) {
		this.receiptId = receiptId;
	}
}