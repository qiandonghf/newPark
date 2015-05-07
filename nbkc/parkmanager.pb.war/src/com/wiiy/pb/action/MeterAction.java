package com.wiiy.pb.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.TreeUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.entity.Building;
import com.wiiy.pb.entity.Meter;
import com.wiiy.pb.entity.Park;
import com.wiiy.pb.preferences.enums.MeterKindEnum;
import com.wiiy.pb.preferences.enums.MeterTypeEnum;
import com.wiiy.pb.service.BuildingService;
import com.wiiy.pb.service.MeterService;
import com.wiiy.pb.service.ParkService;

public class MeterAction extends JqGridBaseAction<Meter>{
	private MeterService meterService;
	private ParkService parkService;
	private BuildingService buildingService;
	private Meter meter;
	private List<Park> parkList;
	private List<Meter> meterList;
	
	private Long id;
	private String ids;
	private Result result;
	private MeterTypeEnum type;
	private MeterKindEnum kind;
	
	private Date date;
	private Double preReading;
	
	public String loadListByRoomId(){
		Filter filter = new Filter(Meter.class).like("roomIds", ","+id+",");
		return refresh(filter);
	}
	
	public String multipList(){
		Filter filter = new Filter(Meter.class).eq("type", type).eq("kind", kind);
		return refresh(filter);
	}
	
	public String waterList(){
		Filter filter = new Filter(Meter.class).eq("type", MeterTypeEnum.WATER);
		return refresh(filter);
	}

	public String eleList(){
		Filter filter = new Filter(Meter.class).eq("type", MeterTypeEnum.ELECTRICITY);
		return refresh(filter);
	}

	public String addWaterMeter(){
		result = parkService.getList();
		return "addWaterMeter";
	}
	
	public String addEleMeter(){
		result = parkService.getList();
		return "addEleMeter";
	}
	
	public String addGasMeter(){
		result = parkService.getList();
		return "addGasMeter";
	}
	
	public String save(){
		if(meter.getParkId()!=null){
			meter.setParkName(parkService.getBeanById(meter.getParkId()).getValue().getName());
		}
		if(meter.getBuildingId()!=null){
			meter.setBuildingName(buildingService.getBeanById(meter.getBuildingId()).getValue().getName());
		}
		result = meterService.save(meter);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = meterService.deleteById(id);
		}
		if(ids!=null){
			result = meterService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String edit(){
		result = parkService.getList();
		meter = meterService.getBeanById(id).getValue();
		String re = "";
		if(meter.getParkId()!=null){
			List<Building> list = buildingService.getListByFilter(new Filter(Building.class).eq("parkId", meter.getParkId())).getValue();
			ServletActionContext.getRequest().setAttribute("list", list);
		}
		if(meter.getType().equals(MeterTypeEnum.WATER)){
			re = "waterEdit";
		}else if(meter.getType().equals(MeterTypeEnum.ELECTRICITY)){
			re = "eleEdit";
		}
		return re;
	}
	
	public String update(){
		if(meter.getParkId()!=null && !meter.getParkId().equals("")){
			meter.setParkName(parkService.getBeanById(meter.getParkId()).getValue().getName());
		}
		if(meter.getBuildingId()!=null && !meter.getBuildingId().equals("")){
			meter.setBuildingName(buildingService.getBeanById(meter.getBuildingId()).getValue().getName());
		}
		Meter dbean = meterService.getBeanById(meter.getId()).getValue();
		Boolean change = false;
		if(meter.getOrderNo()!=dbean.getOrderNo()){
			change = true;
		}
		BeanUtil.copyProperties(meter, dbean);
		dbean.setParkId(meter.getParkId());
		dbean.setParkName(meter.getParkName());
		dbean.setBuildingId(meter.getBuildingId());
		dbean.setBuildingName(meter.getBuildingName());
		result = meterService.updateMeter(dbean,change);
		return JSON;
	}
	
	public String view(){
		meter = meterService.getBeanById(id).getValue();
		String re = "";
		if(meter.getType().equals(MeterTypeEnum.WATER)){
			re = "waterView";
		}else if(meter.getType().equals(MeterTypeEnum.ELECTRICITY)){
			re = "eleView";
		}
		return re;
	}
	
	public String treeList(){
		meterList = new ArrayList<Meter>();
		if(type.equals(MeterTypeEnum.WATER)){
			meterList = meterService.getListByFilter(new Filter(Meter.class).eq("type", MeterTypeEnum.WATER)).getValue();
		}else if(type.equals(MeterTypeEnum.ELECTRICITY)){
			meterList = meterService.getListByFilter(new Filter(Meter.class).eq("type", MeterTypeEnum.ELECTRICITY)).getValue();
		}
		if(meterList!=null && meterList.size()>0){
			for(Meter mt : meterList){
				mt.setState(TreeEntity.STATE_CLOSED);
				mt.setText(mt.getOrderNo());
				mt.setLevel(mt.getLevel());
			}
		}
		meterList = TreeUtil.generateTree(meterList);
		return JSON;
	}
	
	public String listByBuildingId(){
		Filter filter = new Filter(Meter.class).eq("buildingId", id).eq("type", type);
		return refresh(filter);
	}
	
	public String select(){
		if (ids != null && ids.trim().length() > 0) {
			List<Meter> selectedMeters = new ArrayList<Meter>();
			String[] meterIds = ids.split(",");
			Long[] newIds = new Long[meterIds.length];
			for(int i=0;i<meterIds.length;i++){
				newIds[i] = Long.parseLong(meterIds[i]);
			}
			selectedMeters = meterService.getListByFilter(new Filter(Meter.class).in("id", newIds)).getValue();
			ServletActionContext.getRequest().setAttribute("selectedMeters", selectedMeters);
		}
		return "multiSelect";
	}
	
	@Override
	protected List<Meter> getListByFilter(Filter filter) {
		return meterService.getListByFilter(filter).getValue();
	}
	public Meter getMeter() {
		return meter;
	}
	public void setMeter(Meter meter) {
		this.meter = meter;
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
	public void setResult(Result result) {
		this.result = result;
	}
	public void setMeterService(MeterService meterService) {
		this.meterService = meterService;
	}

	public void setParkService(ParkService parkService) {
		this.parkService = parkService;
	}

	public void setBuildingService(BuildingService buildingService) {
		this.buildingService = buildingService;
	}

	public List<Park> getParkList() {
		return parkList;
	}

	public void setParkList(List<Park> parkList) {
		this.parkList = parkList;
	}

	public MeterTypeEnum getType() {
		return type;
	}

	public void setType(MeterTypeEnum type) {
		this.type = type;
	}

	public List<Meter> getMeterList() {
		return meterList;
	}

	public void setMeterList(List<Meter> meterList) {
		this.meterList = meterList;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Double getPreReading() {
		return preReading;
	}

	public void setPreReading(Double preReading) {
		this.preReading = preReading;
	}

	public MeterKindEnum getKind() {
		return kind;
	}

	public void setKind(MeterKindEnum kind) {
		this.kind = kind;
	}
	
}
