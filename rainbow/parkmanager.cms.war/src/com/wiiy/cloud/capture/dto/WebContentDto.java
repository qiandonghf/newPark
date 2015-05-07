package com.wiiy.cloud.capture.dto;

import java.util.Date;

public class WebContentDto {
	private Long id;
	private String url;
	private String title;
	private Date date;
	private String source;
	private boolean contentCollect; 
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public boolean isContentCollect() {
		return contentCollect;
	}
	public void setContentCollect(boolean contentCollect) {
		this.contentCollect = contentCollect;
	}

}
