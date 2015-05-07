package com.wiiy.pb.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.entity.RoomChangeLog;
import com.wiiy.pb.service.RoomChangeLogService;

/**
 * @author my
 */
public class RoomChangeLogAction extends JqGridBaseAction<RoomChangeLog>{
	private RoomChangeLogService roomChangeLogService;
	
	private Result result;
	private RoomChangeLog roomChangeLog;
	private Long id;
	private String ids;
	
	public String delete(){
		if(id!=null){
			result = roomChangeLogService.deleteById(id);
		} else if(ids!=null){
			result = roomChangeLogService.deleteByIds(ids);
		}
		return JSON;
	}
	public String list(){
		Filter filter = new Filter(RoomChangeLog.class);
		filter.eq("roomId", id);
		return refresh(filter);
	}
	
	public RoomChangeLog getRoomChangeLog() {
		return roomChangeLog;
	}

	public void setRoomChangeLog(RoomChangeLog roomChangeLog) {
		this.roomChangeLog = roomChangeLog;
	}

	public void setRoomChangeLogService(RoomChangeLogService roomChangeLogService) {
		this.roomChangeLogService = roomChangeLogService;
	}

	@Override
	protected List<RoomChangeLog> getListByFilter(Filter fitler) {
		return roomChangeLogService.getListByFilter(fitler).getValue();
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

	public Result getResult() {
		return result;
	}
}
