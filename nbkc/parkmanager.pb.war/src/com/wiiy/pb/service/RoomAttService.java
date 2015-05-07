package com.wiiy.pb.service;

import java.io.Serializable;

import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.entity.RoomAtt;

/**
 * @author my
 */
public interface RoomAttService extends IService<RoomAtt> {

	Result<RoomAtt> deleteByAttId(Serializable id);

}
