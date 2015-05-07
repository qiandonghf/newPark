package com.wiiy.pb.service;

import java.util.List;

import org.hibernate.Session;

import com.wiiy.commons.service.IService;
import com.wiiy.crm.entity.Contract;
import com.wiiy.crm.entity.SubjectRent;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.entity.Room;

/**
 * @author my
 */
public interface RoomService extends IService<Room> {
	
	boolean checkNameUnique(Long buildingId,String name);
	
	boolean checkNameUnique(Long buildingId,String name,Long excludeId);
	
	String[] minus(String[] arr1, String[] arr2);
	
	int isImg(String name);

	Result<Room> mergeRoom(Room room1, Room room2,String newName);

	Result<Room> roomBroken(Room room, String string, String string2);
	
	Result<Room> updateRoomCustomer(Session session,Long roomId,Contract contract,SubjectRent subjectRent);
	
	Result<List<Room>> getListByHql(String hql);
}
