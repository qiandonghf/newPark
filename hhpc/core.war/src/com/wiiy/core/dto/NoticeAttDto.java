package com.wiiy.core.dto;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;


/**
 * @author qd
 */
public class NoticeAttDto implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private long id;
	/**
	 * 附件名称
	 */
	private String name;
	/**
	 * 重命名名称
	 */
	private String newName;
	/**
	 * 附件大小
	 */
	private Long size;
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNewName() {
		return newName;
	}
	public void setNewName(String newName) {
		this.newName = newName;
	}
	public Long getSize() {
		return size;
	}
	public void setSize(Long size) {
		this.size = size;
	}
	

}