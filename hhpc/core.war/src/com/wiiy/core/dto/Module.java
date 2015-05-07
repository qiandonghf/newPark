package com.wiiy.core.dto;

import java.util.ArrayList;
import java.util.List;

/**
 * User: Administrator
 * Date: 11-10-22
 * To change this template use File | Settings | File Templates.
 */
public class Module {
	
	private String id;
	
	private String name;
	
	private int orderCode;
	
	private String icon;
	
	private boolean display;

    private List<Menu> menus = new ArrayList<Menu>();

    private List<Operation> operationList = new ArrayList<Operation>();
    
    public Module() {
    }

    public Module(String id, String name, int orderCode) {
    	this.id=id;
    	this.name = name;
    	this.orderCode = orderCode;
    }

    public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(int orderCode) {
		this.orderCode = orderCode;
	}
	
	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}


	public List<Menu> getMenus() {
        return menus;
    }

    public void setMenus(List<Menu> menus) {
        this.menus = menus;
    }
    
    public boolean isEnterpriseService() {
    	return id == "5";
    }
    
    public List<Operation> getOperationList() {
		return operationList;
	}

	public void setOperationList(List<Operation> operationList) {
		this.operationList = operationList;
	}

	public boolean isDink() {
    	return menus == null || menus.size() == 0;
    }
    
	public String getKey() {
		return id + "_" + id;
	}
	
	@Override
	public String toString() {
		return "Module [id=" + id + ", name=" + name + ", orderCode="
				+ orderCode + ", menus=" + menus + "]";
	}

	public boolean isDisplay() {
		return display;
	}

	public void setDisplay(boolean display) {
		this.display = display;
	}

    
}
