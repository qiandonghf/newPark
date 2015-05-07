package com.wiiy.cloud.capture.service;


import java.util.List;

import com.wiiy.cloud.capture.entity.WebContent;
import com.wiiy.cloud.capture.entity.WebInfo;
import com.wiiy.commons.service.IService;
import com.wiiy.core.entity.Org;
import com.wiiy.hibernate.Result;

public interface WebInfoService extends IService<WebInfo>{
	public void saveContent(WebContent webContent);

	public List<WebContent> getWebContentListByIdRegex(String id);

	public void updateContent(WebContent webContent);

	public List<WebContent> getContentById(Long id);
	
	
}
