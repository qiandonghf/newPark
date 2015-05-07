package com.wiiy.core.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.wiiy.core.preferences.R;
import com.wiiy.core.service.export.FKService;

public class FKServiceImpl implements FKService{
	
	private static Map<String,String> fkMap = new HashMap<String, String>();

	@Override
	public void registryFK(Map<String,List<String>> map) {
		for (String key : map.keySet()) {
			for (String fk : map.get(key)) {
				fkMap.put(fk, key);
//				logger.debug("registerFK 【"+key+"】 "+fk);
			}
		}
	}

	@Override
	public String getFKClassDescription(String fk) {
		if(fkMap.containsKey(fk)){
			return fkMap.get(fk);
		} else {
			return R.DEFAULT_FK_MESSAGE+"("+fk+")!";
		}
	}

}
