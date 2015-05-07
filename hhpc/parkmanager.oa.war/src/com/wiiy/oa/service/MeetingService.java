package com.wiiy.oa.service;

import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.Meeting;

/**
 * @author my
 */
public interface MeetingService extends IService<Meeting> {

	Result<Meeting> update(Meeting dbBean, String attAddress);
}
