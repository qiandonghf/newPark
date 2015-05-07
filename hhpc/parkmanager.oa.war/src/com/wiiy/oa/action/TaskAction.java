package com.wiiy.oa.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.core.entity.User;
import com.wiiy.core.external.service.UserPubService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Pager;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.dto.EmployeeWorkDto;
import com.wiiy.oa.dto.FinishWorkDto;
import com.wiiy.oa.dto.MyTaskAmountDto;
import com.wiiy.oa.dto.TaskDepartDto;
import com.wiiy.oa.dto.TaskDto;
import com.wiiy.oa.dto.TaskProjectDto;
import com.wiiy.oa.dto.WeekDto;
import com.wiiy.oa.entity.Task;
import com.wiiy.oa.entity.TaskAtt;
import com.wiiy.oa.entity.TaskDepart;
import com.wiiy.oa.entity.TaskDepartConfig;
import com.wiiy.oa.entity.TaskLog;
import com.wiiy.oa.entity.TaskProject;
import com.wiiy.oa.preferences.R;
import com.wiiy.oa.preferences.enums.PriorityEnum;
import com.wiiy.oa.preferences.enums.PromotEnum;
import com.wiiy.oa.preferences.enums.SubTaskStatusEnum;
import com.wiiy.oa.preferences.enums.TaskProjectStatusEnum;
import com.wiiy.oa.preferences.enums.TaskStatusEnum;
import com.wiiy.oa.service.TaskAttService;
import com.wiiy.oa.service.TaskDepartConfigService;
import com.wiiy.oa.service.TaskDepartService;
import com.wiiy.oa.service.TaskLogService;
import com.wiiy.oa.service.TaskProjectService;
import com.wiiy.oa.service.TaskService;
import com.wiiy.oa.util.ScheduleUtil;

/**
 * @author my
 */
public class TaskAction extends JqGridBaseAction<Task>{
	
	private TaskService taskService;
	private TaskLogService taskLogService;
	private TaskAttService taskAttService;
	private TaskDepartService taskDepartService;
	private TaskProjectService taskProjectService;
	private TaskDepartConfigService taskDepartConfigService;
	private List<Task> taskList;
	private List<Task> pendingList;//待签收的工作
	private List<Task> sendList;//我派出的工作
	private List<TaskDepart> taskDepartList;
	private List<TaskProject> taskProjectList;
	private List<TaskDepartDto> departDtoList;
	private List<TaskProjectDto> projectDtoList;
	private List<EmployeeWorkDto> employeeWorkDtoList;
	private List<TaskDto> taskDtoList;//派出
	private List<TaskDto> taskWorkDtoList;//待办
	private List<TaskDto> pengdingDtoList;//待办
	private List<FinishWorkDto> finishWorkDtoList;
	private List<TaskLog> taskLogList;
	private Result result;
	private Task task;
	private Long id;
	private String ids;
	private Pager pager;
	private Integer progress;
	private Integer week;
	
	private int lastDay = 7;
	private Long departId;
	private Long projectId;
	private String status;
	
	private String op;
	private Date endTime;
	
	private String sendIds;
	
	private MyTaskAmountDto myTaskAmountDto;
	private String title;
	
	private String creatorid;
	private String creator;
	private String executorid;
	private String executor;
	
	private List<Integer> years;
	private List<Integer> months;
	private List<Date> dateList;
	private Integer curYear;
	private Integer curMonth;
	
	private Long userOrgId;
	
	public String mySignedTaskCount(){
		Filter countFilter = new Filter(Task.class);
	//	countFilter.ge("endTime", CalendarUtil.getEarliest(Calendar.DAY_OF_MONTH));
	//	countFilter.le("endTime", CalendarUtil.getLatest(Calendar.DAY_OF_MONTH));
		countFilter.sqlRestriction("{alias}.id IN (SELECT a.id FROM oa_task a WHERE a.receiver_id = "+OaActivator.getSessionUser().getId()+" and a.child_status = 'PENDING')");
		try {
			result = Result.value(taskService.getRowCount(countFilter).getValue());
		} catch (Exception e) {
			result = Result.value(0);
		}
		return JSON;
	}
	public String myTaskToDoCount(){
		Filter countFilter = new Filter(Task.class);
		//	countFilter.ge("endTime", CalendarUtil.getEarliest(Calendar.DAY_OF_MONTH));
		//	countFilter.le("endTime", CalendarUtil.getLatest(Calendar.DAY_OF_MONTH));
		countFilter.eq("receiverId", OaActivator.getSessionUser().getId()).eq("childStatus", SubTaskStatusEnum.SIGNED).notIn("status", TaskStatusEnum.FINISHED).orderBy("endTime", "asc");
		try {
			result = Result.value(taskService.getRowCount(countFilter).getValue());
		} catch (Exception e) {
			result = Result.value(0);
		}
		return JSON;
	}
	public String myPendingTaskCount(){
		Filter countFilter = new Filter(Task.class);
		//	countFilter.ge("endTime", CalendarUtil.getEarliest(Calendar.DAY_OF_MONTH));
		//	countFilter.le("endTime", CalendarUtil.getLatest(Calendar.DAY_OF_MONTH));
		countFilter.eq("receiverId", OaActivator.getSessionUser().getId()).eq("childStatus", SubTaskStatusEnum.PENDING);
		try {
			result = Result.value(taskService.getRowCount(countFilter).getValue());
		} catch (Exception e) {
			result = Result.value(0);
		}
		return JSON;
	}
	//工作台显示我的待办任务
	public String deskTopPendingTask(){
		taskDtoList = taskService.getPendingTask().getValue();
		return "deskTopPendingTask";
	}
	
	public String updateEndTime(){
		Task dbBean = taskService.getBeanById(id).getValue();
		dbBean.setEndTime(endTime);
		result = taskService.update(dbBean);
		String memo = "将工作延期至"+DateUtil.format(endTime,"yyyy-MM-dd");
		taskLogService.save(memo, id,dbBean.getProgress());
		
		List<Task> taskList = taskService.getListByFilter(new Filter(Task.class).eq("parentId", id).notNull("receiverId")).getValue();
		if(taskList.size()>0 && taskList!=null){
			for(Task t : taskList){
				t.setEndTime(endTime);
				taskService.update(t);
				taskLogService.save(title, t.getId(),t.getProgress());
			}
		}
		return JSON;
	}
	
	public String taskSend(){
		result = taskService.taskSend(id,ids);
		task = (Task)result.getValue();
		StringBuilder memo = new StringBuilder(" 将工作派送给 ");
		Long[] idArrays = StringUtil.splitToLongArray(ids);
		for (Long id : idArrays) {
			memo.append(OaActivator.getUserById(id).getRealName()).append(",");
		}
		if(memo.toString().endsWith(","))memo.deleteCharAt(memo.length()-1);
		taskLogService.save(memo.toString(), id,task.getProgress());
		return JSON;
	}
	
	//工作转交
	public String taskMove(){
		Long moveId = Long.parseLong(ids);
		result = taskService.taskMove(id,moveId);
		task = (Task)result.getValue();
			
		StringBuilder memo = new StringBuilder("将工作转交给");
		memo.append(OaActivator.getUserById(moveId).getRealName());
		taskLogService.save(memo.toString(), id);
		return JSON;
	}
	
	public String setProject(){
		Task dbBean = taskService.getBeanById(id).getValue();
		TaskProject tp = taskProjectService.getBeanById(projectId).getValue();
		dbBean.setProjectId(projectId);
		dbBean.setProject(tp);
		Integer progress = dbBean.getProgress();
		String memo = dbBean.getProject().getName();
		result = taskService.update(dbBean);
		taskLogService.save("将工作项目设置为"+memo, id,progress);
		
		List<Task> taskList = taskService.getListByFilter(new Filter(Task.class).eq("parentId", id).notNull("receiverId")).getValue();
		if(taskList.size()>0 && taskList!=null){
			for(Task t : taskList){
				t.setProjectId(projectId);
				t.setProject(tp);
				taskService.update(t);
				taskLogService.save("将工作项目设置为"+memo, id,t.getProgress());
			}
		}
		return JSON;
	}
	
	public String setDepart(){
		result = taskService.setDepart(id,ids);
		taskDepartList = taskDepartService.getListByFilter(new Filter(TaskDepart.class).in("id", (Object[])StringUtil.splitToLongArray(ids))).getValue();
		StringBuilder memo = new StringBuilder(" 将工作部门设置为 ");
		for(TaskDepart depart : taskDepartList) {
			memo.append(depart.getName()).append(",");
		}
		if(memo.toString().endsWith(","))memo.deleteCharAt(memo.length()-1);
		taskLogService.save(memo.toString(), id,((Task)result.getValue()).getProgress());
		
		List<Task> taskList = taskService.getListByFilter(new Filter(Task.class).eq("parentId", id).notNull("receiverId")).getValue();
		if(taskList.size()>0 && taskList!=null){
			for(Task t : taskList){
				taskService.setDepart(t.getId(),ids);
				taskLogService.save(memo.toString(), id,((Task)result.getValue()).getProgress());
			}
		}
		return JSON;
	}
	
	public String aborted(){
		Task dbBean = taskService.getBeanById(id).getValue();
		List<Task> taskList = taskService.getListByFilter(new Filter(Task.class).eq("parentId", id).notNull("receiverId")).getValue();
		if(taskList.size()>0 && taskList!=null){
			for(Task t : taskList){
				t.setStatus(TaskStatusEnum.ABORTED);
				t.setChildStatus(SubTaskStatusEnum.ABORTED);
				taskService.update(t);
			}
		}
		dbBean.setStatus(TaskStatusEnum.ABORTED);
		dbBean.setChildStatus(SubTaskStatusEnum.ABORTED);
		result = taskService.update(dbBean);
		taskLogService.save("中止工作", dbBean.getId(),dbBean.getProgress());
		return JSON;
	}
	
	public String progress(){
		Task dbBean = taskService.getBeanById(id).getValue();
		if(progress==100){
			dbBean.setStatus(TaskStatusEnum.FINISHED);
			dbBean.setChildStatus(SubTaskStatusEnum.FINISHED);
			taskLogService.save("工作已完成",id,dbBean.getProgress());
		}
		dbBean.setProgress(progress);
		result = taskService.update(dbBean);
		taskLogService.save("将工作进度设为"+progress+"%", dbBean.getId(),progress);
		
		List<Task> taskList = taskService.getListByFilter(new Filter(Task.class).eq("parentId", id).notNull("receiverId")).getValue();
		if(taskList.size()>0 && taskList!=null){
			for(Task t : taskList){
				if(progress==100){
					t.setStatus(TaskStatusEnum.FINISHED);
					t.setChildStatus(SubTaskStatusEnum.FINISHED);
				}
				t.setProgress(progress);
				taskService.update(t);
			}
		}
		return JSON;
	}
	
