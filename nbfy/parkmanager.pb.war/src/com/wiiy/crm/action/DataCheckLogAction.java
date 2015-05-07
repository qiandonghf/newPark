package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.crm.entity.DataCheckLog;
import com.wiiy.crm.service.DataCheckLogService;

/**
 * @author my
 */
public class DataCheckLogAction extends JqGridBaseAction<DataCheckLog>{
	
	private DataCheckLogService dataCheckLogService;
	private Result result;
	private DataCheckLog dataCheckLog;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = dataCheckLogService.save(dataCheckLog);
		return JSON;
	}
	
	public String view(){
		result = dataCheckLogService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = dataCheckLogService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		DataCheckLog dbBean = dataCheckLogService.getBeanById(dataCheckLog.getId()).getValue();
		BeanUtil.copyProperties(dataCheckLog, dbBean);
		result = dataCheckLogService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = dataCheckLogService.deleteById(id);
		} else if(ids!=null){
			result = dataCheckLogService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(DataCheckLog.class));
	}
	
	@Override
	protected List<DataCheckLog> getListByFilter(Filter fitler) {
		return dataCheckLogService.getListByFilter(fitler).getValue();
	}
	
	
	public DataCheckLog getDataCheckLog() {
		return dataCheckLog;
	}

	public void setDataCheckLog(DataCheckLog dataCheckLog) {
		this.dataCheckLog = dataCheckLog;
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

	public void setDataCheckLogService(DataCheckLogService dataCheckLogService) {
		this.dataCheckLogService = dataCheckLogService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
