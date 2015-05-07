package com.wiiy.core.dto;

import java.io.Serializable;
import java.util.Date;
import java.util.List;


/**
 * @author qd
 */
public class NoticeDto implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private long id;
	private String title;//公告标题
	private String content;//公告内容
	private String issuer;//发布者
	private String incubator;//发布来源
	private String center;//是否是中心人员
	private Date time;//发布时间
	
	private List<NoticeAttDto> noticeAttList;
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getIssuer() {
		return issuer;
	}
	public void setIssuer(String issuer) {
		this.issuer = issuer;
	}
	public String getIncubator() {
		return incubator;
	}
	public void setIncubator(String incubator) {
		this.incubator = incubator;
	}
	public String getCenter() {
		return center;
	}
	public void setCenter(String center) {
		this.center = center;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public List<NoticeAttDto> getNoticeAttList() {
		return noticeAttList;
	}
	public void setNoticeAttList(List<NoticeAttDto> noticeAttList) {
		this.noticeAttList = noticeAttList;
	}
	
	

}