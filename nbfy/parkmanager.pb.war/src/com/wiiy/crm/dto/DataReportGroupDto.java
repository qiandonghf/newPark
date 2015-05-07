package com.wiiy.crm.dto;

import java.util.ArrayList;
import java.util.List;

public class DataReportGroupDto {
	
	private Long id;
//	private DataReportDefGroup group;
	private List<DataReportPropertyDto> list;
	
	public DataReportGroupDto() {
		list = new ArrayList<DataReportPropertyDto>();
	}
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

/*	public DataReportDefGroup getGroup() {
		return group;
	}
	public void setGroup(DataReportDefGroup group) {
		this.group = group;
	}*/
	public List<DataReportPropertyDto> getList() {
		return list;
	}
	public void setList(List<DataReportPropertyDto> list) {
		this.list = list;
	}
	
	

}