	public String high(){
		Task dbBean = taskService.getBeanById(id).getValue();
		dbBean.setPriority(PriorityEnum.HIGH);
		result = taskService.update(dbBean);
		taskLogService.save("将工作级别设为高级", dbBean.getId(),dbBean.getProgress());
		
		List<Task> taskList = taskService.getListByFilter(new Filter(Task.class).eq("parentId", id).notNull("receiverId")).getValue();
		if(taskList.size()>0 && taskList!=null){
			for(Task t : taskList){
				t.setPriority(PriorityEnum.HIGH);
				taskService.update(t);
			}
		}
		return JSON;
	}
	public String middle(){
		Task dbBean = taskService.getBeanById(id).getValue();
		dbBean.setPriority(PriorityEnum.MIDDLE);
		result = taskService.update(dbBean);
		taskLogService.save("将工作级别设为中级", dbBean.getId(),dbBean.getProgress());
		
		List<Task> taskList = taskService.getListByFilter(new Filter(Task.class).eq("parentId", id).notNull("receiverId")).getValue();
		if(taskList.size()>0 && taskList!=null){
			for(Task t : taskList){
				t.setPriority(PriorityEnum.MIDDLE);
				taskService.update(t);
			}
		}
		return JSON;
	}
	public String low(){
		Task dbBean = taskService.getBeanById(id).getValue();
		dbBean.setPriority(PriorityEnum.LOW);
		result = taskService.update(dbBean);
		taskLogService.save("将工作级别设为低级", dbBean.getId(),dbBean.getProgress());
		
		List<Task> taskList = taskService.getListByFilter(new Filter(Task.class).eq("parentId", id).notNull("receiverId")).getValue();
		if(taskList.size()>0 && taskList!=null){
			for(Task t : taskList){
				t.setPriority(PriorityEnum.LOW);
				taskService.update(t);
			}
		}
		return JSON;
	}
	
	
	private HttpSession getSession(){
		return ServletActionContext.getRequest().getSession();
	}
	
	@SuppressWarnings("unchecked")
	private List<TaskAtt> getSessionTaskAttList(){
		HttpSession session = getSession();
		return (List<TaskAtt>) session.getAttribute("taskAttList");
	}
	
	public String add(){
		getSession().removeAttribute("taskAttList");
		taskDepartList = taskDepartService.getList().getValue();
		taskProjectList = taskProjectService.getList().getValue();
		userOrgId = OaActivator.getSessionUser().getOrg().getId();
		return "add";
	}
	
	public String save(){
		/*if(task.getProgress()==null) task.setProgress(0);
		String[] departIds = ServletActionContext.getRequest().getParameterValues("ids");
		if(sendIds.split(",").length > 0){
			task.setReceiverIds(sendIds);
			task.setReceiverId(null);
			setPromotTime(task);
			taskService.save(task);
			for(String id : sendIds.split(",")){
				Long userId = Long.parseLong(id);
				Task newTask = new Task();
				BeanUtil.copyProperties(task, newTask);
				newTask.setId(null);
				newTask.setPromotTime(task.getPromotTime());
				newTask.setParentId(task.getId());
				newTask.setReceiverId(userId);
				newTask.setReceiverIds(null);
				if(userId.equals(OaActivator.getSessionUser().getId())){
					newTask.setChildStatus(SubTaskStatusEnum.SIGNED);
				}else{
					newTask.setChildStatus(SubTaskStatusEnum.PENDING);
				}
				setPromotTime(newTask);
				result = taskService.save(newTask,getSessionTaskAttList(),departIds,sendIds);
				Task t2 = (Task)result.getValue();
				if(userId.equals(OaActivator.getSessionUser().getId())){
					taskLogService.save("工作已签收",t2.getId(),t2.getProgress());
				}else{
					taskLogService.save("工作未签收", t2.getId(),t2.getProgress(),userId);
				}
				getSession().removeAttribute("taskAttList");
				
			}
		}*/
		String[] departIds = ServletActionContext.getRequest().getParameterValues("ids");
		if(task.getProgress()==null) task.setProgress(0);
		task.setReceiverIds(null);
		setPromotTime(task);
		task.setReceiverId(OaActivator.getSessionUser().getId());
		task.setChildStatus(SubTaskStatusEnum.SIGNED);
		result = taskService.save(task,getSessionTaskAttList(),departIds,sendIds);
		taskLogService.save("新建工作", task.getId(),task.getProgress());
		return JSON;
	}
	
	private void setPromotTime(Task task){
		if(task.getPromot()!=null && !task.getPromot().equals(PromotEnum.NOPROMOT)){
			if(task.getStartTime()==null) return;
			String time = DateUtil.format(task.getStartTime());
			switch (task.getPromot()) {
			case LASTDAY:
			case CURRENTDAY:
				time += " "+task.getPromotDetail();
				break;
			case SPECIALDAY:
				time += task.getPromotDetail();
				break;
			}
			task.setPromotTime(DateUtil.parse(task.getPromotDetail(),"yyyy-MM-dd HH"));
		}
	}
	
	public String view(){
		Task task = taskService.getBeanById(id).getValue();
		if(task.getParentId()!=null){
			Task parentTask = taskService.getBeanById(task.getParentId()).getValue();
			creator = parentTask.getCreator();
		}else{
			creator = task.getCreator();
		}
		Boolean isSelf = false;
		if(creator.equals(OaActivator.getSessionUser().getRealName())){
			isSelf = true;
		}
		List<String> newDepList = new ArrayList<String>();
		for(TaskDepartConfig tdc : task.getDepartConfigs()){
			newDepList.add(tdc.getDepart().getName());
		}
		ServletActionContext.getRequest().setAttribute("newDepList", newDepList);
		ServletActionContext.getRequest().setAttribute("isSelf", isSelf);
		if(task.getProjectId()!=null){
			String projectName = taskProjectService.getBeanById(task.getProjectId()).getValue().getName();
			ServletActionContext.getRequest().setAttribute("projectName", projectName);
		}
		List<TaskLog> logList = taskLogService.getListByFilter(new Filter(TaskLog.class).eq("taskId", id)).getValue();
		taskLogList = new ArrayList<TaskLog>();
		for(TaskLog taskLog : logList){
			if (taskLog.getMemo() != null) {
				if(taskLog.getMemo().equals("工作已签收")){
					taskLogList.add(taskLog);
				}else if(taskLog.getMemo().equals("中止工作")){
					taskLogList.add(taskLog);
				}else if(taskLog.getMemo().equals("完成工作")){
					taskLogList.add(taskLog);
				}
			}
		}
		if(task.getReceiverId()==null){
			taskLogList=null;
			executor = "";
			for(String exeId : task.getReceiverIds().split(",")){
				User user = OaActivator.getUserById(Long.parseLong(exeId));
				executor += user.getRealName()+",";
			}
			executor = executor.substring(0, executor.length()-1);
		}
		if(task.getAtts().size()==0) task.setAtts(null);
		result = Result.value(task);
		return VIEW;
	}
	
	public String edit(){
		add();
		Task task = taskService.getBeanById(id).getValue();
		if(task.getParentId()!=null){
			Task parentTask = taskService.getBeanById(task.getParentId()).getValue();
			creator = parentTask.getCreator();
		}else{
			creator = task.getCreator();
		}
		getSession().setAttribute("taskAttList", new ArrayList<TaskAtt>(task.getAtts()));
		result = Result.value(task);
		return EDIT;
	}
	
	public String update(){
		Task dbBean = taskService.getBeanById(task.getId()).getValue();
		if(task.getEmail()==null)task.setEmail(BooleanEnum.NO);
		if(task.getDefaultEmail()==null)task.setDefaultEmail(BooleanEnum.NO);
		if(task.getSms()==null)task.setSms(BooleanEnum.NO);
		BeanUtil.copyProperties(task, dbBean);
		if(task.getProjectId()==null){
			dbBean.setProject(null);
			dbBean.setProjectId(null);
		}
		String[] departIds = ServletActionContext.getRequest().getParameterValues("ids");
		setPromotTime(dbBean);
		result = taskService.update(dbBean,departIds);
		taskLogService.save("更新工作", dbBean.getId(),dbBean.getProgress());
		getSession().removeAttribute("taskAttList");
		
		List<Task> taskList = taskService.getListByFilter(new Filter(Task.class).eq("parentId", task.getId()).notNull("receiverId")).getValue();
		if(taskList.size()>0 && taskList!=null){
			for(Task t : taskList){
				Long childId = t.getId();
				BeanUtil.copyProperties(task, t);
				t.setId(childId);
				taskService.update(t,departIds);
				getSession().removeAttribute("taskAttList");
			}
		}
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			List<TaskLog> taskLog = taskLogService.getListByFilter(new Filter(TaskLog.class).eq("taskId", id)).getValue();
			String logIds = "";
			if(taskLog!=null && taskLog.size()>0){
				for(TaskLog log : taskLog){
					logIds += log.getId()+",";
				}
				String myIds = logIds.substring(0,logIds.length()-1);
				taskLogService.deleteByIds(myIds);
				List<TaskDepartConfig> tdcList = taskDepartConfigService.getListByFilter(new Filter(TaskDepartConfig.class).eq("taskId", id)).getValue();
				String tdcIds = "";
				if(tdcList.size()>0 && tdcList!=null){
					for(TaskDepartConfig tdc : tdcList){
						tdcIds += tdc.getId()+",";
					}
					tdcIds = tdcIds.substring(0,tdcIds.length()-1);
					taskDepartConfigService.deleteByIds(tdcIds);
				}
				List<TaskAtt> taskAttList = taskAttService.getListByFilter(new Filter(TaskAtt.class).eq("taskId", id)).getValue();
				String attIds = "";
				if(taskAttList.size()>0 && taskAttList!=null){
					for(TaskAtt att : taskAttList){
						attIds += att.getId()+",";
					}
					attIds = attIds.substring(0,attIds.length()-1);
					taskAttService.deleteByIds(attIds);
				}
				result = taskService.deleteById(id);
			}else{
				List<TaskDepartConfig> tdcList = taskDepartConfigService.getListByFilter(new Filter(TaskDepartConfig.class).eq("taskId", id)).getValue();
				String tdcIds = "";
				if(tdcList.size()>0 && tdcList!=null){
					for(TaskDepartConfig tdc : tdcList){
						tdcIds += tdc.getId()+",";
					}
					tdcIds = tdcIds.substring(0,tdcIds.length()-1);
					taskDepartConfigService.deleteByIds(tdcIds);
				}
				List<TaskAtt> taskAttList = taskAttService.getListByFilter(new Filter(TaskAtt.class).eq("taskId", id)).getValue();
				String attIds = "";
				if(taskAttList.size()>0 && taskAttList!=null){
					for(TaskAtt att : taskAttList){
						attIds += att.getId()+",";
					}
					attIds = attIds.substring(0,attIds.length()-1);
					taskAttService.deleteByIds(attIds);
				}
				result = taskService.deleteById(id);
			}
		} else if(ids!=null){
			result = taskService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(Task.class).eq("id", id);
		return refresh(filter);
	}
	
