package com.wiiy.core.dto;

import java.util.Date;

/**
 * User: Aswan
 * 
 * */
public class DBDto {
	
	
	private String name;//备份文件名
	
	private Date createTime;//创建时间
	
	private long size;//大小

    private String sizeStr;//大小字符串表示
    
    private String path;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public long getSize() {
		return size;
	}

	public void setSize(long size) {
		this.size = size;
	}

	public String getSizeStr() {
		if(size<1024)sizeStr=size+"B";
		else if(size<1024*1024)sizeStr=size/1024+"KB";
		else if(size<1024*1024*1024)sizeStr=size/1024/1024+"MB";
		else if(size<1024*1024*1024*1024)sizeStr=size/1024/1024/1024+"GB";
		else sizeStr="未知大小";
		
		return sizeStr;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}
    
}
