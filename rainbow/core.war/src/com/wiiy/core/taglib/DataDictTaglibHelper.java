package com.wiiy.core.taglib;

import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.entity.DataDict;

public class DataDictTaglibHelper {
	public static Map<String, String> getValueMapByKey(String key){
		Map<String,String> map = new TreeMap<String, String>();
		List<DataDict> dataDictList = CoreActivator.getDataDictInitService().getDataDictByParentId(key);
		for (DataDict dataDict : dataDictList) {
			map.put(dataDict.getId(), dataDict.getDataValue());
		}
		return map;
	}
}
