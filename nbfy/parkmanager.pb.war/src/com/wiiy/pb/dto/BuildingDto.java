package com.wiiy.pb.dto;

import java.util.List;

import com.wiiy.pb.entity.Building;

/**
 * 楼层视图DTO 包含楼宇实体中所有楼层及房间信息
 * @author my
 *
 */
public class BuildingDto {
	
	private Building building;
	private List<FloorDto> floorDtoList;
	
	public Building getBuilding() {
		return building;
	}
	public void setBuilding(Building building) {
		this.building = building;
	}
	public List<FloorDto> getFloorDtoList() {
		return floorDtoList;
	}
	public void setFloorDtoList(List<FloorDto> floorDtoList) {
		this.floorDtoList = floorDtoList;
	}

}
