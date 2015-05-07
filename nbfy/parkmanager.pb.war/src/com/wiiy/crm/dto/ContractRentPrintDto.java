package com.wiiy.crm.dto;

import java.util.Date;
import java.util.List;

import com.wiiy.crm.preferences.enums.ContractItemEnum;

public class ContractRentPrintDto {
	
	private ContractItemEnum item;
	
	private String customerName;
	private String contractParty;//甲方
	private String propertyName;//本物业名称
	private String propertyNo;//房屋产权证号
	private String roomType;
	private String contractItemList;
	private Double areaTotal;
	private String purpose;//租赁用途
	private String propertyUnit;//物管理单价
	private Double price;
	
	private String address;//座落
	private String years;//租期多少
	private String overallFloorage;//厂房建筑总面积
	private String payType;//租金支付方式
	private Double amount;//押金
	private String rentAmount;//租金额度
	
	private List<ContractBillPlanDto> rentList;
	private List<ContractBillPlanDto> energyList;
	private List<ContractBillPlanDto> depositList;//押金集合
	private Double annuity;//年费用
	private Date startDate;
	private Date endDate;
	private Date signDate;
	private String policy;//优惠政策
	private Double deposit;//押金,ningbo的押金就一条，替换时用这个。
	private Double rentTotal;//租金总额
	private Double energyTotal;//能源费总额
	private Double netTotal;//网络总额
	public ContractItemEnum getItem() {
		return item;
	}
	public void setItem(ContractItemEnum item) {
		this.item = item;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public Double getAreaTotal() {
		return areaTotal;
	}
	public void setAreaTotal(Double areaTotal) {
		this.areaTotal = areaTotal;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public List<ContractBillPlanDto> getRentList() {
		return rentList;
	}
	public void setRentList(List<ContractBillPlanDto> rentList) {
		this.rentList = rentList;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public Date getSignDate() {
		return signDate;
	}
	public void setSignDate(Date signDate) {
		this.signDate = signDate;
	}
	public List<ContractBillPlanDto> getDepositList() {
		return depositList;
	}
	public void setDepositList(List<ContractBillPlanDto> depositList) {
		this.depositList = depositList;
	}
	public String getPolicy() {
		return policy;
	}
	public void setPolicy(String policy) {
		this.policy = policy;
	}
	public List<ContractBillPlanDto> getEnergyList() {
		return energyList;
	}
	public void setEnergyList(List<ContractBillPlanDto> energyList) {
		this.energyList = energyList;
	}
	public Double getDeposit() {
		return deposit;
	}
	public void setDeposit(Double deposit) {
		this.deposit = deposit;
	}
	public String getContractItemList() {
		return contractItemList;
	}
	public void setContractItemList(String contractItemList) {
		this.contractItemList = contractItemList;
	}
	public Double getRentTotal() {
		return rentTotal;
	}
	public void setRentTotal(Double rentTotal) {
		this.rentTotal = rentTotal;
	}
	public Double getEnergyTotal() {
		return energyTotal;
	}
	public void setEnergyTotal(Double energyTotal) {
		this.energyTotal = energyTotal;
	}
	public Double getNetTotal() {
		return netTotal;
	}
	public void setNetTotal(Double netTotal) {
		this.netTotal = netTotal;
	}
	public String getContractParty() {
		return contractParty;
	}
	public void setContractParty(String contractParty) {
		this.contractParty = contractParty;
	}
	public String getPropertyName() {
		return propertyName;
	}
	public void setPropertyName(String propertyName) {
		this.propertyName = propertyName;
	}
	public String getPropertyNo() {
		return propertyNo;
	}
	public void setPropertyNo(String propertyNo) {
		this.propertyNo = propertyNo;
	}
	public String getRoomType() {
		return roomType;
	}
	public void setRoomType(String roomType) {
		this.roomType = roomType;
	}
	public String getPropertyUnit() {
		return propertyUnit;
	}
	public void setPropertyUnit(String propertyUnit) {
		this.propertyUnit = propertyUnit;
	}
	public Double getAnnuity() {
		return annuity;
	}
	public void setAnnuity(Double annuity) {
		this.annuity = annuity;
	}
	public String getOverallFloorage() {
		return overallFloorage;
	}
	public void setOverallFloorage(String overallFloorage) {
		this.overallFloorage = overallFloorage;
	}
	public String getPayType() {
		return payType;
	}
	public void setPayType(String payType) {
		this.payType = payType;
	}
	public Double getAmount() {
		return amount;
	}
	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public String getRentAmount() {
		return rentAmount;
	}
	public void setRentAmount(String rentAmount) {
		this.rentAmount = rentAmount;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getYears() {
		return years;
	}
	public void setYears(String years) {
		this.years = years;
	}
}
