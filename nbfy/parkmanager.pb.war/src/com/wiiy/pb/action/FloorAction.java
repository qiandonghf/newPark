package com.wiiy.pb.action;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.dto.BuildingDto;
import com.wiiy.pb.dto.FloorDto;
import com.wiiy.pb.entity.Building;
import com.wiiy.pb.entity.Floor;
import com.wiiy.pb.entity.Room;
import com.wiiy.pb.service.BuildingService;
import com.wiiy.pb.service.FloorService;
import com.wiiy.pb.service.RoomService;

/**
 * @author my
 */
public class FloorAction extends JqGridBaseAction<Floor>{
	
	private FloorService floorService;
	private BuildingService buildingService;
	private RoomService roomService;
	private Result result;
	private Floor floor;
	private Long id;
	private String ids;
	
	
	public String loadFloorByBuildingId(){
		result = floorService.getListByFilter(new Filter(Floor.class).eq("buildingId", id));
		return JSON;
	}
	
	public String save(){
		result = floorService.save(floor);
		return JSON;
	}
	
	public String view(){
		floor = floorService.getBeanById(id).getValue();
		return VIEW;
	}
	
	public String edit(){
		floor = floorService.getBeanById(id).getValue();
		return EDIT;
	}
	
	public String exchangeOrder(){
		String[] longs = ids.split(",");
		result = floorService.exchangeOrder(Long.parseLong(longs[0]),Long.parseLong(longs[1]));
		return JSON;
	}
	
	public String update(){
		Floor dbBean = floorService.getBeanById(floor.getId()).getValue();
		BeanUtil.copyProperties(floor, dbBean);
		result = floorService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = floorService.deleteById(id);
		} else if(ids!=null){
			result = floorService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String floorView(){
		Building building = buildingService.getBeanById(id).getValue();
		List<Floor> floorList = floorService.getListByFilter(new Filter(Floor.class).eq("buildingId", id)).getValue();
		Collections.sort(floorList, new Comparator<Floor>() {
			@Override
			public int compare(Floor o1, Floor o2) {
				if(o1.getOrderNo()==null)return -1;
				if(o2.getOrderNo()==null)return 1;
				return o1.getOrderNo()-o2.getOrderNo();
			}
		});
		List<Room> roomList = roomService.getListByFilter(new Filter(Room.class).eq("buildingId", id).orderBy("name", Filter.ASC)).getValue();
		BuildingDto buildingDto = new BuildingDto();
		buildingDto.setBuilding(building);
		List<FloorDto> floorDtoList = new ArrayList<FloorDto>();
		for (Floor floor : floorList) {
			FloorDto floorDto = new FloorDto();
			floorDto.setFloor(floor);
			List<Room> floorRoomList = new ArrayList<Room>();
			for (Room room : roomList) {
				if(room.getFloorId().longValue()==floor.getId().longValue()){
					floorRoomList.add(room);
				}
			}
			floorDto.setRoomList(floorRoomList);
			floorDtoList.add(floorDto);
		}
		buildingDto.setFloorDtoList(floorDtoList);
		result = Result.value(buildingDto);
		return "floorView";
	}
	
	public String listByBuildingId(){
		result = floorService.getListByFilter(new Filter(Floor.class).eq("buildingId", id));
		List<Floor> floorList = (List<Floor>) result.getValue();
		Collections.sort(floorList, new Comparator<Floor>() {
			@Override
			public int compare(Floor o1, Floor o2) {
				if(o1.getOrderNo()==null)return -1;
				if(o2.getOrderNo()==null)return 1;
				return o1.getOrderNo()-o2.getOrderNo();
			}
		});
		return "listByBuildingId";
	}
	
	public String list(){
		return refresh(new Filter(Floor.class));
	}
	
	@Override
	protected List<Floor> getListByFilter(Filter fitler) {
		return floorService.getListByFilter(fitler).getValue();
	}
	
	
	public Floor getFloor() {
		return floor;
	}

	public void setFloor(Floor floor) {
		this.floor = floor;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public void setFloorService(FloorService floorService) {
		this.floorService = floorService;
	}
	
	public void setBuildingService(BuildingService buildingService) {
		this.buildingService = buildingService;
	}

	public void setRoomService(RoomService roomService) {
		this.roomService = roomService;
	}

	public Result getResult() {
		return result;
	}
	
}
