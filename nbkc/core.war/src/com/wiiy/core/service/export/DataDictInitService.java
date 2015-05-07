package com.wiiy.core.service.export;

import java.util.List;

import com.wiiy.core.entity.DataDict;

public interface DataDictInitService {

	public boolean init(List<DataDict> list);
	
	public List<DataDict> getDataDictByParentId(String parentId);
	
	public DataDict getDataDictById(String id);
	
	/*public void initSql(String sql);
	
	public void initSql(String[] sql);*/
	
}
