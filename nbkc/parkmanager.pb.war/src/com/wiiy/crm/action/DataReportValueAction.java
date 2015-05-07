package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.crm.entity.DataReportValue;
import com.wiiy.crm.service.DataReportValueService;

/**
 * @author my
 */
public class DataReportValueAction extends JqGridBaseAction<DataReportValue>{
	
	private DataReportValueService dataReportValueService;
	private Result result;
	private DataReportValue dataReportValue;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = dataReportValueService.save(dataReportValue);
		return JSON;
	}
	
	public String view(){
		result = dataReportValueService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = dataReportValueService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		DataReportValue dbBean = dataReportValueService.getBeanById(dataReportValue.getId()).getValue();
		BeanUtil.copyProperties(dataReportValue, dbBean);
		result = dataReportValueService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = dataReportValueService.deleteById(id);
		} else if(ids!=null){
			result = dataReportValueService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(DataReportValue.class));
	}
	
	@Override
	protected List<DataReportValue> getListByFilter(Filter fitler) {
		return dataReportValueService.getListByFilter(fitler).getValue();
	}
	
	
	public DataReportValue getDataReportValue() {
		return dataReportValue;
	}

	public void setDataReportValue(DataReportValue dataReportValue) {
		this.dataReportValue = dataReportValue;
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

	public void setDataReportValueService(DataReportValueService dataReportValueService) {
		this.dataReportValueService = dataReportValueService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
