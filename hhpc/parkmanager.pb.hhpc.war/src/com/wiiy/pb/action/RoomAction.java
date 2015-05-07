package com.wiiy.pb.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.POIUtil;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.crm.entity.Bill;
import com.wiiy.crm.service.BillService;
import com.wiiy.crm.service.CustomerService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.entity.Building;
import com.wiiy.pb.entity.Floor;
import com.wiiy.pb.entity.Park;
import com.wiiy.pb.entity.Room;
import com.wiiy.pb.entity.RoomAtt;
import com.wiiy.pb.preferences.enums.RoomStatusEnum;
import com.wiiy.pb.service.BuildingService;
import com.wiiy.pb.service.FloorService;
import com.wiiy.pb.service.ParkService;
import com.wiiy.pb.service.RoomAttService;
import com.wiiy.pb.service.RoomService;

/**
 * @author my
 */
public class RoomAction extends JqGridBaseAction<Room>{
	private RoomService roomService;
	private BuildingService buildingService;
	private FloorService floorService;
	private RoomAttService roomAttService;
	private ParkService parkService;
	private CustomerService customerService;

	private Result result;
	private Building building;
	private List<Floor> floorList;
	private Room room;
	private RoomAtt roomAtt;
	private List<RoomAtt> roomAttList;
	private Long id;
	private String ids;
	private boolean unique;
	private String name;
	private Long roomId;
	private String attName;
	private List<Park> parkList;
	private List<Building> buildingList;
	private String reportAddr;
	private Double receivedTotal = 0d;
	private Double notReceivedTotal = 0d;
	private BillService billService;
	private boolean hasCustomer;
	private String fileName;
	private String columns;
	private InputStream inputStream;
	private String roomIds;
	private String exportName;
	private Long customerId;
	
	public String export(){
		Filter filter = new Filter(Room.class);
		if(exportName.equals("到期单元列表")){
			filter.lt("endDate",new Date());
		}else if(exportName.equals("置空单元列表")){
			filter.eq("status", RoomStatusEnum.IDLE);
		}
		filter.createAlias("building", "building");
		filter.createAlias("floor", "floor");
		if(sidx==null || sidx.equals("")){
			filter.orderBy("building.name", Filter.ASC).orderBy("floor.name", Filter.ASC).orderBy("name", Filter.ASC);
		}
		if(id!=null){
			filter.eq("buildingId", id);
		}
		page=0;//不要分页
		String name = exportName;
		refresh(filter);
		fileName = StringUtil.URLEncoderToUTF8(name)+".xls";
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		POIUtil.export(name, generateExportColumns(columns), root, out);
		inputStream = new ByteArrayInputStream(out.toByteArray());
		return "export";
	}
	private LinkedHashMap<String, String> generateExportColumns(String columns2) {
		LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();
		columns = columns.replace("{", "");
		columns = columns.replace("}", "");
		String[] properties = columns.split(",");
		for (String string : properties) {
			String[] ss = string.split(":");
			String field = ss[0].replace("\"", "");
			String description = ss[1].replace("\"", "");
			map.put(field, description);
		}
		return map;
	}
	public String loadCusInfoByRoomId(){
		Room room = roomService.getBeanById(id).getValue();
		if(room.getCustomerId()!=null){
			result = customerService.getBeanById(room.getCustomerId());
		}
		return "loadCusInfoByRoomId";
	}
	
	//孵化用房管理表
	public String parkmanageList(){
		result = parkService.getListByFilter(new Filter(Park.class));
		return "parkmanageList";
	}
	
	//所有出租房间
	public String rentRoom(){
		Filter filter = new Filter(Room.class);
		filter.eq("kindId", "pb.000701");
		return refresh(filter);
	}
	
	public String loadPark(){
		result = buildingService.getListByFilter(new Filter(Building.class));
		return JSON;
	}
	
	public String loadByParkId(){
		result = buildingService.getListByFilter(new Filter(Building.class).eq("parkId", id));
		return JSON;
	}
	
	public String loadByBuildingId(){
		result = floorService.getListByFilter(new Filter(Floor.class).eq("buildingId", id));
		return JSON;
	}
	
	public String addRoom(){
		result = parkService.getListByFilter(new Filter(Park.class));
		return "addRoom";
	}
	
	//出租明细表
	public String rentDetail(){
		result = parkService.getListByFilter(new Filter(Park.class));
		return "rentDetail";
	}
	
