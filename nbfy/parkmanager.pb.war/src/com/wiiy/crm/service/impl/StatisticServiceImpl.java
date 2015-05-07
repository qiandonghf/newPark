package com.wiiy.crm.service.impl;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.hibernate.Query;
import org.hibernate.Session;

import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.core.entity.DataDict;
import com.wiiy.core.service.export.DataDictInitService;
import com.wiiy.crm.dao.CustomerDao;
import com.wiiy.crm.dto.BillReportDto;
import com.wiiy.crm.dto.ContractStatisticDto;
import com.wiiy.crm.dto.StatisticDto;
import com.wiiy.crm.dto.StatisticGroupDto;
import com.wiiy.crm.entity.Bill;
import com.wiiy.crm.entity.BillPlanFacility;
import com.wiiy.crm.entity.BillPlanRent;
import com.wiiy.crm.entity.BillType;
import com.wiiy.crm.entity.Certification;
import com.wiiy.crm.entity.Contect;
import com.wiiy.crm.entity.Contract;
import com.wiiy.crm.entity.Copyright;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.entity.CustomerCategory;
import com.wiiy.crm.entity.CustomerInfo;
import com.wiiy.crm.entity.CustomerLabel;
import com.wiiy.crm.entity.CustomerLabelRef;
import com.wiiy.crm.entity.Deposit;
import com.wiiy.crm.entity.IncubationInfo;
import com.wiiy.crm.entity.IncubationRoute;
import com.wiiy.crm.entity.Patent;
import com.wiiy.crm.entity.Product;
import com.wiiy.crm.entity.Staffer;
import com.wiiy.crm.entity.SubjectRent;
import com.wiiy.crm.preferences.enums.BillInOutEnum;
import com.wiiy.crm.preferences.enums.BillStatusEnum;
import com.wiiy.crm.preferences.enums.ParkStatusEnum;
import com.wiiy.crm.preferences.enums.RentBillPlanFeeEnum;
import com.wiiy.crm.service.StatisticService;
import com.wiiy.hibernate.ModulePrefixNamingStrategy;
import com.wiiy.hibernate.Pager;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.activator.PbActivator;
import com.wiiy.pb.entity.Building;
import com.wiiy.pb.entity.Room;
import com.wiiy.pb.preferences.enums.FacilityTypeEnum;
import com.wiiy.pb.preferences.enums.RoomStatusEnum;

public class StatisticServiceImpl implements StatisticService {
	
	private CustomerDao customerDao;

	
	public void setCustomerDao(CustomerDao customerDao) {
		this.customerDao = customerDao;
	}

	@Override
	public Result<?> customerCategory() {
		return null;
	}

	@Override
	public Result<?> customerIncubationStatus() {
	    String sql = "SELECT d.data_value,COUNT(i.status_id)";
		sql += " FROM "+ModulePrefixNamingStrategy.classToTableName(DataDict.class)+" d";
		sql += " LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(IncubationRoute.class)+" ir ON ir.route_id = d.id";
		sql += " LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(IncubationInfo.class)+" i ON i.status_id = ir.id";
		sql += " WHERE d.parent_id = 'crm.0025' GROUP BY d.data_value;";
		List<Object> list = customerDao.getObjectListBySql(sql);
		List<StatisticDto> dtoList = new ArrayList<StatisticDto>();
		DataDictInitService dataDictInitService = PbActivator.getDataDictInitService();
		for (Object object : list) {
			Object[] objects = (Object[])object;
			String status = String.valueOf(objects[0]);
			Integer amount = BigInteger.class.cast(objects[1]).intValue();
			StatisticDto dto = new StatisticDto();
			dto.setName(status);
			dto.setAmount(amount);
			dtoList.add(dto);
		}
		return Result.value(dtoList);
	}

	@Override
	public Result<?> customerParkStatus() {
		List<Object> list = customerDao.getObjectListBySql("SELECT park_status,COUNT(*) FROM "+ModulePrefixNamingStrategy.classToTableName(Customer.class)+" GROUP BY park_status HAVING park_status != '';");
		List<StatisticDto> dtoList = new ArrayList<StatisticDto>();
		for (Object object : list) {
			Object[] objects = (Object[])object;
			String status = String.valueOf(objects[0]);
			Integer amount = BigInteger.class.cast(objects[1]).intValue();
			StatisticDto dto = new StatisticDto();
			dto.setName(ParkStatusEnum.valueOf(status).getTitle());
			dto.setAmount(amount);
			dtoList.add(dto);
		}
		return Result.value(dtoList);
	}

