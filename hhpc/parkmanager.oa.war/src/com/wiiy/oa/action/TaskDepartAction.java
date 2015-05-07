package com.wiiy.oa.action;

import java.util.ArrayList;
import java.util.List;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Pager;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.TaskDepart;
import com.wiiy.oa.service.TaskDepartService;

public class TaskDepartAction extends JqGridBaseAction<TaskDepart>{
	private TaskDepartService taskDepartService;
	private Result result;
	private TaskDepart taskDepart;
	private Long id;
	private String ids;
	private Long orgId;
	private List<TaskDepart> taskDepartList;
	private Pager pager;
	
	public String deRelated(){
		TaskDepart dbBean = taskDepartService.getBeanById(id).getValue();
		if(dbBean.getOrgId()!=null){
			dbBean.setOrg(null);
			dbBean.setOrgId(null);
			result = taskDepartService.update(dbBean);
			if(result.isSuccess()){
				result.setMsg("取消关联成功");
			}else{
				result.setMsg("取消关联失败");
			}
		}else{
			result = Result.failure("无关联部门");
		}
		return JSON;
	}
	
	public String relatedDepartments(){
		result = taskDepartService.relatedDepartments(id,orgId);
		return JSON;
	}
	
	public String select(){
		ServletActionContext.getRequest().setAttribute("ids", ids);
		result = taskDepartService.getList();
		return SELECT;
	}
	
	public String list2(){
		List<TaskDepart> taskDepartList2 =taskDepartService.getList().getValue();
		taskDepartList = new ArrayList<TaskDepart>();
		for(TaskDepart td : taskDepartList2){
			td.setText(td.getName());
			td.setState(TreeEntity.STATE_CLOSED);
			taskDepartList.add(td);
		}
		return JSON;
	}
	
	public String save(){		
		result = taskDepartService.save(taskDepart);
		return JSON;
	}
	
	public String edit(){		
		result = taskDepartService.getBeanById(id);		
		return EDIT;		
	}
	
	public String delete(){
		if(id!=null){
			result = taskDepartService.deleteById(id);
		}else if(ids!=null){
			result = taskDepartService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String update(){
		TaskDepart dbBean = taskDepartService.getBeanById(taskDepart.getId()).getValue();
		BeanUtil.copyProperties(taskDepart, dbBean);
		result = taskDepartService.update(dbBean);
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(TaskDepart.class);
		if(page!=0){
			pager = new Pager(page,10);
		} else {
			pager = new Pager(1,10);
		}
		filter.pager(pager);
		taskDepartList = taskDepartService.getListByFilter(filter).getValue();
		return LIST;
	}

	@Override
	protected List<TaskDepart> getListByFilter(Filter fitler) {
		return taskDepartService.getListByFilter(fitler).getValue();
	}
	
	public void setTaskDepartService(TaskDepartService taskDepartService) {
		this.taskDepartService = taskDepartService;
	}
	public Result getResult() {
		return result;
	}
	public void setResult(Result result) {
		this.result = result;
	}
	public TaskDepart getTaskDepart() {
		return taskDepart;
	}
	public void setTaskDepart(TaskDepart taskDepart) {
		this.taskDepart = taskDepart;
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

	public void setTaskDepartList(List<TaskDepart> taskDepartList) {
		this.taskDepartList = taskDepartList;
	}

	public List<TaskDepart> getTaskDepartList() {
		return taskDepartList;
	}

	public Pager getPager() {
		return pager;
	}

	public void setPager(Pager pager) {
		this.pager = pager;
	}
	public Long getOrgId() {
		return orgId;
	}

	public void setOrgId(Long orgId) {
		this.orgId = orgId;
	}

}
