package com.wiiy.pb.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.pb.entity.GardenApplyLog;
import com.wiiy.pb.service.GardenApplyLogService;

/**
 * @author my
 */
public class GardenApplyLogAction extends JqGridBaseAction<GardenApplyLog>{
	
	private GardenApplyLogService gardenApplyLogService;
	private Result result;
	private GardenApplyLog gardenApplyLog;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = gardenApplyLogService.save(gardenApplyLog);
		return JSON;
	}
	
	public String view(){
		result = gardenApplyLogService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = gardenApplyLogService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		GardenApplyLog dbBean = gardenApplyLogService.getBeanById(gardenApplyLog.getId()).getValue();
		BeanUtil.copyProperties(gardenApplyLog, dbBean);
		result = gardenApplyLogService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = gardenApplyLogService.deleteById(id);
		} else if(ids!=null){
			result = gardenApplyLogService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(GardenApplyLog.class));
	}
	
	/**
	 * 根据入圃申请的id查询
	 * @return
	 */
	public String listByApplyId() {
		return refresh(new Filter(GardenApplyLog.class).eq("applyId", id));
	}
	
	@Override
	protected List<GardenApplyLog> getListByFilter(Filter fitler) {
		return gardenApplyLogService.getListByFilter(fitler).getValue();
	}
	
	
	public GardenApplyLog getGardenApplyLog() {
		return gardenApplyLog;
	}

	public void setGardenApplyLog(GardenApplyLog gardenApplyLog) {
		this.gardenApplyLog = gardenApplyLog;
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

	public void setGardenApplyLogService(GardenApplyLogService gardenApplyLogService) {
		this.gardenApplyLogService = gardenApplyLogService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
