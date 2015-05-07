package com.wiiy.crm.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.crm.entity.DataReportProperty;
import com.wiiy.crm.service.DataReportPropertyService;

/**
 * @author my
 */
public class DataReportPropertyAction extends JqGridBaseAction<DataReportProperty>{
	
	private DataReportPropertyService dataReportPropertyService;
	private Result result;
	private DataReportProperty dataReportProperty;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = dataReportPropertyService.save(dataReportProperty);
		return JSON;
	}
	
	public String view(){
		result = dataReportPropertyService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = dataReportPropertyService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		DataReportProperty dbBean = dataReportPropertyService.getBeanById(dataReportProperty.getId()).getValue();
		BeanUtil.copyProperties(dataReportProperty, dbBean);
		result = dataReportPropertyService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = dataReportPropertyService.deleteById(id);
		} else if(ids!=null){
			result = dataReportPropertyService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(DataReportProperty.class));
	}
	
	@Override
	protected List<DataReportProperty> getListByFilter(Filter fitler) {
		return dataReportPropertyService.getListByFilter(fitler).getValue();
	}
	
	
	public DataReportProperty getDataReportProperty() {
		return dataReportProperty;
	}

	public void setDataReportProperty(DataReportProperty dataReportProperty) {
		this.dataReportProperty = dataReportProperty;
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

	public void setDataReportPropertyService(DataReportPropertyService dataReportPropertyService) {
		this.dataReportPropertyService = dataReportPropertyService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
