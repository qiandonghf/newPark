package com.wiiy.pb.service.impl;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.crm.entity.Bill;
import com.wiiy.crm.entity.BillPlanRent;
import com.wiiy.crm.entity.Contract;
import com.wiiy.crm.entity.SubjectRent;
import com.wiiy.crm.preferences.enums.BillPlanStatusEnum;
import com.wiiy.crm.preferences.enums.BillStatusEnum;
import com.wiiy.crm.preferences.enums.ContractStatusEnum;
import com.wiiy.crm.preferences.enums.PriceUnitEnum;
import com.wiiy.crm.preferences.enums.RentBillPlanFeeEnum;
import com.wiiy.crm.service.SubjectRentService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.pb.dao.RoomDao;
import com.wiiy.pb.entity.Room;
import com.wiiy.pb.entity.RoomAtt;
import com.wiiy.pb.entity.RoomChangeLog;
import com.wiiy.pb.entity.RoomFee;
import com.wiiy.pb.entity.RoomMemo;
import com.wiiy.pb.entity.RoomMonitor;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.preferences.enums.RoomStatusEnum;
import com.wiiy.pb.service.BuildingService;
import com.wiiy.pb.service.RoomAttService;
import com.wiiy.pb.service.RoomChangeLogService;
import com.wiiy.pb.service.RoomFeeService;
import com.wiiy.pb.service.RoomMemoService;
import com.wiiy.pb.service.RoomMonitorService;
import com.wiiy.pb.service.RoomService;

/**
 * @author my
 */
public class RoomServiceImpl implements RoomService {

	private RoomDao roomDao;
	private RoomAttService roomAttService;
	private RoomFeeService roomFeeService;
	private RoomMemoService roomMemoService;
	private RoomChangeLogService roomChangeLogService;
	private SubjectRentService subjectRentService;
	private RoomMonitorService roomMonitorService;
	private BuildingService buildingService;

	public void setBuildingService(BuildingService buildingService) {
		this.buildingService = buildingService;
	}

	public void setRoomMonitorService(RoomMonitorService roomMonitorService) {
		this.roomMonitorService = roomMonitorService;
	}

	public void setSubjectRentService(SubjectRentService subjectRentService) {
		this.subjectRentService = subjectRentService;
	}

	public void setRoomChangeLogService(
			RoomChangeLogService roomChangeLogService) {
		this.roomChangeLogService = roomChangeLogService;
	}

	public void setRoomMemoService(RoomMemoService roomMemoService) {
		this.roomMemoService = roomMemoService;
	}

	public void setRoomFeeService(RoomFeeService roomFeeService) {
		this.roomFeeService = roomFeeService;
	}

	public void setRoomAttService(RoomAttService roomAttService) {
		this.roomAttService = roomAttService;
	}

	public void setRoomDao(RoomDao roomDao) {
		this.roomDao = roomDao;
	}

