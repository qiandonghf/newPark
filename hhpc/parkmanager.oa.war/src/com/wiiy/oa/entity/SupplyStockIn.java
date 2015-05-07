package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.oa.entity.Supply;

/**
 * <br/>class-description 办公用品入库
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class SupplyStockIn extends BaseEntity implements Serializable {
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
	 * 供应商名称
	 */
	@FieldDescription("供应商名称")
	private String supplier;
	/**
	 * 价格
	 */
	@FieldDescription("价格")
	private Double price;
	/**
	 * 入库数量
	 */
	@FieldDescription("入库数量")
	private Double amount;
	/**
	 * 总额
	 */
	@FieldDescription("总额")
	private Double cost;
	/**
	 * 入库时间
	 */
	@FieldDescription("入库时间")
	private Date inTime;
	/**
	 * 购买人
	 */
	@FieldDescription("购买人")
	private String purchaser;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 总额
	 */
	public Double getCost() {
		return cost;
	}
	public void setCost(Double cost) {
		this.cost = cost;
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
	 * 供应商名称
	 */
	public String getSupplier(){
		return supplier;
	}
	public void setSupplier(String supplier){
		this.supplier = supplier;
	}
	/**
	 * 价格
	 */
	public Double getPrice(){
		return price;
	}
	public void setPrice(Double price){
		this.price = price;
	}
	/**
	 * 入库数量
	 */
	public Double getAmount(){
		return amount;
	}
	public void setAmount(Double amount){
		this.amount = amount;
	}
	/**
	 * 入库时间
	 */
	public Date getInTime(){
		return inTime;
	}
	public void setInTime(Date inTime){
		this.inTime = inTime;
	}
	/**
	 * 购买人
	 */
	public String getPurchaser(){
		return purchaser;
	}
	public void setPurchaser(String purchaser){
		this.purchaser = purchaser;
	}
}