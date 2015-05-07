package com.wiiy.cms.entity;

import java.io.Serializable;
import java.util.Set;

import com.wiiy.cms.entity.ArticleAtt;
import com.wiiy.cms.entity.Param;
import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;

/**
 * <br/>class-description 意见反馈
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Advicement extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 网站
	 */
	@FieldDescription("网站")
	private Param param;
	/**
	 * 网站外键
	 */
	@FieldDescription("网站外键")
	private Long paramId;
	/**
	 * 姓名
	 */
	@FieldDescription("姓名")
	private String name;
	/**
	 * 昵称
	 */
	@FieldDescription("昵称")
	private String nickName;
	/**
	 * 电话
	 */
	@FieldDescription("电话")
	private String phone;
	/**
	 * 电话
	 */
	@FieldDescription("电话")
	private String email;
	/**
	 * 留言主题
	 */
	@FieldDescription("留言主题")
	private String title;
	/**
	 * 留言内容
	 */
	@FieldDescription("留言内容")
	private String content;
	/**
	 * 文章外键Id
	 */
	@FieldDescription("文章外键Id")
	private Set<ArticleAtt> articleAtts;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 网站
	 */
	public Param getParam(){
		return param;
	}
	public void setParam(Param param){
		this.param = param;
	}
	/**
	 * 网站外键
	 */
	public Long getParamId(){
		return paramId;
	}
	public void setParamId(Long paramId){
		this.paramId = paramId;
	}
	/**
	 * 姓名
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 昵称
	 */
	public String getNickName(){
		return nickName;
	}
	public void setNickName(String nickName){
		this.nickName = nickName;
	}
	/**
	 * 电话
	 */
	public String getPhone(){
		return phone;
	}
	public void setPhone(String phone){
		this.phone = phone;
	}
	/**
	 * 电话
	 */
	public String getEmail(){
		return email;
	}
	public void setEmail(String email){
		this.email = email;
	}
	/**
	 * 留言主题
	 */
	public String getTitle(){
		return title;
	}
	public void setTitle(String title){
		this.title = title;
	}
	/**
	 * 留言内容
	 */
	public String getContent(){
		return content;
	}
	public void setContent(String content){
		this.content = content;
	}
	/**
	 * 文章外键Id
	 */
	public Set<ArticleAtt> getArticleAtts(){
		return articleAtts;
	}
	public void setArticleAtts(Set<ArticleAtt> articleAtts){
		this.articleAtts = articleAtts;
	}
}