	@Override
	public Result<Room> save(Room t) {
		try {
			List<Room> rooms = getListByFilter(new Filter(Room.class).eq("buildingId", t.getBuildingId())).getValue();
			if (rooms != null) {
				for (Room r : rooms) {
					if (r.getName().equals(t.getName())) {
						return Result.failure("房间名称不能重复");
					}
				}
			}
			t.setBuilding(buildingService.getBeanById(t.getBuildingId()).getValue());
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			roomDao.save(t);
			PbActivator.getOperationLogService().logLogout(
					"添加房间【" + t.getName() + "】");
			return Result.success(R.Room.SAVE_SUCCESS, t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil
					.getFieldDescriptionByColumnName(e.getUK(), Room.class)));
		} catch (Exception e) {
			return Result.failure(R.Room.SAVE_FAILURE);
		}
	}

	@Override
	public Result<Room> delete(Room t) {
		try {
			List<SubjectRent> subjectRents = subjectRentService
					.getListByFilter(
							new Filter(SubjectRent.class).eq("roomId",
									t.getId())).getValue();
			if (subjectRents != null && subjectRents.size() > 0) {
				return Result.failure("租赁合同中有相关联数据 请先删除");
			}
			List<RoomMemo> roomMemos = roomMemoService.getListByFilter(
					new Filter(RoomMemo.class).eq("roomId", t.getId()))
					.getValue();
			List<RoomChangeLog> roomChangeLogs = roomChangeLogService
					.getListByFilter(
							new Filter(RoomChangeLog.class).eq("roomId",
									t.getId())).getValue();
			List<RoomFee> roomFees = roomFeeService.getListByFilter(
					new Filter(RoomFee.class).eq("roomId", t.getId()))
					.getValue();
			List<RoomAtt> roomAtts = roomAttService.getListByFilter(
					new Filter(RoomAtt.class).eq("roomId", t.getId()))
					.getValue();
			for (RoomAtt roomAtt : roomAtts) {
				PbActivator.getOperationLogService().logLogout(
						"删除房间附件/图片【" + roomAtt.getName() + "】");
				roomAttService.delete(roomAtt);
			}
			for (RoomMemo roomMemo : roomMemos) {
				PbActivator.getOperationLogService().logLogout(
						"删除房间备注【" + roomMemo.getMemo() + "】");
				roomMemoService.delete(roomMemo);
			}
			for (RoomChangeLog roomChangeLog : roomChangeLogs) {
				PbActivator.getOperationLogService().logLogout(
						"删除房间变更记录【" + roomChangeLog.getContent() + "】");
				roomChangeLogService.delete(roomChangeLog);
			}
			for (RoomFee roomFee : roomFees) {
				PbActivator.getOperationLogService().logLogout(
						"删除房间费用【" + roomFee.getFeeType().toString() + "】");
				roomFeeService.delete(roomFee);
			}
			Result<Room> result = getBeanById(t.getId());
			String path = result.getValue().getPhotos();
			PbActivator.getResourcesService().delete(path);
			roomDao.delete(t);
			PbActivator.getOperationLogService().logLogout(
					"删除房间【" + t.getName() + "】");
			return Result.success(R.Room.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Room.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Room> deleteById(Serializable id) {
		try {
			Room room = getBeanById(id).getValue();
			Result<Room> result = delete(room);
			return result;
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Room.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Room> deleteByIds(String ids) {
		try {
			List<String> list = roomDao
					.getObjectListByHql("select r.photos from Room r where r.id in ("
							+ ids + ")");
			if (list != null) {
				for (String data : list) {
					String[] pathes = data.split(",");
					for (String path : pathes) {
						PbActivator.getResourcesService().delete(path);
					}
				}
			}
			Result<Room> result = null;
			List<Long> roomIds = roomDao
					.getObjectListByHql("select r.id from Room r where r.id in ("
							+ ids + ")");
			if (list != null) {
				for (Long id : roomIds) {
					Room room = getBeanById(id).getValue();
					result = delete(room);
				}
			}
			return result;
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.Room.DELETE_FAILURE);
		}
	}

	@Override
	public Result<Room> update(Room t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			roomDao.update(t);
			PbActivator.getOperationLogService().logLogout(
					"更新房间【" + t.getName() + "】");
			return Result.success(R.Room.UPDATE_SUCCESS);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil
					.getFieldDescriptionByColumnName(e.getUK(), Room.class)));
		} catch (Exception e) {
			return Result.failure(R.Room.UPDATE_FAILURE);
		}
	}

	@Override
	public Result<Room> getBeanById(Serializable id) {
		try {
			return Result.value(roomDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.Room.LOAD_FAILURE);
		}
	}

	@Override
	public Result<Room> getBeanByFilter(Filter filter) {
		try {
			return Result.value(roomDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Room.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Room>> getList() {
		try {
			return Result.value(roomDao.getList());
		} catch (Exception e) {
			return Result.failure(R.Room.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<Room>> getListByFilter(Filter filter) {
		try {
			return Result.value(roomDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.Room.LOAD_FAILURE);
		}
	}

	@Override
	public boolean checkNameUnique(Long buildingId, String name) {
		return roomDao.getRowCount(new Filter(Room.class).eq("buildingId",
				buildingId).eq("name", name)) == 0;
	}

	@Override
	public boolean checkNameUnique(Long buildingId, String name, Long excludeId) {
		return roomDao.getRowCount(new Filter(Room.class)
				.eq("buildingId", buildingId).ne("id", excludeId)
				.eq("name", name)) == 0;
	}

	public int isImg(String name) {
		String imgeArray[] = { "bmp", "dib", "gif", "jfif", "jpe", "jpeg",
				"jpg", "png", "tif", "tiff", "ico" };
		String suffixName = name.substring(name.lastIndexOf("."));
		String endStr = suffixName.substring(1, suffixName.length())
				.toLowerCase();
		int flag = 0;
		if (suffixName != null) {
			for (int i = 0; i < imgeArray.length; i++) {
				if (imgeArray[i].equals(endStr)) {
					flag = 1;
					break;
				}
			}
		}
		return flag;
	}

	public String[] minus(String[] arr1, String[] arr2) {
		LinkedList<String> list = new LinkedList<String>();
		LinkedList<String> history = new LinkedList<String>();
		String[] longerArr = arr1;
		String[] shorterArr = arr2;
		// 找出较长的数组来减较短的数组
		if (arr1.length > arr2.length) {
			longerArr = arr2;
			shorterArr = arr1;
		}
		for (String str : longerArr) {
			if (!list.contains(str)) {
				list.add(str);
			}
		}
		for (String str : shorterArr) {
			if (list.contains(str)) {
				history.add(str);
				list.remove(str);
			} else {
				if (!history.contains(str)) {
					list.add(str);
				}
			}
		}

		String[] result = {};
		return list.toArray(result);
	}

	@Override
	public Result<Room> mergeRoom(Room room1, Room room2, String newName) {
		Session session = null;
		Transaction tr = null;
		try {
			String name1 = room1.getName();
			String name2 = room2.getName();
			session = roomDao.openSession();
			tr = session.beginTransaction();
			List<SubjectRent> subjectRents = session.createQuery(
					"from SubjectRent where roomId = " + room1.getId()).list();
			List<SubjectRent> subjectRents2 = session.createQuery(
					"from SubjectRent where roomId = " + room2.getId()).list();
			if (subjectRents != null && subjectRents.size() > 0) {
				for (SubjectRent subjectRent : subjectRents) {
					if (subjectRent.getEndDate().getTime() < (new Date())
							.getTime()) {
					}else{
						return Result.failure("租赁合同中有房间【"+room1.getName()+"】相关联数据 请先处理");
					}
				}
			}
			
			if (subjectRents2 != null && subjectRents2.size() > 0) {
				for (SubjectRent subjectRent : subjectRents2) {
					if (subjectRent.getEndDate().getTime() < (new Date())
							.getTime()) {
						subjectRent.setRoomId(room1.getId());
						session.update(subjectRent);
					}else{
						return Result.failure("租赁合同中有房间【"+room2.getName()+"】相关联数据 请先处理");
					}
				}
			}
			List<BillPlanRent> billPlanRents  = session.createQuery(
					"from Bill where roomId = " + room1.getId()).list();
			if(billPlanRents!=null && billPlanRents.size()>0){
				for (BillPlanRent billPlanRent : billPlanRents) {
					if(billPlanRent.getStatus().equals(BillPlanStatusEnum.UNCHECK)){
						return Result.failure("房间【"+room1.getName()+"】中还有资金计划未出帐");
					}
				}
			}
			List<BillPlanRent> billPlanRents2  = session.createQuery(
					"from Bill where roomId = " + room2.getId()).list();
			if(billPlanRents2!=null && billPlanRents2.size()>0){
				for (BillPlanRent billPlanRent : billPlanRents2) {
					if(billPlanRent.getStatus().equals(BillPlanStatusEnum.UNCHECK)){
						return Result.failure("房间【"+room2.getName()+"】中还有资金计划未出帐");
					}else{
						billPlanRent.setRoomId(room1.getId());
					}
				}
			}
			List<Bill> bills = session.createQuery(
					"from Bill where roomId = " + room1.getId()).list();
			List<Bill> bills2 = session.createQuery(
					"from Bill where roomId = " + room2.getId()).list();
			if(bills!=null && bills.size()>0){
				for (Bill bill : bills) {
					if(bill.getStatus().equals(BillStatusEnum.UNPAID)){
						return Result.failure("房间【"+room1.getName()+"】中还有未结算账单 请先处理");
					}
				}
			}
			if(bills2!=null && bills2.size()>0){
				for (Bill bill : bills2) {
					if(bill.getStatus().equals(BillStatusEnum.UNPAID)){
						return Result.failure("房间【"+room2.getName()+"】中还有未结算账单 请先处理");
					}else{
						bill.setRoomId(room1.getId());
					}
				}
			}
			room1.setName(newName);
			if (room1.getBuildingArea() == null) {
				room1.setBuildingArea(BigDecimal.valueOf(0));
			}
			if (room2.getBuildingArea() == null) {
				room2.setBuildingArea(BigDecimal.valueOf(0));
			}
			if (room1.getRealArea() == null) {
				room1.setRealArea(BigDecimal.valueOf(0));
			}
			if (room2.getRealArea() == null) {
				room2.setRealArea(BigDecimal.valueOf(0));
			}
			room1.setBuildingArea(room1.getBuildingArea().add(
					room2.getBuildingArea()));
			room1.setRealArea(room1.getRealArea().add(room2.getRealArea()));
			List<RoomAtt> roomAtts = session.createQuery(
					"from RoomAtt where roomId = " + room2.getId()).list();
			List<RoomMemo> roomMemos = session.createQuery(
					"from RoomMemo where roomId = " + room2.getId()).list();
			List<RoomChangeLog> roomChangeLogs = session.createQuery(
					"from RoomChangeLog where roomId = " + room2.getId())
					.list();
			List<RoomFee> roomFees2 = session.createQuery(
					"from RoomFee where roomId = " + room2.getId()).list();
			List<RoomFee> roomFees = session.createQuery(
					"from RoomFee where roomId = " + room1.getId()).list();
			List<RoomMonitor> roomMonitors = session.createQuery(
					"from RoomMonitor where roomId = " + room2.getId()).list();
			if (roomAtts != null && roomAtts.size() > 0) {
				for (RoomAtt roomAtt : roomAtts) {
					int flag = isImg(roomAtt.getName());
					if (flag == 1) {
						room1.setPhotos(roomAtt.getNewName() + ","
								+ room1.getPhotos());
					}
					roomAtt.setRoomId(room1.getId());
					session.update(roomAtt);
				}
			}
			if (roomMonitors != null && roomMonitors.size() > 0) {
				for (RoomMonitor roomMonitor : roomMonitors) {
					roomMonitor.setRoomId(room1.getId());
					session.update(roomMonitor);
				}
			}
			if (roomMemos != null && roomMemos.size() > 0) {
				for (RoomMemo roomMemo : roomMemos) {
					roomMemo.setRoomId(room1.getId());
					session.update(roomMemo);
				}
			}
			if (roomChangeLogs != null && roomChangeLogs.size() > 0) {
				for (RoomChangeLog roomChangeLog : roomChangeLogs) {
					roomChangeLog.setRoomId(room1.getId());
					session.update(roomChangeLog);
				}
			}
			Map<RentBillPlanFeeEnum, RoomFee> map = new HashMap<RentBillPlanFeeEnum, RoomFee>();
			if (roomFees2 != null && roomFees2.size() > 0) {
				for (RoomFee roomFee : roomFees2) {
					roomFee.setRoomId(room1.getId());
					session.update(roomFee);
					map.put(roomFee.getFeeType(), roomFee);
				}
			}
			for (RoomFee roomFee : roomFees) {
				if (map.get(roomFee.getFeeType()) != null) {
					RoomFee fee = map.get(roomFee.getFeeType());
					fee.setAmount(fee.getAmount() + roomFee.getAmount());
					session.update(fee);
					session.createQuery(
							"delete RoomFee where id = " + roomFee.getId())
							.executeUpdate();
				}
			}
			RoomChangeLog roomChangeLog = new RoomChangeLog();
			roomChangeLog.setContent(name1 + "与" + name2 + "合并为" + newName);
			roomChangeLog.setRoomId(room1.getId());
			roomChangeLog.setCreateTime(new Date());
			roomChangeLog
					.setCreator(PbActivator.getSessionUser().getRealName());
			roomChangeLog.setCreatorId(PbActivator.getSessionUser().getId());
			roomChangeLog.setModifyTime(room1.getCreateTime());
			roomChangeLog.setModifier(room1.getCreator());
			roomChangeLog.setModifierId(room1.getCreatorId());
			roomChangeLog.setEntityStatus(EntityStatus.NORMAL);
			roomChangeLog.setTypeId("pb.000801");
			session.save(roomChangeLog);
			session.update(room1);
			session.createQuery("delete Room where id = " + room2.getId())
					.executeUpdate();
			tr.commit();
			PbActivator.getOperationLogService().logLogout(
					name1 + "与" + name2 + "合并房间为【" + newName + "】");
			return Result.success("房间合并成功", room1);
		} catch (Exception e) {
			tr.rollback();
			return Result.failure("房间合并失败");
		} finally {
			session.close();
		}
	}

	@Override
	public Result<Room> roomBroken(Room room, String name1, String name2) {
		Session session = null;
		Transaction tr = null;
		try {
			session = roomDao.openSession();
			tr = session.beginTransaction();
			String name = room.getName();
			Room room2 = new Room();
			BeanUtil.copyProperties(room, room2);
			room2.setName(name2);
			room2.setCustomerName(null);
			room2.setCustomerId(null);
			room2.setEndDate(null);
			room2.setBuildingArea(BigDecimal.ZERO);
			room2.setRealArea(BigDecimal.ZERO);
			room2.setPhotos("");
			session.save(room2);
			room.setName(name1);
			session.update(room);
			RoomChangeLog roomChangeLog = new RoomChangeLog();
			roomChangeLog.setContent(room.getName() + "拆分为" + name1 + "与"
					+ name2);
			roomChangeLog.setRoomId(room.getId());
			roomChangeLog.setCreateTime(new Date());
			roomChangeLog
					.setCreator(PbActivator.getSessionUser().getRealName());
			roomChangeLog.setCreatorId(PbActivator.getSessionUser().getId());
			roomChangeLog.setModifyTime(room.getCreateTime());
			roomChangeLog.setModifier(room.getCreator());
			roomChangeLog.setModifierId(room.getCreatorId());
			roomChangeLog.setEntityStatus(EntityStatus.NORMAL);
			roomChangeLog.setTypeId("pb.000802");
			session.save(roomChangeLog);
			PbActivator.getOperationLogService().logLogout(
					"拆分房间【" + name + "】为" + room.getName() + "和"
							+ room2.getName());
			tr.commit();
			return Result.success("房间拆分成功");
		} catch (Exception e) {
			tr.rollback();
			return Result.failure("房间拆分失败");
		} finally {
			session.close();
		}
	}

	@Override
	public Result<Room> updateRoomCustomer(Session session, Long roomId,
			Contract contract,SubjectRent subjectRent) {
		try {
			Room room = (Room) session.get(Room.class, roomId);
			if (contract.getState().equals(ContractStatusEnum.CLOSED)) {
				room.setCustomerName(null);
				room.setCustomerId(null);
				room.setEndDate(null);
				room.setRoomEndDate(null);
				room.setStatus(RoomStatusEnum.IDLE);
				room.setRentPrice(null);
			} else if (contract.getState().equals(ContractStatusEnum.EXECUTE)) {
				room.setCustomerId(contract.getCustomer().getId());
				room.setCustomerName(contract.getCustomer().getName());
				room.setRoomEndDate(subjectRent.getEndDate());
				room.setStatus(RoomStatusEnum.USING);
				room.setEndDate(contract.getEndDate());
				long time1 = subjectRent.getStartDate().getTime();
				long time2 = subjectRent.getEndDate().getTime();
				int days = (int) ((time2-time1)/(1000*60*60*24));
				double propertyFee = 0;
				if(contract.getPropertyUnit()!=null){
					propertyFee = days/30.0*subjectRent.getRoomArea()*contract.getPropertyUnit().doubleValue();
				}
				if(subjectRent.getRentPriceUnit()==PriceUnitEnum.DAY){
					room.setRentPrice(BigDecimal.valueOf(days*subjectRent.getRoomArea()*subjectRent.getRentPrice()+propertyFee));
				}else if(subjectRent.getRentPriceUnit()==PriceUnitEnum.MONTH){
					room.setRentPrice(BigDecimal.valueOf(days/30.0*subjectRent.getRoomArea()*subjectRent.getRentPrice()+propertyFee));
				}else if(subjectRent.getRentPriceUnit()==PriceUnitEnum.ONCE){
					room.setRentPrice(BigDecimal.valueOf(subjectRent.getRentPrice()+propertyFee));
				}
			}
			session.update(room);
			return Result.success(R.Room.UPDATE_SUCCESS, room);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil
					.getFieldDescriptionByColumnName(e.getUK(), Room.class)));
		} catch (Exception e) {
			return Result.failure(R.Room.UPDATE_FAILURE);
		}
	}
	
	@Override
	public Result<List<Room>> getListByHql(String hql) {
		try {
			return Result.value(roomDao.getListByHql(hql));
		} catch (Exception e) {
			return Result.failure(R.Room.LOAD_FAILURE);
		}
	}

}
