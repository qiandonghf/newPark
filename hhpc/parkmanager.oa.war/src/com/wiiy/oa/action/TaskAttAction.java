package com.wiiy.oa.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.entity.TaskAtt;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.service.TaskAttService;

/**
 * @author my
 */
public class TaskAttAction extends JqGridBaseAction<TaskAtt>{
	
	private TaskAttService taskAttService;
	private Result result;
	private TaskAtt taskAtt;
	private Long id;
	private String ids;
	
	private HttpSession getSession(){
		return ServletActionContext.getRequest().getSession();
	}
	
	@SuppressWarnings("unchecked")
	private List<TaskAtt> getSessionTaskAttList(){
		HttpSession session = getSession();
		return (List<TaskAtt>) session.getAttribute("taskAttList");
	}
	
	public String saveToSession(){
		if(getSessionTaskAttList()==null){
			List<TaskAtt> taskAttList = new ArrayList<TaskAtt>();
			getSession().setAttribute("taskAttList", taskAttList);
		}
		taskAtt.setId((new Date()).getTime());
		getSessionTaskAttList().add(taskAtt);
		result = Result.success(R.TaskAtt.SAVE_SUCCESS,taskAtt);
		return JSON;
	}
	
	public String deleteFromSession(){
		List<TaskAtt> list = getSessionTaskAttList();
		TaskAtt delete = null;
		if(list!=null){
			for (TaskAtt task : list) {
				if(task.getId().longValue()==id.longValue()){
					delete = task;
					break;
				}
			}
			if(delete!=null){
				OaActivator.getResourcesService().delete(delete.getNewName());
				list.remove(delete);
			}
		}
		result = Result.success(R.TaskAtt.DELETE_SUCCESS);
		return JSON;
	}
	
	public String save(){
		result = taskAttService.save(taskAtt);
		return JSON;
	}
	
	public String view(){
		result = taskAttService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = taskAttService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		result = taskAttService.update(taskAtt);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = taskAttService.deleteById(id);
		} else if(ids!=null){
			result = taskAttService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(TaskAtt.class));
	}
	
	@Override
	protected List<TaskAtt> getListByFilter(Filter fitler) {
		return taskAttService.getListByFilter(fitler).getValue();
	}
	
	
	public TaskAtt getTaskAtt() {
		return taskAtt;
	}

	public void setTaskAtt(TaskAtt taskAtt) {
		this.taskAtt = taskAtt;
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

	public void setTaskAttService(TaskAttService taskAttService) {
		this.taskAttService = taskAttService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
