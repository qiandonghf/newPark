package com.wiiy.pb.service.impl;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.EntityStatus;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.crm.entity.Bill;
import com.wiiy.crm.entity.BillPlanRent;
import com.wiiy.crm.entity.BillType;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.preferences.enums.BillInOutEnum;
import com.wiiy.crm.preferences.enums.BillStatusEnum;
import com.wiiy.crm.preferences.enums.RentBillPlanFeeEnum;
import com.wiiy.crm.service.BillService;
import com.wiiy.crm.service.BillTypeService;
import com.wiiy.crm.service.CustomerService;
import com.wiiy.hibernate.FKConstraintException;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.ModulePrefixNamingStrategy;
import com.wiiy.hibernate.Result;
import com.wiiy.hibernate.UKConstraintException;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.pb.dao.MeterLabelRecordDao;
import com.wiiy.pb.dto.FeeStatementsDto;
import com.wiiy.pb.entity.Building;
import com.wiiy.pb.entity.Meter;
import com.wiiy.pb.entity.MeterLabel;
import com.wiiy.pb.entity.MeterLabelRecord;
import com.wiiy.pb.entity.Park;
import com.wiiy.pb.entity.Room;
import com.wiiy.pb.entity.RoomMeterFee;
import com.wiiy.pb.preferences.R;
import com.wiiy.pb.preferences.enums.MeterEleFeeEnum;
import com.wiiy.pb.preferences.enums.MeterRecordStatusEnum;
import com.wiiy.pb.preferences.enums.MeterTypeEnum;
import com.wiiy.pb.service.MeterLabelRecordService;
import com.wiiy.pb.service.MeterLabelService;
import com.wiiy.pb.service.MeterService;
import com.wiiy.pb.service.ParkService;
import com.wiiy.pb.service.RoomMeterFeeService;

