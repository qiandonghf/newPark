package com.wiiy.cms.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.cms.preferences.enums.LinksTypeEnum;
import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;

/**
 * <br/>class-description 友情链接
 * <br/>extends com.wiiy.commons.entity.TreeEntity
 */
public class Links extends TreeEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 网站外键Id
	 */
	@FieldDescription("网站外键Id")
	private Long paramId;
	/**
	 * 链接名称
	 */
	@FieldDescription("链接名称")
	private String linkName;
	/**
	 * 链接类型
	 */
	@FieldDescription("链接类型")
	private LinksTypeEnum type;
	/**
	 * 链接图片路径
	 */
	@FieldDescription("链接图片路径")
	private String photo;
	/**
	 * 链接图片原始名称
	 */
	@FieldDescription("链接图片原始名称")
	private String oldName;
	/**
	 * 链接地址
	 */
	@FieldDescription("链接地址")
	private String linkURL;
	/**
	 * 是否启用
	 */
	@FieldDescription("是否启用")
	private BooleanEnum display;
	/**
	 * 创建时间
	 */
	@FieldDescription("创建时间")
	private Date openedTime;
	/**
	 * 显示顺序
	 */
	@FieldDescription("显示顺序")
	private Integer displayOrder;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
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
	 * 链接名称
	 */
	public String getLinkName(){
		return linkName;
	}
	public void setLinkName(String linkName){
		this.linkName = linkName;
	}
	/**
	 * 链接类型
	 */
	public LinksTypeEnum getType(){
		return type;
	}
	public void setType(LinksTypeEnum type){
		this.type = type;
	}
	/**
	 * 链接图片路径
	 */
	public String getPhoto(){
		return photo;
	}
	public void setPhoto(String photo){
		this.photo = photo;
	}
	/**
	 * 链接图片原始名称
	 */
	public String getOldName(){
		return oldName;
	}
	public void setOldName(String oldName){
		this.oldName = oldName;
	}
	/**
	 * 链接地址
	 */
	public String getLinkURL(){
		return linkURL;
	}
	public void setLinkURL(String linkURL){
		this.linkURL = linkURL;
	}
	/**
	 * 是否启用
	 */
	public BooleanEnum getDisplay(){
		return display;
	}
	public void setDisplay(BooleanEnum display){
		this.display = display;
	}
	/**
	 * 创建时间
	 */
	public Date getOpenedTime(){
		return openedTime;
	}
	public void setOpenedTime(Date openedTime){
		this.openedTime = openedTime;
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
}