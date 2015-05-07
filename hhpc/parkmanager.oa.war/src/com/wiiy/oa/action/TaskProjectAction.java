package com.wiiy.oa.action;

import java.util.List;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Pager;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.TaskProject;
import com.wiiy.oa.preferences.enums.TaskProjectStatusEnum;
import com.wiiy.oa.service.TaskProjectService;

public class TaskProjectAction extends JqGridBaseAction<TaskProject>{
	private TaskProjectService taskProjectService;
	private List<TaskProject> taskProjectList;
	private Result result;
	private TaskProject taskProject;
	private Long id;
	private String ids;
	private Pager pager;
	
	public String select(){
		ServletActionContext.getRequest().setAttribute("id", id);
		taskProjectList = taskProjectService.getList().getValue();
		return SELECT;
	}
	
	public String  save(){
		taskProject.setStatus(TaskProjectStatusEnum.NORMAL);
		result = taskProjectService.save(taskProject);
		return JSON;
	}
	
	public String edit(){
		result = taskProjectService.getBeanById(id);
		return EDIT;
	}
	
	public String delete(){
		if(id!=null){
			result = taskProjectService.deleteById(id);
		}else if(ids!=null){
			result = taskProjectService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(TaskProject.class);
		if(page!=0){
			pager = new Pager(page,10);
		} else {
			pager = new Pager(1,10);
		}
		filter.pager(pager);
		taskProjectList = taskProjectService.getListByFilter(filter).getValue();
		return LIST;
	}
	
	public String update(){
		TaskProject dbBean = taskProjectService.getBeanById(taskProject.getId()).getValue();
		BeanUtil.copyProperties(taskProject, dbBean);
		result = taskProjectService.update(dbBean);
		return JSON;
	}
	
	public String openProject(){
		TaskProject dbean = taskProjectService.getBeanById(id).getValue();
		dbean.setStatus(TaskProjectStatusEnum.NORMAL);
		result = taskProjectService.update(dbean);
		return JSON;
	}
	
	public String closeProject(){
		TaskProject dbean = taskProjectService.getBeanById(id).getValue();
		dbean.setStatus(TaskProjectStatusEnum.CLOSED);
		result = taskProjectService.update(dbean);
		return JSON;
	}
	
	@Override
	protected List<TaskProject> getListByFilter(Filter fitler) {
		return taskProjectService.getListByFilter(fitler).getValue();
	}
	
	public void setTaskProjectService(TaskProjectService taskProjectService) {
		this.taskProjectService = taskProjectService;
	}
	public Result getResult() {
		return result;
	}
	public void setResult(Result result) {
		this.result = result;
	}
	public TaskProject getTaskProject() {
		return taskProject;
	}
	public void setTaskProject(TaskProject taskProject) {
		this.taskProject = taskProject;
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

	public List<TaskProject> getTaskProjectList() {
		return taskProjectList;
	}

	public void setTaskProjectList(List<TaskProject> taskProjectList) {
		this.taskProjectList = taskProjectList;
	}

	public Pager getPager() {
		return pager;
	}

	public void setPager(Pager pager) {
		this.pager = pager;
	}
}