public class MeterLabelRecordServiceImpl implements MeterLabelRecordService{
	private MeterLabelRecordDao meterLabelRecordDao;
	private MeterLabelService meterLabelService;
	private MeterService meterService;
	private ParkService parkService;
	private BillService billService;
	private BillTypeService billTypeService;
	private CustomerService customerService;
	private RoomMeterFeeService roomMeterFeeService;
	public void setRoomMeterFeeService(RoomMeterFeeService roomMeterFeeService) {
		this.roomMeterFeeService = roomMeterFeeService;
	}

	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}

	public void setBillTypeService(BillTypeService billTypeService) {
		this.billTypeService = billTypeService;
	}

	public void setBillService(BillService billService) {
		this.billService = billService;
	}

	public void setParkService(ParkService parkService) {
		this.parkService = parkService;
	}

	public void setMeterService(MeterService meterService) {
		this.meterService = meterService;
	}

	public void setMeterLabelService(MeterLabelService meterLabelService) {
		this.meterLabelService = meterLabelService;
	}

	public void setMeterLabelRecordDao(MeterLabelRecordDao meterLabelRecordDao) {
		this.meterLabelRecordDao = meterLabelRecordDao;
	}

	@Override
	public Result<MeterLabelRecord> save(MeterLabelRecord t) {
		try {
			t.setCreateTime(new Date());
			t.setCreator(PbActivator.getSessionUser().getRealName());
			t.setCreatorId(PbActivator.getSessionUser().getId());
			t.setModifyTime(t.getCreateTime());
			t.setModifier(t.getCreator());
			t.setModifierId(t.getCreatorId());
			t.setEntityStatus(EntityStatus.NORMAL);
			meterLabelRecordDao.save(t);
			return Result.success(R.MeterLabelRecord.SAVE_SUCCESS, t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),MeterLabelRecord.class)));
		} catch (Exception e) {
			return Result.failure(R.MeterLabelRecord.SAVE_FAILURE);
		}
	}

	@Override
	public Result<MeterLabelRecord> update(MeterLabelRecord t) {
		try {
			t.setModifyTime(new Date());
			t.setModifier(PbActivator.getSessionUser().getRealName());
			t.setModifierId(PbActivator.getSessionUser().getId());
			meterLabelRecordDao.update(t);
			return Result.success(R.MeterLabelRecord.UPDATE_SUCCESS,t);
		} catch (UKConstraintException e) {
			return Result.failure(R.getUKMessage(BeanUtil.getFieldDescriptionByColumnName(e.getUK(),MeterLabelRecord.class)));
		} catch (Exception e) {
			return Result.failure(R.MeterLabelRecord.UPDATE_FAILURE);
		}
	}
	
	@Override
	public Result<MeterLabelRecord> delete(MeterLabelRecord t) {
		try {
			meterLabelRecordDao.delete(t);
			return Result.success(R.MeterLabelRecord.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.MeterLabelRecord.DELETE_FAILURE);
		}
	}

	@Override
	public Result<MeterLabelRecord> deleteById(Serializable id) {
		try {
			meterLabelRecordDao.deleteById(id);
			return Result.success(R.MeterLabelRecord.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.MeterLabelRecord.DELETE_FAILURE);
		}
	}

	@Override
	public Result<MeterLabelRecord> deleteByIds(String ids) {
		try {
			meterLabelRecordDao.deleteByIds(ids);
			System.out.println(ids);
			return Result.success(R.MeterLabelRecord.DELETE_SUCCESS);
		} catch (FKConstraintException e) {
			return Result.failure(PbActivator.getFKMessage(e.getFK()));
		} catch (Exception e) {
			return Result.failure(R.MeterLabelRecord.DELETE_FAILURE);
		}
	}

	@Override
	public Result<MeterLabelRecord> getBeanByFilter(Filter filter) {
		try {
			return Result.value(meterLabelRecordDao.getBeanByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.MeterLabelRecord.LOAD_FAILURE);
		}
	}

	@Override
	public Result<MeterLabelRecord> getBeanById(Serializable id) {
		try {
			return Result.value(meterLabelRecordDao.getBeanById(id));
		} catch (Exception e) {
			return Result.failure(R.MeterLabelRecord.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<MeterLabelRecord>> getList() {
		try {
			return Result.value(meterLabelRecordDao.getList());
		} catch (Exception e) {
			return Result.failure(R.MeterLabelRecord.LOAD_FAILURE);
		}
	}

	@Override
	public Result<List<MeterLabelRecord>> getListByFilter(Filter filter) {
		try {
			return Result.value(meterLabelRecordDao.getListByFilter(filter));
		} catch (Exception e) {
			return Result.failure(R.MeterLabelRecord.LOAD_FAILURE);
		}
	}

	@Override
	public Result addMeter(Long labelId, List<String> existList, List<String> newList) {
		Session session = null;
		Transaction tr = null;
		try{
			session = meterLabelRecordDao.openSession();
			tr = session.beginTransaction();
			String sql = "";
			String addIds = "";
			String delIds = "";
			for (String id : newList) {
				if(!existList.contains(id)){
					addIds += id + ",";
				}
			}
			if(addIds.endsWith(",")){
				addIds = addIds.substring(0,addIds.length()-1);
			}
			
			for(String oldId : existList){
				if(!newList.contains(oldId)){
					delIds += oldId+",";
				}
			}
			if(delIds.endsWith(",")){
				delIds = delIds.substring(0,delIds.length()-1);
			}
			
			if(addIds.length()>0){
			sql = "SELECT m.id, m.pre_reading, m.reading_date,m.room_ids,m.orderNo,m.type,m.meter_factor,m.building_id,m.park_id  FROM "+ModulePrefixNamingStrategy.classToTableName(Meter.class)+" m " +
					"WHERE m.id in ("+addIds+")" +
					"GROUP BY m.id, m.pre_reading, m.reading_date,m.room_ids,m.orderNo,m.type,m.meter_factor,m.building_id,m.park_id ";
			List<Object> list = new ArrayList<Object>();
			list = meterLabelRecordDao.getObjectListBySql(sql);
			for (Object object : list) {
				Object[] objects = (Object[])object;
				Long meterId =  Long.parseLong(String.valueOf(objects[0]));
				Double preReading = null;
				if(String.valueOf(objects[1])!="null"){
					 preReading = Double.parseDouble(String.valueOf(objects[1]));
				}
				Date readingDate = DateUtil.parse(String.valueOf(objects[2]));
				String roomIds = String.valueOf(objects[3]);
				String orderNo = String.valueOf(objects[4]);
				MeterTypeEnum type = MeterTypeEnum.valueOf(String.valueOf(objects[5]));
				Integer meterFactor = Integer.parseInt(String.valueOf(objects[6]));
				
				MeterLabelRecord mlr = new MeterLabelRecord();
				mlr.setLabelId(labelId);
				mlr.setMeterId(meterId);
				mlr.setPreReading(preReading);
				mlr.setPreDate(readingDate);
				mlr.setMeterOrderNo(orderNo);
				mlr.setMeterType(type);
				mlr.setMeterFactor(meterFactor);
				mlr.setCurDate(new Date());
				
				Meter meter = (Meter) session.get(Meter.class, meterId);
				meter.setReadingDate(new Date());
				session.merge(meter);
				
				String bId = String.valueOf(objects[7]);
				if(bId!="null"){
					Long buildingId = Long.parseLong(String.valueOf(objects[7]));
					if(buildingId!=null){
						Building building = (Building)session.load(Building.class, buildingId);
						mlr.setBuildingId(buildingId);
						mlr.setBuildingName(building.getPark().getName()+"-"+building.getName());
					}
				}
				
				if(!roomIds.equals(",") ){
					Room room = (Room) session.load(Room.class,Long.parseLong(roomIds.split(",")[1]));
					mlr.setCustomerName(room.getCustomerName());
				}
				mlr.setCreateTime(new Date());
				mlr.setCreator(PbActivator.getSessionUser().getRealName());
				mlr.setCreatorId(PbActivator.getSessionUser().getId());
				mlr.setModifyTime(mlr.getCreateTime());
				mlr.setModifier(mlr.getCreator());
				mlr.setModifierId(mlr.getCreatorId());
				mlr.setEntityStatus(EntityStatus.NORMAL);
				session.save(mlr);
			}
			}
			if(delIds.length()>0){
				sql = "DELETE FROM "+ModulePrefixNamingStrategy.classToTableName(MeterLabelRecord.class)+
						" WHERE meter_id in ("+delIds+")";
						session.createSQLQuery(sql).executeUpdate();
			}
			tr.commit();
			return Result.success("操作成功");
		}catch (Exception e) {
			tr.rollback();
			return Result.failure("操作失败");
		}finally{
			session.close();
		}
	}

	@Override
	public Result<FeeStatementsDto> generateReport(Long labelId,boolean isSetFee) {
		FeeStatementsDto fsDto = new FeeStatementsDto();
		Session session = null;
		Transaction tr = null;
		try {
			session = meterLabelRecordDao.openSession();
			tr = session.beginTransaction();
			List<Meter> meterList = new ArrayList<Meter>();
			if(isSetFee&&labelId!=null){
				MeterLabel ml = meterLabelService.getBeanById(labelId).getValue();
				if(labelId!=null){
					List<MeterLabelRecord> mrList = meterLabelRecordDao.getListByFilter(new Filter(MeterLabelRecord.class).eq("labelId", labelId));
					if(mrList!=null&&mrList.size()>0){
						for(MeterLabelRecord mr:mrList){
							Meter m = meterService.getBeanByFilter(new Filter(Meter.class).eq("orderNo", mr.getMeterOrderNo())).getValue();
							Park p = parkService.getBeanById(m.getParkId()).getValue();
							RoomMeterFee rmf = roomMeterFeeService.getBeanByFilter(new Filter(RoomMeterFee.class).eq("meterId", m.getId()).eq("priceType", "CUSTOMIZE")).getValue();
							Double elePrice=0.0;
							Double watPrice=0.0;
							if(rmf!=null){
								if(rmf.getType()==MeterTypeEnum.WATER){
									watPrice=rmf.getPrice();
									elePrice=p.getElectricity();
								}else{
									watPrice = p.getWater();
									elePrice=rmf.getPrice();
								}
							}else{
								elePrice = p.getElectricity();//电价
								watPrice = p.getWater();//水价
							}
							if(0==elePrice||null==elePrice||0==watPrice||null==watPrice){
								return Result.failure("请设置水电费单价后重试。");
							}
							if(MeterTypeEnum.ELECTRICITY.equals(mr.getMeterType())&&isSetFee){
								mr.setPrice(elePrice);
								mr.setCheckOut(MeterRecordStatusEnum.GENERATED);
								mr.setBill(elePrice*mr.getTotalAmount());
								double totalBill=mr.getTotalAmount()*elePrice;
								if(m.getCapacity()!=null&&m.getCapacityBill()!=null){
									totalBill+=(m.getCapacity())+(m.getCapacityBill());
								}
								//double totalBill = (meterLableRecord.getTotalAmount())*elePrice+((meter.getCapacity())+(meter.getCapacityBill()));
								m.setReadingDate(mr.getCurDate());
								meterService.update(m);
								mr.setTotalBill(totalBill);
								meterLabelRecordDao.update(mr);
							}else if(MeterTypeEnum.WATER.equals(mr.getMeterType())&&isSetFee){
								mr.setPrice(watPrice);
								mr.setCheckOut(MeterRecordStatusEnum.GENERATED);
								double totalBill = (mr.getTotalAmount())*watPrice;
								mr.setTotalBill(totalBill);
								m.setReadingDate(mr.getCurDate());
								meterService.update(m);
								meterLabelRecordDao.update(mr);
							}
							meterList.add(m);
						}
						fsDto.setLabelRecords(mrList);
						fsDto.setMeters(meterList);
						fsDto.setStartTime(ml.getStartTime());
						fsDto.setEndTime(ml.getEndTime());
						fsDto.setLabelId(ml.getId());
						fsDto.setLabelType(ml.getType().toString());
						fsDto.setCheckOut(ml.getCheckOut().toString());
						tr.commit();
					}
				}
				ml.setCheckOut(MeterRecordStatusEnum.GENERATED);
				meterLabelService.update(ml);
				return Result.success("操作成功！",fsDto);
			}else{
				List<MeterLabelRecord> mrList = meterLabelRecordDao.getListByFilter(new Filter(MeterLabelRecord.class).eq("labelId", labelId));
				MeterLabel ml = meterLabelService.getBeanById(labelId).getValue();
				for(MeterLabelRecord mr : mrList){
					Meter m = meterService.getBeanByFilter(new Filter(Meter.class).eq("orderNo", mr.getMeterOrderNo())).getValue();
					meterList.add(m);
				}
				fsDto.setLabelRecords(mrList);
				fsDto.setMeters(meterList);
				fsDto.setStartTime(ml.getStartTime());
				fsDto.setEndTime(ml.getEndTime());
				fsDto.setLabelId(ml.getId());
				fsDto.setLabelType(ml.getType().toString());
				fsDto.setCheckOut(ml.getCheckOut().toString());
				return Result.success("成功",fsDto);
			}
		} catch (Exception e) {
			tr.rollback();
			e.printStackTrace();
			return Result.failure("操作失败,请将信息输入完整后再试",fsDto);
		}finally{
			session.close();
		}
	}
	
	@Override
	public Result waterEleFee(long labelId,String ids) {
		Session session = null;
		Transaction tr = null;
		try {
			String idsStr="";
			session = meterLabelRecordDao.openSession();
			tr = session.beginTransaction();
			//Filter filter = new Filter(MeterLabelRecord.class).eq("labelId", labelId);
			MeterLabel meterLabel = meterLabelService.getBeanById(labelId).getValue();
			meterLabel.setCheckOut(MeterRecordStatusEnum.CKECKOUT);
			List<MeterLabelRecord> meterLabelRecordList=new ArrayList<MeterLabelRecord>();
			if(ids.length()>0){
				idsStr = ids.substring(0, ids.length()-1);
				meterLabelRecordList = session.createQuery("from MeterLabelRecord where id not in ("+idsStr+") and labelId="+labelId).list();
			}else{
				meterLabelRecordList = session.createQuery("from MeterLabelRecord where labelId="+labelId).list();
			}
			String number = billService.generateNumber(session);
			int num = Integer.valueOf(number.substring(2, number.length()-1));
			BillType topType = billTypeService.getBillType("水电").getValue();
			Map<MeterEleFeeEnum,Long> typeMap = new HashMap<MeterEleFeeEnum,Long>();
			for (MeterEleFeeEnum meterEleFeeEnum : MeterEleFeeEnum.values()) {
				BillType billType = new BillType();
				billType.setTypeName(meterEleFeeEnum.getTitle());
				billType.setParentId(topType.getId());
				billTypeService.checkBillType(billType);
				typeMap.put(meterEleFeeEnum, billType.getId());
			}
			for(MeterLabelRecord meterLableRecord : meterLabelRecordList){
				meterLableRecord.setCheckOut(MeterRecordStatusEnum.CKECKOUT);
				meterLabelRecordDao.update(meterLableRecord);
				Customer c = customerService.getBeanByFilter(new Filter(Customer.class).eq("name", meterLableRecord.getCustomerName())).getValue();
				Meter meter = meterService.getBeanByFilter(new Filter(Meter.class).eq("orderNo", meterLableRecord.getMeterOrderNo())).getValue();
				RoomMeterFee rmf = roomMeterFeeService.getBeanByFilter(new Filter(RoomMeterFee.class).eq("meterId", meter.getId())).getValue();
				Bill bill = new Bill();
				StringBuilder sb = new StringBuilder(); 
				String billNumber = sb.append("账单").append(String.valueOf(num)).append("号").toString();
				bill.setNumber(billNumber);
				bill.setBillSplit(null);
				if(MeterTypeEnum.WATER.equals(meterLableRecord.getMeterType())){
					bill.setBillTypeId(typeMap.get(MeterEleFeeEnum.WATER));
				}else{
					bill.setBillTypeId(typeMap.get(MeterEleFeeEnum.ELECTRICITY));
				}
				bill.setCustomerId(c.getId());
				bill.setRoomId(rmf.getRoomId());
				bill.setBillPlanId(meterLableRecord.getId());
				bill.setBillPlanTableName(ModulePrefixNamingStrategy.classToTableName(MeterLabelRecord.class));
				bill.setPrice(meterLableRecord.getPrice().toString());
				bill.setAmount(meterLableRecord.getTotalAmount());
				bill.setContractNo(null);
				bill.setInvoice(BooleanEnum.NO);
				bill.setUrged(BooleanEnum.NO);
				bill.setPayType(null);
				bill.setTotalAmount(meterLableRecord.getTotalBill());
				bill.setFactPayment(meterLableRecord.getTotalBill());
				
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
				int day =Integer.valueOf(PbActivator.getAppConfig().getConfig("contractDueRemindDays").getParameter("day"));
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(new Date());
				calendar.add(Calendar.DAY_OF_YEAR, day);
				
				bill.setPlanPayTime(calendar.getTime());
				bill.setPayTime(null);
				bill.setCheckoutTime(new Date());
				bill.setPenalty(0d);
				bill.setStatus(BillStatusEnum.UNPAID);
				bill.setInOut(BillInOutEnum.IN);
				bill.setDiscountRate(meterLableRecord.getTotalBill());
				bill.setFeeStartTime(meterLabel.getStartTime());
				bill.setFeeEndTime(meterLabel.getEndTime());
				bill.setMemo(null);
				num++;
				setcreatemodify(bill);
				session.save(bill);
			}
			
			meterLabelService.update(meterLabel);
			tr.commit();
			return Result.success("出账成功");
		} catch (Exception e) {
			tr.rollback();
			return Result.failure("出账失败");
		}finally{
			session.close();
		}
		
		
	}

	public void setcreatemodify(BaseEntity t){
		t.setCreateTime(new Date());
		t.setCreator(PbActivator.getSessionUser().getRealName());
		t.setCreatorId(PbActivator.getSessionUser().getId());
		t.setModifyTime(t.getCreateTime());
		t.setModifier(t.getCreator());
		t.setModifierId(t.getCreatorId());
		t.setEntityStatus(EntityStatus.NORMAL);
	}

	@Override
	public Result printFee(long labelId) {
		FeeStatementsDto fsDto = new FeeStatementsDto();
		Session session = null;
		Transaction tr = null;
		try {
			session = meterLabelRecordDao.openSession();
			tr=session.beginTransaction();
			Filter filter = new Filter(MeterLabelRecord.class).eq("labelId", labelId);
			MeterLabel meterLabel = meterLabelService.getBeanById(labelId).getValue();
			List<MeterLabelRecord> meterLabelRecordList = meterLabelRecordDao.getListByFilter(filter);
			List<Meter> meters = new ArrayList<Meter>();
			for(MeterLabelRecord meterLableRecord : meterLabelRecordList){
				Meter meter = meterService.getBeanByFilter(new Filter(Meter.class).eq("orderNo", meterLableRecord.getMeterOrderNo())).getValue();
				meters.add(meter);
			}
			fsDto.setLabelRecords(meterLabelRecordList);
			fsDto.setMeters(meters);
			fsDto.setStartTime(meterLabel.getStartTime());
			fsDto.setEndTime(meterLabel.getEndTime());
			fsDto.setLabelId(meterLabel.getId());
			fsDto.setLabelType(meterLabel.getType().toString());
			tr.commit();
			return Result.value(fsDto);
		} catch (Exception e) {
			tr.rollback();
			return Result.failure("操作失败");
		}finally{
			session.close();
		}
	}
}
