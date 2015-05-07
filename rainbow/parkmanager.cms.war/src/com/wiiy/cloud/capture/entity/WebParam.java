package com.wiiy.cloud.capture.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;

/**
 * <br/>class-description 网站抓取参数
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class WebParam extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 网站名称
	 */
	@FieldDescription("网站名称")
	private String webName;
	/**
	 * 网址
	 */
	@FieldDescription("网址")
	private String webUrl;
	/**
	 * 抓取间隔
	 */
	@FieldDescription("抓取间隔")
	private Integer period;
	/**
	 * 抓取开始时间
	 */
	@FieldDescription("抓取开始时间")
	private Date startDate;
	/**
	 * 抓取结束时间
	 */
	@FieldDescription("抓取结束时间")
	private Date endDate;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 网站名称
	 */
	public String getWebName(){
		return webName;
	}
	public void setWebName(String webName){
		this.webName = webName;
	}
	/**
	 * 网址
	 */
	public String getWebUrl(){
		return webUrl;
	}
	public void setWebUrl(String webUrl){
		this.webUrl = webUrl;
	}
	/**
	 * 抓取间隔
	 */
	public Integer getPeriod(){
		return period;
	}
	public void setPeriod(Integer period){
		this.period = period;
	}
	/**
	 * 抓取开始时间
	 */
	public Date getStartDate(){
		return startDate;
	}
	public void setStartDate(Date startDate){
		this.startDate = startDate;
	}
	/**
	 * 抓取结束时间
	 */
	public Date getEndDate(){
		return endDate;
	}
	public void setEndDate(Date endDate){
		this.endDate = endDate;
	}
}