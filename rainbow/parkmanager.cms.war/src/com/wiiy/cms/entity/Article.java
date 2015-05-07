package com.wiiy.cms.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

import com.wiiy.cms.entity.ArticleAtt;
import com.wiiy.cms.entity.ArticleType;
import com.wiiy.cms.preferences.enums.ArticleKindEnum;
import com.wiiy.cms.preferences.enums.NewsTypeEnum;
import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;

/**
 * <br/>class-description 文章
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Article extends BaseEntity implements Serializable {
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
	 * 网站
	 */
	@FieldDescription("网站")
	private Param param;
	/**
	 * 单页Id
	 */
	@FieldDescription("单页Id")
	private Long singleId;
	/**
	 * 文章标题
	 */
	@FieldDescription("文章标题")
	private String title;
	/**
	 * 文章副标题
	 */
	@FieldDescription("文章副标题")
	private String subtitle;
	/**
	 * TAG标签
	 */
	@FieldDescription("TAG标签")
	private String tags;
	/**
	 * 新闻类别
	 */
	@FieldDescription("新闻类别")
	private NewsTypeEnum newsType;
	/**
	 * 如果是图片新闻 这里放图片地址用于首页图片翻滚
	 */
	@FieldDescription("如果是图片新闻 这里放图片地址用于首页图片翻滚")
	private String photo;
	/**
	 * 图片原始名称
	 */
	@FieldDescription("图片原始名称")
	private String oldName;
	/**
	 * 图片新名称
	 */
	@FieldDescription("图片新名称")
	private String newName;
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
	 * 记录信息
	 */
	@FieldDescription("记录信息")
	private String record;
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
	 * 文章来源
	 */
	@FieldDescription("文章来源")
	private String source;
	/**
	 * 编辑人
	 */
	@FieldDescription("编辑人")
	private String editor;
	/**
	 * 关键字
	 */
	@FieldDescription("关键字")
	private String keyWord;
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
	 * 文章类型
	 */
	public ArticleType getArticleType(){
		return articleType;
	}
	public void setArticleType(ArticleType articleType){
		this.articleType = articleType;
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
	 * 单页Id
	 */
	public Long getSingleId(){
		return singleId;
	}
	public void setSingleId(Long singleId){
		this.singleId = singleId;
	}
	/**
	 * 文章标题
	 */
	public String getTitle(){
		return title;
	}
	public void setTitle(String title){
		this.title = title;
	}
	/**
	 * 文章副标题
	 */
	public String getSubtitle() {
		return subtitle;
	}
	public void setSubtitle(String subtitle) {
		this.subtitle = subtitle;
	}
	/**
	 * TAG标签
	 */
	public String getTags(){
		return tags;
	}
	public void setTags(String tags){
		this.tags = tags;
	}
	public NewsTypeEnum getNewsType() {
		return newsType;
	}
	public void setNewsType(NewsTypeEnum newsType) {
		this.newsType = newsType;
	}
	/**
	 * 如果是图片新闻 这里放图片地址用于首页图片翻滚
	 */
	public String getPhoto(){
		return photo;
	}
	public void setPhoto(String photo){
		this.photo = photo;
	}
	/**
	 * 记录信息
	 */
	public String getRecord() {
		return record;
	}
	public void setRecord(String record) {
		this.record = record;
	}
	/**
	 * 图片原始名称
	 */
	public String getOldName() {
		return oldName;
	}
	public void setOldName(String oldName) {
		this.oldName = oldName;
	}
	public String getNewName() {
		return newName;
	}
	public void setNewName(String newName) {
		this.newName = newName;
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
	 * 文章来源
	 */
	public String getSource(){
		return source;
	}
	public void setSource(String source){
		this.source = source;
	}
	/**
	 * 编辑人
	 */
	public String getEditor(){
		return editor;
	}
	public void setEditor(String editor){
		this.editor = editor;
	}
	/**
	 * 关键字
	 */
	public String getKeyWord(){
		return keyWord;
	}
	public void setKeyWord(String keyWord){
		this.keyWord = keyWord;
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
	 * 文章外键Id
	 */
	public Set<ArticleAtt> getArticleAtts(){
		return articleAtts;
	}
	public void setArticleAtts(Set<ArticleAtt> articleAtts){
		this.articleAtts = articleAtts;
	}
	/**
	 * 网站外键Id
	 */
	public Long getParamId() {
		return paramId;
	}
	public void setParamId(Long paramId) {
		this.paramId = paramId;
	}
	/**
	 * 网站
	 */
	public Param getParam() {
		return param;
	}
	public void setParam(Param param) {
		this.param = param;
	}
}