	public String roomList(){
		Filter filter = new Filter(Room.class);
		filter.createAlias("building", "building");
		filter.createAlias("floor", "floor");
		if(sidx==null || sidx.equals("")){
			filter.orderBy("building.name", Filter.ASC).orderBy("floor.name", Filter.ASC).orderBy("name", Filter.ASC);
		}
		return refresh(filter);
	}
	
	//空闲房间列表
	public String idleRoomList(){
		Filter filter = new Filter(Room.class).eq("status", RoomStatusEnum.IDLE);
		filter.createAlias("building", "building");
		filter.createAlias("floor", "floor");
		if(sidx==null || sidx.equals("")){
			filter.orderBy("building.name", Filter.ASC).orderBy("floor.name", Filter.ASC).orderBy("name", Filter.ASC);
		}
		if(id!=null){
			filter.eq("buildingId", id);
		}
		return refresh(filter);
	}
	
	//到期单元列表
	public String expiresRoomList(){
		Filter filter = new Filter(Room.class).match("endDate", new Date(), "lt");
		filter.createAlias("building", "building");
		filter.createAlias("floor", "floor");
		if(sidx==null || sidx.equals("")){
			filter.orderBy("building.name", Filter.ASC).orderBy("floor.name", Filter.ASC).orderBy("name", Filter.ASC);
		}
		return refresh(filter);
	}
	
	public String roomBroken(){
		String[] names = name.split(",");
		if(names[0].equals(names[1])){
			result = Result.failure("新房间编号重复");
		}else{
			Room brokenRoom = roomService.getBeanById(id).getValue();
			Long buildingId = brokenRoom.getBuildingId();
			Filter filter = new Filter(Room.class);
			filter.eq("buildingId", buildingId).ne("name", brokenRoom.getName());
			List<Room> list = roomService.getListByFilter(filter.eq("name", names[0])).getValue();
			List<Room> list2 = roomService.getListByFilter(filter.eq("name", names[1])).getValue();
			if(list!=null&&list.size()>0){
				result = Result.failure("新房间编号一重复");
			}else if(list2!=null&&list2.size()>0){
				result = Result.failure("新房间编号二重复");
			}else{
				result = roomService.roomBroken(brokenRoom,names[0],names[1]);
				room = roomService.getBeanByFilter(new Filter(Room.class).eq("buildingId", buildingId).eq("name", names[0])).getValue();
			}
		}
		return JSON;
	}
	
	public String roomMerge(){
		String[] roomIds = ids.split(";");
		if(roomIds[0].equals(roomIds[1])){
			result = Result.failure("同一房间不能合并");
		}else{
			Room room1 = roomService.getBeanById(Long.parseLong(roomIds[0])).getValue();
			Room room2 = roomService.getBeanById(Long.parseLong(roomIds[1])).getValue();
			Long buildingId = room1.getBuildingId();
			Long floorId = room1.getFloorId();
			if(floorId.intValue()==room2.getFloorId().intValue()&&buildingId.intValue()==room2.getBuildingId().intValue()){
				List<Room> list = roomService.getListByFilter(new Filter(Room.class).eq("buildingId", room1.getBuildingId()).eq("name", name).ne("id",room1.getId()).ne("id", room2.getId())).getValue();
				if(list!=null&&list.size()>0){
					result = Result.failure("合并房间编号重复");
				}else{
					result = roomService.mergeRoom(room1,room2,name);
					room = roomService.getBeanByFilter(new Filter(Room.class).eq("buildingId", buildingId).eq("name", name)).getValue();
				}
			}else{
				result = Result.failure("两个房间不在同一楼宇同一楼层下");
			}
		}
		return JSON;
	}
	
	public String selectByName(){
		Filter filter = new Filter(Room.class);
		filter.eq("name", name);
		return refresh(filter);
	}
	
	public String selectList(){
		Filter filter = null;
		if(id!=null){
			filter = new Filter(Room.class);
			filter.eq("buildingId",id);
		}else if(name!=null){
			filter = new Filter(Room.class);
			filter.eq("name", name);
		}else{
			filter = new Filter(Room.class);
		}
		fetchDepth = 2;
		return refresh(filter);
	}
	
	public String loadRoomByBuilding(){
		Filter filter = new Filter(Room.class);
		if(roomIds!=null && !roomIds.isEmpty()){
			String[] idsArray = roomIds.split(",");
			Long[] ids = new Long[idsArray.length];
			for(int i=0;i<idsArray.length;i++){
				ids[i] = Long.parseLong(idsArray[i].trim());
			}
			
			filter.in("id", ids);
		}
		if(id!=null)filter.eq("buildingId", id);
		if(customerId!=null)filter.eq("customerId", customerId);
		fetchDepth = 3;
		return refresh(filter);
	}
	
