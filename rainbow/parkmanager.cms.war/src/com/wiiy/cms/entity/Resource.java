package com.wiiy.cms.entity;

import java.io.Serializable;

import com.wiiy.cms.preferences.enums.ResourceTypeEnum;
import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.core.entity.DataDict;

/**
 * <br/>class-description 网站资源
 * <br/>extends com.wiiy.commons.entity.TreeEntity
 */
public class Resource extends TreeEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 资源位置
	 */
	@FieldDescription("资源位置")
	private DataDict position;
	/**
	 * 网站外键Id
	 */
	@FieldDescription("网站外键Id")
	private Long paramId;
	/**
	 * 资源名称
	 */
	@FieldDescription("资源名称")
	private String name;
	/**
	 * 资源类型
	 */
	@FieldDescription("资源类型")
	private ResourceTypeEnum resourceType;
	/**
	 * 资源内容
	 */
	@FieldDescription("资源内容")
	private String content;
	/**
	 * 资源链接
	 */
	@FieldDescription("资源链接")
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
	 * 资源宽度
	 */
	@FieldDescription("资源宽度")
	private Integer width;
	/**
	 * 资源高度
	 */
	@FieldDescription("资源高度")
	private Integer height;
	/**
	 * 资源位置外键
	 */
	@FieldDescription("资源位置外键")
	private String positionId;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 资源位置
	 */
	public DataDict getPosition(){
		return position;
	}
	public void setPosition(DataDict position){
		this.position = position;
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
	 * 资源名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 资源类型
	 */
	public ResourceTypeEnum getResourceType(){
		return resourceType;
	}
	public void setResourceType(ResourceTypeEnum resourceType){
		this.resourceType = resourceType;
	}
	/**
	 * 资源内容
	 */
	public String getContent(){
		return content;
	}
	public void setContent(String content){
		this.content = content;
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
	 * 资源宽度
	 */
	public Integer getWidth(){
		return width;
	}
	public void setWidth(Integer width){
		this.width = width;
	}
	/**
	 * 资源高度
	 */
	public Integer getHeight(){
		return height;
	}
	public void setHeight(Integer height){
		this.height = height;
	}
	/**
	 * 资源位置外键
	 */
	public String getPositionId(){
		return positionId;
	}
	public void setPositionId(String positionId){
		this.positionId = positionId;
	}
	/**
	 * 资源链接
	 */
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
}