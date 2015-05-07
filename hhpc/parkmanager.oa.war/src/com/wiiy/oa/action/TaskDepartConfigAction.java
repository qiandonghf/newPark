package com.wiiy.oa.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.oa.entity.TaskDepartConfig;
import com.wiiy.oa.service.TaskDepartConfigService;

/**
 * @author my
 */
public class TaskDepartConfigAction extends JqGridBaseAction<TaskDepartConfig>{
	
	private TaskDepartConfigService taskDepartConfigService;
	private Result result;
	private TaskDepartConfig taskDepartConfig;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = taskDepartConfigService.save(taskDepartConfig);
		return JSON;
	}
	
	public String view(){
		result = taskDepartConfigService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = taskDepartConfigService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		result = taskDepartConfigService.update(taskDepartConfig);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = taskDepartConfigService.deleteById(id);
		} else if(ids!=null){
			result = taskDepartConfigService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(TaskDepartConfig.class));
	}
	
	@Override
	protected List<TaskDepartConfig> getListByFilter(Filter fitler) {
		return taskDepartConfigService.getListByFilter(fitler).getValue();
	}
	
	
	public TaskDepartConfig getTaskDepartConfig() {
		return taskDepartConfig;
	}

	public void setTaskDepartConfig(TaskDepartConfig taskDepartConfig) {
		this.taskDepartConfig = taskDepartConfig;
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

	public void setTaskDepartConfigService(TaskDepartConfigService taskDepartConfigService) {
		this.taskDepartConfigService = taskDepartConfigService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
