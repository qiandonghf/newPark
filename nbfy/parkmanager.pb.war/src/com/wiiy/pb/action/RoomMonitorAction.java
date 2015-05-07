package com.wiiy.pb.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.pb.entity.RoomMonitor;
import com.wiiy.pb.service.RoomMonitorService;

/**
 * @author my
 */
public class RoomMonitorAction extends JqGridBaseAction<RoomMonitor>{
	
	private RoomMonitorService roomMonitorService;
	private Result result;
	private RoomMonitor roomMonitor;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = roomMonitorService.save(roomMonitor);
		return JSON;
	}
	
	public String view(){
		result = roomMonitorService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = roomMonitorService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		RoomMonitor dbBean = roomMonitorService.getBeanById(roomMonitor.getId()).getValue();
		BeanUtil.copyProperties(roomMonitor, dbBean);
		result = roomMonitorService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = roomMonitorService.deleteById(id);
		} else if(ids!=null){
			result = roomMonitorService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(RoomMonitor.class).eq("roomId", id));
	}
	
	@Override
	protected List<RoomMonitor> getListByFilter(Filter fitler) {
		return roomMonitorService.getListByFilter(fitler).getValue();
	}
	
	
	public RoomMonitor getRoomMonitor() {
		return roomMonitor;
	}

	public void setRoomMonitor(RoomMonitor roomMonitor) {
		this.roomMonitor = roomMonitor;
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

	public void setRoomMonitorService(RoomMonitorService roomMonitorService) {
		this.roomMonitorService = roomMonitorService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
