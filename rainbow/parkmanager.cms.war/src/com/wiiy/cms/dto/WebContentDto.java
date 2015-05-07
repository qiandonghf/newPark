package com.wiiy.cms.dto;

import java.util.Date;

public class WebContentDto {
	private String title;//新闻标题
	private String link;//链接
	private Date publishedDate;//发布时间
	private String author;//作者
	private String uri;
	private String memo;//描述
	private String contentId;
	private Long webInfoId;
	private String image;
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public Date getPublishedDate() {
		return publishedDate;
	}
	public void setPublishedDate(Date publishedDate) {
		this.publishedDate = publishedDate;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getUri() {
		return uri;
	}
	public void setUri(String uri) {
		this.uri = uri;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getContentId() {
		return contentId;
	}
	public void setContentId(String contentId) {
		this.contentId = contentId;
	}
	public Long getWebInfoId() {
		return webInfoId;
	}
	public void setWebInfoId(Long webInfoId) {
		this.webInfoId = webInfoId;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	
}
