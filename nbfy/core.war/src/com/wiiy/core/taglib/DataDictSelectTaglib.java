package com.wiiy.core.taglib;

import java.util.Map;

import com.wiiy.commons.taglib.AbstractSelectTaglib;

public class DataDictSelectTaglib extends AbstractSelectTaglib {

	private String key;

	@Override
	protected Map<String, String> getValueMap() {
		return DataDictTaglibHelper.getValueMapByKey(key);
	}

	public void setKey(String key) {
		this.key = key;
	}

}
