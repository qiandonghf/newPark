package com.wiiy.oa.dto;

import com.wiiy.oa.entity.TaskDepart;

public class TaskDepartDto {
	
	private TaskDepart depart;
	
	private int finish;
	private int unfinish;
	private int overdue;
	public TaskDepart getDepart() {
		return depart;
	}
	public void setDepart(TaskDepart depart) {
		this.depart = depart;
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
	
	

}
