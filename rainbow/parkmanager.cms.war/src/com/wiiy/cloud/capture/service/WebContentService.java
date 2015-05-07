package com.wiiy.cloud.capture.service;


import java.util.List;

import com.wiiy.cloud.capture.entity.WebContent;
import com.wiiy.cloud.capture.entity.WebInfo;
import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

public interface WebContentService extends IService<WebContent>{

	WebInfo getWebInfoByName(String name);

	List<WebInfo> getWebInfoList();

	void updateWebInfoTime(WebInfo webInfo);

	Result doBackUp();

	Result getRowCount(Filter filter);
	
}
