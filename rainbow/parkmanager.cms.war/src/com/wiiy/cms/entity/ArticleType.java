package com.wiiy.cms.entity;

import java.io.Serializable;

import com.wiiy.cms.preferences.enums.ArticleKindEnum;
import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.core.entity.DataDict;

/**
 * <br/>class-description 文章栏目
 * <br/>extends com.wiiy.commons.entity.TreeEntity
 */
public class ArticleType extends TreeEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 网站实体
	 */
	@FieldDescription("网站实体")
	private Param param;
	/**
	 * 文章栏目实体
	 */
	@FieldDescription("文章栏目实体")
	private ArticleType parentType;
	/**
	 * 显示位置
	 */
	@FieldDescription("显示位置")
	private DataDict displayPosition;
	/**
	 * 网站外键id
	 */
	@FieldDescription("网站外键id")
	private Long paramId;
	/**
	 * 栏目管理员ids
	 */
	@FieldDescription("栏目管理员ids")
	private String managerIds;
	/**
	 * 栏目管理员名称
	 */
	@FieldDescription("栏目管理员名称")
	private String managerNames;
	/**
	 * 栏目名称
	 */
	@FieldDescription("栏目名称")
	private String typeName;
	/**
	 * 栏目辅助名称
	 */
	@FieldDescription("栏目辅助名称")
	private String typeName1;
	/**
	 * 是否在菜单显示
	 */
	@FieldDescription("是否在菜单显示")
	private BooleanEnum display;
	/**
	 * 显示位置外键
	 */
	@FieldDescription("显示位置外键")
	private String displayPositionId;
	/**
	 * 显示顺序
	 */
	@FieldDescription("显示顺序")
	private Integer displayOrder;
	/**
	 * 是否允许修改删除
	 */
	@FieldDescription("是否允许修改删除")
	private BooleanEnum fixed;
	/**
	 * 其它信息
	 */
	@FieldDescription("其它信息")
	private Integer ext1;
	/**
	 * 分类简介
	 */
	@FieldDescription("分类简介")
	private String ext2;
	/**
	 * 分类图片
	 */
	@FieldDescription("分类图片")
	private String ext3;
	/**
	 * 关键字
	 */
	@FieldDescription("关键字")
	private String keyWord;
	/**
	 * URL信息
	 */
	@FieldDescription("URL信息")
	private String url;
	/**
	 * 文章栏目类型
	 */
	@FieldDescription("文章栏目类型")
	private ArticleKindEnum kind;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 网站实体
	 */
	public Param getParam(){
		return param;
	}
	public void setParam(Param param){
		this.param = param;
	}
	/**
	 * 文章栏目实体
	 */
	public ArticleType getParentType(){
		return parentType;
	}
	public void setParentType(ArticleType parentType){
		this.parentType = parentType;
	}
	/**
	 * 显示位置
	 */
	public DataDict getDisplayPosition(){
		return displayPosition;
	}
	public void setDisplayPosition(DataDict displayPosition){
		this.displayPosition = displayPosition;
	}
	/**
	 * 网站外键id
	 */
	public Long getParamId(){
		return paramId;
	}
	public void setParamId(Long paramId){
		this.paramId = paramId;
	}
	/**
	 * 栏目管理员ids
	 */
	public String getManagerIds(){
		return managerIds;
	}
	public void setManagerIds(String managerIds){
		this.managerIds = managerIds;
	}
	/**
	 * 栏目管理员名称
	 */
	public String getManagerNames(){
		return managerNames;
	}
	public void setManagerNames(String managerNames){
		this.managerNames = managerNames;
	}
	/**
	 * 栏目名称
	 */
	public String getTypeName(){
		return typeName;
	}
	public void setTypeName(String typeName){
		this.typeName = typeName;
	}
	/**
	 * 栏目辅助名称
	 */
	public String getTypeName1(){
		return typeName1;
	}
	public void setTypeName1(String typeName1){
		this.typeName1 = typeName1;
	}
	/**
	 * 是否在菜单显示
	 */
	public BooleanEnum getDisplay(){
		return display;
	}
	public void setDisplay(BooleanEnum display){
		this.display = display;
	}
	/**
	 * 显示位置外键
	 */
	public String getDisplayPositionId(){
		return displayPositionId;
	}
	public void setDisplayPositionId(String displayPositionId){
		this.displayPositionId = displayPositionId;
	}
	/**
	 * 显示顺序
	 */
	public Integer getDisplayOrder(){
		return displayOrder;
	}
	public void setDisplayOrder(Integer displayOrder){
		this.displayOrder = displayOrder;
	}
	/**
	 * 是否允许修改删除
	 */
	public BooleanEnum getFixed(){
		return fixed;
	}
	public void setFixed(BooleanEnum fixed){
		this.fixed = fixed;
	}
	/**
	 * 其它信息
	 */
	public Integer getExt1(){
		return ext1;
	}
	public void setExt1(Integer ext1){
		this.ext1 = ext1;
	}
	/**
	 * 分类简介
	 */
	public String getExt2(){
		return ext2;
	}
	public void setExt2(String ext2){
		this.ext2 = ext2;
	}
	/**
	 * 分类图片
	 */
	public String getExt3(){
		return ext3;
	}
	public void setExt3(String ext3){
		this.ext3 = ext3;
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
	 * URL信息
	 */
	public String getUrl(){
		return url;
	}
	public void setUrl(String url){
		this.url = url;
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
}