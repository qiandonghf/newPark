package com.wiiy.pb.service;

import com.wiiy.commons.service.IService;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.entity.Floor;

/**
 * @author my
 */
public interface FloorService extends IService<Floor> {

	/**
	 * 交换两个楼层顺序
	 * @param ids
	 * @return
	 */
	Result exchangeOrder(Long id1,Long id2);
}
