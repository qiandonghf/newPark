package com.wiiy.cms.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.cms.entity.ArticleType;
import com.wiiy.cms.entity.Param;
import com.wiiy.cms.preferences.enums.ArticleKindEnum;
import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;

/**
 * <br/>class-description 技术平台
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Platform extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 文章类型
	 */
	@FieldDescription("文章类型")
	private ArticleType articleType;
	/**
	 * 网站
	 */
	@FieldDescription("网站")
	private Param param;
	/**
	 * 文章类型外键
	 */
	@FieldDescription("文章类型外键")
	private Long typeId;
	/**
	 * 网站外键Id
	 */
	@FieldDescription("网站外键Id")
	private Long paramId;
	/**
	 * 平台名称
	 */
	@FieldDescription("平台名称")
	private String name;
	/**
	 * 平台标题
	 */
	@FieldDescription("平台标题")
	private String title;
	/**
	 * 平台URL
	 */
	@FieldDescription("平台URL")
	private String url;
	/**
	 * 地址
	 */
	@FieldDescription("地址")
	private String address;
	/**
	 * 联系电话
	 */
	@FieldDescription("联系电话")
	private String phone;
	/**
	 * 平台logo
	 */
	@FieldDescription("平台logo")
	private String photo;
	/**
	 * 图片原名
	 */
	@FieldDescription("图片原名")
	private String oldName;
	/**
	 * 简介
	 */
	@FieldDescription("简介")
	private String summery;
	/**
	 * 文章内容
	 */
	@FieldDescription("文章内容")
	private String content;
	/**
	 * 纯文本文章内容
	 */
	@FieldDescription("纯文本文章内容")
	private String contentText;
	/**
	 * 是否发布
	 */
	@FieldDescription("是否发布")
	private BooleanEnum pubed;
	/**
	 * 发布时间
	 */
	@FieldDescription("发布时间")
	private Date pubTime;
	/**
	 * 点击次数
	 */
	@FieldDescription("点击次数")
	private Integer hits;
	/**
	 * 文章栏目类型
	 */
	@FieldDescription("文章栏目类型")
	private ArticleKindEnum kind;
	/**
	 * 是否首页推荐
	 */
	@FieldDescription("是否首页推荐")
	private BooleanEnum recommend;
	/**
	 * 是否置顶
	 */
	@FieldDescription("是否置顶")
	private BooleanEnum toped;
	/**
	 * 是否加粗
	 */
	@FieldDescription("是否加粗")
	private BooleanEnum bold;
	/**
	 * 是否加入回收站
	 */
	@FieldDescription("是否加入回收站")
	private BooleanEnum deleted;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 文章类型
	 */
	public ArticleType getArticleType(){
		return articleType;
	}
	public void setArticleType(ArticleType articleType){
		this.articleType = articleType;
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
	 * 文章类型外键
	 */
	public Long getTypeId(){
		return typeId;
	}
	public void setTypeId(Long typeId){
		this.typeId = typeId;
	}
	/**
	 * 网站外键Id
	 */
	public Long getParamId(){
		return paramId;
	}
	public void setParamId(Long paramId){
		this.paramId = paramId;
	}
	/**
	 * 平台名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 平台标题
	 */
	public String getTitle(){
		return title;
	}
	public void setTitle(String title){
		this.title = title;
	}
	/**
	 * 地址
	 */
	public String getAddress(){
		return address;
	}
	public void setAddress(String address){
		this.address = address;
	}
	/**
	 * 联系电话
	 */
	public String getPhone(){
		return phone;
	}
	public void setPhone(String phone){
		this.phone = phone;
	}
	/**
	 * 平台logo
	 */
	public String getPhoto(){
		return photo;
	}
	public void setPhoto(String photo){
		this.photo = photo;
	}
	/**
	 * 图片原名
	 */
	public String getOldName(){
		return oldName;
	}
	public void setOldName(String oldName){
		this.oldName = oldName;
	}
	/**
	 * 简介
	 */
	public String getSummery(){
		return summery;
	}
	public void setSummery(String summery){
		this.summery = summery;
	}
	/**
	 * 文章内容
	 */
	public String getContent(){
		return content;
	}
	public void setContent(String content){
		this.content = content;
	}
	/**
	 * 纯文本文章内容
	 */
	public String getContentText(){
		return contentText;
	}
	public void setContentText(String contentText){
		this.contentText = contentText;
	}
	/**
	 * 是否发布
	 */
	public BooleanEnum getPubed(){
		return pubed;
	}
	public void setPubed(BooleanEnum pubed){
		this.pubed = pubed;
	}
	/**
	 * 发布时间
	 */
	public Date getPubTime(){
		return pubTime;
	}
	public void setPubTime(Date pubTime){
		this.pubTime = pubTime;
	}
	/**
	 * 点击次数
	 */
	public Integer getHits(){
		return hits;
	}
	public void setHits(Integer hits){
		this.hits = hits;
	}
	/**
	 * 文章栏目类型
	 */
	public ArticleKindEnum getKind(){
		return kind;
	}
	public void setKind(ArticleKindEnum kind){
		this.kind = kind;
	}
	/**
	 * 是否首页推荐
	 */
	public BooleanEnum getRecommend(){
		return recommend;
	}
	public void setRecommend(BooleanEnum recommend){
		this.recommend = recommend;
	}
	/**
	 * 是否置顶
	 */
	public BooleanEnum getToped(){
		return toped;
	}
	public void setToped(BooleanEnum toped){
		this.toped = toped;
	}
	/**
	 * 是否加粗
	 */
	public BooleanEnum getBold(){
		return bold;
	}
	public void setBold(BooleanEnum bold){
		this.bold = bold;
	}
	/**
	 * 是否加入回收站
	 */
	public BooleanEnum getDeleted(){
		return deleted;
	}
	public void setDeleted(BooleanEnum deleted){
		this.deleted = deleted;
	}
	/**
	 * 平台URL
	 */
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
}