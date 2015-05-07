package com.wiiy.pb.dto;

import java.util.List;

import com.wiiy.pb.entity.Floor;
import com.wiiy.pb.entity.Room;

/**
 * 楼层信息DTO  包含楼层所有房间信息
 * @author my
 *
 */
public class FloorDto {
	
	private Floor floor;
	private List<Room> roomList;
	
	public Floor getFloor() {
		return floor;
	}
	public void setFloor(Floor floor) {
		this.floor = floor;
	}
	public List<Room> getRoomList() {
		return roomList;
	}
	public void setRoomList(List<Room> roomList) {
		this.roomList = roomList;
	}

}
