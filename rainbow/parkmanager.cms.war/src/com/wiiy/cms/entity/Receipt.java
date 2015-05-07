package com.wiiy.cms.entity;

import java.io.Serializable;
import java.util.Set;

import com.wiiy.cms.entity.Article;
import com.wiiy.cms.entity.Param;
import com.wiiy.cms.entity.ReceiptAtt;
import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;

/**
 * <br/>class-description 通知回执
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Receipt extends BaseEntity implements Serializable {
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
	 * 文章
	 */
	@FieldDescription("文章")
	private Article article;
	/**
	 * 网站外键
	 */
	@FieldDescription("网站外键")
	private Long paramId;
	/**
	 * 文章外键
	 */
	@FieldDescription("文章外键")
	private Long articleId;
	/**
	 * 姓名
	 */
	@FieldDescription("姓名")
	private String name;
	/**
	 * 企业名称
	 */
	@FieldDescription("企业名称")
	private String customerName;
	/**
	 * 职务
	 */
	@FieldDescription("职务")
	private String position;
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
	 * Email
	 */
	@FieldDescription("Email")
	private String email;
	/**
	 * 主题
	 */
	@FieldDescription("主题")
	private String title;
	/**
	 * 内容
	 */
	@FieldDescription("内容")
	private String content;
	/**
	 * 附件路径
	 */
	@FieldDescription("附件路径")
	private String path;
	/**
	 * 附件名称
	 */
	@FieldDescription("附件名称")
	private String oldName;
	/**
	 * 文章外键Id
	 */
	@FieldDescription("文章外键Id")
	private Set<ReceiptAtt> receiptAtts;

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
	 * 文章
	 */
	public Article getArticle(){
		return article;
	}
	public void setArticle(Article article){
		this.article = article;
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
	 * 文章外键
	 */
	public Long getArticleId(){
		return articleId;
	}
	public void setArticleId(Long articleId){
		this.articleId = articleId;
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
	 * Email
	 */
	public String getEmail(){
		return email;
	}
	public void setEmail(String email){
		this.email = email;
	}
	/**
	 * 主题
	 */
	public String getTitle(){
		return title;
	}
	public void setTitle(String title){
		this.title = title;
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
	/**
	 * 附件路径
	 */
	public String getPath(){
		return path;
	}
	public void setPath(String path){
		this.path = path;
	}
	/**
	 * 附件名称
	 */
	public String getOldName(){
		return oldName;
	}
	public void setOldName(String oldName){
		this.oldName = oldName;
	}
	/**
	 * 文章外键Id
	 */
	public Set<ReceiptAtt> getReceiptAtts(){
		return receiptAtts;
	}
	public void setReceiptAtts(Set<ReceiptAtt> receiptAtts){
		this.receiptAtts = receiptAtts;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
}