package com.wiiy.core.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.DesktopItem;
import com.wiiy.core.entity.Role;

/**
 * <br/>class-description 角色工作台配置
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class RoleDesktop extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 角色
	 */
	@FieldDescription("角色")
	private Role role;
	/**
	 * 模块
	 */
	@FieldDescription("模块")
	private DesktopItem desktopItem;
	/**
	 * 角色ID
	 */
	@FieldDescription("角色ID")
	private Long roleId;
	/**
	 * 模块ID
	 */
	@FieldDescription("模块ID")
	private Long itemId;
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
	 * 角色
	 */
	public Role getRole(){
		return role;
	}
	public void setRole(Role role){
		this.role = role;
	}
	/**
	 * 模块
	 */
	public DesktopItem getDesktopItem(){
		return desktopItem;
	}
	public void setDesktopItem(DesktopItem desktopItem){
		this.desktopItem = desktopItem;
	}
	/**
	 * 角色ID
	 */
	public Long getRoleId(){
		return roleId;
	}
	public void setRoleId(Long roleId){
		this.roleId = roleId;
	}
	/**
	 * 模块ID
	 */
	public Long getItemId(){
		return itemId;
	}
	public void setItemId(Long itemId){
		this.itemId = itemId;
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