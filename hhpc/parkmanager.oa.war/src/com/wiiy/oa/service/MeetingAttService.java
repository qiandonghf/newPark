package com.wiiy.oa.service;

import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.MeetingAtt;

/**
 * @author my
 */
public interface MeetingAttService extends IService<MeetingAtt> {

	Result<MeetingAtt> save(MeetingAtt meetingAtt, String attAddress);
}
