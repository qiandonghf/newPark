package com.wiiy.cms.entity;

import java.io.Serializable;

import com.wiiy.cms.preferences.enums.PositionEnum;
import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;

/**
 * <br/>class-description 图片水印
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class WaterMark extends BaseEntity implements Serializable {
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
	 * 是否启用水印
	 */
	@FieldDescription("是否启用水印")
	private BooleanEnum opened;
	/**
	 * 水印宽度
	 */
	@FieldDescription("水印宽度")
	private Integer width;
	/**
	 * 水印高度
	 */
	@FieldDescription("水印高度")
	private Integer height;
	/**
	 * 水印图片名称
	 */
	@FieldDescription("水印图片名称")
	private String imgName;
	/**
	 * 水印图片位置
	 */
	@FieldDescription("水印图片位置")
	private String imgPath;
	/**
	 * 水印文字
	 */
	@FieldDescription("水印文字")
	private String marktext;
	/**
	 * 水印文字颜色
	 */
	@FieldDescription("水印文字颜色")
	private String color;
	/**
	 * 水印位置
	 */
	@FieldDescription("水印位置")
	private PositionEnum position;

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
	 * 是否启用水印
	 */
	public BooleanEnum getOpened(){
		return opened;
	}
	public void setOpened(BooleanEnum opened){
		this.opened = opened;
	}
	/**
	 * 水印宽度
	 */
	public Integer getWidth(){
		return width;
	}
	public void setWidth(Integer width){
		this.width = width;
	}
	/**
	 * 水印高度
	 */
	public Integer getHeight(){
		return height;
	}
	public void setHeight(Integer height){
		this.height = height;
	}
	/**
	 * 水印图片名称
	 */
	public String getImgName(){
		return imgName;
	}
	public void setImgName(String imgName){
		this.imgName = imgName;
	}
	/**
	 * 水印图片位置
	 */
	public String getImgPath(){
		return imgPath;
	}
	public void setImgPath(String imgPath){
		this.imgPath = imgPath;
	}
	/**
	 * 水印文字
	 */
	public String getMarktext(){
		return marktext;
	}
	public void setMarktext(String marktext){
		this.marktext = marktext;
	}
	/**
	 * 水印文字颜色
	 */
	public String getColor(){
		return color;
	}
	public void setColor(String color){
		this.color = color;
	}
	/**
	 * 水印位置
	 */
	public PositionEnum getPosition(){
		return position;
	}
	public void setPosition(PositionEnum position){
		this.position = position;
	}
}