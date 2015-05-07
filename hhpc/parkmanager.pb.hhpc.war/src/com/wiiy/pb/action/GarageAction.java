package com.wiiy.pb.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.pb.entity.Building;
import com.wiiy.pb.entity.Garage;
import com.wiiy.pb.entity.Park;
import com.wiiy.pb.service.GarageService;
import com.wiiy.pb.service.ParkService;

/**
 * @author my
 */
public class GarageAction extends JqGridBaseAction<Garage>{
	private ParkService parkService;
	private GarageService garageService;
	private Result result;
	private Garage garage;
	private Long id;
	private String ids;
	private List<Garage> garageList;
	private List<Park> parkList;
	
	public String save(){
		result = garageService.save(garage);
		return JSON;
	}
	
	public String view(){
		result = garageService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = garageService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		Garage dbBean = garageService.getBeanById(garage.getId()).getValue();
		BeanUtil.copyProperties(garage, dbBean);
		result = garageService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = garageService.deleteById(id);
		} else if(ids!=null){
			result = garageService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(Garage.class));
	}
	public String listGarage(){
		parkList = parkService.getList().getValue();
		garageList = garageService.getListByFilter(new Filter(Garage.class)).getValue();
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
		for (Garage garage : garageList) {
			if(map.get(garage.getParkId())!=null){
				garage.setText(garage.getTitle());
				garage.setLevel(1);
				garage.setIconCls("icon-garage");
				map.get(garage.getParkId()).getChildren().add(garage);
			}
		}
		return JSON;
	}
	
	@Override
	protected List<Garage> getListByFilter(Filter fitler) {
		return garageService.getListByFilter(fitler).getValue();
	}
	
	
	public Garage getGarage() {
		return garage;
	}

	public void setGarage(Garage garage) {
		this.garage = garage;
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

	public void setGarageService(GarageService garageService) {
		this.garageService = garageService;
	}
	
	public Result getResult() {
		return result;
	}

	public List<Park> getParkList() {
		return parkList;
	}

	public void setParkList(List<Park> parkList) {
		this.parkList = parkList;
	}

	public void setParkService(ParkService parkService) {
		this.parkService = parkService;
	}

	public List<Garage> getGarageList() {
		return garageList;
	}

	public void setGarageList(List<Garage> garageList) {
		this.garageList = garageList;
	}
}
