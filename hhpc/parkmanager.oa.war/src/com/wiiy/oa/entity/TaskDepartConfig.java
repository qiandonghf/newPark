package com.wiiy.oa.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.oa.entity.Task;
import com.wiiy.oa.entity.TaskDepart;

/**
 * <br/>class-description 任务部门配置
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class TaskDepartConfig extends BaseEntity implements Serializable {
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
	 * 任务部门
	 */
	@FieldDescription("任务部门")
	private TaskDepart depart;
	/**
	 * 任务外键
	 */
	@FieldDescription("任务外键")
	private Long taskId;
	/**
	 * 任务部门外键
	 */
	@FieldDescription("任务部门外键")
	private Long departId;

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
	 * 任务部门
	 */
	public TaskDepart getDepart(){
		return depart;
	}
	public void setDepart(TaskDepart depart){
		this.depart = depart;
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
	 * 任务部门外键
	 */
	public Long getDepartId(){
		return departId;
	}
	public void setDepartId(Long departId){
		this.departId = departId;
	}
}