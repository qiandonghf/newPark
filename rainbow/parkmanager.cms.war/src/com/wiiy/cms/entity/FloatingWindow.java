package com.wiiy.cms.entity;

import java.io.Serializable;

import com.wiiy.cms.entity.Param;
import com.wiiy.cms.preferences.enums.FloatingTypeEnum;
import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;

/**
 * <br/>class-description 网站浮窗
 * <br/>extends com.wiiy.commons.entity.TreeEntity
 */
public class FloatingWindow extends TreeEntity implements Serializable {
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
	 * 网站外键id
	 */
	@FieldDescription("网站外键id")
	private Long paramId;
	/**
	 * 浮窗名称
	 */
	@FieldDescription("浮窗名称")
	private String name;
	/**
	 * 浮窗类型
	 */
	@FieldDescription("浮窗类型")
	private FloatingTypeEnum type;
	/**
	 * 文字内容
	 */
	@FieldDescription("文字内容")
	private String content;
	/**
	 * 浮窗链接
	 */
	@FieldDescription("浮窗链接")
	private String url;
	/**
	 * 附件原名称
	 */
	@FieldDescription("附件原名称")
	private String oldName;
	/**
	 * 附件新名称
	 */
	@FieldDescription("附件新名称")
	private String newName;
	/**
	 * 附件路径
	 */
	@FieldDescription("附件路径")
	private String resourcePath;
	/**
	 * 是否启用
	 */
	@FieldDescription("是否启用")
	private BooleanEnum enable;
	/**
	 * 宽度
	 */
	@FieldDescription("宽度")
	private Integer width;
	/**
	 * 高度
	 */
	@FieldDescription("高度")
	private Integer height;

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
	 * 网站外键id
	 */
	public Long getParamId(){
		return paramId;
	}
	public void setParamId(Long paramId){
		this.paramId = paramId;
	}
	/**
	 * 浮窗名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 浮窗类型
	 */
	public FloatingTypeEnum getType(){
		return type;
	}
	public void setType(FloatingTypeEnum type){
		this.type = type;
	}
	/**
	 * 文字内容
	 */
	public String getContent(){
		return content;
	}
	public void setContent(String content){
		this.content = content;
	}
	/**
	 * 浮窗链接
	 */
	public String getUrl(){
		return url;
	}
	public void setUrl(String url){
		this.url = url;
	}
	/**
	 * 附件原名称
	 */
	public String getOldName(){
		return oldName;
	}
	public void setOldName(String oldName){
		this.oldName = oldName;
	}
	/**
	 * 附件新名称
	 */
	public String getNewName(){
		return newName;
	}
	public void setNewName(String newName){
		this.newName = newName;
	}
	/**
	 * 附件路径
	 */
	public String getResourcePath(){
		return resourcePath;
	}
	public void setResourcePath(String resourcePath){
		this.resourcePath = resourcePath;
	}
	/**
	 * 是否启用
	 */
	public BooleanEnum getEnable(){
		return enable;
	}
	public void setEnable(BooleanEnum enable){
		this.enable = enable;
	}
	/**
	 * 宽度
	 */
	public Integer getWidth(){
		return width;
	}
	public void setWidth(Integer width){
		this.width = width;
	}
	/**
	 * 高度
	 */
	public Integer getHeight(){
		return height;
	}
	public void setHeight(Integer height){
		this.height = height;
	}
}