	//我的派出工作
	public String mySendTaskList(){
		String userIds = OaActivator.getSessionUser().getId()+"";
		Filter filter = new Filter(Task.class);
		if(page!=0){
			pager = new Pager(page,7);
		} else {
			pager = new Pager(1,7);
		}
		filter.pager(pager);
		filter.orderBy("modifyTime", Filter.DESC);
		filter.eq("creator", OaActivator.getSessionUser().getRealName()).isNull("receiverId").ne("receiverIds", userIds);
		sendList = taskService.getListByFilter(filter).getValue();
		
		//根据父工作,找出所有子工作
		List<Task> list = taskService.getListByFilter(new Filter(Task.class).notNull("parentId").notNull("receiverId")).getValue();
		Map<Long,List<Task>> childTaskMap = new HashMap<Long, List<Task>>();
		if(sendList.size()>0 && sendList!=null){
			if(list.size()>0 && list!=null){
				for(Task parentTask : sendList){
					List<Task> newList = new ArrayList<Task>();
					for(Task task : list){
						if(task.getParentId().equals(parentTask.getId())){
							newList.add(task);
						}
					}
					childTaskMap.put(parentTask.getId(), newList);
				}
			}
		
			taskDtoList = new ArrayList<TaskDto>();
			for(Task t : sendList){
				TaskDto dto = new TaskDto();
				dto.setTask(t);
				//List<Task> childTaskList = taskService.getListByFilter(new Filter(Task.class).eq("parentId", t.getId()).notNull("receiverId")).getValue();
				List<Task> childTaskList = childTaskMap.get(t.getId());
				dto.setChildTaskList(childTaskList);
				taskDtoList.add(dto);
			}
		}
		return "mySendTaskList";
	}
	
	//我未签收的工作
	public String myPendingList(){
		Filter filter = new Filter(Task.class);
		if(page!=0){
			pager = new Pager(page,3);
		} else {
			pager = new Pager(1,3);
		}
		filter.pager(pager);
		filter.orderBy("modifyTime", Filter.DESC);
		filter.eq("receiverId", OaActivator.getSessionUser().getId()).eq("childStatus", SubTaskStatusEnum.PENDING);
		pendingList = taskService.getListByFilter(filter).getValue();
		
		//根据任务parentId找到父级任务
		List<Task> allTaskList = taskService.getListByFilter(new Filter(Task.class)).getValue();
		Map<Long,Task> myParentTaskMap = new HashMap<Long, Task>();
		if(pendingList.size()>0 && pendingList!=null){
			for(Task allTask : allTaskList){
				for(Task myPendingTask : pendingList){
					if(myPendingTask.getParentId()!=null){
						if(myPendingTask.getParentId().equals(allTask.getId())){
							myParentTaskMap.put(myPendingTask.getParentId(), allTask);
						}
					}
				}
			}
			//如果有转交记录,找出对应的数据
			String memo = "将工作转交给"+OaActivator.getSessionUser().getRealName();
			List<TaskLog> taskLogList = taskLogService.getListByFilter(new Filter(TaskLog.class).eq("memo", memo)).getValue();
			Map<Long,TaskLog> taskLogMap = new HashMap<Long, TaskLog>();
			if(taskLogList.size()>0 && taskLogList!=null){
				for(Task allTask : allTaskList){
					for(TaskLog log : taskLogList){
						if(log.getTaskId()==allTask.getId()){
							taskLogMap.put(log.getTaskId(), log);
						}
					}
				}
			}
			pengdingDtoList = new ArrayList<TaskDto>();
			for(Task t :pendingList){
				TaskDto dto = new TaskDto();
				dto.setTask(t);
				if(t.getParentId()!=null){
					String parentCreator = myParentTaskMap.get(t.getParentId()).getCreator();
					dto.setName(parentCreator);
				}else{
					dto.setName(t.getCreator());
				}
				TaskLog log = taskLogMap.get(t.getId());
				if(log!=null){
					dto.setPriorityName(log.getExecuteUserName());
				}
				pengdingDtoList.add(dto);
			}
		}
		return "myPendingList";
	}
	
	//我待办的工作
	public String myWorkList(){
		taskList = taskService.getListByFilter(new Filter(Task.class).eq("receiverId", OaActivator.getSessionUser().getId()).eq("childStatus", SubTaskStatusEnum.SIGNED).notIn("status", TaskStatusEnum.FINISHED).orderBy("endTime", "asc")).getValue();
		
		//查询所有待办任务的部门集合
		List<TaskDepartConfig> tdcList = taskDepartConfigService.getListByFilter(new Filter(TaskDepartConfig.class).createAlias("task", "task").eq("task.receiverId", OaActivator.getSessionUser().getId()).eq("task.childStatus", SubTaskStatusEnum.SIGNED).notIn("task.status", TaskStatusEnum.FINISHED)).getValue();
		//将对应的待办任务的部门放到map中
		Map<Long,List<TaskDepartConfig>> departMap = new HashMap<Long, List<TaskDepartConfig>>();
		if(taskList.size()>0 && taskList!=null){
			for(Task t : taskList){
				List<TaskDepartConfig> list = new ArrayList<TaskDepartConfig>();
				for(TaskDepartConfig tdc : tdcList){
					if(t.getId().equals(tdc.getTaskId())){
						list.add(tdc);
					}
				}
				departMap.put(t.getId(), list);
			}
			
			//根据子任务Id找到父任务
			List<Task> allTaskList = taskService.getListByFilter(new Filter(Task.class)).getValue();
			Map<Long,Task> myParentTaskMap = new HashMap<Long, Task>();
			for(Task myTask : taskList){
				for(Task allTask : allTaskList){
					if(myTask.getParentId()!=null && myTask.getParentId().equals(allTask.getId())){
						myParentTaskMap.put(myTask.getId(), allTask);
					}
				}
			}
			
			
			//匹配每个任务对应的已经签收的日志
			List<TaskLog> myTaskLogList = taskLogService.getListByFilter(new Filter(TaskLog.class).eq("memo", "工作已签收").createAlias("task", "task").eq("task.receiverId", OaActivator.getSessionUser().getId()).eq("task.childStatus", SubTaskStatusEnum.SIGNED).notIn("task.status", TaskStatusEnum.FINISHED)).getValue();
			Map<Long,TaskLog> taskLogMap = new HashMap<Long, TaskLog>();
			if(myTaskLogList.size()>0 && myTaskLogList!=null){
				for(Task t : taskList){
					for(TaskLog log : myTaskLogList){
						if(t.getId().equals(log.getTaskId())){
							taskLogMap.put(t.getId(), log);
						}
					}
				}
			}
			//创建待办任务显示信息
			taskWorkDtoList = new ArrayList<TaskDto>();
			for(Task t : taskList){
				TaskDto dto = new TaskDto();
				dto.setTask(t);
				TaskLog log = taskLogMap.get(t.getId());
				if(log!=null){
					dto.setSignedDate(log.getCreateTime());
				}
				List<TaskDepartConfig> tdc = departMap.get(t.getId());
				if(tdc!=null && tdc.size()>0){
					String taskDepart = "";
					String depIds = "";
					for(TaskDepartConfig config : tdc){
						taskDepart += config.getDepart().getName()+",";
						depIds += config.getDepart().getId()+",";
					}
					taskDepart = taskDepart.substring(0, taskDepart.length()-1);
					depIds = depIds.substring(0, depIds.length()-1);
					dto.setTaskDepart(taskDepart);
					dto.setDepIds(depIds);
				}
				dto.setDay(ScheduleUtil.getDiffDays(new Date(),t.getEndTime()));
				if(t.getParentId()!=null){
					String creator = myParentTaskMap.get(t.getId()).getCreator();
					dto.setName(creator);
				}else{
					dto.setName(t.getCreator());
				}
				taskWorkDtoList.add(dto);
			}
		}
		return "myWork";
	}
	
	
	public String signed(){
		Task task = taskService.getBeanById(id).getValue();
		task.setChildStatus(SubTaskStatusEnum.SIGNED);
		taskLogService.save("工作已签收",id,task.getProgress());
		result = taskService.update(task);
		return JSON;
	}
	
	public String finished(){
		Task dbBean = taskService.getBeanByFilter(new Filter(Task.class).eq("id", id)).getValue();
		dbBean.setFinishTime(new Date());
		dbBean.setStatus(TaskStatusEnum.FINISHED);
		dbBean.setChildStatus(SubTaskStatusEnum.FINISHED);
		dbBean.setProgress(100);
		taskLogService.save("完成工作",id,dbBean.getProgress());
		result = taskService.update(dbBean);
		result.setMsg(R.Task.FINISH);
		
		List<Task> taskList = taskService.getListByFilter(new Filter(Task.class).eq("parentId", id).notNull("receiverId")).getValue();
		if(taskList.size()>0 && taskList!=null){
			for(Task t : taskList){
				t.setFinishTime(new Date());
				t.setStatus(TaskStatusEnum.FINISHED);
				t.setChildStatus(SubTaskStatusEnum.FINISHED);
				t.setProgress(100);
				taskService.update(t);
			}
		}
		
		return JSON;
	}
	//完成工作
	public String finish(){
		//显示当前周和前四周的日期,完成数量,中止数量
		List<WeekDto> weekDtoList = ScheduleUtil.currWeek();
		finishWorkDtoList = new ArrayList<FinishWorkDto>();
		for(WeekDto weekDto : weekDtoList){
			FinishWorkDto dto = new FinishWorkDto();
			Date start = weekDto.getDateList().get(0);
			Date end = weekDto.getDateList().get(weekDto.getDateList().size()-1);
			List<Task> list = taskService.getListByFilter(new Filter(Task.class).eq("status", TaskStatusEnum.FINISHED).eq("receiverId", OaActivator.getSessionUser().getId()).between("modifyTime", start, end)).getValue();
			Integer finishNum = list.size();
			List<Task> list2 = taskService.getListByFilter(new Filter(Task.class).eq("status", TaskStatusEnum.ABORTED).eq("receiverId", OaActivator.getSessionUser().getId()).between("modifyTime", start, end)).getValue();
			Integer abortedNum = list2.size();
			List<Date> dateList = new ArrayList<Date>();
			for(Date date : weekDto.getDateList()){
				dateList.add(date);
			}
			dto.setDateList(dateList);
			dto.setAbortedNum(abortedNum);
			dto.setFinishNum(finishNum);
			dto.setWeek(weekDto.getWeek());
			finishWorkDtoList.add(dto);
		}
		curYear = Integer.parseInt(DateUtil.format(new Date(),"yyyy"));
		curMonth = Integer.parseInt(DateUtil.format(new Date(),"M"));
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		week = cal.get(Calendar.WEEK_OF_YEAR);
		years = new ArrayList<Integer>();
		for(int n=(curYear-5);n<(curYear+2);n++){
			years.add(n);
		}
		months = new ArrayList<Integer>();
		for(int m=1;m<13;m++){
			months.add(m);
		}
		return "finishWork";
	}
	
