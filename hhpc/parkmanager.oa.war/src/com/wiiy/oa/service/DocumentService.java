package com.wiiy.oa.service;

import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.Document;

public interface DocumentService extends IService<Document>{

	Result<Document> saveFolder(Document document);

	Result<Document> updateFolder(Document dbBean);

	Result<Document> moveTo(Long id, Long toId);
	
	Result<Document> publish(Long id,BooleanEnum isFolder);
	
	Result<Document> back(Long id,BooleanEnum isFolder);

}
