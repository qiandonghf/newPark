package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.oa.entity.Task;

/**
 * <br/>class-description 任务轨迹
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class TaskLog extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 任务
	 */
	@FieldDescription("任务")
	private Task task;
	/**
	 * 任务外键
	 */
	@FieldDescription("任务外键")
	private Long taskId;
	/**
	 * 任务执行时间
	 */
	@FieldDescription("任务执行时间")
	private Date executeTime;
	/**
	 * 任务执行人外键
	 */
	@FieldDescription("任务执行人外键")
	private Long executeUserId;
	/**
	 * 任务执行人
	 */
	@FieldDescription("任务执行人")
	private String executeUserName;
	/**
	 * 进度记录
	 */
	@FieldDescription("进度记录")
	private Integer progress;
	/**
	 * 内容
	 */
	@FieldDescription("内容")
	private String memo;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 任务
	 */
	public Task getTask(){
		return task;
	}
	public void setTask(Task task){
		this.task = task;
	}
	/**
	 * 任务外键
	 */
	public Long getTaskId(){
		return taskId;
	}
	public void setTaskId(Long taskId){
		this.taskId = taskId;
	}
	/**
	 * 任务执行时间
	 */
	public Date getExecuteTime(){
		return executeTime;
	}
	public void setExecuteTime(Date executeTime){
		this.executeTime = executeTime;
	}
	/**
	 * 任务执行人外键
	 */
	public Long getExecuteUserId(){
		return executeUserId;
	}
	public void setExecuteUserId(Long executeUserId){
		this.executeUserId = executeUserId;
	}
	/**
	 * 任务执行人
	 */
	public String getExecuteUserName(){
		return executeUserName;
	}
	public void setExecuteUserName(String executeUserName){
		this.executeUserName = executeUserName;
	}
	/**
	 * 进度记录
	 */
	public Integer getProgress(){
		return progress;
	}
	public void setProgress(Integer progress){
		this.progress = progress;
	}
	/**
	 * 内容
	 */
	public String getMemo(){
		return memo;
	}
	public void setMemo(String memo){
		this.memo = memo;
	}
}