	public String taskXML(){
		List<WeekDto> weekDtoList = ScheduleUtil.currWeek();
		finishWorkDtoList = new ArrayList<FinishWorkDto>();
		for(WeekDto weekDto : weekDtoList){
			FinishWorkDto dto = new FinishWorkDto();
			Date start = weekDto.getDateList().get(0);
			Date end = weekDto.getDateList().get(weekDto.getDateList().size()-1);
			List<Task> list = taskService.getListByFilter(new Filter(Task.class).eq("status", TaskStatusEnum.FINISHED).eq("receiverId", OaActivator.getSessionUser().getId()).between("modifyTime", start, end)).getValue();
			Integer finishNum = list.size();
			List<Task> list2 = taskService.getListByFilter(new Filter(Task.class).eq("status", TaskStatusEnum.ABORTED).eq("receiverId", OaActivator.getSessionUser().getId()).between("modifyTime", start, end)).getValue();
			Integer abortedNum = list2.size();
			List<Date> dateList = new ArrayList<Date>();
			for(Date date : weekDto.getDateList()){
				dateList.add(date);
			}
			dto.setDateList(dateList);
			dto.setAbortedNum(abortedNum);
			dto.setFinishNum(finishNum);
			dto.setWeek(weekDto.getWeek());
			finishWorkDtoList.add(dto);
		}
		 StringBuffer sb=new StringBuffer();
		 int i = 0;
		 for(FinishWorkDto dto : finishWorkDtoList){
			 i+=dto.getFinishNum();
		 }
		 if(i==0){
			 sb.append("<graph showNames='1' decimalPrecision='0' formatNumberScale='0' showLimits='1' showhovercap='1' yAxisMaxValue='5'>\n");
		 }else{
			 sb.append("<graph showNames='1' decimalPrecision='0' formatNumberScale='0' showLimits='1' showhovercap='1' yAxisMaxValue='5'>\n");
		 }
		 for(FinishWorkDto dto : finishWorkDtoList){
			 sb.append("\n"+"   <set name='第"+dto.getWeek()+"周'  value='"+dto.getFinishNum()+"' color='#FF4040'/>");
		}
		 sb.append("\n</graph>");
		 try {
			 ServletActionContext.getResponse().setContentType("text/html;charset=gb2312");
			 PrintWriter writer=ServletActionContext.getResponse().getWriter();
			 writer.write(sb.toString());
			 writer.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//部门工作
	public String depList(){
		int i = 0;//待办
		int o = 0;//逾期
		taskDepartList = taskDepartService.getList().getValue();
		List<TaskDepartConfig> allTdcList = taskDepartConfigService.getList().getValue();
		Map<Long,List<TaskDepartConfig>> tdcMap = new HashMap<Long, List<TaskDepartConfig>>();
		for (TaskDepart taskDepart : taskDepartList) {
			List<TaskDepartConfig> tdcConfigList = new ArrayList<TaskDepartConfig>();
			for(TaskDepartConfig tdc : allTdcList){
				if(taskDepart.getId().equals(tdc.getDepartId())){
					tdcConfigList.add(tdc);
				}
			}
			tdcMap.put(taskDepart.getId(), tdcConfigList);
		}
		
		//所有部门集合,以及待办任务数目
		departDtoList = new ArrayList<TaskDepartDto>();
		for (TaskDepart taskDepart : taskDepartList) {
			TaskDepartDto tDto = new TaskDepartDto();
			//List<TaskDepartConfig> tdcList = taskDepartConfigService.getListByFilter(new Filter(TaskDepartConfig.class).eq("departId",taskDepart.getId())).getValue();
			List<TaskDepartConfig> tdcList = tdcMap.get(taskDepart.getId());
			if(tdcList!=null && tdcList.size()>0){
				for(TaskDepartConfig tdc : tdcList){
					Task task = taskService.getBeanById(tdc.getTaskId()).getValue();
					if(task.getChildStatus()!=null){
						if(task.getChildStatus().equals(SubTaskStatusEnum.SIGNED)||task.getChildStatus().equals(SubTaskStatusEnum.PENDING)){
							i++;
						}
						if(((new Date()).getTime()-task.getEndTime().getTime())>0 && !task.getChildStatus().equals(SubTaskStatusEnum.FINISHED) && !task.getChildStatus().equals(SubTaskStatusEnum.ABORTED)){
							o++;
						}
					}
				}
			}
			tDto.setDepart(taskDepart);
			tDto.setUnfinish(i);
			tDto.setOverdue(o);
			departDtoList.add(tDto);
			i = 0;o = 0;
		}
		
		curYear = Integer.parseInt(DateUtil.format(new Date(),"yyyy"));
		curMonth = Integer.parseInt(DateUtil.format(new Date(),"M"));
		years = new ArrayList<Integer>();
		for(int n=(curYear-5);n<(curYear+2);n++){
			years.add(n);
		}
		months = new ArrayList<Integer>();
		for(int m=1;m<13;m++){
			months.add(m);
		}
		return "depList";
	}
	
	public String departXML(){

		 try {
			 int i = 0;//待办
			 int o = 0;//逾期
			 taskDepartList = taskDepartService.getList().getValue();
			 List<TaskDepartConfig> allTdcList = taskDepartConfigService.getList().getValue();
				Map<Long,List<TaskDepartConfig>> tdcMap = new HashMap<Long, List<TaskDepartConfig>>();
				for (TaskDepart taskDepart : taskDepartList) {
					List<TaskDepartConfig> tdcConfigList = new ArrayList<TaskDepartConfig>();
					for(TaskDepartConfig tdc : allTdcList){
						if(taskDepart.getId().equals(tdc.getDepartId())){
							tdcConfigList.add(tdc);
						}
					}
					tdcMap.put(taskDepart.getId(), tdcConfigList);
				}
				//所有部门集合,以及待办任务数目
				departDtoList = new ArrayList<TaskDepartDto>();
				for (TaskDepart taskDepart : taskDepartList) {
					TaskDepartDto tDto = new TaskDepartDto();
				//	List<TaskDepartConfig> tdcList = taskDepartConfigService.getListByFilter(new Filter(TaskDepartConfig.class).eq("departId",taskDepart.getId())).getValue();
					List<TaskDepartConfig> tdcList = tdcMap.get(taskDepart.getId());
					if(tdcList!=null && tdcList.size()>0){
						for(TaskDepartConfig tdc : tdcList){
							Task task = taskService.getBeanById(tdc.getTaskId()).getValue();
							if(task.getChildStatus()!=null){
								if(task.getChildStatus().equals(SubTaskStatusEnum.SIGNED)||task.getChildStatus().equals(SubTaskStatusEnum.PENDING)){
									i++;
								}
								if(((new Date()).getTime()-task.getEndTime().getTime())>0 && !task.getChildStatus().equals(SubTaskStatusEnum.FINISHED) && !task.getChildStatus().equals(SubTaskStatusEnum.ABORTED)){
									o++;
								}
							}
						}
					}
					tDto.setDepart(taskDepart);
					tDto.setUnfinish(i);
					tDto.setOverdue(o);
					departDtoList.add(tDto);
					i = 0;o = 0;
				}
			 StringBuffer sb=new StringBuffer();
			 int num = 0;
			 for(TaskDepartDto dto : departDtoList){
				 num += dto.getUnfinish();
			 }
			 if(num==0){
				 sb.append("<graph showNames='1' decimalPrecision='0' formatNumberScale='0' showLimits='1' showhovercap='1' yAxisMaxValue='5'>\n");
			 }else{
				 sb.append("<graph showNames='1' decimalPrecision='0' formatNumberScale='0' showLimits='1' showhovercap='1' yAxisMaxValue='5'>\n");
			 }
			 for(TaskDepartDto dto : departDtoList){
				 sb.append("\n"+"   <set name='"+dto.getDepart().getName()+"' value='"+dto.getUnfinish()+"' color='#FF4040'/>");
			}
			 sb.append("\n</graph>");
			 ServletActionContext.getResponse().setContentType("text/html;charset=gb2312");
			 PrintWriter writer=ServletActionContext.getResponse().getWriter();
			 writer.write(sb.toString());
			 writer.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		 return null;
	}
	
	//项目工作
	public String projectList(){
		int f = 0;//完成数量
		int w = 0;//待办数量
		int s = 0;//中止数量
		int o = 0;//逾期数量
		taskProjectList = taskProjectService.getListByFilter(new Filter(TaskProject.class).eq("status", TaskProjectStatusEnum.NORMAL)).getValue();
		//所有项目集合,以及对应项目的待办,完成,中止数量
		projectDtoList = new ArrayList<TaskProjectDto>();
		List<Task> allTaskList = taskService.getListByFilter(new Filter(Task.class).notNull("receiverId")).getValue();
		Map<Long,List<Task>> taskMap = new HashMap<Long, List<Task>>();
		if(taskProjectList.size()>0 && taskProjectList!=null){
		for (TaskProject tp : taskProjectList) {
			List<Task> taskMapList = new ArrayList<Task>();
			for(Task t : allTaskList){
				if(tp.getId().equals(t.getProjectId())){
					taskMapList.add(t);
				}
			}
			taskMap.put(tp.getId(), taskMapList);
		}
		for(TaskProject tp : taskProjectList){
			TaskProjectDto dto = new TaskProjectDto();
			List<Task> taskList = taskMap.get(tp.getId());
			if(taskList!=null && taskList.size()>0){
				for(Task task : taskList){
					if(task.getChildStatus().equals(SubTaskStatusEnum.FINISHED)){
						f++;
					}
					if(task.getChildStatus().equals(SubTaskStatusEnum.SIGNED)||task.getChildStatus().equals(SubTaskStatusEnum.PENDING)){
						w++;
					}
					if(task.getChildStatus().equals(SubTaskStatusEnum.ABORTED)){
						s++;
					}
					if(((new Date()).getTime()-task.getEndTime().getTime())>0 && !task.getChildStatus().equals(SubTaskStatusEnum.FINISHED) && !task.getChildStatus().equals(SubTaskStatusEnum.ABORTED)){
						o++;
					}
				}
			}
			dto.setProject(tp);
			dto.setFinish(f);
			dto.setUnfinish(w);
			dto.setStop(s);
			dto.setOverdue(o);
			
			projectDtoList.add(dto);
			f=0;w=0;s=0;o=0;
		}
		}
		
		curYear = Integer.parseInt(DateUtil.format(new Date(),"yyyy"));
		curMonth = Integer.parseInt(DateUtil.format(new Date(),"M"));
		years = new ArrayList<Integer>();
		for(int n=(curYear-5);n<(curYear+2);n++){
			years.add(n);
		}
		months = new ArrayList<Integer>();
		for(int m=1;m<13;m++){
			months.add(m);
		}
		return "projectList";
	}
	
	public String projectXML(){
		int f = 0;//完成数量
		int w = 0;//待办数量
		int s = 0;//中止数量
		int o = 0;//逾期数量
		taskProjectList = taskProjectService.getListByFilter(new Filter(TaskProject.class).eq("status", TaskProjectStatusEnum.NORMAL)).getValue();
		//所有项目集合,以及对应项目的待办,完成,中止数量
		projectDtoList = new ArrayList<TaskProjectDto>();
		List<Task> allTaskList = taskService.getListByFilter(new Filter(Task.class).notNull("receiverId")).getValue();
		Map<Long,List<Task>> taskMap = new HashMap<Long, List<Task>>();
		for (TaskProject tp : taskProjectList) {
			List<Task> taskMapList = new ArrayList<Task>();
			for(Task t : allTaskList){
				if(tp.getId().equals(t.getProjectId())){
					taskMapList.add(t);
				}
			}
			taskMap.put(tp.getId(), taskMapList);
		}
		projectDtoList = new ArrayList<TaskProjectDto>();
		for(TaskProject tp : taskProjectList){
			TaskProjectDto dto = new TaskProjectDto();
			//List<Task> taskList = taskService.getListByFilter(new Filter(Task.class).eq("projectId", tp.getId()).notNull("receiverId")).getValue();
			List<Task> taskList = taskMap.get(tp.getId());
			if(taskList!=null && taskList.size()>0){
				for(Task task : taskList){
					if(task.getChildStatus().equals(SubTaskStatusEnum.FINISHED)){
						f++;
					}
					if(task.getChildStatus().equals(SubTaskStatusEnum.SIGNED)||task.getChildStatus().equals(SubTaskStatusEnum.PENDING)){
						w++;
					}
					if(task.getChildStatus().equals(SubTaskStatusEnum.ABORTED)){
						s++;
					}
					if(((new Date()).getTime()-task.getEndTime().getTime())>0 && !task.getChildStatus().equals(SubTaskStatusEnum.FINISHED) && !task.getChildStatus().equals(SubTaskStatusEnum.ABORTED)){
						o++;
					}
				}
			}
			dto.setProject(tp);
			dto.setFinish(f);
			dto.setUnfinish(w);
			dto.setStop(s);
			dto.setOverdue(o);
			
			projectDtoList.add(dto);
			f=0;w=0;s=0;o=0;
		}
		 StringBuffer sb=new StringBuffer();
		 int num = 0;
		 for(TaskProjectDto dto : projectDtoList){
			 num += dto.getUnfinish();
		 }
		 if(num==0){
			 sb.append("<graph showNames='1' decimalPrecision='0' formatNumberScale='0' showLimits='1' showhovercap='1' yAxisMaxValue='5'>\n");
		 }else{
			 sb.append("<graph showNames='1' decimalPrecision='0' formatNumberScale='0' showLimits='1' showhovercap='1' yAxisMaxValue='5'>\n");
		 }
		 for(TaskProjectDto dto : projectDtoList){
			 sb.append("\n"+"   <set name='"+dto.getProject().getName()+"' value='"+dto.getUnfinish()+"' color='#FF4040'/>");
		}
		 sb.append("\n</graph>");
		 
		 try {
			 ServletActionContext.getResponse().setContentType("text/html;charset=gb2312");
			 PrintWriter writer=ServletActionContext.getResponse().getWriter();
			 writer.write(sb.toString());
			 writer.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//员工工作
	public String employeeList(){
		int u = 0;//待办
		int f = 0;//完成
		int s = 0;//终止
		employeeWorkDtoList = new ArrayList<EmployeeWorkDto>();
		taskList = taskService.getListByFilter(new Filter(Task.class).notNull("receiverId")).getValue();
		
		UserPubService userPubService=OaActivator.getService(UserPubService.class);
		List<User> centerUserList=userPubService.getCenterUserList2();
		//将员工对应的所有任务放入Map中
		Map<Long, List<Task>> userMap = new HashMap<Long, List<Task>>();
		if(taskList.size()>0 && taskList!=null){
			if(centerUserList.size()>0 && centerUserList!=null){
			for(User user : centerUserList){
				List<Task> ownTaskList = new ArrayList<Task>();
				for(Task task : taskList){
					if(task.getReceiverId().equals(user.getId())){
						ownTaskList.add(task);
					}
				}
				userMap.put(user.getId(), ownTaskList);
			}
			
			for(User user : centerUserList){
				EmployeeWorkDto dto = new EmployeeWorkDto();
				dto.setId(user.getId());
				dto.setName(user.getRealName());
				List<Task> userTaskList = userMap.get(user.getId());
				if(userTaskList.size()>0 && userTaskList!=null){
					for(Task t : userTaskList){//查找出待办,完成和终止的数量
						if(t.getChildStatus().equals(SubTaskStatusEnum.FINISHED)){
							f++;
						}
						if(t.getChildStatus().equals(SubTaskStatusEnum.SIGNED)||t.getChildStatus().equals(SubTaskStatusEnum.PENDING)){
							u++;
						}
						if(t.getChildStatus().equals(SubTaskStatusEnum.ABORTED)){
							s++;
						}
					}
				}
				dto.setFinish(f);
				dto.setUnfinish(u);
				dto.setStop(s);
				employeeWorkDtoList.add(dto);
				f=0;u=0;s=0;
			}
		  }
		}
		return "employeeList";
	}
	
	//我的完成工作列表
	public String viewFinishWork(){
		if(week!=null){
			taskList = new ArrayList<Task>();
			List<WeekDto> weekDto = ScheduleUtil.currWeek();
			if(weekDto.size()>0 && weekDto!=null){
				for(WeekDto dto: weekDto){
					if(week == dto.getWeek()){
						dateList = dto.getDateList();
					}
				}
			}
		if(title!=null || curYear!=null || curMonth!=null){//条件查询
			try {
				title = new String(title.getBytes("ISO8859_1"),"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			if(title.equals("无上良品")){
				title=null;
			}
			taskList = searchTask(title,curYear,curMonth);
		}else{
			if(dateList!=null&&dateList.size()>0){
				Date startTime = dateList.get(0);
				Date endTime = dateList.get(6);
				taskList = taskService.getListByFilter(new Filter(Task.class).eq("receiverId", OaActivator.getSessionUser().getId()).in("status", TaskStatusEnum.FINISHED,TaskStatusEnum.ABORTED).between("modifyTime", startTime, endTime).orderBy("endTime", "asc")).getValue();
			}
		}
		
		taskWorkDtoList = new ArrayList<TaskDto>();
		for(Task t : taskList){
			TaskDto dto = new TaskDto();
			dto.setId(t.getId());
			if(t.getParentId()!=null){
				dto.setName(taskService.getBeanById(t.getParentId()).getValue().getCreator());
			}else{
				dto.setName(t.getCreator());
			}
			dto.setTitle(t.getTitle());
			dto.setChildStatus(t.getChildStatus());
			dto.setCreateTime(t.getCreateTime());
			dto.setProgress(t.getProgress());
			dto.setStatus(t.getStatus());
			dto.setStartTime(t.getStartTime());
			dto.setAtts(t.getAtts());
			dto.setPriority(t.getPriority());
			dto.setTask(t);
			TaskLog log = taskLogService.getBeanByFilter(new Filter(TaskLog.class).eq("taskId", t.getId()).eq("memo", "工作已签收")).getValue();
			if(log!=null){
				dto.setSignedDate(log.getCreateTime());
			}
			List<TaskDepartConfig> tdc = taskDepartConfigService.getListByFilter(new Filter(TaskDepartConfig.class).eq("taskId", t.getId())).getValue();
			if(tdc.size()>0){
				String taskDepart = "";
				String depIds = "";
				for(TaskDepartConfig config : tdc){
					taskDepart += config.getDepart().getName()+",";
					depIds += config.getDepart().getId()+",";
				}
				taskDepart = taskDepart.substring(0, taskDepart.length()-1);
				depIds = depIds.substring(0, depIds.length()-1);
				dto.setTaskDepart(taskDepart);
				dto.setDepIds(depIds);
			}
			dto.setDay(ScheduleUtil.getDiffDays(new Date(),t.getEndTime()));
			taskWorkDtoList.add(dto);
		}
		}
		curYear = Integer.parseInt(DateUtil.format(new Date(),"yyyy"));
		curMonth = Integer.parseInt(DateUtil.format(new Date(),"M"));
		years = new ArrayList<Integer>();
		for(int n=(curYear-5);n<(curYear+2);n++){
			years.add(n);
		}
		months = new ArrayList<Integer>();
		for(int m=1;m<13;m++){
			months.add(m);
		}
		return "viewFinishWork";
	}
	
	//部门工作列表
	public String viewDepart(){
		if(id!=null){
			Filter filter = new Filter(TaskDepartConfig.class);
			if(page!=0){
				pager = new Pager(page,10);
			} else {
				pager = new Pager(1,10);
			}
			filter.pager(pager);
			filter.orderBy("modifyTime", Filter.ASC).eq("departId", id);
			List<TaskDepartConfig> tdcList = taskDepartConfigService.getListByFilter(filter).getValue();
			//根据部门id,找出对应的任务
			if(tdcList!=null && tdcList.size()>0){
				List<Task> tdcTaskList = taskService.getListByFilter(new Filter(Task.class).notNull("receiverId").orderBy("endTime", "asc")).getValue();
				Map<Long,Task> tdcTaskMap = new HashMap<Long, Task>();
				if(tdcTaskList.size()>0 && tdcTaskList!=null){
					for(TaskDepartConfig tdc : tdcList){
						for(Task task : tdcTaskList){
							if(task.getId().equals(tdc.getTaskId())){
								tdcTaskMap.put(tdc.getId(), task);
							}
						}
					}
				}
				//根据子任务ID 找出对应的父任务
				List<Task> allTaskList = taskService.getListByFilter(new Filter(Task.class)).getValue();
				Map<Long,Task> myParentTaskMap = new HashMap<Long, Task>();
				for(Task myTask : tdcTaskList){
					for(Task allTask : allTaskList){
						if(myTask.getParentId()!=null && myTask.getParentId().equals(allTask.getId())){
							myParentTaskMap.put(myTask.getId(), allTask);
						}
					}
				}
				//匹配每个任务已签收的记录
				List<TaskLog> logList = taskLogService.getListByFilter(new Filter(TaskLog.class).eq("memo","工作已签收")).getValue();
				Map<Long,TaskLog> logMap = new HashMap<Long, TaskLog>();
				if(logList.size()>0 && logList!=null){
					for(Task task : tdcTaskList){
						for(TaskLog log : logList){
							if(log.getTaskId().equals(task.getId())){
								logMap.put(task.getId(), log);
							}
						}
					}
				}
				//找出对应任务的所有所属部门配置
				List<TaskDepartConfig> allTdcList = taskDepartConfigService.getListByFilter(new Filter(TaskDepartConfig.class)).getValue();
				Map<Long,List<TaskDepartConfig>> departMap = new HashMap<Long, List<TaskDepartConfig>>();
				for(Task task : allTaskList){
					List<TaskDepartConfig> newList = new ArrayList<TaskDepartConfig>();
					for(TaskDepartConfig tdc : allTdcList){
						if(task.getId().equals(tdc.getTaskId())){
							newList.add(tdc);
						}
					}
					departMap.put(task.getId(), newList);
				}
				
				
				taskWorkDtoList = new ArrayList<TaskDto>();
				for (TaskDepartConfig tdc : tdcList) {
					task = new Task();
					if(title==null && curYear==null && curMonth==null && status==null){//所选部门
						//task = taskService.getBeanByFilter(new Filter(Task.class).eq("id", tdc.getTaskId()).notNull("receiverId").orderBy("endTime", "asc")).getValue();
						task = tdcTaskMap.get(tdc.getId());
					}
					TaskDto dto = new TaskDto();
					if(task!=null){
						//TaskLog log = taskLogService.getBeanByFilter(new Filter(TaskLog.class).eq("taskId", task.getId()).eq("memo", "工作已签收")).getValue();
						TaskLog log = logMap.get(task.getId());
						if(log!=null){
							dto.setSignedDate(log.getCreateTime());
						}
						//List<TaskDepartConfig> myList = taskDepartConfigService.getListByFilter(new Filter(TaskDepartConfig.class).eq("taskId", task.getId())).getValue();
						List<TaskDepartConfig> myList = departMap.get(task.getId());
						String taskDepart = "";
						String depIds = "";
						if(myList.size()>0 && myList!=null){
							for(TaskDepartConfig config : myList){
								if(config!=null){
									taskDepart += config.getDepart().getName()+",";
									depIds += config.getDepart().getId()+","; 
								}
							}
						}
						taskDepart = taskDepart.substring(0, taskDepart.length()-1);
						depIds = depIds.substring(0, depIds.length()-1);
						dto.setTaskDepart(taskDepart);
						dto.setDepIds(depIds);
						dto.setTask(task);
						dto.setDay(ScheduleUtil.getDiffDays(new Date(),task.getEndTime()));
						if(task.getParentId()!=null){
//							dto.setName(taskService.getBeanById(task.getParentId()).getValue().getCreator());
							String creator = myParentTaskMap.get(task.getId()).getCreator();
							dto.setName(creator);
						}else{
							dto.setName(task.getCreator());
						}
						taskWorkDtoList.add(dto);
					}
				}
			}
			//taskWorkDtoList = sortByDay(taskWorkDtoList);
		}
		curYear = Integer.parseInt(DateUtil.format(new Date(),"yyyy"));
		curMonth = Integer.parseInt(DateUtil.format(new Date(),"M"));
		years = new ArrayList<Integer>();
		for(int n=(curYear-5);n<(curYear+2);n++){
			years.add(n);
		}
		months = new ArrayList<Integer>();
		for(int m=1;m<13;m++){
			months.add(m);
		}
		return "viewDepart";
	}
	
	//项目工作列表
	public String viewProject(){
		if(id!=null){
			if(title!=null || curYear!=null || curMonth!=null){//条件查询
				try {
					title = new String(title.getBytes("ISO8859_1"),"UTF-8");
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
				if(title.equals("无上良品")){
					title=null;
				}
				taskList = searchProjectTask(id, title, curYear, curMonth);
			}else if(title==null && curYear==null && curMonth==null && status==null){//所选项目工作
				Filter filter = new Filter(Task.class);
				if(page!=0){
					pager = new Pager(page,10);
				} else {
					pager = new Pager(1,10);
				}
				filter.pager(pager);
				filter.eq("projectId", id).orderBy("endTime", "asc");
				//taskList = taskService.getListByFilter(new Filter(Task.class).eq("projectId", id).orderBy("endTime", "asc")).getValue();
				taskList = taskService.getListByFilter(filter).getValue();
			}
		}else{
			if(title!=null || curYear!=null || curMonth!=null){//条件查询
				try {
					title = new String(title.getBytes("ISO8859_1"),"UTF-8");
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
				if(title.equals("无上良品")){
					title=null;
				}
				taskList = searchProjectTask(id, title, curYear, curMonth);
			}
		}
		if(taskList!=null && taskList.size()>0){
			//根据子任务ID 找出对应的父任务
			List<Task> allTaskList = taskService.getListByFilter(new Filter(Task.class)).getValue();
			Map<Long,Task> myParentTaskMap = new HashMap<Long, Task>();
			for(Task myTask : taskList){
				for(Task allTask : allTaskList){
					if(myTask.getParentId()!=null && myTask.getParentId().equals(allTask.getId())){
						myParentTaskMap.put(myTask.getId(), allTask);
					}
				}
			}
			//匹配每个任务已签收的记录
			List<TaskLog> logList = taskLogService.getListByFilter(new Filter(TaskLog.class).eq("memo","工作已签收")).getValue();
			Map<Long,TaskLog> logMap = new HashMap<Long, TaskLog>();
			if(logList.size()>0 && logList!=null){
				for(Task task : taskList){
					for(TaskLog log : logList){
						if(log.getTaskId().equals(task.getId())){
							logMap.put(task.getId(), log);
						}
					}
				}
			}
			//根据任务id 找出对应的项目
			List<TaskProject> tpList = taskProjectService.getList().getValue();
			Map<Long,TaskProject> tpMap = new HashMap<Long, TaskProject>();
			if(tpList.size()>0 && tpList!=null){
				for(Task task : taskList){
					for(TaskProject tp : tpList){
						if(tp.getId().equals(task.getProjectId())){
							tpMap.put(task.getId(), tp);
						}
					}
				}
			}
			
			taskWorkDtoList = new ArrayList<TaskDto>();
			loop:for(Task task : taskList){
				if(task.getReceiverId()==null){
					continue loop;
				}
				TaskDto dto = new TaskDto();
				//TaskProject tp = taskProjectService.getBeanById(task.getProjectId()).getValue();
				TaskProject tp = tpMap.get(task.getId());
				if(tp!=null){
					dto.setName(tp.getName());
				}
				//TaskLog log = taskLogService.getBeanByFilter(new Filter(TaskLog.class).eq("taskId", task.getId()).eq("memo", "工作已签收")).getValue();
				TaskLog log = logMap.get(task.getId());
				if(log!=null){
					dto.setSignedDate(log.getCreateTime());
				}
				dto.setDay(ScheduleUtil.getDiffDays(new Date(),task.getEndTime()));
				dto.setTask(task);
				if(task.getParentId()!=null){
//					dto.setName(taskService.getBeanById(task.getParentId()).getValue().getCreator());
					String creator = myParentTaskMap.get(task.getId()).getCreator();
					dto.setName(creator);
				}else{
					dto.setName(task.getCreator());
				}
				taskWorkDtoList.add(dto);
			}
		}
		curYear = Integer.parseInt(DateUtil.format(new Date(),"yyyy"));
		curMonth = Integer.parseInt(DateUtil.format(new Date(),"M"));
		years = new ArrayList<Integer>();
		for(int n=(curYear-5);n<(curYear+2);n++){
			years.add(n);
		}
		months = new ArrayList<Integer>();
		for(int m=1;m<13;m++){
			months.add(m);
		}
		
		return "viewProject";
	}
	
	//员工工作列表
	public String viewEmployee(){
		Filter filter = new Filter(Task.class);
		if(page!=0){
			pager = new Pager(page,10);
		} else {
			pager = new Pager(1,10);
		}
		filter.pager(pager);
		filter.orderBy("status",  Filter.DESC);
		filter.orderBy("modifyTime", Filter.DESC);
		if(id!=null){
			if(title!=null || curYear!=null || curMonth!=null){
				try {
					title = new String(title.getBytes("ISO8859_1"),"UTF-8");
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
				if(title.equals("无上良品")){
					title=null;
				}
				taskList = searchEmployeeTask(title, curYear, curMonth);
			}else{
				//taskList = taskService.getListByFilter(new Filter(Task.class).eq("receiverId", id).orderBy("endTime", "asc")).getValue();
				filter.eq("receiverId", id).orderBy("endTime", "asc");
				taskList = taskService.getListByFilter(filter).getValue();
			}
		}else if(title!=null || curYear!=null || curMonth!=null){
			try {
				title = new String(title.getBytes("ISO8859_1"),"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			if(title.equals("无上良品")){
				title=null;
			}
			taskList = searchEmployeeTask(title, curYear, curMonth);
		}
		if(taskList!=null && taskList.size()>0){
			//找出每个任务对应的部门配置,并放入map中
			List<TaskDepartConfig> tdcList = taskDepartConfigService.getList().getValue();
			Map<Long,List<TaskDepartConfig>> tdcMap = new HashMap<Long, List<TaskDepartConfig>>();
			if(tdcList.size()>0 && tdcList!=null){
				for(Task task : taskList){
					List<TaskDepartConfig> newList = new ArrayList<TaskDepartConfig>();
					for(TaskDepartConfig tdc : tdcList){
						if(tdc.getTaskId().equals(task.getId())){
							newList.add(tdc);
						}
					}
					tdcMap.put(task.getId(), newList);
				}
			}
			
			//匹配每个任务已签收的记录
			List<TaskLog> logList = taskLogService.getListByFilter(new Filter(TaskLog.class).eq("memo","工作已签收")).getValue();
			Map<Long,TaskLog> logMap = new HashMap<Long, TaskLog>();
			if(logList.size()>0 && logList!=null){
				for(Task task : taskList){
					for(TaskLog log : logList){
						if(log.getTaskId().equals(task.getId())){
							logMap.put(task.getId(), log);
						}
					}
				}
			}
			
			//根据子任务ID 找出对应的任务
			List<Task> allTaskList = taskService.getListByFilter(new Filter(Task.class)).getValue();
			Map<Long,Task> myParentTaskMap = new HashMap<Long, Task>();
			for(Task myTask : taskList){
				for(Task allTask : allTaskList){
					if(myTask.getParentId()!=null && myTask.getParentId().equals(allTask.getId())){
						myParentTaskMap.put(myTask.getId(), allTask);
					}
				}
			}
			
			taskWorkDtoList = new ArrayList<TaskDto>();
			loop:for(Task task : taskList){
				if(task.getReceiverId()==null){
					continue loop;
				}
				TaskDto dto = new TaskDto();
				if(task.getDepartConfigs().size()>0 && task.getDepartConfigs()!=null){
					List<TaskDepartConfig> tdc = tdcMap.get(task.getId());
					if(tdc.size()>0){
						String taskDepart = "";
						String depIds = "";
						for(TaskDepartConfig config : tdc){
							if(config!=null){
								taskDepart += config.getDepart().getName()+",";
								depIds += config.getDepart().getId()+",";
							}
						}
						taskDepart = taskDepart.substring(0, taskDepart.length()-1);
						depIds = depIds.substring(0, depIds.length()-1);
						dto.setTaskDepart(taskDepart);
						dto.setDepIds(depIds);
					}
				}
				//TaskLog log = taskLogService.getBeanByFilter(new Filter(TaskLog.class).eq("taskId", task.getId()).eq("memo", "工作已签收")).getValue();
				TaskLog log = logMap.get(task.getId());
				if(log!=null){
					dto.setSignedDate(log.getCreateTime());
				}
				dto.setDay(ScheduleUtil.getDiffDays(new Date(),task.getEndTime()));
				dto.setTask(task);
				if(task.getParentId()!=null){
					//dto.setName(taskService.getBeanById(task.getParentId()).getValue().getCreator());
					String creator = myParentTaskMap.get(task.getId()).getCreator();
					dto.setName(creator);
				}else{
					dto.setName(task.getCreator());
				}
				taskWorkDtoList.add(dto);
			}
		}
		curYear = Integer.parseInt(DateUtil.format(new Date(),"yyyy"));
		curMonth = Integer.parseInt(DateUtil.format(new Date(),"M"));
		years = new ArrayList<Integer>();
		for(int n=(curYear-5);n<(curYear+2);n++){
			years.add(n);
		}
		months = new ArrayList<Integer>();
		for(int m=1;m<13;m++){
			months.add(m);
		}
		return "viewEmployee";
	}
	
	/**
	 * 根据条件查询我的完成任务
	 * @param dateList
	 * @param title
	 * @param curYear
	 * @param curMonth
	 * @return
	 */
	protected List<Task> searchTask(String title,Integer curYear,Integer curMonth){
		taskList = new ArrayList<Task>();
		List<Task> list = taskService.getListByFilter(new Filter(Task.class).eq("receiverId", OaActivator.getSessionUser().getId()).in("status", TaskStatusEnum.FINISHED,TaskStatusEnum.ABORTED).orderBy("endTime", "asc")).getValue();
		if(list.size()>0 && list!=null){
			if(title!=null && curYear==null && curMonth==null){//1.根据标题查询
				taskList = taskService.getListByFilter(new Filter(Task.class).eq("receiverId", OaActivator.getSessionUser().getId()).eq("title",title).in("status", TaskStatusEnum.FINISHED,TaskStatusEnum.ABORTED).orderBy("endTime", "asc")).getValue();
			}else if(title==null && curYear!=null && curMonth==null){//2.根据年份查询
				for(Task task : list){
					if(Integer.parseInt(DateUtil.format(task.getCreateTime(),"yyyy"))==curYear){
						taskList.add(task);
					}
				}
			}else if(title==null && curYear==null && curMonth!=null){//3.根据月份查询
				for (Task task : list) {
					if(Integer.parseInt(DateUtil.format(task.getCreateTime(),"M"))==curMonth){
						taskList.add(task);
					}
				}
			}else if(title!=null && curYear!=null && curMonth==null){//4.根据标题和年份查询
				for (Task task : list) {
					if(Integer.parseInt(DateUtil.format(task.getCreateTime(),"yyyy"))==curYear && task.getTitle().equals(title)){
						taskList.add(task);
					}
				}
			}else if(title!=null && curYear==null && curMonth!=null){//5.根据标题和月份查询
				for (Task task : list) {
					if(Integer.parseInt(DateUtil.format(task.getCreateTime(),"M"))==curMonth && task.getTitle().equals(title)){
						taskList.add(task);
					}
				}
			}else if(title==null && curYear!=null && curMonth!=null){//6.根据年份和月份查询
				for (Task task : list) {
					if(Integer.parseInt(DateUtil.format(task.getCreateTime(),"M"))==curMonth && Integer.parseInt(DateUtil.format(task.getCreateTime(),"yyyy"))==curYear){
						taskList.add(task);
					}
				}
			}else if(title!=null && curYear!=null && curMonth!=null){//7.根据标题、年份和月份查询
				for (Task task : list) {
					if(Integer.parseInt(DateUtil.format(task.getCreateTime(),"M"))==curMonth && Integer.parseInt(DateUtil.format(task.getCreateTime(),"yyyy"))==curYear && task.getTitle().equals(title)){
						taskList.add(task);
					}
				}
			}
		}
		return taskList;
	}
	
	/**
	 * 根据条件查询项目任务
	 */
	protected List<Task> searchProjectTask(Long projectId,String title,Integer curYear ,Integer curMonth){
		taskList = new ArrayList<Task>();
		if(title!=null && curYear==null && curMonth==null){//1.根据标题查询
			taskList = taskService.getListByFilter(new Filter(Task.class).eq("title",title).notNull("projectId").orderBy("endTime", "asc")).getValue();
		}else if(title==null && curYear!=null && curMonth==null){//2.根据年份查询
			List<Task> list = taskService.getListByFilter(new Filter(Task.class).notNull("projectId").orderBy("endTime", "asc")).getValue();
			if(list.size()>0 && list!=null){
			for (Task task : list) {
				if(Integer.parseInt(DateUtil.format(task.getCreateTime(),"yyyy"))==curYear){
					taskList.add(task);
				}
			  }
			}
		}else if(title==null && curYear==null && curMonth!=null){//3.根据月份查询
			List<Task> list = taskService.getListByFilter(new Filter(Task.class).notNull("projectId").orderBy("endTime", "asc")).getValue();
			if(list.size()>0 && list!=null){
			for (Task task : list) {
				if(Integer.parseInt(DateUtil.format(task.getCreateTime(),"M"))==curMonth){
					taskList.add(task);
				}
			}
			}
		}else if(title!=null && curYear!=null && curMonth==null){//4.根据标题和年份查询
			List<Task> list = taskService.getListByFilter(new Filter(Task.class).notNull("projectId").orderBy("endTime", "asc")).getValue();
			if(list.size()>0 && list!=null){
			for (Task task : list) {
				if(Integer.parseInt(DateUtil.format(task.getCreateTime(),"yyyy"))==curYear && task.getTitle().equals(title)){
					taskList.add(task);
				}
			}
			}
		}else if(title!=null && curYear==null && curMonth!=null){//5.根据标题和月份查询
			List<Task> list = taskService.getListByFilter(new Filter(Task.class).notNull("projectId").orderBy("endTime", "asc")).getValue();
			if(list.size()>0 && list!=null){
			for (Task task : list) {
				if(Integer.parseInt(DateUtil.format(task.getCreateTime(),"M"))==curMonth && task.getTitle().equals(title)){
					taskList.add(task);
				}
			}
			}
		}else if(title==null && curYear!=null && curMonth!=null){//6.根据年份和月份查询
			List<Task> list = taskService.getListByFilter(new Filter(Task.class).notNull("projectId").orderBy("endTime", "asc")).getValue();
			if(list.size()>0 && list!=null){
			for (Task task : list) {
				if(Integer.parseInt(DateUtil.format(task.getCreateTime(),"M"))==curMonth && Integer.parseInt(DateUtil.format(task.getCreateTime(),"yyyy"))==curYear){
					taskList.add(task);
				}
			}
			}
		}else if(title!=null && curYear!=null && curMonth!=null){//7.根据标题、年份和月份查询
			List<Task> list = taskService.getListByFilter(new Filter(Task.class).notNull("projectId").orderBy("endTime", "asc")).getValue();
			if(list.size()>0 && list!=null){
			for (Task task : list) {
				if(Integer.parseInt(DateUtil.format(task.getCreateTime(),"M"))==curMonth && Integer.parseInt(DateUtil.format(task.getCreateTime(),"yyyy"))==curYear && task.getTitle().equals(title)){
					taskList.add(task);
				}
			}
			}
		}
		return taskList;
	}
	/**
	 * 根据条件查询部门任务
	 */
	public String searchDepartTask(){

			try {
				title = new String(title.getBytes("ISO8859_1"),"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			if(title.equals("无上良品")){
				title=null;
			}
			taskList = new ArrayList<Task>();
			if(title!=null && curYear==null && curMonth==null){//1.根据标题查询
				List<Task> list = taskService.getListByFilter(new Filter(Task.class).eq("title", title).notNull("receiverId").orderBy("endTime", "asc")).getValue();
				for(Task t : list){
					if(t.getDepartConfigs().size()>0 && t.getDepartConfigs()!=null){
						taskList.add(t);
					}
				}
			}else if(title==null && curYear!=null && curMonth==null){//2.根据年份查询
				List<Task> list = taskService.getListByFilter(new Filter(Task.class).notNull("receiverId").orderBy("endTime", "asc")).getValue();
					for(Task task : list){
						if(Integer.parseInt(DateUtil.format(task.getCreateTime(),"yyyy"))==curYear && task.getDepartConfigs().size()>0 && task.getDepartConfigs()!=null){
							taskList.add(task);
						}
					}
			}else if(title==null && curYear==null && curMonth!=null){//3.根据月份查询
				List<Task> list = taskService.getListByFilter(new Filter(Task.class).notNull("receiverId").orderBy("endTime", "asc")).getValue();
				for(Task task : list){
						if(Integer.parseInt(DateUtil.format(task.getCreateTime(),"M"))==curMonth  && task.getDepartConfigs().size()>0 && task.getDepartConfigs()!=null){
							taskList.add(task);
						}
					}
			}else if(title!=null && curYear!=null && curMonth==null){//4.根据标题和年份查询
				List<Task> list = taskService.getListByFilter(new Filter(Task.class).eq("title", title).notNull("receiverId").orderBy("endTime", "asc")).getValue();
				for(Task task : list){
						if(Integer.parseInt(DateUtil.format(task.getCreateTime(),"yyyy"))==curYear  && task.getDepartConfigs().size()>0 && task.getDepartConfigs()!=null){
							taskList.add(task);
						}
					}
			}else if(title!=null && curYear==null && curMonth!=null){//5.根据标题和月份查询
				List<Task> list = taskService.getListByFilter(new Filter(Task.class).eq("title", title).notNull("receiverId").orderBy("endTime", "asc")).getValue();
				for(Task task : list){
						if(Integer.parseInt(DateUtil.format(task.getCreateTime(),"M"))==curMonth  && task.getDepartConfigs().size()>0 && task.getDepartConfigs()!=null){
							taskList.add(task);
						}
				}
			}else if(title==null && curYear!=null && curMonth!=null){//6.根据年份和月份查询
				List<Task> list = taskService.getListByFilter(new Filter(Task.class).notNull("receiverId").orderBy("endTime", "asc")).getValue();
				for(Task task : list){
						if(Integer.parseInt(DateUtil.format(task.getCreateTime(),"M"))==curMonth && Integer.parseInt(DateUtil.format(task.getCreateTime(),"yyyy"))==curYear && task.getDepartConfigs().size()>0 && task.getDepartConfigs()!=null){
							taskList.add(task);
						}
					}
			}else if(title!=null && curYear!=null && curMonth!=null){//7.根据标题、年份和月份查询
				List<Task> list = taskService.getListByFilter(new Filter(Task.class).eq("title", title).notNull("receiverId").orderBy("endTime", "asc")).getValue();
				for(Task task : list){
						if(Integer.parseInt(DateUtil.format(task.getCreateTime(),"M"))==curMonth && Integer.parseInt(DateUtil.format(task.getCreateTime(),"yyyy"))==curYear && task.getDepartConfigs().size()>0 && task.getDepartConfigs()!=null){
							taskList.add(task);
						}
					}
			}
			if(taskList!=null && taskList.size()>0){
				taskWorkDtoList = new ArrayList<TaskDto>();
					for(Task task : taskList){
						TaskDto dto = new TaskDto();
						TaskLog log = taskLogService.getBeanByFilter(new Filter(TaskLog.class).eq("taskId", task.getId()).eq("memo", "工作已签收")).getValue();
						if(log!=null){
							dto.setSignedDate(log.getCreateTime());
						}
						List<TaskDepartConfig> myList = taskDepartConfigService.getListByFilter(new Filter(TaskDepartConfig.class).eq("taskId", task.getId())).getValue();
						String taskDepart = "";
						String depIds = "";
						if(myList.size()>0 && myList!=null){
							for(TaskDepartConfig config : myList){
								if(config!=null){
									taskDepart += config.getDepart().getName()+",";
									depIds += config.getDepart().getId()+",";
								}
							}
							taskDepart = taskDepart.substring(0, taskDepart.length()-1);
							depIds = depIds.substring(0, depIds.length()-1);
						}
						dto.setTaskDepart(taskDepart);
						dto.setDepIds(depIds);
						dto.setTask(task);
						dto.setDay(ScheduleUtil.getDiffDays(new Date(),task.getEndTime()));
						taskWorkDtoList.add(dto);
					}
				}
			curYear = Integer.parseInt(DateUtil.format(new Date(),"yyyy"));
			curMonth = Integer.parseInt(DateUtil.format(new Date(),"M"));
			years = new ArrayList<Integer>();
			for(int n=(curYear-5);n<(curYear+2);n++){
				years.add(n);
			}
			months = new ArrayList<Integer>();
			for(int m=1;m<13;m++){
				months.add(m);
			}
		
		return "viewDepart";
	}
	
	/**
	 * 根据条件查询员工任务
	 * @param title
	 * @param curYear
	 * @param curMonth
	 * @return
	 */
	protected List<Task> searchEmployeeTask(String title,Integer curYear ,Integer curMonth){
		taskList = new ArrayList<Task>();
		if(title!=null && curYear==null && curMonth==null){//1.根据标题查询
			taskList = taskService.getListByFilter(new Filter(Task.class).eq("title",title).notNull("receiverId").orderBy("endTime", "asc")).getValue();
		}else if(title==null && curYear!=null && curMonth==null){//2.根据年份查询
			List<Task> list = taskService.getListByFilter(new Filter(Task.class).notNull("receiverId").orderBy("endTime", "asc")).getValue();
			if(list.size()>0 && list!=null){
			for (Task task : list) {
				if(Integer.parseInt(DateUtil.format(task.getCreateTime(),"yyyy"))==curYear){
					taskList.add(task);
				}
			  }
			}
		}else if(title==null && curYear==null && curMonth!=null){//3.根据月份查询
			List<Task> list = taskService.getListByFilter(new Filter(Task.class).notNull("receiverId").orderBy("endTime", "asc")).getValue();
			if(list.size()>0 && list!=null){
			for (Task task : list) {
				if(Integer.parseInt(DateUtil.format(task.getCreateTime(),"M"))==curMonth){
					taskList.add(task);
				}
			}
			}
		}else if(title!=null && curYear!=null && curMonth==null){//4.根据标题和年份查询
			List<Task> list = taskService.getListByFilter(new Filter(Task.class).notNull("receiverId").orderBy("endTime", "asc")).getValue();
			if(list.size()>0 && list!=null){
			for (Task task : list) {
				if(Integer.parseInt(DateUtil.format(task.getCreateTime(),"yyyy"))==curYear && task.getTitle().equals(title)){
					taskList.add(task);
				}
			}
			}
		}else if(title!=null && curYear==null && curMonth!=null){//5.根据标题和月份查询
			List<Task> list = taskService.getListByFilter(new Filter(Task.class).notNull("receiverId").orderBy("endTime", "asc")).getValue();
			if(list.size()>0 && list!=null){
			for (Task task : list) {
				if(Integer.parseInt(DateUtil.format(task.getCreateTime(),"M"))==curMonth && task.getTitle().equals(title)){
					taskList.add(task);
				}
			}
			}
		}else if(title==null && curYear!=null && curMonth!=null){//6.根据年份和月份查询
			List<Task> list = taskService.getListByFilter(new Filter(Task.class).notNull("receiverId").orderBy("endTime", "asc")).getValue();
			if(list.size()>0 && list!=null){
			for (Task task : list) {
				if(Integer.parseInt(DateUtil.format(task.getCreateTime(),"M"))==curMonth && Integer.parseInt(DateUtil.format(task.getCreateTime(),"yyyy"))==curYear){
					taskList.add(task);
				}
			}
			}
		}else if(title!=null && curYear!=null && curMonth!=null){//7.根据标题、年份和月份查询
			List<Task> list = taskService.getListByFilter(new Filter(Task.class).notNull("receiverId").orderBy("endTime", "asc")).getValue();
			if(list.size()>0 && list!=null){
			for (Task task : list) {
				if(Integer.parseInt(DateUtil.format(task.getCreateTime(),"M"))==curMonth && Integer.parseInt(DateUtil.format(task.getCreateTime(),"yyyy"))==curYear && task.getTitle().equals(title)){
					taskList.add(task);
				}
			}
			}
		}
		return taskList;
	}
	
	//删除任务时,删除任务对应的部门配置,日志,以及附件信息
	protected void deleteMyTask(Long id){
		List<TaskLog> taskLog = taskLogService.getListByFilter(new Filter(TaskLog.class).eq("taskId", id)).getValue();
		String logIds = "";
		if(taskLog!=null && taskLog.size()>0){
			for(TaskLog log : taskLog){
				logIds += log.getId()+",";
			}
			String myIds = logIds.substring(0,logIds.length()-1);
			taskLogService.deleteByIds(myIds);
			List<TaskDepartConfig> tdcList = taskDepartConfigService.getListByFilter(new Filter(TaskDepartConfig.class).eq("taskId", id)).getValue();
			String tdcIds = "";
			if(tdcList.size()>0 && tdcList!=null){
				for(TaskDepartConfig tdc : tdcList){
					tdcIds += tdc.getId()+",";
				}
				tdcIds = tdcIds.substring(0,tdcIds.length()-1);
				taskDepartConfigService.deleteByIds(tdcIds);
			}
			List<TaskAtt> taskAttList = taskAttService.getListByFilter(new Filter(TaskAtt.class).eq("taskId", id)).getValue();
			String attIds = "";
			if(taskAttList.size()>0 && taskAttList!=null){
				for(TaskAtt att : taskAttList){
					attIds += att.getId()+",";
				}
				attIds = attIds.substring(0,attIds.length()-1);
				taskAttService.deleteByIds(attIds);
			}
			result = taskService.deleteById(id);
		}else{
			List<TaskDepartConfig> tdcList = taskDepartConfigService.getListByFilter(new Filter(TaskDepartConfig.class).eq("taskId", id)).getValue();
			String tdcIds = "";
			if(tdcList.size()>0 && tdcList!=null){
				for(TaskDepartConfig tdc : tdcList){
					tdcIds += tdc.getId()+",";
				}
				tdcIds = tdcIds.substring(0,tdcIds.length()-1);
				taskDepartConfigService.deleteByIds(tdcIds);
			}
			List<TaskAtt> taskAttList = taskAttService.getListByFilter(new Filter(TaskAtt.class).eq("taskId", id)).getValue();
			String attIds = "";
			if(taskAttList.size()>0 && taskAttList!=null){
				for(TaskAtt att : taskAttList){
					attIds += att.getId()+",";
				}
				attIds = attIds.substring(0,attIds.length()-1);
				taskAttService.deleteByIds(attIds);
			}
			result = taskService.deleteById(id);
		}
	}
	
	//根据剩余天数进行升序排序
	protected List<TaskDto> sortByDay(List<TaskDto> taskWorkDtoList){
		List<TaskDto> newDto = new ArrayList<TaskDto>();
		for(TaskDto dto : taskWorkDtoList){
			Integer day = dto.getDay();
			for(int i=0;i<=day;i++){
				
			}
		}
		return newDto;
	}
	
 	protected List<Task> getListByFilter(Filter fitler) {
		return taskService.getListByFilter(fitler).getValue();
	}
	
	
	public Task getTask() {
		return task;
	}
	

	public List<TaskLog> getTaskLogList() {
		return taskLogList;
	}

	public void setTaskLogList(List<TaskLog> taskLogList) {
		this.taskLogList = taskLogList;
	}

	public void setTask(Task task) {
		this.task = task;
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

	public void setTaskService(TaskService taskService) {
		this.taskService = taskService;
	}
	
	public Result getResult() {
		return result;
	}

	public Pager getPager() {
		return pager;
	}

	public void setPager(Pager pager) {
		this.pager = pager;
	}

	public List<TaskDepart> getTaskDepartList() {
		return taskDepartList;
	}

	public List<TaskProject> getTaskProjectList() {
		return taskProjectList;
	}

	public Integer getProgress() {
		return progress;
	}

	public void setProgress(Integer progress) {
		this.progress = progress;
	}

	public void setTaskDepartService(TaskDepartService taskDepartService) {
		this.taskDepartService = taskDepartService;
	}

	public void setTaskProjectService(TaskProjectService taskProjectService) {
		this.taskProjectService = taskProjectService;
	}

	public List<TaskDepartDto> getDepartDtoList() {
		return departDtoList;
	}

	public List<TaskProjectDto> getProjectDtoList() {
		return projectDtoList;
	}

	public MyTaskAmountDto getMyTaskAmountDto() {
		return myTaskAmountDto;
	}

	public List<Task> getTaskList() {
		return taskList;
	}

	public int getLastDay() {
		return lastDay;
	}

	public void setLastDay(int lastDay) {
		this.lastDay = lastDay;
	}

	public Long getDepartId() {
		return departId;
	}

	public String getSendIds() {
		return sendIds;
	}

	public void setSendIds(String sendIds) {
		this.sendIds = sendIds;
	}

	public void setDepartId(Long departId) {
		this.departId = departId;
	}

	public Long getProjectId() {
		return projectId;
	}

	public void setProjectId(Long projectId) {
		this.projectId = projectId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public void setTaskLogService(TaskLogService taskLogService) {
		this.taskLogService = taskLogService;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getOp() {
		return op;
	}

	public void setOp(String op) {
		this.op = op;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getCreatorid() {
		return creatorid;
	}

	public void setCreatorid(String creatorid) {
		this.creatorid = creatorid;
	}

	public String getExecutorid() {
		return executorid;
	}

	public void setExecutorid(String executorid) {
		this.executorid = executorid;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getExecutor() {
		return executor;
	}

	public void setExecutor(String executor) {
		this.executor = executor;
	}

	public List<Task> getPendingList() {
		return pendingList;
	}

	public void setPendingList(List<Task> pendingList) {
		this.pendingList = pendingList;
	}

	public List<Task> getSendList() {
		return sendList;
	}

	public void setSendList(List<Task> sendList) {
		this.sendList = sendList;
	}

	public List<TaskDto> getTaskDtoList() {
		return taskDtoList;
	}

	public void setTaskDtoList(List<TaskDto> taskDtoList) {
		this.taskDtoList = taskDtoList;
	}

	public void setTaskDepartConfigService(
			TaskDepartConfigService taskDepartConfigService) {
		this.taskDepartConfigService = taskDepartConfigService;
	}

	public List<TaskDto> getTaskWorkDtoList() {
		return taskWorkDtoList;
	}

	public void setTaskWorkDtoList(List<TaskDto> taskWorkDtoList) {
		this.taskWorkDtoList = taskWorkDtoList;
	}

	public List<FinishWorkDto> getFinishWorkDtoList() {
		return finishWorkDtoList;
	}

	public void setFinishWorkDtoList(List<FinishWorkDto> finishWorkDtoList) {
		this.finishWorkDtoList = finishWorkDtoList;
	}

	public List<Integer> getYears() {
		return years;
	}

	public void setYears(List<Integer> years) {
		this.years = years;
	}

	public List<Integer> getMonths() {
		return months;
	}

	public void setMonths(List<Integer> months) {
		this.months = months;
	}

	public TaskAttService getTaskAttService() {
		return taskAttService;
	}

	public void setTaskAttService(TaskAttService taskAttService) {
		this.taskAttService = taskAttService;
	}

	public List<Date> getDateList() {
		return dateList;
	}

	public void setDateList(List<Date> dateList) {
		this.dateList = dateList;
	}

	public Integer getWeek() {
		return week;
	}

	public void setWeek(Integer week) {
		this.week = week;
	}

	public Integer getCurYear() {
		return curYear;
	}

	public Integer setCurYear(Integer curYear) {
		this.curYear = curYear;
		return curYear;
	}

	public Integer getCurMonth() {
		return curMonth;
	}

	public void setCurMonth(Integer curMonth) {
		this.curMonth = curMonth;
	}

	public List<EmployeeWorkDto> getEmployeeWorkDtoList() {
		return employeeWorkDtoList;
	}

	public void setEmployeeWorkDtoList(List<EmployeeWorkDto> employeeWorkDtoList) {
		this.employeeWorkDtoList = employeeWorkDtoList;
	}

	public List<TaskDto> getPengdingDtoList() {
		return pengdingDtoList;
	}

	public void setPengdingDtoList(List<TaskDto> pengdingDtoList) {
		this.pengdingDtoList = pengdingDtoList;
	}

	public Long getUserOrgId() {
		return userOrgId;
	}
	public void setUserOrgId(Long userOrgId) {
		this.userOrgId = userOrgId;
	}
}
