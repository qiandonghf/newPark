package com.wiiy.pb.dto;
public class ParkSituationOnDesktopDto {
	private Long parkId;//园区Id
	private Long buildingId;//楼宇id
	private String photos;//楼宇图片
	private String parkBuildingName;//楼宇园区名称
	private Double usageRates;//使用率
	private Double occupancy;//出租率
	private Long customerNumber;//入驻企业数
	private String customerIds;//楼宇中的企业IDS
	private Long dueNumber;//即将到期数
	private String contractIds;//楼宇中即将到期或逾期的合同IDS
	private Long arrearsNumber;//欠费数
	private String billIds;//逾期未缴的账单IDS
	
	public String getParkBuildingName() {
		return parkBuildingName;
	}
	public void setParkBuildingName(String parkBuildingName) {
		this.parkBuildingName = parkBuildingName;
	}
	public Double getUsageRates() {
		return usageRates;
	}
	public void setUsageRates(Double usageRates) {
		this.usageRates = usageRates;
	}
	public Double getOccupancy() {
		return occupancy;
	}
	public void setOccupancy(Double occupancy) {
		this.occupancy = occupancy;
	}
	public Long getDueNumber() {
		return dueNumber;
	}
	public void setDueNumber(Long dueNumber) {
		this.dueNumber = dueNumber;
	}
	public Long getArrearsNumber() {
		return arrearsNumber;
	}
	public void setArrearsNumber(Long arrearsNumber) {
		this.arrearsNumber = arrearsNumber;
	}
	public Long getParkId() {
		return parkId;
	}
	public void setParkId(Long parkId) {
		this.parkId = parkId;
	}
	public Long getBuildingId() {
		return buildingId;
	}
	public void setBuildingId(Long buildingId) {
		this.buildingId = buildingId;
	}
	public Long getCustomerNumber() {
		return customerNumber;
	}
	public void setCustomerNumber(Long customerNumber) {
		this.customerNumber = customerNumber;
	}
	public String getCustomerIds() {
		return customerIds;
	}
	public void setCustomerIds(String customerIds) {
		this.customerIds = customerIds;
	}
	public String getContractIds() {
		return contractIds;
	}
	public void setContractIds(String contractIds) {
		this.contractIds = contractIds;
	}
	public String getBillIds() {
		return billIds;
	}
	public void setBillIds(String billIds) {
		this.billIds = billIds;
	}
	public String getPhotos() {
		return photos;
	}
	public void setPhotos(String photos) {
		this.photos = photos;
	}
}
