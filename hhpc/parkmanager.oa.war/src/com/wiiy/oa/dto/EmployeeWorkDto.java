package com.wiiy.oa.dto;

public class EmployeeWorkDto {
	private Long id;//员工id
	private String name;//员工姓名
	private Integer unfinish;//待办
	private Integer finish;//完成
	private Integer stop;//中止
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getUnfinish() {
		return unfinish;
	}
	public void setUnfinish(Integer unfinish) {
		this.unfinish = unfinish;
	}
	public Integer getFinish() {
		return finish;
	}
	public void setFinish(Integer finish) {
		this.finish = finish;
	}
	public Integer getStop() {
		return stop;
	}
	public void setStop(Integer stop) {
		this.stop = stop;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
}
