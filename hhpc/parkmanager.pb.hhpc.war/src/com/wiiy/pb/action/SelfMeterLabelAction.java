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
import com.wiiy.pb.entity.SelfMeterLabel;
import com.wiiy.pb.preferences.enums.MeterRecordStatusEnum;
import com.wiiy.pb.preferences.enums.MeterTypeEnum;
import com.wiiy.pb.service.BuildingService;
import com.wiiy.pb.service.SelfMeterLabelService;

public class SelfMeterLabelAction extends JqGridBaseAction<SelfMeterLabel>{
	private SelfMeterLabelService selfMeterLabelService;
	private BuildingService buildingService;
	
	private SelfMeterLabel selfMeterLabel;
	private Long id;
	private String ids;
	private Result result;
	private Pager pager;
	private List<SelfMeterLabel> selfMeterLabelList;
	private MeterTypeEnum type;
	
	public String list(){
		Filter filter = new Filter(SelfMeterLabel.class);
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
		selfMeterLabelList = selfMeterLabelService.getListByFilter(filter).getValue();
		return LIST;
	}

	public String save(){
		selfMeterLabel.setCheckOut(MeterRecordStatusEnum.INITIAL);
		result = selfMeterLabelService.save(selfMeterLabel);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = selfMeterLabelService.deleteById(id);
		}
		return JSON;
	}
	
	public String edit(){
		result = selfMeterLabelService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		SelfMeterLabel dbean = selfMeterLabelService.getBeanById(selfMeterLabel.getId()).getValue();
		String oldIds = dbean.getBuildingIds();
		BeanUtil.copyProperties(selfMeterLabel, dbean);
		String newIds = selfMeterLabel.getBuildingIds();
		result = selfMeterLabelService.update(dbean);
		if(result.isSuccess()){
			if(!oldIds.equals(newIds)){
				selfMeterLabelService.updateRecord(selfMeterLabel.getId(),oldIds,newIds);
			}
		}
		return JSON;
	}
	
	public String view(){
		result = selfMeterLabelService.getBeanById(id);
		String buildingNames = "";
		selfMeterLabel = (SelfMeterLabel)result.getValue();
		String buildingIds = selfMeterLabel.getBuildingIds();
		for(String buildingId : buildingIds.split(",")){
			Building building = buildingService.getBeanById(Long.parseLong(buildingId)).getValue();
			String name = building.getPark().getName()+"--"+building.getName(); 
			buildingNames += name + ",";
		}
		buildingNames = buildingNames.substring(0,buildingNames.length()-1);
		ServletActionContext.getRequest().setAttribute("buildingNames", buildingNames);
		return VIEW;
	}
	
	
	@Override
	protected List<SelfMeterLabel> getListByFilter(Filter filter) {
		return selfMeterLabelService.getListByFilter(filter).getValue();
	}

	public SelfMeterLabel getSelfMeterLabel() {
		return selfMeterLabel;
	}

	public void setSelfMeterLabel(SelfMeterLabel selfMeterLabel) {
		this.selfMeterLabel = selfMeterLabel;
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

	public Pager getPager() {
		return pager;
	}

	public void setPager(Pager pager) {
		this.pager = pager;
	}

	public List<SelfMeterLabel> getSelfMeterLabelList() {
		return selfMeterLabelList;
	}

	public void setSelfMeterLabelList(List<SelfMeterLabel> selfMeterLabelList) {
		this.selfMeterLabelList = selfMeterLabelList;
	}

	public MeterTypeEnum getType() {
		return type;
	}

	public void setType(MeterTypeEnum type) {
		this.type = type;
	}

	public void setSelfMeterLabelService(SelfMeterLabelService selfMeterLabelService) {
		this.selfMeterLabelService = selfMeterLabelService;
	}

	public void setBuildingService(BuildingService buildingService) {
		this.buildingService = buildingService;
	}

}
