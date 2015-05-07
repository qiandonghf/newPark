package com.wiiy.pb.action;

import java.util.ArrayList;
import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.preferences.enums.RentBillPlanFeeEnum;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.entity.Room;
import com.wiiy.pb.entity.RoomFee;
import com.wiiy.pb.service.RoomFeeService;
import com.wiiy.pb.service.RoomService;

/**
 * @author my
 */
public class RoomFeeAction extends JqGridBaseAction<RoomFee>{
	
	private RoomFeeService roomFeeService;
	private RoomService roomService;
	private List<TreeEntity> list = new ArrayList<TreeEntity>();
	private Room room;
	private Result result;
	private RoomFee roomFee;
	private Long id;
	private String ids;
	private int type = 1;
	private RentBillPlanFeeEnum name;
	
	public String feeTypeList(){
		TreeEntity entity = new TreeEntity();
		entity.setText("物业");
		entity.setLevel(0);
		entity.setState(TreeEntity.STATE_CLOSED);
		List<TreeEntity> children = new ArrayList<TreeEntity>();
		TreeEntity child1 = new TreeEntity();
		child1.setId(1l);
		child1.setText(RentBillPlanFeeEnum.RENT.getTitle());
		child1.setLevel(1);
		children.add(child1);
		TreeEntity child2 = new TreeEntity();
		child2.setId(2l);
		child2.setText(RentBillPlanFeeEnum.MANAGE.getTitle());
		child2.setLevel(1);
		children.add(child2);
		TreeEntity child3 = new TreeEntity();
		child3.setId(3l);
		child3.setText(RentBillPlanFeeEnum.ENERGY.getTitle());
		child3.setLevel(1);
		children.add(child3);
		entity.setChildren(children);
		list.add(entity);
		return JSON;
	}
	
	public String editRoomFees(){
		room = roomService.getBeanById(id).getValue();
		return "editRoomFees";
	}
	
	public String editRoomFee(){
		room = roomService.getBeanById(id).getValue();
		if(type==1){
			name = RentBillPlanFeeEnum.RENT;
			result = roomFeeService.getBeanByFilter(new Filter(RoomFee.class).eq("roomId", id).eq("feeType", RentBillPlanFeeEnum.RENT));
		}else if(type==2){
			name = RentBillPlanFeeEnum.MANAGE;
			result = roomFeeService.getBeanByFilter(new Filter(RoomFee.class).eq("roomId", id).eq("feeType", RentBillPlanFeeEnum.MANAGE));
		}else if(type==3){
			name = RentBillPlanFeeEnum.ENERGY;
			result = roomFeeService.getBeanByFilter(new Filter(RoomFee.class).eq("roomId", id).eq("feeType", RentBillPlanFeeEnum.ENERGY));
		}
		return "editRoomFee";
	}
	
	public String save(){
		result = roomFeeService.save(roomFee);
		return JSON;
	}
	
	public String view(){
		result = roomFeeService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = roomFeeService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		if(roomFee.getId()==null){
			result = roomFeeService.save(roomFee);
		}else{
			RoomFee dbBean = roomFeeService.getBeanById(roomFee.getId()).getValue();
			BeanUtil.copyProperties(roomFee, dbBean);
			result = roomFeeService.update(dbBean);
		}
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = roomFeeService.deleteById(id);
		} else if(ids!=null){
			result = roomFeeService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(RoomFee.class).eq("roomId", id));
	}
	
	@Override
	protected List<RoomFee> getListByFilter(Filter fitler) {
		return roomFeeService.getListByFilter(fitler).getValue();
	}
	
	
	public RoomFee getRoomFee() {
		return roomFee;
	}

	public void setRoomFee(RoomFee roomFee) {
		this.roomFee = roomFee;
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

	public void setRoomFeeService(RoomFeeService roomFeeService) {
		this.roomFeeService = roomFeeService;
	}
	
	public Result getResult() {
		return result;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public RentBillPlanFeeEnum getName() {
		return name;
	}

	public void setName(RentBillPlanFeeEnum name) {
		this.name = name;
	}

	public void setRoomService(RoomService roomService) {
		this.roomService = roomService;
	}
	public Room getRoom() {
		return room;
	}

	public void setRoom(Room room) {
		this.room = room;
	}
	public List<TreeEntity> getList() {
		return list;
	}

	public void setList(List<TreeEntity> list) {
		this.list = list;
	}

}
