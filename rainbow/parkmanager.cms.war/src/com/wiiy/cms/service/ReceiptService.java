package com.wiiy.cms.service;

import com.wiiy.commons.service.IService;
import com.wiiy.cms.entity.Receipt;
import com.wiiy.hibernate.Result;

/**
 * @author my
 */
public interface ReceiptService extends IService<Receipt> {
	Result<Receipt> deleteByIds(String ids,Long articleId);
}
