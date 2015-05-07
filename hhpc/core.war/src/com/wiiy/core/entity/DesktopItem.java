package com.wiiy.core.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;

/**
 * <br/>class-description 工作台模块
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class DesktopItem extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 标题
	 */
	@FieldDescription("标题")
	private String title;
	
	/**
	 * 简介
	 */
	@FieldDescription("简介")
	private String memo;
	/**
	 * 数据接口URL
	 */
	@FieldDescription("数据接口URL")
	private String url;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
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
	 * 简介
	 */
	public String getMemo(){
		return memo;
	}
	public void setMemo(String memo){
		this.memo = memo;
	}
	/**
	 * 数据接口URL
	 */
	public String getUrl(){
		return url;
	}
	public void setUrl(String url){
		this.url = url;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		DesktopItem other = (DesktopItem) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}
}