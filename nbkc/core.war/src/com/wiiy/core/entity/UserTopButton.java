package com.wiiy.core.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.User;

/**
 * <br/>class-description 快速按钮
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class UserTopButton extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 所属用户
	 */
	@FieldDescription("所属用户")
	private User user;
	/**
	 * 模块ID
	 */
	@FieldDescription("模块ID")
	private String moduleId;
	/**
	 * 菜单ID
	 */
	@FieldDescription("菜单ID")
	private String menuId;
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
	 * 所属用户
	 */
	public User getUser(){
		return user;
	}
	public void setUser(User user){
		this.user = user;
	}
	/**
	 * 模块ID
	 */
	public String getModuleId(){
		return moduleId;
	}
	public void setModuleId(String moduleId){
		this.moduleId = moduleId;
	}
	/**
	 * 菜单ID
	 */
	public String getMenuId(){
		return menuId;
	}
	public void setMenuId(String menuId){
		this.menuId = menuId;
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