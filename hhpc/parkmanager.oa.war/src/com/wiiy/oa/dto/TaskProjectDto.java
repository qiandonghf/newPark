package com.wiiy.oa.dto;

import com.wiiy.oa.entity.TaskProject;

public class TaskProjectDto {
	
	private TaskProject project;
	
	private int finish;
	private int unfinish;
	private int overdue;
	private int stop;
	public TaskProject getProject() {
		return project;
	}
	public void setProject(TaskProject project) {
		this.project = project;
	}
	public int getFinish() {
		return finish;
	}
	public void setFinish(int finish) {
		this.finish = finish;
	}
	public int getUnfinish() {
		return unfinish;
	}
	public void setUnfinish(int unfinish) {
		this.unfinish = unfinish;
	}
	public int getOverdue() {
		return overdue;
	}
	public void setOverdue(int overdue) {
		this.overdue = overdue;
	}
	public int getStop() {
		return stop;
	}
	public void setStop(int stop) {
		this.stop = stop;
	}
	
	

}
