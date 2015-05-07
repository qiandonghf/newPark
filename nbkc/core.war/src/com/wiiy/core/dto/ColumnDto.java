package com.wiiy.core.dto;

import com.wiiy.commons.entity.TreeEntity;

public class ColumnDto extends TreeEntity {
	private Long id ;
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	private String columnName;


	public String getColumnName() {
		return columnName;
	}

	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	
	private String superId ;
	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}
}
