package com.wiiy.cms.service;

import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;
import com.wiiy.cms.entity.Document;

public interface DocumentService extends IService<Document>{

	Result<Document> saveFolder(Document document);

	Result<Document> updateFolder(Document dbBean);

	Result<Document> moveTo(Long id, Long toId);

}
