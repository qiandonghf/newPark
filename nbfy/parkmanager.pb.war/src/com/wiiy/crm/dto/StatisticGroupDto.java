package com.wiiy.crm.dto;

import java.util.ArrayList;
import java.util.List;

public class StatisticGroupDto {
	
	private Integer iid;
	private Long lid;
	private String name;
	private Integer amount;
	private List<StatisticGroupDto> groups;
	private List<StatisticDto> list;
	
	public StatisticGroupDto() {
		amount = 0;
		list = new ArrayList<StatisticDto>();
		groups = new ArrayList<StatisticGroupDto>();
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getAmount() {
		return amount;
	}
	public void setAmount(Integer amount) {
		this.amount = amount;
	}
	public List<StatisticDto> getList() {
		return list;
	}
	public void setList(List<StatisticDto> list) {
		this.list = list;
	}

	public Integer getIid() {
		return iid;
	}

	public void setIid(Integer iid) {
		this.iid = iid;
	}

	public Long getLid() {
		return lid;
	}

	public void setLid(Long lid) {
		this.lid = lid;
	}

	public List<StatisticGroupDto> getGroups() {
		return groups;
	}

	public void setGroups(List<StatisticGroupDto> groups) {
		this.groups = groups;
	}
	
}
