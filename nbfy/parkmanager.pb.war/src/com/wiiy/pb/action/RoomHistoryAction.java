package com.wiiy.pb.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.pb.entity.RoomHistory;
import com.wiiy.pb.service.RoomHistoryService;

/**
 * @author my
 */
public class RoomHistoryAction extends JqGridBaseAction<RoomHistory>{
	
	private RoomHistoryService roomHistoryService;
	private Result result;
	private RoomHistory roomHistory;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = roomHistoryService.save(roomHistory);
		return JSON;
	}
	
	public String view(){
		result = roomHistoryService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = roomHistoryService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		RoomHistory dbBean = roomHistoryService.getBeanById(roomHistory.getId()).getValue();
		BeanUtil.copyProperties(roomHistory, dbBean);
		result = roomHistoryService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = roomHistoryService.deleteById(id);
		} else if(ids!=null){
			result = roomHistoryService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(RoomHistory.class);
		filter.createAlias("customer", "customer");
		filter.createAlias("contract", "contract");
		filter.createAlias("manager", "manager");
		String[] names = {"id","customer.name","contract.contractNo","manager.username","phone","rentDate"};
		filter.include(names);
		filter.eq("roomId", id);
		//return refresh(new Filter(RoomHistory.class).eq("roomId", id).createAlias("customer", "customer").createAlias("manager", "manager").createAlias("contract", "contract"));
		return refresh(filter);
	}
	
	@Override
	protected List<RoomHistory> getListByFilter(Filter fitler) {
		return roomHistoryService.getListByFilter(fitler).getValue();
	}
	
	
	public RoomHistory getRoomHistory() {
		return roomHistory;
	}

	public void setRoomHistory(RoomHistory roomHistory) {
		this.roomHistory = roomHistory;
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

	public void setRoomHistoryService(RoomHistoryService roomHistoryService) {
		this.roomHistoryService = roomHistoryService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
