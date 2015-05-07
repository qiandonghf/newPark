package com.wiiy.core.service.export;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


public interface FKService {
	
	public static final Log logger = LogFactory.getLog(FKService.class);
	
	void registryFK(Map<String,List<String>> map);
	
	String getFKClassDescription(String fk);

}
