package com.wiiy.cms.service;

import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;
import com.wiiy.cms.entity.Document;

public interface DocShareService extends IService<Document>{

	Result<Document> share(Document dbBean);

	Result<Document> moveTo(Long id, Long toId);

	Result shareDel(Long id, Long parentDocId);
	

}
