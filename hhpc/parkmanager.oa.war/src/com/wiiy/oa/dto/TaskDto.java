package com.wiiy.oa.dto;

import java.util.Date;
import java.util.List;
import java.util.Set;

import com.wiiy.oa.entity.Task;
import com.wiiy.oa.entity.TaskAtt;
import com.wiiy.oa.entity.TaskLog;
import com.wiiy.oa.preferences.enums.PriorityEnum;
import com.wiiy.oa.preferences.enums.SubTaskStatusEnum;
import com.wiiy.oa.preferences.enums.TaskStatusEnum;
/**
 * 每条任务匹配相应的任务轨迹
 * @author Administrator
 *
 */
public class TaskDto {
	private Task task;
	private Long id;
	private String name;//接收人
	private String title;//主题
	private Date createTime;//创建时间
	private TaskStatusEnum status;//任务状态
	private SubTaskStatusEnum childStatus;//签收状态
	private Integer progress;//进度
	private List<TaskLog> taskLogList;
	private String taskDepart;//任务部门
	private String depIds;
    private Integer day;//当前时间距离结束时间的天数
    private Date startTime;//任务开始时间
    private Set<TaskAtt> atts;//附件
    private Date signedDate;//签收日期 
    private PriorityEnum priority;//优先级
    private String priorityName;
    private List<Task> childTaskList;
    private Integer taskStatus;//任务状态,0:为待办, 1:为派出 , -1:未签收
    
	public List<TaskLog> getTaskLogList() {
		return taskLogList;
	}
	public void setTaskLogList(List<TaskLog> taskLogList) {
		this.taskLogList = taskLogList;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public TaskStatusEnum getStatus() {
		return status;
	}
	public void setStatus(TaskStatusEnum status) {
		this.status = status;
	}
	public SubTaskStatusEnum getChildStatus() {
		return childStatus;
	}
	public void setChildStatus(SubTaskStatusEnum childStatus) {
		this.childStatus = childStatus;
	}
	public Integer getProgress() {
		return progress;
	}
	public void setProgress(Integer progress) {
		this.progress = progress;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTaskDepart() {
		return taskDepart;
	}
	public void setTaskDepart(String taskDepart) {
		this.taskDepart = taskDepart;
	}
	public Integer getDay() {
		return day;
	}
	public void setDay(Integer day) {
		this.day = day;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Set<TaskAtt> getAtts() {
		return atts;
	}
	public void setAtts(Set<TaskAtt> atts) {
		this.atts = atts;
	}
	public Date getSignedDate() {
		return signedDate;
	}
	public void setSignedDate(Date signedDate) {
		this.signedDate = signedDate;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public PriorityEnum getPriority() {
		return priority;
	}
	public void setPriority(PriorityEnum priority) {
		this.priority = priority;
	}
	public Task getTask() {
		return task;
	}
	public void setTask(Task task) {
		this.task = task;
	}
	public String getPriorityName() {
		return priorityName;
	}
	public void setPriorityName(String priorityName) {
		this.priorityName = priorityName;
	}
	public List<Task> getChildTaskList() {
		return childTaskList;
	}
	public void setChildTaskList(List<Task> childTaskList) {
		this.childTaskList = childTaskList;
	}
	public Integer getTaskStatus() {
		return taskStatus;
	}
	public void setTaskStatus(Integer taskStatus) {
		this.taskStatus = taskStatus;
	}
	public String getDepIds() {
		return depIds;
	}
	public void setDepIds(String depIds) {
		this.depIds = depIds;
	}
	
}	
