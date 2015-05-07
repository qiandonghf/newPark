package com.wiiy.pb.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.entity.Building;
import com.wiiy.pb.entity.Park;
import com.wiiy.pb.entity.Room;
import com.wiiy.pb.entity.RoomMeterFee;
import com.wiiy.pb.preferences.enums.MeterTypeEnum;
import com.wiiy.pb.service.BuildingService;
import com.wiiy.pb.service.ParkService;
import com.wiiy.pb.service.RoomMeterFeeService;
import com.wiiy.pb.service.RoomService;

/**
 * @author my
 */
public class RoomMeterFeeAction extends JqGridBaseAction<RoomMeterFee>{
	
	private RoomMeterFeeService roomMeterFeeService;
	private RoomService roomService;
	private ParkService parkService;
	private Result result;
	private RoomMeterFee roomMeterFee;
	private Long id;
	private String ids;
	private BuildingService buildingService;
	
	public void setBuildingService(BuildingService buildingService) {
		this.buildingService = buildingService;
	}

	public String save(){
		RoomMeterFee meterFee = roomMeterFeeService.getBeanByFilter(new Filter(RoomMeterFee.class).eq("meterId", roomMeterFee.getMeterId())).getValue();
		if(meterFee!=null){
			result = Result.failure("房间中已存在该水电表");
		}else{
			if(roomMeterFee.getPrice()==null){
				Room room = roomService.getBeanById(roomMeterFee.getRoomId()).getValue();
				Building buildind = buildingService.getBeanById(room.getBuildingId()).getValue();
				Park park = parkService.getBeanById(buildind.getParkId()).getValue();
				if(roomMeterFee.getType()==MeterTypeEnum.ELECTRICITY){
					roomMeterFee.setPrice(park.getElectricity());
				}else{
					roomMeterFee.setPrice(park.getWater());
				}
			}
			result = roomMeterFeeService.save(roomMeterFee);
		}
		return JSON;
	}

	public String view(){
		result = roomMeterFeeService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		roomMeterFee = roomMeterFeeService.getBeanById(id).getValue();
		return EDIT;
	}
	
	public String update(){
		RoomMeterFee dbBean = roomMeterFeeService.getBeanById(roomMeterFee.getId()).getValue();
		BeanUtil.copyProperties(roomMeterFee, dbBean);
		result = roomMeterFeeService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = roomMeterFeeService.deleteById(id);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(RoomMeterFee.class).eq("roomId", id));
	}
	
	@Override
	protected List<RoomMeterFee> getListByFilter(Filter fitler) {
		return roomMeterFeeService.getListByFilter(fitler).getValue();
	}
	
	
	public RoomMeterFee getRoomMeterFee() {
		return roomMeterFee;
	}

	public void setRoomMeterFee(RoomMeterFee roomMeterFee) {
		this.roomMeterFee = roomMeterFee;
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

	public void setRoomMeterFeeService(RoomMeterFeeService roomMeterFeeService) {
		this.roomMeterFeeService = roomMeterFeeService;
	}
	
	public Result getResult() {
		return result;
	}

	public void setRoomService(RoomService roomService) {
		this.roomService = roomService;
	}

	public void setParkService(ParkService parkService) {
		this.parkService = parkService;
	}
}
