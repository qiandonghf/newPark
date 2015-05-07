package com.wiiy.pb.dto;

import java.math.BigDecimal;

public class BuildingPandectDto {
	private Long parkId;//园区Id
	private Long id;//楼宇id
	private String buildingName;//楼宇名称
	private BigDecimal allArea = BigDecimal.ZERO;//总面积
	private BigDecimal rentArea = BigDecimal.ZERO;//房间性质为出租的面积
	private BigDecimal ownArea = BigDecimal.ZERO;//自用面积
	private BigDecimal shareArea = BigDecimal.ZERO;//共用面积
	private BigDecimal saletArea = BigDecimal.ZERO;//出售面积
	private BigDecimal otherArea = BigDecimal.ZERO;//出售面积
	
	private BigDecimal rentedArea = BigDecimal.ZERO;//已出租面积
	private Double occupancy;//出租率
	private Double usageRates;//使用率
	private String photos;//楼宇照片
	
	public Double getUsageRates() {
		return usageRates;
	}
	public void setUsageRates(Double usageRates) {
		this.usageRates = usageRates;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getBuildingName() {
		return buildingName;
	}
	public void setBuildingName(String buildingName) {
		this.buildingName = buildingName;
	}
	public BigDecimal getAllArea() {
		return allArea;
	}
	public void setAllArea(BigDecimal allArea) {
		this.allArea = allArea;
	}
	public BigDecimal getRentArea() {
		return rentArea;
	}
	public void setRentArea(BigDecimal rentArea) {
		this.rentArea = rentArea;
	}
	public BigDecimal getOwnArea() {
		return ownArea;
	}
	public void setOwnArea(BigDecimal ownArea) {
		this.ownArea = ownArea;
	}
	public BigDecimal getShareArea() {
		return shareArea;
	}
	public void setShareArea(BigDecimal shareArea) {
		this.shareArea = shareArea;
	}
	public BigDecimal getSaletArea() {
		return saletArea;
	}
	public void setSaletArea(BigDecimal saletArea) {
		this.saletArea = saletArea;
	}
	public Double getOccupancy() {
		return occupancy;
	}
	public void setOccupancy(Double occupancy) {
		this.occupancy = occupancy;
	}
	public BigDecimal getRentedArea() {
		return rentedArea;
	}
	public void setRentedArea(BigDecimal rentedArea) {
		this.rentedArea = rentedArea;
	}
	public Long getParkId() {
		return parkId;
	}
	public void setParkId(Long parkId) {
		this.parkId = parkId;
	}
	public BigDecimal getOtherArea() {
		return otherArea;
	}
	public void setOtherArea(BigDecimal otherArea) {
		this.otherArea = otherArea;
	}
	public String getPhotos() {
		return photos;
	}
	public void setPhotos(String photos) {
		this.photos = photos;
	}
	
}
