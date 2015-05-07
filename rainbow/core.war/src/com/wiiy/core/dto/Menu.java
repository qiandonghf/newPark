package com.wiiy.core.dto;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 11-10-22
 * Time: 上午11:35
 * To change this template use File | Settings | File Templates.
 */
public class Menu {

	private String id;

	private String name;

    private int orderCode;

    protected String[] uris;

    private String icon;
    
    private Module module;
    
    private Menu parent;

    private List<Menu> subMenus = new ArrayList<Menu>();

    private List<Operation> operationList = new ArrayList<Operation>();

    public Menu() {
    }

    public Menu(String id, String name, int orderCode, String[] uris, String icon) {
		this.id = id;
		this.name = name;
		this.orderCode = orderCode;
		this.uris = uris;
		this.icon = icon;
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

    public String getUri() {
        return isLeaf() ? (uris != null && uris.length > 0 ? uris[0] : "javascript:void(0)") : "javascript:void(0)";
    }

	public void setUris(String uris) {
		if (uris != null) {
			this.uris = uris.split(Operation.urisSeparator);
		}
	}

	public String[] getUris() {
		return uris;
	}

	public Module getModule() {
		return module;
	}

	public void setModule(Module module) {
		this.module = module;
	}

	public Menu getParent() {
		return parent;
	}

	public void setParent(Menu parent) {
		this.parent = parent;
	}

	public List<Menu> getSubMenus() {
        return subMenus;
    }

    public void setSubMenus(List<Menu> subMenus) {
        this.subMenus = subMenus;
    }

    public List<Operation> getOperationList() {
        return operationList;
    }

    public void setOperationList(List<Operation> operationList) {
        this.operationList = operationList;
    }

    public boolean isLeaf() {
        return subMenus.size() == 0;
    }

    public boolean isDink() {
        return (subMenus == null || subMenus.size() == 0) && 
        		(operationList == null || operationList.size() == 0);
    }

    public String getKey() {
        return module.getId() + "_" + id;
    }

    public String getPageRef() {
        if (uris != null && uris.length > 0) {
            return uris[0].replaceAll("\\/", "_");
        }
        return null;
    }
    
    public String getGlobalId() {
    	return module.getId() + "_" + id;
    }
	
	@Override
	public String toString() {
		return "Menu [id=" + id + ", name=" + name + ", orderCode=" + orderCode
				+ ", uri=" + uris + ", icon=" + icon + ", module.id=" + module.getId()
				+ ", subMenus=" + subMenus + ", operationList=" + operationList
				+ "]";
	}
}
