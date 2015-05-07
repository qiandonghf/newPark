package com.wiiy.pb.action;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.TreeUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.entity.Building;
import com.wiiy.pb.entity.Park;
import com.wiiy.pb.service.BuildingService;
import com.wiiy.pb.service.ParkService;

/**
 * @author my
 */
public class ParkAction extends JqGridBaseAction<Park>{
	
	private ParkService parkService;
	private BuildingService buildingService;
	private Result result;
	private Park park;
	private Long id = null;
	private String ids;
	
	private List<Park> parkList;
	private List<Building> buildingList;
	private Long buildingId = 0L;
	
	public String energyFeeList(){
		parkList = parkService.getListByFilter(new Filter(Park.class)).getValue();
		return "energyFeeList";
	}
	
	public String parkFeeList(){
		parkList = parkService.getListByFilter(new Filter(Park.class)).getValue();
		return "parkFeeList";
	}
	
	public String save(){
		result = parkService.save(park);
		return JSON;
	}
	
	public String view(){
		result = parkService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = parkService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		Park dbBean = parkService.getBeanById(park.getId()).getValue();
		BeanUtil.copyProperties(park, dbBean);
		result = parkService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = parkService.deleteById(id);
		} else if(ids!=null){
			result = parkService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		buildingId = id;
		return LIST;
	}
	
	public String listBuilding(){
		parkList = parkService.getList().getValue();
		buildingList = buildingService.getList().getValue();
		Map<Long,Park> map = new HashMap<Long, Park>();
		for(Park park : parkList){
			List<Building> buildings = new ArrayList<Building>();
			park.setLevel(0);
			park.setIconCls("icon-building");
			park.setText(park.getName());
			park.setState(TreeEntity.STATE_CLOSED);
			park.setChildren(buildings);
			map.put(park.getId(), park);
		}
		for(Building building:buildingList){
			if(map.get(building.getParkId())!=null){
				building.setText(building.getName());
				building.setLevel(1);
				building.setIconCls("icon-room");
				map.get(building.getParkId()).getChildren().add(building);
			}
		}
		Collection<Park> list = map.values();
		List<Park> newList = new ArrayList<Park>();
		for (Park park : list) {
			newList.add(park);
		}
		parkList = TreeUtil.generateTree(newList);
		return JSON;
	}
	
	@Override
	protected List<Park> getListByFilter(Filter fitler) {
		return parkService.getListByFilter(fitler).getValue();
	}
	
	
	public Park getPark() {
		return park;
	}

	public void setPark(Park park) {
		this.park = park;
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

	public void setParkService(ParkService parkService) {
		this.parkService = parkService;
	}
	
	public Result getResult() {
		return result;
	}

	public List<Park> getParkList() {
		return parkList;
	}

	public List<Building> getBuildingList() {
		return buildingList;
	}

	public void setBuildingService(BuildingService buildingService) {
		this.buildingService = buildingService;
	}

	public Long getBuildingId() {
		return buildingId;
	}

	public void setBuildingId(Long buildingId) {
		this.buildingId = buildingId;
	}
	
}
