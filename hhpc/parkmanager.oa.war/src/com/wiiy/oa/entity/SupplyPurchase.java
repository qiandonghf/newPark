package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.oa.entity.Supply;

/**
 * <br/>class-description 办公用品采购申请
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class SupplyPurchase extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 办公用品实体
	 */
	@FieldDescription("办公用品实体")
	private Supply supply;
	/**
	 * 办公用品外键
	 */
	@FieldDescription("办公用品外键")
	private Long supplyId;
	/**
	 * 数量
	 */
	@FieldDescription("数量")
	private Double amount;
	/**
	 * 单价
	 */
	@FieldDescription("单价")
	private Double price;
	/**
	 * 总价
	 */
	@FieldDescription("总价")
	private Double totalPrice;
	/**
	 * 申请时间
	 */
	@FieldDescription("申请时间")
	private Date applyTime;
	/**
	 * 采购人
	 */
	@FieldDescription("采购人")
	private String purchaser;
	/**
	 * 备注
	 */
	@FieldDescription("备注")
	private String comment;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 办公用品实体
	 */
	public Supply getSupply(){
		return supply;
	}
	public void setSupply(Supply supply){
		this.supply = supply;
	}
	/**
	 * 办公用品外键
	 */
	public Long getSupplyId(){
		return supplyId;
	}
	public void setSupplyId(Long supplyId){
		this.supplyId = supplyId;
	}
	/**
	 * 数量
	 */
	public Double getAmount(){
		return amount;
	}
	public void setAmount(Double amount){
		this.amount = amount;
	}
	/**
	 * 单价
	 */
	public Double getPrice(){
		return price;
	}
	public void setPrice(Double price){
		this.price = price;
	}
	/**
	 * 总价
	 */
	public Double getTotalPrice(){
		return totalPrice;
	}
	public void setTotalPrice(Double totalPrice){
		this.totalPrice = totalPrice;
	}
	/**
	 * 申请时间
	 */
	public Date getApplyTime(){
		return applyTime;
	}
	public void setApplyTime(Date applyTime){
		this.applyTime = applyTime;
	}
	/**
	 * 采购人
	 */
	public String getPurchaser(){
		return purchaser;
	}
	public void setPurchaser(String purchaser){
		this.purchaser = purchaser;
	}
	/**
	 * 备注
	 */
	public String getComment(){
		return comment;
	}
	public void setComment(String comment){
		this.comment = comment;
	}
}