package com.wiiy.core.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.entity.DataDict;
import com.wiiy.core.service.DataDictService;
import com.wiiy.core.service.export.DataDictInitService;
import com.wiiy.hibernate.Filter;

public class DataDictInitServiceImpl implements DataDictInitService {
	
	private static final Log logger = LogFactory.getLog(CoreActivator.class);
	private DataDictService dataDictService;

	public void setDataDictService(DataDictService dataDictService) {
		this.dataDictService = dataDictService;
	}
	
	public boolean init(List<DataDict> list){
		logger.debug("初始化数据字典");
//		return dataDictService.init(list);
		return true;
	}

	@Override
	public List<DataDict> getDataDictByParentId(String parentId) {
		return dataDictService.getListByFilter(new Filter(DataDict.class).eq("parentId",parentId).orderBy("displayOrder", Filter.ASC)).getValue();
	}

	@Override
	public DataDict getDataDictById(String id) {
		return dataDictService.getBeanById(id).getValue();
	}

	@Override
	public List<DataDict> getDataDictsByDataName(String dataName) {
		return dataDictService.getListByFilter(new Filter(DataDict.class).eq("dataName",dataName).orderBy("displayOrder", Filter.ASC)).getValue();
	}

	@Override
	public void initSql(String sql) {
		//dataDictService.initSql(sql);
	}

	@Override
	public void initSql(String[] sqls) {
		//dataDictService.initSql(sqls);
	}
	
}
