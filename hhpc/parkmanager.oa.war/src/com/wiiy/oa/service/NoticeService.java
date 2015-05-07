package com.wiiy.oa.service;

import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.Notice;

/**
 * @author my
 */
public interface NoticeService extends IService<Notice> {
	Result save(Notice t,String attAddress);

	Result update(Notice t, String attAddress);

	int getRowCount(); 
}
