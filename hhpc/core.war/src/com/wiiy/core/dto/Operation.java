package com.wiiy.core.dto;

import java.util.Arrays;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 11-10-22
 * Time: 上午11:36
 * To change this template use File | Settings | File Templates.
 */
public class Operation {
	
	public static final String urisSeparator = "\\s+";

	private String id;
	
	private String name;
	
	private String[] uris;
	
	private Module module;
	
    public Operation() {
    }

    public Operation(String id, String name, String uris) {
    	this.id = id;
    	this.name = name;
    	this.uris = uris.split(urisSeparator); 
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

	public String[] getUris() {
		return uris;
	}

	public void setUris(String uris) {
		this.uris = uris.split(urisSeparator);
	}
	
	public Module getModule() {
		return module;
	}

	public void setModule(Module module) {
		this.module = module;
	}
	
    public String getGlobalId() {
    	return module.getId() + "_" + id;
    }

	@Override
	public String toString() {
		return "Operation [id=" + id + ", name=" + name + ", uris="
				+ Arrays.toString(uris) + "]";
	}

	public String getKey() {
		return null;
	}
  
}