	public String select(){
		parkList = parkService.getList().getValue();
		buildingList = buildingService.getList().getValue();
		return SELECT;
	}
	
	public String add(){
		building = buildingService.getBeanById(id).getValue();
		floorList = floorService.getListByFilter(new Filter(Floor.class).eq("buildingId", id)).getValue();
		return "add";
	}

	public String checkNameUnique(){
		if(roomId==null){
			unique = roomService.checkNameUnique(id,name);
		}else{
			unique = roomService.checkNameUnique(id,name,roomId);
		}
		return JSON;
	}
	
	public String save(){
		if(room.getKindId().equals("")){
			room.setKindId(null);
		}
		if(room.getTypeId().equals("")){
			room.setTypeId(null);
		}
		result = roomService.save(room);
		if(!room.getPhotos().equals("")){
			String[] photos = room.getPhotos().split(",");
			String[] attNames = roomAtt.getName().split(",");
			for(int i=0;i<photos.length;i++){
				roomAtt.setNewName(photos[i]);
				roomAtt.setName(attNames[i]);
				roomAtt.setRoomId(room.getId());
				roomAttService.save(roomAtt);
			}
		}
		return JSON;
	}
	
	public String info(){
		Room room = roomService.getBeanById(id).getValue();
		hasCustomer = false;
		if(room.getCustomerId()!=null){
			hasCustomer = true;
		}
		List<Bill> bills = billService.getListByFilter(new Filter(Bill.class).eq("room.id", id)).getValue();
		if(bills!=null && bills.size()>0){
			for (Bill bill : bills) {
				receivedTotal += bill.getFactPayment();
				notReceivedTotal += (bill.getTotalAmount() - bill.getFactPayment());
			}
		}
		return "info";
	}
	
	public String view(){
		result = roomService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		attName="";
		ids = "";
		roomAttList = roomAttService.getListByFilter(new Filter(RoomAtt.class).eq("roomId", id)).getValue();
		if(roomAttList!=null){
			for(RoomAtt att:roomAttList){
				int flag = roomService.isImg(att.getName());
				if(flag==1){
					attName += att.getName()+",";
					ids += att.getId()+",";
				}
			}
		}
		result = roomService.getBeanById(id);
		Room room = (Room) result.getValue();
		floorList = floorService.getListByFilter(new Filter(Floor.class).eq("buildingId", room.getBuildingId())).getValue();
		return EDIT;
	}
	
