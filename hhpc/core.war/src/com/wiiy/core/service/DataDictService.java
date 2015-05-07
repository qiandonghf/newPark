package com.wiiy.core.service;

import java.util.List;

import com.wiiy.commons.service.IService;
import com.wiiy.core.entity.DataDict;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public interface DataDictService extends IService<DataDict> {
	
	public boolean init(List<DataDict> list);
	
	public Result<List<DataDict>> listCategory(String moduleName);

	/*public void initSql(String sql);
	
	public void initSql(String[] sql);*/
	
}
