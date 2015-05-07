package com.wiiy.pb.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.entity.RoomAtt;
import com.wiiy.pb.service.RoomAttService;

/**
 * @author my
 */
public class RoomAttAction extends JqGridBaseAction<RoomAtt>{
	private RoomAttService roomAttService;
	
	private Result result;
	private RoomAtt roomAtt;
	private Long id;
	private String ids;
	private String name;
	
	public String save(){
		result = roomAttService.save(roomAtt);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = roomAttService.deleteById(id);
		} else if(ids!=null){
			
			result = roomAttService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(RoomAtt.class);
		filter.eq("roomId",id);
		return refresh(filter);
	}
	
	@Override
	protected List<RoomAtt> getListByFilter(Filter fitler) {
		return roomAttService.getListByFilter(fitler).getValue();
	}
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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
	
	public RoomAtt getRoomAtt() {
		return roomAtt;
	}

	public void setRoomAtt(RoomAtt roomAtt) {
		this.roomAtt = roomAtt;
	}
	
	public void setRoomAttService(RoomAttService roomAttService) {
		this.roomAttService = roomAttService;
	}

	public Result getResult() {
		return result;
	}
}
