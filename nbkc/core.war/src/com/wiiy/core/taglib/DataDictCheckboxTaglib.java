package com.wiiy.core.taglib;

import java.util.Map;

import com.wiiy.commons.taglib.AbstractCheckboxTaglib;

public class DataDictCheckboxTaglib extends AbstractCheckboxTaglib {
	
	private String key;

	@Override
	protected Map<String, String> getValueMap() {
		return DataDictTaglibHelper.getValueMapByKey(key);
	}

	public void setKey(String key) {
		this.key = key;
	}

}
