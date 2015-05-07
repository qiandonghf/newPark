package com.wiiy.oa.service;

import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.Document;

public interface DocShareService extends IService<Document>{

	Result<Document> share(Document dbBean);

	Result<Document> moveTo(Long id, Long toId);

	Result shareDel(Long id, Long parentDocId);
	

}
