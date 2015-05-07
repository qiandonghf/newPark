package com.wiiy.oa.action;

import java.util.List;

import org.hibernate.criterion.MatchMode;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.TaskLog;
import com.wiiy.oa.service.TaskLogService;

/**
 * @author my
 */
public class TaskLogAction extends JqGridBaseAction<TaskLog>{
	
	private TaskLogService taskLogService;
	private Result result;
	private TaskLog taskLog;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = taskLogService.save(taskLog);
		return JSON;
	}
	
	public String view(){
		result = taskLogService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = taskLogService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		result = taskLogService.update(taskLog);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = taskLogService.deleteById(id);
		} else if(ids!=null){
			result = taskLogService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(TaskLog.class).eq("taskId", id).notIn("memo", "将工作级别设为高级","将工作级别设为中级","将工作级别设为低级","更新工作","将工作进度设为25%","将工作进度设为0%","将工作进度设为50%","将工作进度设为75%","将工作进度设为100%","工作未签收"));
	}
	
	public String list2(){
//		Filter filter = new Filter(TaskLog.class).or(Filter.Eq("memo","未签收")).or(Filter.Eq("memo", "已签收")).or(Filter.Eq("memo", "已拒绝")).or(Filter.Eq("memo", "已完成")).or(Filter.Eq("memo", "已中止"));
		Filter filter = new Filter(TaskLog.class).eq("taskId", id).like("memo", "工作", Filter.START);
		return refresh(filter);
	}
	
	@Override
	protected List<TaskLog> getListByFilter(Filter fitler) {
		return taskLogService.getListByFilter(fitler).getValue();
	}
	
	
	public TaskLog getTaskLog() {
		return taskLog;
	}

	public void setTaskLog(TaskLog taskLog) {
		this.taskLog = taskLog;
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

	public void setTaskLogService(TaskLogService taskLogService) {
		this.taskLogService = taskLogService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
