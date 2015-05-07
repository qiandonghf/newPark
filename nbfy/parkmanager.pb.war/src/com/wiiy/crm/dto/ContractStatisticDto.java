package com.wiiy.crm.dto;

import com.wiiy.crm.entity.Contract;

public class ContractStatisticDto {
	
	private Contract contract;
	
	private String manager;
	private String managerPhone;
	
	private String rooms;
	
	private Double area;
	
	private String rentPrice;
	private Double energyPrice;
	
	private Double rentTotal;
	private Double energyTotal;
	
	private String firstHalfYearTime;
	private Double firstHalfYearMoneyRent;
	private Double firstHalfYearMoneyEnergy;
	private Double firstHalfYearMoneyNet;
	
	private String secondHalfYearTime;
	private Double secondHalfYearMoneyRent;
	private Double secondHalfYearMoneyEnergy;
	private Double secondHalfYearMoneyNet;
	
	private Double deposit;
	
	public ContractStatisticDto() {
		
		rooms = "";
		
		rentPrice = "";
		energyPrice = 0d;
		rentTotal = 0d;
		energyTotal = 0d;
		
		firstHalfYearTime = "";
		firstHalfYearMoneyRent = 0d;
		firstHalfYearMoneyEnergy = 0d;
		firstHalfYearMoneyNet = 0d;
		
		secondHalfYearTime = "";
		secondHalfYearMoneyEnergy = 0d;
		secondHalfYearMoneyNet = 0d;
		secondHalfYearMoneyRent = 0d;
	}

	public Contract getContract() {
		return contract;
	}

	public void setContract(Contract contract) {
		this.contract = contract;
	}

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}

	public String getManagerPhone() {
		return managerPhone;
	}

	public void setManagerPhone(String managerPhone) {
		this.managerPhone = managerPhone;
	}

	public String getRooms() {
		return rooms;
	}

	public void setRooms(String rooms) {
		this.rooms = rooms;
	}

	public Double getArea() {
		return area;
	}

	public void setArea(Double area) {
		this.area = area;
	}

	public String getRentPrice() {
		return rentPrice;
	}

	public void setRentPrice(String rentPrice) {
		this.rentPrice = rentPrice;
	}

	public Double getEnergyPrice() {
		return energyPrice;
	}

	public void setEnergyPrice(Double energyPrice) {
		this.energyPrice = energyPrice;
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

	public String getFirstHalfYearTime() {
		return firstHalfYearTime;
	}

	public void setFirstHalfYearTime(String firstHalfYearTime) {
		this.firstHalfYearTime = firstHalfYearTime;
	}


	public String getSecondHalfYearTime() {
		return secondHalfYearTime;
	}

	public void setSecondHalfYearTime(String secondHalfYearTime) {
		this.secondHalfYearTime = secondHalfYearTime;
	}

	public Double getFirstHalfYearMoneyRent() {
		return firstHalfYearMoneyRent;
	}

	public void setFirstHalfYearMoneyRent(Double firstHalfYearMoneyRent) {
		this.firstHalfYearMoneyRent = firstHalfYearMoneyRent;
	}

	public Double getFirstHalfYearMoneyEnergy() {
		return firstHalfYearMoneyEnergy;
	}

	public void setFirstHalfYearMoneyEnergy(Double firstHalfYearMoneyEnergy) {
		this.firstHalfYearMoneyEnergy = firstHalfYearMoneyEnergy;
	}

	public Double getFirstHalfYearMoneyNet() {
		return firstHalfYearMoneyNet;
	}

	public void setFirstHalfYearMoneyNet(Double firstHalfYearMoneyNet) {
		this.firstHalfYearMoneyNet = firstHalfYearMoneyNet;
	}

	public Double getSecondHalfYearMoneyRent() {
		return secondHalfYearMoneyRent;
	}

	public void setSecondHalfYearMoneyRent(Double secondHalfYearMoneyRent) {
		this.secondHalfYearMoneyRent = secondHalfYearMoneyRent;
	}

	public Double getSecondHalfYearMoneyEnergy() {
		return secondHalfYearMoneyEnergy;
	}

	public void setSecondHalfYearMoneyEnergy(Double secondHalfYearMoneyEnergy) {
		this.secondHalfYearMoneyEnergy = secondHalfYearMoneyEnergy;
	}

	public Double getSecondHalfYearMoneyNet() {
		return secondHalfYearMoneyNet;
	}

	public void setSecondHalfYearMoneyNet(Double secondHalfYearMoneyNet) {
		this.secondHalfYearMoneyNet = secondHalfYearMoneyNet;
	}

	public Double getDeposit() {
		return deposit;
	}

	public void setDeposit(Double deposit) {
		this.deposit = deposit;
	}

}
