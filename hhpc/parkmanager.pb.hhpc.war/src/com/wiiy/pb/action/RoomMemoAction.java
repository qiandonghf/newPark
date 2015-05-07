package com.wiiy.pb.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.entity.RoomMemo;
import com.wiiy.pb.service.RoomMemoService;

/**
 * @author my
 */
public class RoomMemoAction extends JqGridBaseAction<RoomMemo>{
	private RoomMemoService roomMemoService;
	
	private Result result;
	private RoomMemo roomMemo;
	private Long id;
	private String ids;
	
	public String save(){
		result = roomMemoService.save(roomMemo);
		return JSON;
	}
	
	public String view(){
		result = roomMemoService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = roomMemoService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		RoomMemo dbBean = roomMemoService.getBeanById(roomMemo.getId()).getValue();
		BeanUtil.copyProperties(roomMemo, dbBean);
		result = roomMemoService.update(dbBean);
		return JSON;
	}
	
	public RoomMemo getRoomMemo() {
		return roomMemo;
	}

	public void setRoomMemo(RoomMemo roomMemo) {
		this.roomMemo = roomMemo;
	}

	public String delete(){
		if(id!=null){
			result = roomMemoService.deleteById(id);
		} else if(ids!=null){
			result = roomMemoService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(RoomMemo.class);
		filter.eq("roomId", id);
		return refresh(filter);
	}
	
	@Override
	protected List<RoomMemo> getListByFilter(Filter fitler) {
		return roomMemoService.getListByFilter(fitler).getValue();
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

	public void setRoomMemoService(RoomMemoService roomMemoService) {
		this.roomMemoService = roomMemoService;
	}

	public Result getResult() {
		return result;
	}
}
