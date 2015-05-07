package com.wiiy.pb.action;

import java.util.List;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Pager;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.entity.Building;
import com.wiiy.pb.entity.MeterLabel;
import com.wiiy.pb.preferences.enums.MeterRecordStatusEnum;
import com.wiiy.pb.preferences.enums.MeterTypeEnum;
import com.wiiy.pb.service.BuildingService;
import com.wiiy.pb.service.MeterLabelRecordService;
import com.wiiy.pb.service.MeterLabelService;
import com.wiiy.pb.service.MeterService;
import com.wiiy.pb.service.ParkService;
import com.wiiy.pb.service.RoomService;

public class MeterLabelAction extends JqGridBaseAction<MeterLabel>{
	private MeterLabelService meterLabelService;
	private MeterService meterService;
	private MeterLabelRecordService meterLabelRecordService;
	private ParkService parkService;
	private BuildingService buildingService;
	private RoomService roomService;
	
	private MeterLabel meterLabel;
	private Long id;
	private String ids;
	private Result result;
	private Pager pager;
	private List<MeterLabel> meterLabelList;
	private MeterTypeEnum type;

	public String list(){
		Filter filter = new Filter(MeterLabel.class);
		if(page!=0){
			pager = new Pager(page,10);
		} else {
			pager = new Pager(1,10);
		}
		filter.pager(pager);
		if(type!=null){
			filter.eq("type", type);
		}
		filter.orderBy("modifyTime", Filter.DESC);
		meterLabelList = meterLabelService.getListByFilter(filter).getValue();
		return LIST;
	}

	public String save(){
		meterLabel.setCheckOut(MeterRecordStatusEnum.INITIAL);
		result = meterLabelService.save(meterLabel);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = meterLabelService.deleteById(id);
		}
		return JSON;
	}
	
	public String edit(){
		result = meterLabelService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		MeterLabel dbean = meterLabelService.getBeanById(meterLabel.getId()).getValue();
		String oldIds = dbean.getBuildingIds();
		BeanUtil.copyProperties(meterLabel, dbean);
		String newIds = meterLabel.getBuildingIds();
		result = meterLabelService.update(dbean);
		if(result.isSuccess()){
			if(!oldIds.equals(newIds)){
				meterLabelService.updateRecord(meterLabel.getId(),oldIds,newIds);
			}
		}
		return JSON;
	}
	
	public String view(){
		meterLabel = meterLabelService.getBeanById(id).getValue();
		result = meterLabelService.getBeanById(id);
		String buildingNames = "";
		meterLabel = (MeterLabel)result.getValue();
		String buildingIds = meterLabel.getBuildingIds();
		for(String buildingId : buildingIds.split(",")){
			Building building = buildingService.getBeanById(Long.parseLong(buildingId)).getValue();
			String name = building.getPark().getName()+"--"+building.getName(); 
			buildingNames += name + ",";
		}
		buildingNames = buildingNames.substring(0,buildingNames.length()-1);
		ServletActionContext.getRequest().setAttribute("buildingNames", buildingNames);
		if(meterLabel.getType().equals(MeterTypeEnum.WATER)){
			return "waterView";
		}else{
			return "eleView";
		}
		
	}
	
	@Override
	protected List<MeterLabel> getListByFilter(Filter filter) {
		return meterLabelService.getListByFilter(filter).getValue();
	}
	public MeterLabel getMeterLabel() {
		return meterLabel;
	}
	public void setMeterLabel(MeterLabel meterLabel) {
		this.meterLabel = meterLabel;
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
	public void setMeterLabelService(MeterLabelService meterLabelService) {
		this.meterLabelService = meterLabelService;
	}

	public void setParkService(ParkService parkService) {
		this.parkService = parkService;
	}

	public void setBuildingService(BuildingService buildingService) {
		this.buildingService = buildingService;
	}

	public List<MeterLabel> getMeterLabelList() {
		return meterLabelList;
	}

	public void setMeterLabelList(List<MeterLabel> meterLabelList) {
		this.meterLabelList = meterLabelList;
	}

	public Pager getPager() {
		return pager;
	}

	public void setPager(Pager pager) {
		this.pager = pager;
	}

	public MeterTypeEnum getType() {
		return type;
	}

	public void setType(MeterTypeEnum type) {
		this.type = type;
	}

	public void setMeterLabelRecordService(
			MeterLabelRecordService meterLabelRecordService) {
		this.meterLabelRecordService = meterLabelRecordService;
	}

	public void setMeterService(MeterService meterService) {
		this.meterService = meterService;
	}

	public void setRoomService(RoomService roomService) {
		this.roomService = roomService;
	}

}
