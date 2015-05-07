package com.wiiy.cloud.capture.external.service.impl;

import java.util.List;


import com.wiiy.cloud.capture.dao.WebContentDao;
import com.wiiy.cloud.capture.entity.WebContent;
import com.wiiy.cloud.capture.external.service.WebContentPubService;
import com.wiiy.hibernate.Filter;

public class WebContentPubServiceImpl implements WebContentPubService{
	private WebContentDao webContentDao;
	public void setWebContentDao(WebContentDao webContentDao) {
		this.webContentDao = webContentDao;
	}
	@Override
	public List<WebContent> getWebContentList() {
		return webContentDao.getListByHql("from WebContent order by release_date desc");
	}
	@Override
	public WebContent getImageNews() {
		return webContentDao.getBeanByFilter(new Filter(WebContent.class).notNull("content"));
	}
}
