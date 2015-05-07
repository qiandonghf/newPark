package com.wiiy.cloud.capture.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.cloud.capture.entity.WebInfo;
import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;

/**
 * <br/>class-description 网站内容
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class WebContent extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 网站
	 */
	@FieldDescription("网站")
	private WebInfo webInfo;
	/**
	 * 网站外键
	 */
	@FieldDescription("网站外键")
	private Long webInfoId;
	/**
	 * 内容标识id
	 */
	@FieldDescription("内容标识id")
	private String contentId;
	/**
	 * 内容地址
	 */
	@FieldDescription("内容地址")
	private String url;
	/**
	 * 标题
	 */
	@FieldDescription("标题")
	private String title;
	/**
	 * 图片路径
	 */
	@FieldDescription("图片路径")
	private String imageUrl;
	/**
	 * 受理
	 */
	@FieldDescription("受理")
	private String hear;
	/**
	 * 发布时间
	 */
	@FieldDescription("发布时间")
	private Date releaseDate;
	/**
	 * 内容
	 */
	@FieldDescription("内容")
	private String content;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 网站
	 */
	public WebInfo getWebInfo(){
		return webInfo;
	}
	public void setWebInfo(WebInfo webInfo){
		this.webInfo = webInfo;
	}
	/**
	 * 网站外键
	 */
	public Long getWebInfoId(){
		return webInfoId;
	}
	public void setWebInfoId(Long webInfoId){
		this.webInfoId = webInfoId;
	}
	/**
	 * 内容标识id
	 */
	public String getContentId(){
		return contentId;
	}
	public void setContentId(String contentId){
		this.contentId = contentId;
	}
	/**
	 * 内容地址
	 */
	public String getUrl(){
		return url;
	}
	public void setUrl(String url){
		this.url = url;
	}
	/**
	 * 标题
	 */
	public String getTitle(){
		return title;
	}
	public void setTitle(String title){
		this.title = title;
	}
	/**
	 * 图片路径
	 */
	public String getImageUrl(){
		return imageUrl;
	}
	public void setImageUrl(String imageUrl){
		this.imageUrl = imageUrl;
	}
	/**
	 * 受理
	 */
	public String getHear(){
		return hear;
	}
	public void setHear(String hear){
		this.hear = hear;
	}
	/**
	 * 发布时间
	 */
	public Date getReleaseDate(){
		return releaseDate;
	}
	public void setReleaseDate(Date releaseDate){
		this.releaseDate = releaseDate;
	}
	/**
	 * 内容
	 */
	public String getContent(){
		return content;
	}
	public void setContent(String content){
		this.content = content;
	}
}