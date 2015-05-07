package com.wiiy.oa.action;

import java.util.List;
import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.WorkReportConfig;
import com.wiiy.oa.service.WorkReportConfigService;

public class WorkReportConfigAction extends JqGridBaseAction<WorkReportConfig>{
	private WorkReportConfigService workReportConfigService;
	private WorkReportConfig workReportConfig;
	private Result result;
	private Long id;
	private String ids;
	
	/**
	 * 设置报送人，将报送人和接收人的信息存入workReportConfig表中
	 */
	public String configReporter(){
		result = workReportConfigService.configReporter(ids);	
		return JSON;
	}
	
	public String save(){
		result = workReportConfigService.save(workReportConfig);
		return JSON;
	}
	
	public String edit(){
		result = workReportConfigService.getBeanById(id);
		return EDIT;
	}
	
	public String delete(){
		if(id!=null){
			result = workReportConfigService.deleteById(id);
		}else if(ids!=null){
			result = workReportConfigService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String update(){
		WorkReportConfig dbBean = workReportConfigService.getBeanById(workReportConfig.getId()).getValue();
		BeanUtil.copyProperties(workReportConfig, dbBean);
		result = workReportConfigService.update(dbBean);
		return JSON;
	}
	
	protected List<WorkReportConfig> getListByFilter(Filter fitler) {
		return workReportConfigService.getListByFilter(fitler).getValue();
	}

	public void setWorkReportConfigService(
			WorkReportConfigService workReportConfigService) {
		this.workReportConfigService = workReportConfigService;
	}

	public WorkReportConfig getWorkReportConfig() {
		return workReportConfig;
	}

	public void setWorkReportConfig(WorkReportConfig workReportConfig) {
		this.workReportConfig = workReportConfig;
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
	
}
