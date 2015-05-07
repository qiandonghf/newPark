package com.wiiy.crm.dto;

import java.util.Date;
import java.util.List;

import com.wiiy.crm.preferences.enums.ContractItemEnum;

public class ContractNetPrintDto {

	private int ipCount;
	private int portCount;
	private int pubIpCount;

	public int getIpCount() {
		return ipCount;
	}

	public void setIpCount(int ipCount) {
		this.ipCount = ipCount;
	}

	public int getPortCount() {
		return portCount;
	}

	public void setPortCount(int portCount) {
		this.portCount = portCount;
	}

	public int getPubIpCount() {
		return pubIpCount;
	}

	public void setPubIpCount(int pubIpCount) {
		this.pubIpCount = pubIpCount;
	}

	private ContractItemEnum item;

	private String customerName;
	private String contractItemList;
	private Double areaTotal;
	private String purpose;
	private Double price;

	private List<ContractBillPlanDto> rentList;//租金集合
	private List<ContractBillPlanDto> energyList;//能源费集合
	private List<ContractBillPlanDto> depositList;// 押金集合

	private Date startDate;
	private Date endDate;
	private Date signDate;
	private String policy;// 优惠政策
	private Double deposit;// 押金,ningbo的押金就一条，替换时用这个。
	private Double rentTotal;// 租金总额
	private Double energyTotal;// 能源费总额
	private Double netTotal;// 网络总额

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
}
