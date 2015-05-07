package com.wiiy.core.dto;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;


/**
 * @author qd
 */
public class UsageDto implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String name;//孵化器名称
	private Integer activeCenterCount;//中心活跃账户数量
	private Integer centerCount;//中心总账户数量
	private Integer activeCustomCount;//企业活跃账户数量
	private Integer customCount;//企业总账户数量
	private String date;//使用时间
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getActiveCenterCount() {
		return activeCenterCount;
	}
	public void setActiveCenterCount(Integer activeCenterCount) {
		this.activeCenterCount = activeCenterCount;
	}
	public Integer getCenterCount() {
		return centerCount;
	}
	public void setCenterCount(Integer centerCount) {
		this.centerCount = centerCount;
	}
	public Integer getActiveCustomCount() {
		return activeCustomCount;
	}
	public void setActiveCustomCount(Integer activeCustomCount) {
		this.activeCustomCount = activeCustomCount;
	}
	public Integer getCustomCount() {
		return customCount;
	}
	public void setCustomCount(Integer customCount) {
		this.customCount = customCount;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	
	

}