	public String update(){
		Room dbBean = roomService.getBeanById(room.getId()).getValue();
		BeanUtil.copyProperties(room, dbBean);
		if(dbBean.getKindId().equals("")){
			dbBean.setKindId(null);
		}
		if(dbBean.getTypeId().equals("")){
			dbBean.setTypeId(null);
		}
		result = roomService.update(dbBean);
		//pic&att
		roomAttList = roomAttService.getListByFilter(new Filter(RoomAtt.class).eq("roomId", room.getId())).getValue();
		String attNewName = "";
		String attId = "";
		if(roomAttList!=null){
			for(RoomAtt att:roomAttList){
				int flag = roomService.isImg(att.getName());
				if(flag==1){
					attNewName += att.getNewName()+",";
					attId += att.getId()+",";
				}
			}
		}
		if(attId!=""){
			String[] attNewIds = ids.split(",");
			String[] attIds = attId.split(",");
			String[] minusId = {};
			if(attId!=""){
				minusId = roomService.minus(attNewIds,attIds);
			}else{
				minusId = attNewIds;
			}
			for(String m:minusId){
				if(!m.equals("")){
					Long id = Long.parseLong(m);
					roomAttService.deleteByAttId(id);
				}
			}
		}
		
		String[] attNewNames = attNewName.split(",");
		String[] photos = room.getPhotos().split(",");
		String[] minus = {};
		if(attNewName!=""){
			minus = roomService.minus(attNewNames,photos);
		}else{
			minus = photos;
		}
		
		//添加新的图片
		roomAttList = roomAttService.getListByFilter(new Filter(RoomAtt.class).eq("roomId", room.getId())).getValue();
		String attNames = "";
		if(roomAttList!=null){
			for(RoomAtt att:roomAttList){
				int flag = roomService.isImg(att.getName());
				if(flag==1){
					attNames += att.getName()+",";
				}
			}
		}
		String[] attNameData = attNames.split(",");
		String[] attName = roomAtt.getName().split(",");
		int i = attNameData.length;
		for(String m:minus){
			if(!attNewName.contains(m)){
					if(attNames!=""){
						roomAtt.setName(attName[i]);
						i++;
					}else{
						roomAtt.setName(attName[0]);
						attNames = "not null";
					}
					roomAtt.setRoomId(room.getId());
					roomAtt.setNewName(m);
					roomAttService.save(roomAtt);
			}
		}
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = roomService.deleteById(id);
		} else if(ids!=null){
			result = roomService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String roomViewTitleById(){
		Room room = roomService.getBeanById(id).getValue();
		name = room.getBuilding().getName()+room.getName();
		return JSON;
	}
	
	public String listByBuildingId(){
		result = buildingService.getBeanById(id);
		return "listByBuildingId";
	}
	public String list(){
		Filter filter = new Filter(Room.class);
		filter.createAlias("floor", "floor");
		filter.eq("buildingId", id);
		if(sidx==null || sidx.equals("")){
			filter.orderBy("floor.name", Filter.ASC).orderBy("name", Filter.ASC);
		}
		return refresh(filter);
	}
	
	public String propertyRepair(){
		room = roomService.getBeanById(id).getValue();
		building = buildingService.getBeanById(room.getBuildingId()).getValue();
		Park park = parkService.getBeanById(building.getParkId()).getValue();
		reportAddr = park.getName()+building.getName()+room.getName();
		return "property_repair_add";
	}
	
	@Override
	protected List<Room> getListByFilter(Filter fitler) {
		return roomService.getListByFilter(fitler).getValue();
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	public Room getRoom() {
		return room;
	}

	public void setRoom(Room room) {
		this.room = room;
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

	public void setRoomService(RoomService roomService) {
		this.roomService = roomService;
	}
	public void setBuildingService(BuildingService buildingService) {
		this.buildingService = buildingService;
	}
	public void setFloorService(FloorService floorService) {
		this.floorService = floorService;
	}

	public boolean isUnique() {
		return unique;
	}

	public Result getResult() {
		return result;
	}
	public Building getBuilding() {
		return building;
	}

	public void setBuilding(Building building) {
		this.building = building;
	}

	public List<Floor> getFloorList() {
		return floorList;
	}

	public void setFloorList(List<Floor> floorList) {
		this.floorList = floorList;
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
	public List<RoomAtt> getRoomAttList() {
		return roomAttList;
	}

	public void setRoomAttList(List<RoomAtt> roomAttList) {
		this.roomAttList = roomAttList;
	}
	public String getAttName() {
		return attName;
	}

	public void setAttName(String attName) {
		this.attName = attName;
	}

	public List<Park> getParkList() {
		return parkList;
	}

	public List<Building> getBuildingList() {
		return buildingList;
	}

	public void setParkService(ParkService parkService) {
		this.parkService = parkService;
	}

	public String getReportAddr() {
		return reportAddr;
	}

	public void setReportAddr(String reportAddr) {
		this.reportAddr = reportAddr;
	}

	public Double getReceivedTotal() {
		return receivedTotal;
	}

	public void setReceivedTotal(Double receivedTotal) {
		this.receivedTotal = receivedTotal;
	}

	public Double getNotReceivedTotal() {
		return notReceivedTotal;
	}

	public void setNotReceivedTotal(Double notReceivedTotal) {
		this.notReceivedTotal = notReceivedTotal;
	}
	public void setBillService(BillService billService) {
		this.billService = billService;
	}
	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}
	public boolean isHasCustomer() {
		return hasCustomer;
	}

	public void setHasCustomer(boolean hasCustomer) {
		this.hasCustomer = hasCustomer;
	}
	
	public String getRoomIds() {
		return roomIds;
	}

	public void setRoomIds(String roomIds) {
		this.roomIds = roomIds;
	}
	
	public String getExportName() {
		return exportName;
	}

	public void setExportName(String exportName) {
		this.exportName = exportName;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getColumns() {
		return columns;
	}
	public void setColumns(String columns) {
		this.columns = columns;
	}
	public InputStream getInputStream() {
		return inputStream;
	}
	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}
	public Long getCustomerId() {
		return customerId;
	}
	public void setCustomerId(Long customerId) {
		this.customerId = customerId;
	}
	
}