	@Override
	public Result<?> customerTechnic() {
		//SELECT d.data_value,COUNT(c.id) FROM core_data_dict d LEFT JOIN crm_customer c on d.id = c.technic_id WHERE d.parent_id = 'crm.0002' GROUP BY d.data_value;
		List<Object> list = customerDao.getObjectListBySql("SELECT d.data_value,COUNT(c.id) FROM "+ModulePrefixNamingStrategy.classToTableName(DataDict.class)+" d LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(Customer.class)+" c on d.id = c.technic_id WHERE d.parent_id = 'crm.0002' GROUP BY d.data_value");
		List<StatisticDto> dtoList = new ArrayList<StatisticDto>();
		for (Object object : list) {
			Object[] objects = (Object[])object;
			String name = String.valueOf(objects[0]);
			Integer amount = BigInteger.class.cast(objects[1]).intValue();
			StatisticDto dto = new StatisticDto();
			dto.setName(name);
			dto.setAmount(amount);
			dtoList.add(dto);
		}
		return Result.value(dtoList);
	}

	@Override
	public Result<?> customerLabel() {
		try {
			
		
		//SELECT c.name,label.name,COUNT(rf.label_id) FROM crm_customer_label_ref rf LEFT JOIN crm_customer_label label ON label.id = rf.label_id LEFT JOIN crm_customer_category c ON label.category_id = c.id WHERE c.name !='' GROUP BY rf.label_id,c.name,label.name;
		String sql = "SELECT c.name as customerName,label.name,COUNT(rf.label_id)";
		sql += " FROM "+ModulePrefixNamingStrategy.classToTableName(CustomerLabelRef.class)+" rf";
		sql += " LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(CustomerLabel.class)+" label ON label.id = rf.label_id";
		sql += " LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(CustomerCategory.class)+" c ON label.category_id = c.id";
		sql += " WHERE c.owner_enum = 'PUBLIC' GROUP BY rf.label_id,c.name,label.name";
		List<Object> list = customerDao.getObjectListBySql(sql);
		List<StatisticGroupDto> groupList = new ArrayList<StatisticGroupDto>();
		StatisticGroupDto group = null;
		for (Object object : list) {
			Object[] objects = (Object[])object;
			String groupName = String.valueOf(objects[0]);
			if(group==null || !groupName.equals(group.getName())){
				group = new StatisticGroupDto();
				group.setName(groupName);
				groupList.add(group);
			}
			String name = String.valueOf(objects[1]);
			Integer amount = BigInteger.class.cast(objects[2]).intValue();
			StatisticDto dto = new StatisticDto();
			dto.setName(name);
			dto.setAmount(amount);
			group.setAmount(group.getAmount()+dto.getAmount());
			group.getList().add(dto);
		}
		String sql2 = "SELECT label.name,COUNT(rf.label_id)";
		sql2 += " FROM "+ModulePrefixNamingStrategy.classToTableName(CustomerLabelRef.class)+" rf";
		sql2 += " LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(CustomerLabel.class)+" label ON label.id = rf.label_id";
		sql2 += " WHERE label.owner_enum = 'PRIVATE' GROUP BY rf.label_id,label.name";
		List<Object> list2 = customerDao.getObjectListBySql(sql2);
		group = new StatisticGroupDto();
		group.setName("我的标签");
		for (Object object : list2) {
			Object[] objects = (Object[])object;
			String name = String.valueOf(objects[0]);
			Integer amount = BigInteger.class.cast(objects[1]).intValue();
			StatisticDto dto = new StatisticDto();
			dto.setName(name);
			dto.setAmount(amount);
			group.setAmount(group.getAmount()+dto.getAmount());
			group.getList().add(dto);
		}
		groupList.add(group);
		return Result.value(groupList);
		} catch (Exception e) {
			e.printStackTrace() ;
			return null ;
		}
		
	}

	@Override
	public Result<?> productTechnic() {
		//SELECT d.data_value,COUNT(p.id) FROM core_data_dict d LEFT JOIN crm_product p on d.id = p.technic_id WHERE d.parent_id = 'crm.0002' GROUP BY d.data_value;
		List<Object> list = customerDao.getObjectListBySql("SELECT d.data_value,COUNT(p.id) FROM "+ModulePrefixNamingStrategy.classToTableName(DataDict.class)+" d LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(Product.class)+" p on d.id = p.technic_id WHERE d.parent_id = 'crm.0002' GROUP BY d.data_value");
		List<StatisticDto> dtoList = new ArrayList<StatisticDto>();
		for (Object object : list) {
			Object[] objects = (Object[])object;
			String name = String.valueOf(objects[0]);
			Integer amount = BigInteger.class.cast(objects[1]).intValue();
			StatisticDto dto = new StatisticDto();
			dto.setName(name);
			dto.setAmount(amount);
			dtoList.add(dto);
		}
		return Result.value(dtoList);
	}

	@Override
	public Result<?> registeredCapital() {
		//SELECT YEAR(c.reg_time),SUM(c.reg_capital),count(c.id) FROM crm_customer_info c WHERE c.reg_time IS NOT NULL GROUP BY YEAR(c.reg_time);
		List<Object> list = customerDao.getObjectListBySql("SELECT YEAR(c.reg_time),SUM(c.reg_capital),count(c.id) FROM "+ModulePrefixNamingStrategy.classToTableName(CustomerInfo.class)+" c WHERE c.reg_time IS NOT NULL GROUP BY YEAR(c.reg_time)");
		List<StatisticDto> dtoList = new ArrayList<StatisticDto>();
		for (Object object : list) {
			Object[] objects = (Object[])object;
			String name = String.valueOf(objects[0]);
			double sum = Double.valueOf((objects[1]).toString());
			Integer amount = BigInteger.class.cast(objects[2]).intValue();
			StatisticDto dto = new StatisticDto();
			dto.setName(name);
			dto.setAmount(amount);
			dto.setdValue(sum);
			dtoList.add(dto);
		}
		return Result.value(dtoList);
	}
	@Override
	public Result<?> customerStaffer() {
		//SELECT YEAR(s.create_time),count(c.id),count(s.id) FROM crm_customer c LEFT JOIN crm_staffer s ON s.customer_id = c.id WHERE s.create_time IS NOT NULL GROUP BY YEAR(s.create_time);
		List<Object> list = customerDao.getObjectListBySql("SELECT YEAR(s.create_time),count(c.id),count(s.id) FROM "+ModulePrefixNamingStrategy.classToTableName(Customer.class)+" c LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(Staffer.class)+" s ON s.customer_id = c.id WHERE s.create_time IS NOT NULL GROUP BY YEAR(s.create_time)");
		List<StatisticDto> dtoList = new ArrayList<StatisticDto>();
		for (Object object : list) {
			Object[] objects = (Object[])object;
			String name = String.valueOf(objects[0]);
			Integer icount = BigInteger.class.cast(objects[1]).intValue();
			Integer amount = BigInteger.class.cast(objects[2]).intValue();
			StatisticDto dto = new StatisticDto();
			dto.setName(name);
			dto.setAmount(amount);
			dto.setiValue(icount);
			dtoList.add(dto);
		}
		return Result.value(dtoList);
	}

	@Override
	public Result<?> propertyRight() {
		//SELECT YEAR(c.birth_day),count(c.id) FROM crm_contect c GROUP BY YEAR(c.birth_day);
		Map<String,StatisticGroupDto> groups = new HashMap<String,StatisticGroupDto>();
		List<Object> copyrightList = customerDao.getObjectListBySql("SELECT YEAR(c.apply_time),count(c.id) FROM "+ModulePrefixNamingStrategy.classToTableName(Copyright.class)+" c where c.apply_time IS NOT NULL GROUP BY YEAR(c.apply_time)");
		Map<String,StatisticDto> copyrightDtos = new HashMap<String,StatisticDto>();
		for (Object object : copyrightList) {
			Object[] objects = (Object[])object;
			String name = String.valueOf(objects[0]);
			if(!groups.containsKey(name)){
				StatisticGroupDto group = new StatisticGroupDto();
				group.setName(name);
				groups.put(name, group);
			}
			Integer amount = BigInteger.class.cast(objects[1]).intValue();
			StatisticDto dto = new StatisticDto();
			dto.setName(name);
			dto.setAmount(amount);
			copyrightDtos.put(name,dto);
		}
		List<Object> patentList = customerDao.getObjectListBySql("SELECT YEAR(c.apply_time),count(c.id) FROM "+ModulePrefixNamingStrategy.classToTableName(Patent.class)+" c where c.apply_time IS NOT NULL GROUP BY YEAR(c.apply_time)");
		Map<String,StatisticDto> patentDtos = new HashMap<String,StatisticDto>();
		for (Object object : patentList) {
			Object[] objects = (Object[])object;
			String name = String.valueOf(objects[0]);
			if(!groups.containsKey(name)){
				StatisticGroupDto group = new StatisticGroupDto();
				group.setName(name);
				groups.put(name, group);
			}
			Integer amount = BigInteger.class.cast(objects[1]).intValue();
			StatisticDto dto = new StatisticDto();
			dto.setName(name);
			dto.setAmount(amount);
			patentDtos.put(name,dto);
		}
		List<Object> certificationList = customerDao.getObjectListBySql("SELECT YEAR(c.cert_time),count(c.id) FROM "+ModulePrefixNamingStrategy.classToTableName(Certification.class)+" c where c.cert_time IS NOT NULL GROUP BY YEAR(c.cert_time)");
		Map<String,StatisticDto> certificationDtos = new HashMap<String,StatisticDto>();
		for (Object object : certificationList) {
			Object[] objects = (Object[])object;
			String name = String.valueOf(objects[0]);
			if(!groups.containsKey(name)){
				StatisticGroupDto group = new StatisticGroupDto();
				group.setName(name);
				groups.put(name, group);
			}
			Integer amount = BigInteger.class.cast(objects[1]).intValue();
			StatisticDto dto = new StatisticDto();
			dto.setName(name);
			dto.setAmount(amount);
			certificationDtos.put(name,dto);
		}
		
		List<StatisticGroupDto> groupList = new ArrayList<StatisticGroupDto>();
		for (StatisticGroupDto statisticGroupDto : groups.values()) {
			groupList.add(statisticGroupDto);
		}
		
		Collections.sort(groupList, new Comparator<StatisticGroupDto>(){
			@Override
			public int compare(StatisticGroupDto o1, StatisticGroupDto o2) {
				return Integer.parseInt(o1.getName())-Integer.parseInt(o2.getName());
			}
			
		});
		
		for (StatisticGroupDto group : groupList) {			
			StatisticDto patent = patentDtos.get(group.getName());
			if(patent==null){patent = new StatisticDto(); patent.setAmount(0); patent.setName(group.getName());};
			group.getList().add(patent);
			StatisticDto copyright = copyrightDtos.get(group.getName());
			if(copyright==null){copyright = new StatisticDto(); copyright.setAmount(0); copyright.setName(group.getName());};
			group.getList().add(copyright);
			StatisticDto certification = certificationDtos.get(group.getName());
			if(certification==null){certification = new StatisticDto(); certification.setAmount(0); certification.setName(group.getName());};
			group.getList().add(certification);
		}
		
		return Result.value(groupList);
	}

	@Override
	public Result<?> buildingGraph() {
		//SELECT b.id,b.`name`,d.data_value,SUM(r.building_area) FROM pb_room r LEFT JOIN pb_building b ON r.building_id = b.id LEFT JOIN core_data_dict d ON r.kind_id = d.id GROUP BY b.id,b.`name`,d.id,d.data_value;
		String sql = "SELECT b.id,b.`name`,d.data_value,SUM(r.building_area) FROM "+ModulePrefixNamingStrategy.classToTableName(Room.class)+" r " +
				"LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(Building.class)+" b ON r.building_id = b.id " +
				"LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(DataDict.class)+" d ON r.kind_id = d.id " +
				"GROUP BY b.id,b.`name`,d.id,d.data_value";
		List<Object> list = customerDao.getObjectListBySql(sql);
		Map<Long,StatisticGroupDto> groups = new HashMap<Long,StatisticGroupDto>();
		for (Object object : list) {
			Object[] objects = (Object[])object;
			Long bId = BigInteger.class.cast(objects[0]).longValue();
			if(!groups.containsKey(bId)){
				StatisticGroupDto group = new StatisticGroupDto();
				group.setName(String.valueOf(objects[1]));
				groups.put(bId, group);
			}
			String status = String.valueOf(objects[2]);
			Double value = Double.parseDouble(String.valueOf(objects[3]));
			StatisticDto dto = new StatisticDto();
			dto.setName(status);
			dto.setdValue(value);
			groups.get(bId).getList().add(dto);
		}
		List<StatisticGroupDto> groupList = new ArrayList<StatisticGroupDto>(groups.values());
		return Result.value(groupList);
	}

	@Override
	public Result<?> buildingRentGraph() {
		//SELECT b.id,b.`name`,r.`status`,SUM(r.building_area) FROM pb_room r LEFT JOIN pb_building b ON r.building_id = b.id WHERE r.kind_id = 'pb.000701' GROUP BY b.id,b.`name`,r.`status`;
		String sql = "SELECT b.id,b.`name`,r.`status`,SUM(r.building_area) FROM "+ModulePrefixNamingStrategy.classToTableName(Room.class)+" r " +
		"LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(Building.class)+" b ON r.building_id = b.id " +
		"GROUP BY b.id,b.`name`,r.`status`";
		List<Object> list = customerDao.getObjectListBySql(sql);
		Map<Long,StatisticGroupDto> groups = new HashMap<Long,StatisticGroupDto>();
		for (Object object : list) {
			Object[] objects = (Object[])object;
			Long bId = BigInteger.class.cast(objects[0]).longValue();
			if(!groups.containsKey(bId)){
				StatisticGroupDto group = new StatisticGroupDto();
				group.setName(String.valueOf(objects[1]));
				groups.put(bId, group);
			}
			String status = String.valueOf(objects[2]);
			Double value = Double.parseDouble(String.valueOf(objects[3]));
			StatisticDto dto = new StatisticDto();
			dto.setName(RoomStatusEnum.valueOf(status).getTitle());
			dto.setdValue(value);
			groups.get(bId).getList().add(dto);
		}
		List<StatisticGroupDto> groupList = new ArrayList<StatisticGroupDto>(groups.values());
		return Result.value(groupList);
	}

	@Override
	public Result<?> billCost(Date startTime, Date endTime , Date time , String type) {
		//SELECT t.type_name,b.in_out,SUM(b.factPayment) FROM crm_bill b LEFT JOIN crm_bill_type t ON b.bill_type_id = t.id WHERE b.planPayTime < NOW() GROUP BY t.type_name,b.in_out;
		String sql = "";
		if(startTime!=null && endTime!=null){
			sql = "SELECT t.id,t.type_name,b.in_out,SUM(b.factPayment) FROM "+ModulePrefixNamingStrategy.classToTableName(Bill.class)+
				" b LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(BillType.class)+
				" t ON b.bill_type_id = t.id WHERE b.status ='"+BillStatusEnum.FULLPAID+"'AND b.payTime BETWEEN '"+DateUtil.format(startTime,"yyyy-MM-dd HH:mm:ss")+"' AND '"+DateUtil.format(endTime,"yyyy-MM-dd HH:mm:ss")+"' GROUP BY t.type_name,b.in_out";
				//" t ON b.bill_type_id = t.id WHERE b.planPayTime < NOW() GROUP BY t.id,t.type_name,b.in_out";
		}else if(startTime!=null && endTime==null){
			sql = "SELECT t.id,t.type_name,b.in_out,SUM(b.factPayment) FROM "+ModulePrefixNamingStrategy.classToTableName(Bill.class)+
				" b LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(BillType.class)+
				" t ON b.bill_type_id = t.id WHERE b.payTime > '"+DateUtil.format(startTime,"yyyy-MM-dd HH:mm:ss")+"' GROUP BY t.type_name,b.in_out";
		}else if(startTime==null && endTime!=null){
			sql = "SELECT t.id,t.type_name,b.in_out,SUM(b.factPayment) FROM "+ModulePrefixNamingStrategy.classToTableName(Bill.class)+
				" b LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(BillType.class)+
				" t ON b.bill_type_id = t.id WHERE b.payTime < '"+DateUtil.format(endTime,"yyyy-MM-dd HH:mm:ss")+"' GROUP BY t.type_name,b.in_out";
		}else if(startTime==null && endTime==null){
			sql = "SELECT t.id,t.type_name,b.in_out,SUM(b.factPayment) FROM "+ModulePrefixNamingStrategy.classToTableName(Bill.class)+
				" b LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(BillType.class)+
				" t ON b.bill_type_id = t.id WHERE b.payTime BETWEEN '"+DateUtil.format(new Date(),"yyyy-MM-dd")+"' AND '"+DateUtil.format(CalendarUtil.add(new Date(), Calendar.DAY_OF_YEAR, 1).getTime(),"yyyy-MM-dd")+"' GROUP BY t.id,t.type_name,b.in_out";
		}
		List<Object> list = customerDao.getObjectListBySql(sql);
		Map<Long,StatisticGroupDto> groups = new HashMap<Long,StatisticGroupDto>();
		for (Object object : list) {
			Object[] objects = (Object[])object;
			Long bId = BigInteger.class.cast(objects[0]).longValue();
			if(!groups.containsKey(bId)){
				StatisticGroupDto group = new StatisticGroupDto();
				group.setName(String.valueOf(objects[1]));
				groups.put(bId, group);
			}
			
			String inOut = String.valueOf(objects[2]);
			Double value = Double.parseDouble(String.valueOf(objects[3]));
			StatisticDto dto = new StatisticDto();
			dto.setName(BillInOutEnum.valueOf(inOut).getTitle());
			dto.setdValue(value);
			groups.get(bId).getList().add(dto);
		}
		List<StatisticGroupDto> groupList = new ArrayList<StatisticGroupDto>(groups.values());
		return Result.value(groupList);
	}

	@Override
	public Result<?> billCostByMonth(Date startTime, Date endTime,String type) {
		//SELECT t.id,b.planPayTime, t.type_name,b.in_out,SUM(b.factPayment) FROM crm_bill b LEFT JOIN crm_bill_type t ON b.bill_type_id = t.id WHERE DATE_FORMAT(b.planPayTime,'%Y')=DATE_FORMAT(NOW(),'%Y') GROUP BY DATE_FORMAT(b.planPayTime,'%Y%m'),t.id,t.type_name,b.in_out;
		String sql = "SELECT b.payTime ,t.id,t.type_name,b.in_out,SUM(b.factPayment) FROM "+ModulePrefixNamingStrategy.classToTableName(Bill.class)+
					" b LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(BillType.class)+
					" t ON b.bill_type_id = t.id WHERE b.status = '"+BillStatusEnum.FULLPAID+"' AND DATE_FORMAT(b.payTime,'%Y%m') between DATE_FORMAT('"+DateUtil.format(startTime,"yyyy-MM-dd HH:mm:ss")+"','%Y%m') AND DATE_FORMAT('"+DateUtil.format(endTime,"yyyy-MM-dd HH:mm:ss")+"','%Y%m') GROUP BY DATE_FORMAT(b.payTime,'%Y%m'),t.id,t.type_name,b.in_out";
		
		String sql2 = "SELECT b.payTime ,t.id,t.type_name,b.in_out,SUM(b.factPayment) FROM "+ModulePrefixNamingStrategy.classToTableName(Bill.class)+
				" b LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(BillType.class)+
				" t ON b.bill_type_id = t.id WHERE b.status = '"+BillStatusEnum.FULLPAID+"' AND DATE_FORMAT(b.payTime,'%Y%m') between DATE_FORMAT('"+DateUtil.format(startTime,"yyyy-MM-dd HH:mm:ss")+"','%Y%m') AND DATE_FORMAT('"+DateUtil.format(endTime,"yyyy-MM-dd HH:mm:ss")+"','%Y%m') GROUP BY DATE_FORMAT(b.payTime,'%Y'),t.id,t.type_name,b.in_out";
		
		List<Object> list = new ArrayList<Object>();
		List<StatisticGroupDto> topGroupList = new ArrayList<StatisticGroupDto>();
		if(type.equals("month")){
			LinkedHashMap<String,Map<Long,StatisticGroupDto>> groupMaps = new LinkedHashMap<String,Map<Long,StatisticGroupDto>>();
			list = customerDao.getObjectListBySql(sql);
			for (Object object : list) {
				Object[] objects = (Object[])object;
				Date bTime = DateUtil.parse(String.valueOf(objects[0]));
				String month = DateUtil.format(bTime, "yyyy-MM");
				String tName = String.valueOf(objects[2]);
				if(!groupMaps.containsKey(month)){
					Map<Long,StatisticGroupDto> map = new HashMap<Long,StatisticGroupDto>();
					groupMaps.put(month, map);
				}
				Map<Long,StatisticGroupDto> subGroupMap = groupMaps.get(month);
				
				Long tId = BigInteger.class.cast(objects[1]).longValue();
				if(!subGroupMap.containsKey(tId)){
					StatisticGroupDto group = new StatisticGroupDto();
					group.setName(tName);
					group.setLid(tId);
					subGroupMap.put(tId, group);
				}
				StatisticGroupDto group = subGroupMap.get(tId);
				
				StatisticDto dto = new StatisticDto();
				dto.setName(String.valueOf(objects[3]));
				if(objects[4]!=null){
					dto.setdValue(Double.parseDouble(String.valueOf(objects[4])));
				}
				group.getList().add(dto);
				group.setAmount(group.getAmount()+1);
			}
			for (Entry<String, Map<Long, StatisticGroupDto>> entry : groupMaps.entrySet()) {
				StatisticGroupDto topGroup = new StatisticGroupDto();
				topGroup.setName(entry.getKey());
				topGroup.getGroups().addAll(entry.getValue().values());
				topGroupList.add(topGroup);
			}
		}else if(type.equals("year")){
			LinkedHashMap<Integer,Map<Long,StatisticGroupDto>> groupMaps = new LinkedHashMap<Integer,Map<Long,StatisticGroupDto>>();
			list = customerDao.getObjectListBySql(sql2);
			for (Object object : list) {
				Object[] objects = (Object[])object;
				Date bTime = DateUtil.parse(String.valueOf(objects[0]));
				Integer year = Integer.parseInt(DateUtil.format(bTime, "yyyy"));
				String tName = String.valueOf(objects[2]);
				if(!groupMaps.containsKey(year)){
					Map<Long,StatisticGroupDto> map = new HashMap<Long,StatisticGroupDto>();
					groupMaps.put(year, map);
				}
				Map<Long,StatisticGroupDto> subGroupMap = groupMaps.get(year);
				
				Long tId = BigInteger.class.cast(objects[1]).longValue();
				if(!subGroupMap.containsKey(tId)){
					StatisticGroupDto group = new StatisticGroupDto();
					group.setName(tName);
					group.setLid(tId);
					subGroupMap.put(tId, group);
				}
				StatisticGroupDto group = subGroupMap.get(tId);
				
				StatisticDto dto = new StatisticDto();
				dto.setName(String.valueOf(objects[3]));
				if(objects[4]!=null){
				dto.setdValue(Double.parseDouble(String.valueOf(objects[4])));
				}
				group.getList().add(dto);
				group.setAmount(group.getAmount()+1);
			}
			for (Entry<Integer, Map<Long, StatisticGroupDto>> entry : groupMaps.entrySet()) {
				StatisticGroupDto topGroup = new StatisticGroupDto();
				topGroup.setAmount(entry.getKey());
				topGroup.getGroups().addAll(entry.getValue().values());
				topGroupList.add(topGroup);
			}
		}
		return Result.value(topGroupList);
	}
	@Override
	public Result<?> billCostByTime(Date time, String type) {
		//SELECT t.id,b.planPayTime, t.type_name,b.in_out,SUM(b.factPayment) FROM crm_bill b LEFT JOIN crm_bill_type t ON b.bill_type_id = t.id WHERE DATE_FORMAT(b.planPayTime,'%Y')=DATE_FORMAT(NOW(),'%Y') GROUP BY DATE_FORMAT(b.planPayTime,'%Y%m'),t.id,t.type_name,b.in_out;
		String sql = "";
		if(time==null){
			sql = "SELECT b.payTime ,t.id,t.type_name,b.in_out,SUM(b.factPayment) FROM "+ModulePrefixNamingStrategy.classToTableName(Bill.class)+
				" b LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(BillType.class)+
				" t ON b.bill_type_id = t.id WHERE b.status = '"+BillStatusEnum.FULLPAID+"' AND DATE_FORMAT(b.payTime,'%Y')=DATE_FORMAT(NOW(),'%Y') GROUP BY DATE_FORMAT(b.payTime,'%Y%m'),t.id,t.type_name,b.in_out";
				//" t ON b.bill_type_id = t.id WHERE DATE_FORMAT(b.planPayTime,'%Y')=DATE_FORMAT(NOW(),'%Y') GROUP BY DATE_FORMAT(b.planPayTime,'%Y%m'),t.id,t.type_name,b.in_out";
		}else{
			sql = "SELECT b.payTime ,t.id,t.type_name,b.in_out,SUM(b.factPayment) FROM "+ModulePrefixNamingStrategy.classToTableName(Bill.class)+
				" b LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(BillType.class)+
				" t ON b.bill_type_id = t.id WHERE b.status = '"+BillStatusEnum.FULLPAID+"' AND DATE_FORMAT(b.payTime,'%Y')=DATE_FORMAT('"+DateUtil.format(time,"yyyy-MM-dd HH:mm:ss")+"','%Y') GROUP BY DATE_FORMAT(b.payTime,'%Y%m'),t.id,t.type_name,b.in_out";
		}
		
		//SELECT b.planPayTime,t.id,t.type_name,b.in_out,SUM(b.factPayment) FROM crm_bill b LEFT JOIN crm_bill_type t ON b.bill_type_id = t.id GROUP BY DATE_FORMAT(b.planPayTime,'%Y'),t.id,t.type_name,b.in_out;
		String sql2 = "SELECT b.payTime ,t.id,t.type_name,b.in_out,SUM(b.factPayment) FROM "+ModulePrefixNamingStrategy.classToTableName(Bill.class)+
				" b LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(BillType.class)+
				" t ON b.bill_type_id = t.id WHERE b.status = '"+BillStatusEnum.FULLPAID+"' GROUP BY DATE_FORMAT(b.payTime,'%Y'),t.id,t.type_name,b.in_out";
		
		List<Object> list = new ArrayList<Object>();
		Map<Integer,StatisticGroupDto> groups = new HashMap<Integer,StatisticGroupDto>();
		List<StatisticGroupDto> topGroupList = new ArrayList<StatisticGroupDto>();
		if(type.equals("month")){
			LinkedHashMap<String,Map<Long,StatisticGroupDto>> groupMaps = new LinkedHashMap<String,Map<Long,StatisticGroupDto>>();
			list = customerDao.getObjectListBySql(sql);
			for (Object object : list) {
				Object[] objects = (Object[])object;
				Date bTime = DateUtil.parse(String.valueOf(objects[0]));
				String month = DateUtil.format(bTime, "yyyy-MM");
				String tName = String.valueOf(objects[2]);
				if(!groupMaps.containsKey(month)){
					Map<Long,StatisticGroupDto> map = new HashMap<Long,StatisticGroupDto>();
					groupMaps.put(month, map);
				}
				Map<Long,StatisticGroupDto> subGroupMap = groupMaps.get(month);
				
				Long tId = BigInteger.class.cast(objects[1]).longValue();
				if(!subGroupMap.containsKey(tId)){
					StatisticGroupDto group = new StatisticGroupDto();
					group.setName(tName);
					group.setLid(tId);
					subGroupMap.put(tId, group);
				}
				StatisticGroupDto group = subGroupMap.get(tId);
				
				StatisticDto dto = new StatisticDto();
				dto.setName(String.valueOf(objects[3]));
				if(objects[4]!=null){
				dto.setdValue(Double.parseDouble(String.valueOf(objects[4])));
				}
				group.getList().add(dto);
				group.setAmount(group.getAmount()+1);
			}
			for (Entry<String, Map<Long, StatisticGroupDto>> entry : groupMaps.entrySet()) {
				StatisticGroupDto topGroup = new StatisticGroupDto();
				topGroup.setName(entry.getKey());
				topGroup.getGroups().addAll(entry.getValue().values());
				topGroupList.add(topGroup);
			}
		}else if(type.equals("year")){
			LinkedHashMap<Integer,Map<Long,StatisticGroupDto>> groupMaps = new LinkedHashMap<Integer,Map<Long,StatisticGroupDto>>();
			list = customerDao.getObjectListBySql(sql2);
			for (Object object : list) {
				Object[] objects = (Object[])object;
				Date bTime = DateUtil.parse(String.valueOf(objects[0]));
				Integer year = Integer.parseInt(DateUtil.format(bTime, "yyyy"));
				String tName = String.valueOf(objects[2]);
				if(!groupMaps.containsKey(year)){
					Map<Long,StatisticGroupDto> map = new HashMap<Long,StatisticGroupDto>();
					groupMaps.put(year, map);
				}
				Map<Long,StatisticGroupDto> subGroupMap = groupMaps.get(year);
				
				Long tId = BigInteger.class.cast(objects[1]).longValue();
				if(!subGroupMap.containsKey(tId)){
					StatisticGroupDto group = new StatisticGroupDto();
					group.setName(tName);
					group.setLid(tId);
					subGroupMap.put(tId, group);
				}
				StatisticGroupDto group = subGroupMap.get(tId);
				
				StatisticDto dto = new StatisticDto();
				dto.setName(String.valueOf(objects[3]));
				if(objects[4]!=null){
				dto.setdValue(Double.parseDouble(String.valueOf(objects[4])));
				}
				group.getList().add(dto);
				group.setAmount(group.getAmount()+1);
			}
			for (Entry<Integer, Map<Long, StatisticGroupDto>> entry : groupMaps.entrySet()) {
				StatisticGroupDto topGroup = new StatisticGroupDto();
				topGroup.setAmount(entry.getKey());
				topGroup.getGroups().addAll(entry.getValue().values());
				topGroupList.add(topGroup);
			}
		}
		return Result.value(topGroupList);
	}

	@SuppressWarnings("unchecked")
	@Override
	public Result<?> billCostByCustomer(Long customerId, Date startTime, Date endTime) {
		//SELECT c.`name`, t.id , t.type_name, b.in_out,SUM(b.factPayment) FROM crm_bill b LEFT JOIN crm_bill_type t ON b.bill_type_id = t.id  LEFT JOIN crm_customer c on b.customer_id=c.id GROUP BY  c.`name`, t.id, t.type_name, b.in_out;
		String sql = "";
		if(customerId==null && startTime==null && endTime==null){
			sql = "SELECT c.`name`, t.id, t.type_name, b.in_out,SUM(b.factPayment) FROM "+ModulePrefixNamingStrategy.classToTableName(Bill.class)+" b " +
				"LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(BillType.class)+" t ON b.bill_type_id=t.id " +
				"LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(Customer.class)+" c ON b.customer_id=c.id where b.status = '"+BillStatusEnum.FULLPAID+
				"' GROUP BY c.`name`, t.id, t.type_name, b.in_out";
		}else if(customerId!=null && startTime==null && endTime==null){
			sql = "SELECT c.`name`, t.id, t.type_name, b.in_out,SUM(b.factPayment) FROM "+ModulePrefixNamingStrategy.classToTableName(Bill.class)+" b " +
					"LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(BillType.class)+" t ON b.bill_type_id=t.id " +
					"LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(Customer.class)+" c ON b.customer_id=c.id " +
					"WHERE c.id='"+customerId+"'AND b.status = '"+BillStatusEnum.FULLPAID+"' GROUP BY c.`name`, t.id, t.type_name, b.in_out";
		}else if(customerId!=null && startTime!=null && endTime==null){
			sql = "SELECT c.`name`, t.id, t.type_name, b.in_out,SUM(b.factPayment) FROM "+ModulePrefixNamingStrategy.classToTableName(Bill.class)+" b " +
				"LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(BillType.class)+" t ON b.bill_type_id=t.id " +
				"LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(Customer.class)+" c ON b.customer_id=c.id " +
				"WHERE c.id='"+customerId+"' AND b.status = '"+BillStatusEnum.FULLPAID+"' AND b.payTime > '"+DateUtil.format(startTime,"yyyy-MM-dd HH:mm:ss")+"'  GROUP BY c.`name`, t.id, t.type_name, b.in_out";
		}else if(customerId!=null && startTime==null && endTime!=null){
			sql = "SELECT c.`name`, t.id, t.type_name, b.in_out,SUM(b.factPayment) FROM "+ModulePrefixNamingStrategy.classToTableName(Bill.class)+" b " +
					"LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(BillType.class)+" t ON b.bill_type_id=t.id " +
					"LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(Customer.class)+" c ON b.customer_id=c.id " +
					"WHERE c.id='"+customerId+"' AND b.status = '"+BillStatusEnum.FULLPAID+"' AND b.payTime < '"+DateUtil.format(endTime,"yyyy-MM-dd HH:mm:ss")+"'  GROUP BY c.`name`, t.id, t.type_name, b.in_out";
		}else if(customerId==null && startTime!=null && endTime!=null){
			sql = "SELECT c.`name`, t.id, t.type_name, b.in_out,SUM(b.factPayment) FROM "+ModulePrefixNamingStrategy.classToTableName(Bill.class)+" b " +
					"LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(BillType.class)+" t ON b.bill_type_id=t.id " +
					"LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(Customer.class)+" c ON b.customer_id=c.id " +
					"WHERE b.status = '"+BillStatusEnum.FULLPAID+"' AND b.payTime BETWEEN '"+DateUtil.format(startTime,"yyyy-MM-dd HH:mm:ss")+"' AND '"+DateUtil.format(endTime,"yyyy-MM-dd HH:mm:ss")+"'  GROUP BY c.`name`, t.id, t.type_name, b.in_out";
		}else if(customerId!=null && startTime!=null && endTime!=null){
			sql = "SELECT c.`name`, t.id, t.type_name, b.in_out,SUM(b.factPayment) FROM "+ModulePrefixNamingStrategy.classToTableName(Bill.class)+" b " +
					"LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(BillType.class)+" t ON b.bill_type_id=t.id " +
					"LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(Customer.class)+" c ON b.customer_id=c.id " +
					"WHERE b.status = '"+BillStatusEnum.FULLPAID+"' AND b.payTime BETWEEN '"+DateUtil.format(startTime,"yyyy-MM-dd HH:mm:ss")+"' AND '"+DateUtil.format(endTime,"yyyy-MM-dd HH:mm:ss")+"' AND c.id='"+customerId+"' GROUP BY c.`name`, t.id, t.type_name, b.in_out";
		}else if(customerId==null && startTime!=null && endTime==null){
			sql = "SELECT c.`name`, t.id, t.type_name, b.in_out,SUM(b.factPayment) FROM "+ModulePrefixNamingStrategy.classToTableName(Bill.class)+" b " +
				"LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(BillType.class)+" t ON b.bill_type_id=t.id " +
				"LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(Customer.class)+" c ON b.customer_id=c.id " +
				"WHERE b.status = '"+BillStatusEnum.FULLPAID+"' AND b.payTime > '"+DateUtil.format(startTime,"yyyy-MM-dd HH:mm:ss")+"' GROUP BY c.`name`, t.id, t.type_name, b.in_out";
		
		}else if(customerId==null && startTime==null && endTime!=null){
			sql = "SELECT c.`name`, t.id, t.type_name, b.in_out,SUM(b.factPayment) FROM "+ModulePrefixNamingStrategy.classToTableName(Bill.class)+" b " +
				"LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(BillType.class)+" t ON b.bill_type_id=t.id " +
				"LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(Customer.class)+" c ON b.customer_id=c.id " +
				"WHERE b.status = '"+BillStatusEnum.FULLPAID+"' AND b.payTime < '"+DateUtil.format(endTime,"yyyy-MM-dd HH:mm:ss")+"' GROUP BY c.`name`, t.id, t.type_name, b.in_out";
		}
		LinkedHashMap<String,Map<Long,StatisticGroupDto>> groupMaps = new LinkedHashMap<String,Map<Long,StatisticGroupDto>>();
		List<Object> list = customerDao.getObjectListBySql(sql);
		for (Object object : list) {
			Object[] objects = (Object[])object;
			String cName = String.valueOf(objects[0]);
			if(!groupMaps.containsKey(cName)){
				Map<Long,StatisticGroupDto> map = new HashMap<Long,StatisticGroupDto>();
				groupMaps.put(cName, map);
			}
			Map<Long,StatisticGroupDto> subGroupMap = groupMaps.get(cName);
			
			Long tId = BigInteger.class.cast(objects[1]).longValue();
			if(!subGroupMap.containsKey(tId)){
				StatisticGroupDto group = new StatisticGroupDto();
				group.setName(String.valueOf(objects[2]));
				group.setLid(tId);
				subGroupMap.put(tId, group);
			}
			StatisticGroupDto group = subGroupMap.get(tId);
			
			StatisticDto dto = new StatisticDto();
			dto.setName(String.valueOf(objects[3]));
			if(objects[4]!=null){
			dto.setdValue(Double.parseDouble(String.valueOf(objects[4])));
			}
			group.getList().add(dto);
			group.setAmount(group.getAmount()+1);
		}
		List<StatisticGroupDto> topGroupList = new ArrayList<StatisticGroupDto>();
		for (Entry<String, Map<Long, StatisticGroupDto>> entry : groupMaps.entrySet()) {
			StatisticGroupDto topGroup = new StatisticGroupDto();
			topGroup.setName(entry.getKey());
			topGroup.getGroups().addAll(entry.getValue().values());
			topGroupList.add(topGroup);
		}
		return Result.value(topGroupList);
	}

	//物业应收未收统计
	@Override
	public Result<?> billWzubCostByProperty(Date startTime,Date endTime) {
		//SELECT b.planPayTime,t.id,t.type_name,SUM(b.totalAmount),SUM(b.factPayment) FROM crm_bill b LEFT JOIN crm_bill_type t ON b.bill_type_id = t.id WHERE b.in_out='IN' GROUP BY DATE_FORMAT(b.planPayTime,'%Y%m'),t.type_name;
		//应收
		String sql = "SELECT b.checkoutTime,t.id,t.type_name,SUM(b.totalAmount) FROM "+ModulePrefixNamingStrategy.classToTableName(Bill.class)+
				" b LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(BillType.class)+
				" t ON b.bill_type_id = t.id  WHERE b.status != '"+BillStatusEnum.CHARGEOFF+"' AND b.in_out='IN' AND ";
		//实收（不累计）
		String sql2 = "SELECT b.payTime,t.id,t.type_name,SUM(b.totalAmount),SUM(b.factPayment) FROM "+ModulePrefixNamingStrategy.classToTableName(Bill.class)+
				" b LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(BillType.class)+
				" t ON b.bill_type_id = t.id  WHERE b.status = '"+BillStatusEnum.FULLPAID+"' AND b.in_out='IN' AND ";
		if(startTime==null && endTime==null){
			//默认显示当前月
			Date preDate = CalendarUtil.getEarliest(new Date(),Calendar.MONTH);
			Date nextDate = CalendarUtil.getLatest(new Date(),Calendar.MONTH);
			sql2 += " b.payTime BETWEEN '"+DateUtil.format(preDate,"yyyy-MM-dd HH:mm:ss")+"' AND '"+DateUtil.format(nextDate,"yyyy-MM-dd")+"' AND b.checkoutTime BETWEEN '"+DateUtil.format(preDate,"yyyy-MM-dd HH:mm:ss")+"' AND '"+DateUtil.format(nextDate,"yyyy-MM-dd")+"' GROUP BY DATE_FORMAT(b.payTime,'%Y%m'),t.type_name";
			sql += "b.checkoutTime BETWEEN '"+DateUtil.format(preDate,"yyyy-MM-dd HH:mm:ss")+"' AND '"+DateUtil.format(nextDate,"yyyy-MM-dd")+"' GROUP BY DATE_FORMAT(b.checkoutTime,'%Y%m'),t.type_name";
		}else if(startTime!=null && endTime==null){
			sql2 += "b.payTime < '"+DateUtil.format(startTime,"yyyy-MM-dd HH:mm:ss")+"' AND b.checkoutTime < '"+DateUtil.format(endTime,"yyyy-MM-dd HH:mm:ss")+"' GROUP BY DATE_FORMAT(b.payTime,'%Y%m'),t.type_name";
			sql += "b.checkoutTime > '"+DateUtil.format(startTime,"yyyy-MM-dd HH:mm:ss")+"' GROUP BY DATE_FORMAT(b.checkoutTime,'%Y%m'),t.type_name";
		}else if(startTime==null && endTime!=null){
			sql2 += "b.payTime < '"+DateUtil.format(endTime,"yyyy-MM-dd HH:mm:ss")+"' AND b.checkoutTime < '"+DateUtil.format(endTime,"yyyy-MM-dd HH:mm:ss")+"' GROUP BY DATE_FORMAT(b.payTime,'%Y%m'),t.type_name";
			sql += "b.checkoutTime < '"+DateUtil.format(endTime,"yyyy-MM-dd HH:mm:ss")+"' GROUP BY DATE_FORMAT(b.checkoutTime,'%Y%m'),t.type_name";
		}else if(startTime!=null && endTime!=null){
			sql2 += "b.payTime BETWEEN '"+DateUtil.format(startTime,"yyyy-MM-dd HH:mm:ss")+"' AND '"+DateUtil.format(endTime,"yyyy-MM-dd HH:mm:ss")+"' AND b.checkoutTime < '"+DateUtil.format(endTime,"yyyy-MM-dd HH:mm:ss")+"' GROUP BY DATE_FORMAT(b.payTime,'%Y%m'),t.type_name";
			sql += "b.checkoutTime BETWEEN '"+DateUtil.format(startTime,"yyyy-MM-dd HH:mm:ss")+"' AND '"+DateUtil.format(endTime,"yyyy-MM-dd HH:mm:ss")+"' GROUP BY DATE_FORMAT(b.checkoutTime,'%Y%m'),t.type_name";
		}
		List<Object> list = new ArrayList<Object>();
		List<Object> list2 = new ArrayList<Object>();
		list = customerDao.getObjectListBySql(sql);
		list2 = customerDao.getObjectListBySql(sql2);
		
		Map<String,Map<String,Double>> factPayMap = new HashMap<String,Map<String,Double>>();//实收
		for (Object object : list2) {
			Object[] objects = (Object[])object;
			Date bTime = DateUtil.parse(String.valueOf(objects[0]));
			String time = DateUtil.format(bTime, "yyyy-MM");
			String tName = String.valueOf(objects[2]);
			if(!factPayMap.containsKey(time)){
				Map<String,Double> map = new HashMap<String, Double>();
				map.put(tName, Double.parseDouble(String.valueOf(objects[4])));
				factPayMap.put(time, map);
			}else{
				factPayMap.get(time).put(tName, Double.parseDouble(String.valueOf(objects[4])));
			}
		}
		
		List<StatisticGroupDto> topGroupList = new ArrayList<StatisticGroupDto>();		
		LinkedHashMap<String,Map<Long,StatisticGroupDto>> groupMaps = new LinkedHashMap<String,Map<Long,StatisticGroupDto>>();
		for (Object object : list) {
			Object[] objects = (Object[])object;
			Date bTime = DateUtil.parse(String.valueOf(objects[0]));
			String time = DateUtil.format(bTime, "yyyy-MM");
			String tName = String.valueOf(objects[2]);
			if(!groupMaps.containsKey(time)){
				Map<Long,StatisticGroupDto> map = new HashMap<Long,StatisticGroupDto>();
				groupMaps.put(time, map);
			}
			Map<Long,StatisticGroupDto> subGroupMap = groupMaps.get(time);
			
			Long tId = BigInteger.class.cast(objects[1]).longValue();
			if(!subGroupMap.containsKey(tId)){
				StatisticGroupDto group = new StatisticGroupDto();
				group.setName(tName);
				group.setLid(tId);
				subGroupMap.put(tId, group);
			}
			StatisticGroupDto group = subGroupMap.get(tId);
			
			StatisticDto dto = new StatisticDto();
			dto.setName(tName);
			dto.setdValue(Double.parseDouble(String.valueOf(objects[3])));
			if(factPayMap.get(time)!=null && factPayMap.get(time).get(tName)!=null){
				BigDecimal bd1 = new BigDecimal(dto.getdValue()); 
		        BigDecimal bd2 = new BigDecimal(factPayMap.get(time).get(tName));
		        dto.setdValue2(bd1.subtract(bd2).doubleValue());
			}else{
				dto.setdValue2(dto.getdValue());
			}
			/*if(objects[4]!=null){
				
				BigDecimal bd1 = new BigDecimal(dto.getdValue()); 
		        BigDecimal bd2 = new BigDecimal(Double.parseDouble(String.valueOf(objects[4])));
		        dto.setdValue2(bd1.subtract(bd2).doubleValue());
			}*/
			group.getList().add(dto);
			group.setAmount(group.getAmount()+1);
		}
		for (Entry<String, Map<Long, StatisticGroupDto>> entry : groupMaps.entrySet()) {
			StatisticGroupDto topGroup = new StatisticGroupDto();
			topGroup.setName(entry.getKey());
			topGroup.getGroups().addAll(entry.getValue().values());
			topGroupList.add(topGroup);
		}
		return Result.value(topGroupList);
	}
	//物业应收实收统计
	@Override
	public Result<?> billCostByProperty(Date startTime,Date endTime) {
		//SELECT b.planPayTime,t.id,t.type_name,SUM(b.totalAmount),SUM(b.factPayment) FROM crm_bill b LEFT JOIN crm_bill_type t ON b.bill_type_id = t.id WHERE b.in_out='IN' GROUP BY DATE_FORMAT(b.planPayTime,'%Y%m'),t.type_name;
		//实收
		String sql = "SELECT b.payTime,t.id,t.type_name,SUM(b.totalAmount),SUM(b.factPayment) FROM "+ModulePrefixNamingStrategy.classToTableName(Bill.class)+
				" b LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(BillType.class)+
				" t ON b.bill_type_id = t.id  WHERE b.status != '"+BillStatusEnum.CHARGEOFF+"' AND b.in_out='IN' AND ";
		//应收
		String sql2 = "SELECT b.checkoutTime,t.id,t.type_name,SUM(b.totalAmount) FROM "+ModulePrefixNamingStrategy.classToTableName(Bill.class)+
				" b LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(BillType.class)+
				" t ON b.bill_type_id = t.id  WHERE b.status != '"+BillStatusEnum.CHARGEOFF+"' AND b.in_out='IN' AND ";
		if(startTime==null && endTime==null){
			//默认显示三个月的时间(前一月 当前月  后一月)
			Date preDate = CalendarUtil.add(new Date(), Calendar.MONTH, -1).getTime();
			Date nextDate = CalendarUtil.add(new Date(), Calendar.MONTH, 1).getTime();
			sql2 += "b.checkoutTime BETWEEN '"+DateUtil.format(preDate,"yyyy-MM-dd HH:mm:ss")+"' AND '"+DateUtil.format(nextDate,"yyyy-MM-dd HH:mm:ss")+"' GROUP BY DATE_FORMAT(b.checkoutTime,'%Y%m'),t.type_name";
			sql += "b.payTime BETWEEN '"+DateUtil.format(preDate,"yyyy-MM-dd HH:mm:ss")+"' AND '"+DateUtil.format(nextDate,"yyyy-MM-dd HH:mm:ss")+"' GROUP BY DATE_FORMAT(b.payTime,'%Y%m'),t.type_name";
		}else if(startTime!=null && endTime==null){
			sql2 += "b.checkoutTime > '"+DateUtil.format(startTime,"yyyy-MM-dd HH:mm:ss")+"' GROUP BY DATE_FORMAT(b.checkoutTime,'%Y%m'),t.type_name";
			sql += "b.payTime > '"+DateUtil.format(startTime,"yyyy-MM-dd HH:mm:ss")+"' GROUP BY DATE_FORMAT(b.payTime,'%Y%m'),t.type_name";
		}else if(startTime==null && endTime!=null){
			sql2 += "b.checkoutTime < '"+DateUtil.format(endTime,"yyyy-MM-dd HH:mm:ss")+"' GROUP BY DATE_FORMAT(b.checkoutTime,'%Y%m'),t.type_name";
			sql += "b.payTime < '"+DateUtil.format(endTime,"yyyy-MM-dd HH:mm:ss")+"' GROUP BY DATE_FORMAT(b.payTime,'%Y%m'),t.type_name";
		}else if(startTime!=null && endTime!=null){
			sql2 += "b.checkoutTime BETWEEN '"+DateUtil.format(startTime,"yyyy-MM-dd HH:mm:ss")+"' AND '"+DateUtil.format(endTime,"yyyy-MM-dd HH:mm:ss")+"' GROUP BY DATE_FORMAT(b.checkoutTime,'%Y%m'),t.type_name";
			sql += "b.payTime BETWEEN '"+DateUtil.format(startTime,"yyyy-MM-dd HH:mm:ss")+"' AND '"+DateUtil.format(endTime,"yyyy-MM-dd HH:mm:ss")+"' GROUP BY DATE_FORMAT(b.payTime,'%Y%m'),t.type_name";
		}
		List<Object> list = new ArrayList<Object>();
		list = customerDao.getObjectListBySql(sql);
		List<Object> list2 = new ArrayList<Object>();
		list2 = customerDao.getObjectListBySql(sql2);
		
		
		Map<String,Map<String,Double>> factPayMap = new HashMap<String,Map<String,Double>>();//实收
		for (Object object : list) {
			Object[] objects = (Object[])object;
			Date bTime = DateUtil.parse(String.valueOf(objects[0]));
			String time = DateUtil.format(bTime, "yyyy-MM");
			String tName = String.valueOf(objects[2]);
			if(!factPayMap.containsKey(time)){
				Map<String,Double> map = new HashMap<String, Double>();
				map.put(tName, Double.parseDouble(String.valueOf(objects[4])));
				factPayMap.put(time, map);
			}else{
				factPayMap.get(time).put(tName, Double.parseDouble(String.valueOf(objects[4])));
			}
		}
		List<StatisticGroupDto> topGroupList = new ArrayList<StatisticGroupDto>();		
		LinkedHashMap<String,Map<Long,StatisticGroupDto>> groupMaps = new LinkedHashMap<String,Map<Long,StatisticGroupDto>>();
		for (Object object : list2) {
			Object[] objects = (Object[])object;
			Date bTime = DateUtil.parse(String.valueOf(objects[0]));
			String time = DateUtil.format(bTime, "yyyy-MM");
			String tName = String.valueOf(objects[2]);//类型名称
			if(!groupMaps.containsKey(time)){
				Map<Long,StatisticGroupDto> map = new HashMap<Long,StatisticGroupDto>();
				groupMaps.put(time, map);
			}
			Map<Long,StatisticGroupDto> subGroupMap = groupMaps.get(time);
			
			Long tId = BigInteger.class.cast(objects[1]).longValue();//类型id
			if(!subGroupMap.containsKey(tId)){
				StatisticGroupDto group = new StatisticGroupDto();
				group.setName(tName);
				group.setLid(tId);
				subGroupMap.put(tId, group);
			}
			StatisticGroupDto group = subGroupMap.get(tId);
			
			StatisticDto dto = new StatisticDto();
			dto.setName(tName);
			
			dto.setdValue(Double.parseDouble(String.valueOf(objects[3])));
			
			if(factPayMap.get(time)!=null && factPayMap.get(time).get(tName)!=null){
				dto.setdValue2(factPayMap.get(time).get(tName));
			}else{
				dto.setdValue2(0D);
			}
			group.getList().add(dto);
			group.setAmount(group.getAmount()+1);
		}
		for (Entry<String, Map<Long, StatisticGroupDto>> entry : groupMaps.entrySet()) {
			StatisticGroupDto topGroup = new StatisticGroupDto();
			topGroup.setName(entry.getKey());
			topGroup.getGroups().addAll(entry.getValue().values());
			topGroupList.add(topGroup);
		}
		return Result.value(topGroupList);
	}

	/*@Override
	public Result<?> billCostByProperty(Date startTime,Date endTime) {
		//SELECT b.planPayTime,t.id,t.type_name,SUM(b.totalAmount),SUM(b.factPayment) FROM crm_bill b LEFT JOIN crm_bill_type t ON b.bill_type_id = t.id WHERE b.in_out='IN' GROUP BY DATE_FORMAT(b.planPayTime,'%Y%m'),t.type_name;
		String sql = "";
		if(startTime==null && endTime==null){
			//默认显示三个月的时间(前一月 当前月  后一月)
			Date preDate = CalendarUtil.add(new Date(), Calendar.MONTH, -1).getTime();
			Date nextDate = CalendarUtil.add(new Date(), Calendar.MONTH, 1).getTime();
			sql = "SELECT b.payTime,t.id,t.type_name,SUM(b.totalAmount),SUM(b.factPayment) FROM "+ModulePrefixNamingStrategy.classToTableName(Bill.class)+
				" b LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(BillType.class)+
				" t ON b.bill_type_id = t.id  WHERE b.status = '"+BillStatusEnum.FULLPAID+"' AND b.in_out='IN' AND b.payTime BETWEEN '"+DateUtil.format(preDate,"yyyy-MM-dd HH:mm:ss")+"' AND '"+DateUtil.format(nextDate,"yyyy-MM-dd HH:mm:ss")+"' GROUP BY DATE_FORMAT(b.payTime,'%Y%m'),t.type_name";
		}else if(startTime!=null && endTime==null){
			sql = "SELECT b.payTime,t.id,t.type_name,SUM(b.totalAmount),SUM(b.factPayment) FROM "+ModulePrefixNamingStrategy.classToTableName(Bill.class)+
				" b LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(BillType.class)+
				" t ON b.bill_type_id = t.id  WHERE b.status = '"+BillStatusEnum.FULLPAID+"' AND b.in_out='IN' AND b.payTime > '"+DateUtil.format(startTime,"yyyy-MM-dd HH:mm:ss")+"' GROUP BY DATE_FORMAT(b.payTime,'%Y%m'),t.type_name";
		}else if(startTime==null && endTime!=null){
			sql = "SELECT b.payTime,t.id,t.type_name,SUM(b.totalAmount),SUM(b.factPayment) FROM "+ModulePrefixNamingStrategy.classToTableName(Bill.class)+
				" b LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(BillType.class)+
				" t ON b.bill_type_id = t.id  WHERE b.status = '"+BillStatusEnum.FULLPAID+"' AND b.in_out='IN' AND b.payTime < '"+DateUtil.format(endTime,"yyyy-MM-dd HH:mm:ss")+"' GROUP BY DATE_FORMAT(b.payTime,'%Y%m'),t.type_name";
		}else if(startTime!=null && endTime!=null){
			sql = "SELECT b.payTime,t.id,t.type_name,SUM(b.totalAmount),SUM(b.factPayment) FROM "+ModulePrefixNamingStrategy.classToTableName(Bill.class)+
				" b LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(BillType.class)+
				" t ON b.bill_type_id = t.id  WHERE b.status = '"+BillStatusEnum.FULLPAID+"' AND b.in_out='IN' AND b.payTime BETWEEN '"+DateUtil.format(startTime,"yyyy-MM-dd HH:mm:ss")+"' AND '"+DateUtil.format(endTime,"yyyy-MM-dd HH:mm:ss")+"' GROUP BY DATE_FORMAT(b.payTime,'%Y%m'),t.type_name";
		}
		List<Object> list = new ArrayList<Object>();
		list = customerDao.getObjectListBySql(sql);
		List<StatisticGroupDto> topGroupList = new ArrayList<StatisticGroupDto>();		
		LinkedHashMap<String,Map<Long,StatisticGroupDto>> groupMaps = new LinkedHashMap<String,Map<Long,StatisticGroupDto>>();
		for (Object object : list) {
			Object[] objects = (Object[])object;
			Date bTime = DateUtil.parse(String.valueOf(objects[0]));
			String time = DateUtil.format(bTime, "yyyy-MM");
			String tName = String.valueOf(objects[2]);
			if(!groupMaps.containsKey(time)){
				Map<Long,StatisticGroupDto> map = new HashMap<Long,StatisticGroupDto>();
				groupMaps.put(time, map);
			}
			Map<Long,StatisticGroupDto> subGroupMap = groupMaps.get(time);
			
			Long tId = BigInteger.class.cast(objects[1]).longValue();
			if(!subGroupMap.containsKey(tId)){
				StatisticGroupDto group = new StatisticGroupDto();
				group.setName(tName);
				group.setLid(tId);
				subGroupMap.put(tId, group);
			}
			StatisticGroupDto group = subGroupMap.get(tId);
			
			StatisticDto dto = new StatisticDto();
			dto.setName(tName);
			dto.setdValue(Double.parseDouble(String.valueOf(objects[3])));
			if(objects[4]!=null){
			dto.setdValue2(Double.parseDouble(String.valueOf(objects[4])));
			}
			group.getList().add(dto);
			group.setAmount(group.getAmount()+1);
		}
		for (Entry<String, Map<Long, StatisticGroupDto>> entry : groupMaps.entrySet()) {
			StatisticGroupDto topGroup = new StatisticGroupDto();
			topGroup.setName(entry.getKey());
			topGroup.getGroups().addAll(entry.getValue().values());
			topGroupList.add(topGroup);
		}
		return Result.value(topGroupList);
	}*/
	
	@Override
	public Result<?> billCostYearCount() {
		//SELECT b.planPayTime,t.id,t.type_name,b.in_out,SUM(b.factPayment) FROM crm_bill b LEFT JOIN crm_bill_type t ON b.bill_type_id = t.id GROUP BY DATE_FORMAT(b.planPayTime,'%Y'),t.id,t.type_name,b.in_out;
		String sql = "SELECT b.planPayTime ,t.id,t.type_name,b.in_out,SUM(b.factPayment) FROM "+ModulePrefixNamingStrategy.classToTableName(Bill.class)+
				" b LEFT JOIN "+ModulePrefixNamingStrategy.classToTableName(BillType.class)+
				" t ON b.bill_type_id = t.id WHERE b.status = '"+BillStatusEnum.FULLPAID+"' GROUP BY t.id,t.type_name,b.in_out";
		List<Object> list = new ArrayList<Object>();
		list = customerDao.getObjectListBySql(sql);
		List<StatisticDto> topList = new ArrayList<StatisticDto>();		
		LinkedHashMap<String,Map<Long,StatisticGroupDto>> groupMaps = new LinkedHashMap<String,Map<Long,StatisticGroupDto>>();
		for (Object object : list) {
			Object[] objects = (Object[])object;
			String tName = String.valueOf(objects[2]);
			String inOut = String.valueOf(objects[3]);
			Double dValue = Double.parseDouble(String.valueOf(objects[4]));
			StatisticDto dto = new StatisticDto();
			dto.setName(tName);
			dto.setMemo(inOut);
			dto.setdValue(dValue);
			topList.add(dto);
		}
		return Result.value(topList);
	}

	@Override
	public Result<?> customerContract(Pager pager) {
		Session session = customerDao.openSession();
		Query query = session.createQuery("from Contract");
		String splitString = "\n";
		if(pager!=null){
			splitString = "</br>";
			Object count = session.createQuery("select count(*) from Contract").uniqueResult();
			if(count instanceof Integer){
				pager.setRecords(Integer.class.cast(count));
			} else if(count instanceof Long) {
				pager.setRecords(Long.class.cast(count).intValue());
			}
			query.setFirstResult((pager.getPage()-1)*pager.getRows()).setMaxResults(pager.getRows());
		}
		List<Contract> contractList = query.list();
		Map<Long,ContractStatisticDto> dtoMap = new HashMap<Long, ContractStatisticDto>();
		DecimalFormat numberFormat = new DecimalFormat("#0.00");
		for (Contract contract : contractList) {
			ContractStatisticDto dto = new ContractStatisticDto();
			List<BillPlanRent> billRentList = session.createQuery("from BillPlanRent where contractId = "+contract.getId()).list();
			Map<Long,SubjectRent> itemMap = new HashMap<Long, SubjectRent>();
			Double rentTotal = 0d;
			Double energyTotal = 0d;
			for (BillPlanRent billPlanRent : billRentList) {
				if(billPlanRent.getRealFee()!=null) {
					if(billPlanRent.getFeeType().equals(RentBillPlanFeeEnum.RENT)) {
						rentTotal+=billPlanRent.getRealFee();
					} else if(billPlanRent.getFeeType().equals(RentBillPlanFeeEnum.ENERGY)) {
						energyTotal+=billPlanRent.getRealFee();
					}
				}
				if(billPlanRent.getSubjectId()!=null){
					if(!itemMap.containsKey(billPlanRent.getSubjectId())) {
						itemMap.put(billPlanRent.getSubjectId(), billPlanRent.getSubject());
					}
				}
				String time = "";
				if(billPlanRent.getStartDate()!=null){
					time += DateUtil.format(billPlanRent.getStartDate());
				}
				if(billPlanRent.getEndDate()!=null){
					time += "-"+DateUtil.format(billPlanRent.getEndDate());
				}
				if(isFirstHalfYear(billPlanRent.getStartDate())){
					if(dto.getFirstHalfYearTime().length()>0){
						dto.setFirstHalfYearTime(dto.getFirstHalfYearTime()+splitString);
					}
					dto.setFirstHalfYearTime(dto.getFirstHalfYearTime()+time);
					if(billPlanRent.getFeeType().equals(RentBillPlanFeeEnum.RENT)) {
						dto.setFirstHalfYearMoneyRent(dto.getFirstHalfYearMoneyRent()+billPlanRent.getRealFee());
					} else if(billPlanRent.getFeeType().equals(RentBillPlanFeeEnum.ENERGY)) {
						dto.setFirstHalfYearMoneyEnergy(dto.getFirstHalfYearMoneyEnergy()+billPlanRent.getRealFee());
					}
				} else {
					if(dto.getSecondHalfYearTime().length()>0){
						dto.setSecondHalfYearTime(dto.getSecondHalfYearTime()+splitString);
					}
					dto.setSecondHalfYearTime(dto.getSecondHalfYearTime()+time);
					if(billPlanRent.getFeeType().equals(RentBillPlanFeeEnum.RENT)) {
						dto.setSecondHalfYearMoneyRent(dto.getSecondHalfYearMoneyRent()+billPlanRent.getRealFee());
					} else if(billPlanRent.getFeeType().equals(RentBillPlanFeeEnum.ENERGY)) {
						dto.setSecondHalfYearMoneyEnergy(dto.getSecondHalfYearMoneyEnergy()+billPlanRent.getRealFee());
					}
				}
			}
			dto.setRentTotal(rentTotal);
			dto.setEnergyTotal(energyTotal);
			Double area = 0d;
			for (Long key : itemMap.keySet()) {
				SubjectRent item = itemMap.get(key);
				if(item!=null){
					dto.setEnergyPrice(item.getRoom().getBuilding().getPark().getEnergyFee());
					area += item.getRoomArea();
					if(dto.getRooms().length()>0){
						dto.setRooms(dto.getRooms()+splitString);
					}
					dto.setRooms(dto.getRooms()+item.getRoom().getName());
					Double price = item.getRentPrice();
					if(price!=null){
						if(dto.getRentPrice().length()>0){
							dto.setRentPrice(dto.getRentPrice()+splitString);
						}
						dto.setRentPrice(dto.getRentPrice()+numberFormat.format(price));
					}
				}
			}
			dto.setArea(area);
			
			List<Deposit> depositList = session.createQuery("from Deposit where contractId = "+contract.getId()).list();
			Double depositAmount = 0d;
			for (Deposit deposit : depositList) {
				if(deposit.getAmount()!=null){
					depositAmount += deposit.getAmount();
				}
			}
			dto.setDeposit(depositAmount);
			
//			User manager = PbActivator.getUserById(contract.getManagerId());
			Long customerId = contract.getCustomerId();
			Contect contect = (Contect) session.createQuery("from Contect where customerId = "+customerId+" and main = 'YES'").setMaxResults(1).uniqueResult();
			if(contect!=null){
				dto.setManager(contect.getName());
				dto.setManagerPhone(contect.getMobile());
			}
			if(dto.getRentPrice()!=null) {
				String[] prices = dto.getRentPrice().split(splitString);
				if(prices.length>0){
					String price = prices[0];
					boolean equal = true;
					for (int i = 1; i < prices.length; i++) {
						if(!prices[i].equals(price)) {
							equal = false;
							break;
						}
					}
					if(equal) dto.setRentPrice(price);
				}
			}
			List<BillPlanFacility> billFacilityList = session.createQuery("from BillPlanFacility where contractId = "+contract.getId() + " and facility.type = '"+FacilityTypeEnum.NETWORK+"'").list();
			for (BillPlanFacility billPlanFacility : billFacilityList) {
				String time = "";
				if(billPlanFacility.getStartDate()!=null){
					time += DateUtil.format(billPlanFacility.getStartDate());
				}
				if(billPlanFacility.getEndDate()!=null){
					time += "-"+DateUtil.format(billPlanFacility.getEndDate());
				}
				if(isFirstHalfYear(billPlanFacility.getStartDate())){
					if(dto.getFirstHalfYearTime().length()>0){
						dto.setFirstHalfYearTime(dto.getFirstHalfYearTime()+splitString);
					}
					dto.setFirstHalfYearTime(dto.getFirstHalfYearTime()+time);
					dto.setFirstHalfYearMoneyNet(dto.getFirstHalfYearMoneyNet()+billPlanFacility.getRealFee());
				} else {
					if(dto.getSecondHalfYearTime().length()>0){
						dto.setSecondHalfYearTime(dto.getSecondHalfYearTime()+splitString);
					}
					dto.setSecondHalfYearTime(dto.getSecondHalfYearTime()+time);
					dto.setSecondHalfYearMoneyNet(dto.getSecondHalfYearMoneyNet()+billPlanFacility.getRealFee());
				}
			}
			dto.setContract(contract);
			dtoMap.put(contract.getId(), dto);
		}
		List<ContractStatisticDto> list = new ArrayList<ContractStatisticDto>(dtoMap.values());
		return Result.value(list);
	}
	
	static boolean isFirstHalfYear(Date time){
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(time);
		return calendar.get(Calendar.MONTH)<6;
	}

	@Override
	public List<Object[]> exportBillByTime(Date startTime,String type) {
		List<Object[]> dataList = new ArrayList<Object[]>();
		List<StatisticGroupDto> topGroupList = (List<StatisticGroupDto>)billCostByTime(startTime, type).getValue();
		List<BillReportDto> dtoList = new ArrayList<BillReportDto>();
		List<String> colNames = new ArrayList<String>();
		if(topGroupList!=null && topGroupList.size()>0){
			for(StatisticGroupDto statisticGroupDto : topGroupList){
				BillReportDto brdto = new BillReportDto();
				String monthName = "";
				if(type.equals("month")){
					monthName = statisticGroupDto.getName();
				}else if(type.equals("year")){
					monthName = statisticGroupDto.getAmount()+"";
				}
				List<StatisticDto> inOutList = new ArrayList<StatisticDto>();
				Double totalIn = 0D;
				Double totalOut = 0D;
				for(StatisticGroupDto childDto : statisticGroupDto.getGroups()){
					if(!colNames.contains(childDto.getName()+"收入")){
						colNames.add(childDto.getName()+"收入");
					}
					if(!colNames.contains(childDto.getName()+"支出")){
						colNames.add(childDto.getName()+"支出");
					}
					if(childDto.getList()!=null && childDto.getList().size()>0){
						String inValue = "0.0";
						String outValue = "0.0";
						for(StatisticDto dto : childDto.getList()){
							StatisticDto statisticDto = new StatisticDto();
							if(dto.getName().equals("IN")){
								inValue = dto.getdValue()+"";
								statisticDto.setName(childDto.getName()+"收入");
								statisticDto.setdValue(dto.getdValue());
							}else if(dto.getName().equals("OUT")){
								outValue = dto.getdValue()+"";
								statisticDto.setName(childDto.getName()+"支出");
								statisticDto.setdValue(dto.getdValue());
							}
							inOutList.add(statisticDto);
						}
						if(!inValue.equals("0.0")){
							totalIn += Double.parseDouble(inValue);
						}
						if(!outValue.equals("0.0")){
							totalOut += Double.parseDouble(outValue);
						}
					}
				}
				brdto.setTime(monthName);
				brdto.setInOutList(inOutList);
				brdto.setTotalIn(totalIn);
				brdto.setTotalOut(totalOut);
				dtoList.add(brdto);
			}
		}
		int j =1;
		for (BillReportDto dto : dtoList) {
			List<String> datas = new ArrayList<String>();
			datas.add(j+"");
			j++;
			datas.add(dto.getTime());
			loop:for(String name : colNames){
				int i=0;
				for(StatisticDto dtoN : dto.getInOutList()){
					if(dtoN.getName().equals(name)){
						datas.add(dtoN.getdValue()+"");
						i = 1;
						continue loop;
					}
				}
				if(i==0){
					datas.add("0");
				}
			}
			datas.add(dto.getTotalIn()+"");
			datas.add(dto.getTotalOut()+"");
			dataList.add(datas.toArray());
		}
		List<String> countDatas = new ArrayList<String>();
		countDatas.add(j+"");
		countDatas.add("合计");
		for(String name : colNames){
			Double count = 0D;
			for (BillReportDto dto : dtoList) {
				for(StatisticDto dtoN : dto.getInOutList()){
					if(dtoN.getName().equals(name)){
						count += dtoN.getdValue();
					}
				}
			}
			countDatas.add(count+"");
		}
		Double ti = 0D;
		Double to = 0D;
		for(BillReportDto dto : dtoList){
			ti += dto.getTotalIn();
			to += dto.getTotalOut();
		}
		countDatas.add(ti+"");
		countDatas.add(to+"");
		dataList.add(countDatas.toArray());
		return dataList;
	}

	@Override
	public List<Object[]> exportBillByCustomer(Long customerId, Date startTime,Date endTime) {
		List<Object[]> dataList = new ArrayList<Object[]>();
		List<StatisticGroupDto> topGroupList = (List<StatisticGroupDto>)billCostByCustomer(customerId,startTime,endTime).getValue();
		List<BillReportDto> dtoList = new ArrayList<BillReportDto>();
		List<String> colNames = new ArrayList<String>();
		if(topGroupList!=null && topGroupList.size()>0){
			for(StatisticGroupDto statisticGroupDto : topGroupList){
				BillReportDto brdto = new BillReportDto();
				String monthName = statisticGroupDto.getName();
				List<StatisticDto> inOutList = new ArrayList<StatisticDto>();
				Double totalIn = 0D;
				Double totalOut = 0D;
				for(StatisticGroupDto childDto : statisticGroupDto.getGroups()){
					if(!colNames.contains(childDto.getName()+"收入")){
						colNames.add(childDto.getName()+"收入");
					}
					if(!colNames.contains(childDto.getName()+"支出")){
						colNames.add(childDto.getName()+"支出");
					}
					if(childDto.getList()!=null && childDto.getList().size()>0){
						String inValue = "0.0";
						String outValue = "0.0";
						for(StatisticDto dto : childDto.getList()){
							StatisticDto statisticDto = new StatisticDto();
							if(dto.getName().equals("IN")){
								inValue = dto.getdValue()+"";
								statisticDto.setName(childDto.getName()+"收入");
								statisticDto.setdValue(dto.getdValue());
							}else if(dto.getName().equals("OUT")){
								outValue = dto.getdValue()+"";
								statisticDto.setName(childDto.getName()+"支出");
								statisticDto.setdValue(dto.getdValue());
							}
							inOutList.add(statisticDto);
						}
						if(!inValue.equals("0.0")){
							totalIn += Double.parseDouble(inValue);
						}
						if(!outValue.equals("0.0")){
							totalOut += Double.parseDouble(outValue);
						}
					}
				}
				brdto.setTime(monthName);
				brdto.setInOutList(inOutList);
				brdto.setTotalIn(totalIn);
				brdto.setTotalOut(totalOut);
				dtoList.add(brdto);
			}
		}
		int j =1;
		for (BillReportDto dto : dtoList) {
			List<String> datas = new ArrayList<String>();
			datas.add(j+"");
			j++;
			datas.add(dto.getTime());
			loop:for(String name : colNames){
				int i=0;
				for(StatisticDto dtoN : dto.getInOutList()){
					if(dtoN.getName().equals(name)){
						datas.add(dtoN.getdValue()+"");
						i = 1;
						continue loop;
					}
				}
				if(i==0){
					datas.add("0");
				}
			}
			datas.add(dto.getTotalIn()+"");
			datas.add(dto.getTotalOut()+"");
			dataList.add(datas.toArray());
		}
		return dataList;
	}

	@Override
	public List<Object[]> exportBillByProperty(Date startTime, Date endTime) {
		List<Object[]> dataList = new ArrayList<Object[]>();
		List<StatisticGroupDto> topGroupList = (List<StatisticGroupDto>)billCostByProperty(startTime,endTime).getValue();
		List<BillReportDto> dtoList = new ArrayList<BillReportDto>();
		List<String> colNames = new ArrayList<String>();
		if(topGroupList!=null && topGroupList.size()>0){
			for(StatisticGroupDto statisticGroupDto : topGroupList){
				BillReportDto brdto = new BillReportDto();
				String monthName = statisticGroupDto.getName();
				List<StatisticDto> inOutList = new ArrayList<StatisticDto>();
				for(StatisticGroupDto childDto : statisticGroupDto.getGroups()){
					if(!colNames.contains("应收"+childDto.getName())){
						colNames.add("应收"+childDto.getName());
					}
					if(!colNames.contains("实收"+childDto.getName())){
						colNames.add("实收"+childDto.getName());
					}
					if(childDto.getList()!=null && childDto.getList().size()>0){
						String inValue = "0.0";
						String outValue = "0.0";
						for(StatisticDto dto : childDto.getList()){
							StatisticDto statisticDto = new StatisticDto();
							statisticDto.setName("应收"+childDto.getName());
							if(dto.getdValue()!=null){
								inValue = dto.getdValue()+"";
							}
							statisticDto.setdValue(dto.getdValue());
							
							StatisticDto statisticDto2 = new StatisticDto();
							statisticDto2.setName("实收"+childDto.getName());
							if(dto.getdValue2()!=null){
								outValue = dto.getdValue2()+"";
							}
							statisticDto2.setdValue(dto.getdValue2());
							
							inOutList.add(statisticDto);
							inOutList.add(statisticDto2);
						}
						
					}
				}
				brdto.setTime(monthName);
				brdto.setInOutList(inOutList);
				dtoList.add(brdto);
			}
		}
		int j =1;
		for (BillReportDto dto : dtoList) {
			List<String> datas = new ArrayList<String>();
			datas.add(j+"");
			j++;
			datas.add(dto.getTime());
			loop:for(String name : colNames){
				int i=0;
				for(StatisticDto dtoN : dto.getInOutList()){
					if(dtoN.getName().equals(name)){
						datas.add(dtoN.getdValue()+"");
						i = 1;
						continue loop;
					}
				}
				if(i==0){
					datas.add("0");
				}
			}
			dataList.add(datas.toArray());
		}
		return dataList;
	}
	
	@Override
	public List<Object[]> exportBillWzubByProperty(Date startTime, Date endTime) {
		List<Object[]> dataList = new ArrayList<Object[]>();
		List<StatisticGroupDto> topGroupList = (List<StatisticGroupDto>)billWzubCostByProperty(startTime,endTime).getValue();
		List<BillReportDto> dtoList = new ArrayList<BillReportDto>();
		List<String> colNames = new ArrayList<String>();
		if(topGroupList!=null && topGroupList.size()>0){
			for(StatisticGroupDto statisticGroupDto : topGroupList){
				BillReportDto brdto = new BillReportDto();
				String monthName = statisticGroupDto.getName();
				List<StatisticDto> inOutList = new ArrayList<StatisticDto>();
				for(StatisticGroupDto childDto : statisticGroupDto.getGroups()){
					if(!colNames.contains("应收"+childDto.getName())){
						colNames.add("应收"+childDto.getName());
					}
					if(!colNames.contains("未收"+childDto.getName())){
						colNames.add("未收"+childDto.getName());
					}
					if(childDto.getList()!=null && childDto.getList().size()>0){
						String inValue = "0.0";
						String outValue = "0.0";
						for(StatisticDto dto : childDto.getList()){
							StatisticDto statisticDto = new StatisticDto();
							statisticDto.setName("应收"+childDto.getName());
							if(dto.getdValue()!=null){
								inValue = dto.getdValue()+"";
							}
							statisticDto.setdValue(dto.getdValue());
							
							StatisticDto statisticDto2 = new StatisticDto();
							statisticDto2.setName("未收"+childDto.getName());
							if(dto.getdValue2()!=null){
								outValue = dto.getdValue2()+"";
							}
							statisticDto2.setdValue(dto.getdValue2());
							
							inOutList.add(statisticDto);
							inOutList.add(statisticDto2);
						}
						
					}
				}
				brdto.setTime(monthName);
				brdto.setInOutList(inOutList);
				dtoList.add(brdto);
			}
		}
		int j =1;
		for (BillReportDto dto : dtoList) {
			List<String> datas = new ArrayList<String>();
			datas.add(j+"");
			j++;
			datas.add(dto.getTime());
			loop:for(String name : colNames){
				int i=0;
				for(StatisticDto dtoN : dto.getInOutList()){
					if(dtoN.getName().equals(name)){
						datas.add(dtoN.getdValue()+"");
						i = 1;
						continue loop;
					}
				}
				if(i==0){
					datas.add("0");
				}
			}
			dataList.add(datas.toArray());
		}
		return dataList;
	}
}
