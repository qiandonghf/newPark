package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.crm.preferences.enums.NetworkPriceUnitEnum;
import com.wiiy.pb.entity.Facility;

/**
 * <br/>class-description 网络合同标的
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class SubjectNetwork extends BaseEntity implements Serializable {
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
	 * 企业
	 */
	@FieldDescription("企业")
	private Customer customer;
	/**
	 * 公共设施
	 */
	@FieldDescription("公共设施")
	private Facility facility;
	/**
	 * 合同外键
	 */
	@FieldDescription("合同外键")
	private Long contractId;
	/**
	 * 企业外键
	 */
	@FieldDescription("企业外键")
	private Long customerId;
	/**
	 * 公共设施外键
	 */
	@FieldDescription("公共设施外键")
	private Long facilityId;
	/**
	 * 单价
	 */
	@FieldDescription("单价")
	private Double price;
	/**
	 * 租金单价单位
	 */
	@FieldDescription("租金单价单位")
	private NetworkPriceUnitEnum priceUnit;
	/**
	 * 租用开始时间
	 */
	@FieldDescription("租用开始时间")
	private Date startDate;
	/**
	 * 租用结束时间
	 */
	@FieldDescription("租用结束时间")
	private Date endDate;
	/**
	 * IP段个数
	 */
	@FieldDescription("IP段个数")
	private Integer ip;
	/**
	 * 端口数目
	 */
	@FieldDescription("端口数目")
	private Integer port;
	/**
	 * 公网IP地址数
	 */
	@FieldDescription("公网IP地址数")
	private Integer publicIP;
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
	 * 合同
	 */
	public Contract getContract(){
		return contract;
	}
	public void setContract(Contract contract){
		this.contract = contract;
	}
	/**
	 * 企业
	 */
	public Customer getCustomer(){
		return customer;
	}
	public void setCustomer(Customer customer){
		this.customer = customer;
	}
	/**
	 * 公共设施
	 */
	public Facility getFacility(){
		return facility;
	}
	public void setFacility(Facility facility){
		this.facility = facility;
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
	 * 企业外键
	 */
	public Long getCustomerId(){
		return customerId;
	}
	public void setCustomerId(Long customerId){
		this.customerId = customerId;
	}
	/**
	 * 公共设施外键
	 */
	public Long getFacilityId(){
		return facilityId;
	}
	public void setFacilityId(Long facilityId){
		this.facilityId = facilityId;
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
	 * 租金单价单位
	 */
	public NetworkPriceUnitEnum getPriceUnit(){
		return priceUnit;
	}
	public void setPriceUnit(NetworkPriceUnitEnum priceUnit){
		this.priceUnit = priceUnit;
	}
	/**
	 * 租用开始时间
	 */
	public Date getStartDate(){
		return startDate;
	}
	public void setStartDate(Date startDate){
		this.startDate = startDate;
	}
	/**
	 * 租用结束时间
	 */
	public Date getEndDate(){
		return endDate;
	}
	public void setEndDate(Date endDate){
		this.endDate = endDate;
	}
	/**
	 * IP段个数
	 */
	public Integer getIp(){
		return ip;
	}
	public void setIp(Integer ip){
		this.ip = ip;
	}
	/**
	 * 端口数目
	 */
	public Integer getPort(){
		return port;
	}
	public void setPort(Integer port){
		this.port = port;
	}
	/**
	 * 公网IP地址数
	 */
	public Integer getPublicIP(){
		return publicIP;
	}
	public void setPublicIP(Integer publicIP){
		this.publicIP = publicIP;
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