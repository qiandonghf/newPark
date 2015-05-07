package com.wiiy.crm.job;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Timer;

import org.springframework.context.ApplicationContext;

import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.crm.entity.Contract;
import com.wiiy.crm.entity.DataCheck;
import com.wiiy.crm.entity.DataCheckLog;
import com.wiiy.crm.entity.SubjectRent;
import com.wiiy.crm.preferences.enums.CheckStatusEnum;
import com.wiiy.crm.preferences.enums.CheckTypeEnum;
import com.wiiy.crm.preferences.enums.ContractStatusEnum;
import com.wiiy.crm.service.ContractService;
import com.wiiy.crm.service.DataCheckLogService;
import com.wiiy.crm.service.DataCheckService;
import com.wiiy.crm.service.SubjectRentService;
import com.wiiy.hibernate.Filter;
import com.wiiy.pb.entity.Room;
import com.wiiy.pb.service.RoomService;

public class DataCheckJob extends RepeatJob{
	
	protected ApplicationContext applicationContext;
	private RoomService roomService;
	private ContractService contractService;
	private SubjectRentService rentService;
	
	private DataCheckService dataCheckService;
	private DataCheckLogService dataCheckLogService;

	private List<Contract> contracts = new ArrayList<Contract>();
	
	public DataCheckJob(ApplicationContext applicationContext) {
		super(applicationContext);
		this.applicationContext = applicationContext;
		roomService = applicationContext.getBean(RoomService.class);
		contractService = applicationContext.getBean(ContractService.class);
		rentService = applicationContext.getBean(SubjectRentService.class);
		dataCheckService = applicationContext.getBean(DataCheckService.class);
		dataCheckLogService = applicationContext.getBean(DataCheckLogService.class);
	}
	
	public void init(){
		new Timer().schedule(new JobTask(),CalendarUtil.getEarliest(CalendarUtil.add(new Date(), Calendar.DAY_OF_YEAR, 1).getTime(), Calendar.DAY_OF_YEAR), 1000*60*60*24);
	}
	
	/*public void init(){
		new Timer().schedule(new JobTask(), 1000,1000*60*60*24);
	}*/
	
	@Override
	protected void execute() {
		try{
			System.out.println("============启动自检Job=============");
			DataCheck dataCheck = new DataCheck();
			dataCheck.setDate(new Date());
			dataCheck.setStartTime(new Date());
			dataCheck.setStatus(CheckStatusEnum.UNFINISHED);
			dataCheckService.save(dataCheck);
			
			boolean roomstatus = roomStatusCheck(dataCheck.getId());
			
			boolean contractstatus = contractExpiredCheckJob(dataCheck.getId());
			
			if(roomstatus==contractstatus==true){
				dataCheck.setStatus(CheckStatusEnum.SUCCESS);
			}else if(roomstatus==contractstatus==false){
				
				dataCheck.setStatus(CheckStatusEnum.FAILURE);
			}else{
				dataCheck.setStatus(CheckStatusEnum.PART);
			}
			dataCheck.setEndTime(new Date());
			dataCheckService.update(dataCheck);
			System.out.println("============自检Job启动完成=============");
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	private boolean roomStatusCheck(Long id){
		//创建自检记录
		DataCheck dataCheck = new DataCheck();
		dataCheck.setDate(new Date());
		dataCheck.setStartTime(new Date());
		dataCheck.setStatus(CheckStatusEnum.UNFINISHED);
		dataCheck.setType(CheckTypeEnum.ROOMKIND);
		if(id!=null){
			dataCheck.setParentId(id);
		}
		try{
			dataCheckService.save(dataCheck);
			Filter filter = new Filter(Room.class);
			filter.createAlias("building", "building");
			String[] roomNames = {"name","status","building.name","kind"};
			filter.include(roomNames);
			List<Room> roomList = roomService.getListByFilter(filter).getValue();
			
			String[] contractNames = {"id","name","contractNo"};
			filter = new Filter(Contract.class);
			filter.include(contractNames);
			List<Contract> contracts = contractService.getListByFilter(filter).getValue();
			filter = new Filter(SubjectRent.class);
			String[] subjectRentNames = {"contractId","roomId"};
			filter.include(subjectRentNames);
			List<SubjectRent> subjectRents = rentService.getListByFilter(filter).getValue();
			
			//企业还在执行中的合同
			Map<Long,Contract> executeContractMap = new HashMap<Long,Contract>();
			for (Contract contract : contracts){
				if(contract.getState() == ContractStatusEnum.EXECUTE){
					for (SubjectRent subjectRent : subjectRents) {
						if(subjectRent.getContractId() == contract.getId()){
							executeContractMap.put(subjectRent.getRoomId(), contract);
						}
					}
				}
			}
			
			//创建自检log
			DataCheckLog checkLog = new DataCheckLog();
			String name = "RoomCheck"+DateUtil.format(new Date(),"yyyy-MM-dd")+".html";
			checkLog.setDate(new Date());
			if(id!=null){
				checkLog.setParentId(id);
			}
			checkLog.setName(name);
			checkLog.setStatus(CheckStatusEnum.UNFINISHED);
			dataCheckLogService.save(checkLog);
			try{
				//创建log文件
				File file = new File(System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+File.separator+"parkmanager.pb.war"+File.separator+"web"+File.separator+"checkHtml"+File.separator+name);
				if(!file.exists()){ 
					file.createNewFile();
				}
				checkLog.setDate(new Date());
				if(id!=null){
					checkLog.setParentId(id);
				}
				BufferedWriter output = new BufferedWriter(new FileWriter(file));
				output.write("<title>房间自检</title><html><body><table>");
				for (Room room : roomList) {
					if(room.getKind().getDataValue().equals("出租")){
						if(executeContractMap.get(room.getId())!=null){
							output.write("<tr><td><span>"+room.getBuilding().getName()+"【"+room.getName()+"】的房间状态正常"+"</span></td></tr>");
							System.out.println("================"+room.getBuilding().getName()+"【"+room.getName()+"】的房间状态正常");
						}else{
							output.write("<tr><td><span style='color:red;'>"+room.getBuilding().getName()+"【"+room.getName()+"】的房间状态不正常,没有相关标的在执行,目前房间性质："+room.getKind().getDataValue()+"</span></td></tr>");
							System.err.println("****************"+room.getBuilding().getName()+"【"+room.getName()+"】的房间状态不正常,没有相关标的在执行,目前房间性质："+room.getKind().getDataValue());
						}
					}else{
						if(executeContractMap.get(room.getId())!=null){
							output.write("<tr><td><span style='color:red;'>"+room.getBuilding().getName()+"【"+room.getName()+"】的房间状态不正常，合同【"+executeContractMap.get(room.getId()).getContractNo()+"】中有相关标的在执行,目前房间性质："+room.getKind().getDataValue()+"</span></td></tr>");
							System.err.println("****************"+room.getBuilding().getName()+"【"+room.getName()+"】的房间状态不正常，合同【"+executeContractMap.get(room.getId()).getContractNo()+"】中有相关标的在执行,目前房间性质："+room.getKind().getDataValue());
						}else{
							output.write("<tr><td><span>"+room.getBuilding().getName()+"【"+room.getName()+"】的房间状态正常"+"</span></td></tr>");
							System.out.println("================"+room.getBuilding().getName()+"【"+room.getName()+"】的房间状态正常");
						}
					}
				}
				output.write("</table></body></html>");
				output.close();
				dataCheck.setStatus(CheckStatusEnum.SUCCESS);
				dataCheck.setEndTime(new Date());
				dataCheckService.update(dataCheck);
				
				checkLog.setEndTime(new Date());
				checkLog.setStatus(CheckStatusEnum.SUCCESS);
				dataCheckLogService.update(checkLog);
			}catch(Exception e){
				System.out.println("=========房间性质自检Job执行失败========");
				dataCheck.setStatus(CheckStatusEnum.FAILURE);
				dataCheck.setEndTime(new Date());
				dataCheckService.update(dataCheck);
				
				checkLog.setStatus(CheckStatusEnum.FAILURE);
				checkLog.setEndTime(new Date());
				dataCheckLogService.update(checkLog);
				e.printStackTrace();
			}
			return true;
		}catch(Exception e){
			System.out.println("=========房间性质自检Job启动失败========");
			dataCheck.setStatus(CheckStatusEnum.FAILURE);
			dataCheck.setEndTime(new Date());
			dataCheckService.update(dataCheck);
			e.printStackTrace();
		}
		return false;
	}
	
	private boolean contractExpiredCheckJob(Long id){
		DataCheck dataCheck = new DataCheck();
		dataCheck.setDate(new Date());
		dataCheck.setStartTime(new Date());
		dataCheck.setStatus(CheckStatusEnum.UNFINISHED);
		dataCheck.setType(CheckTypeEnum.CONTRACTEND);
		if(id!=null){
			dataCheck.setParentId(id);
		}
		try{
			dataCheckService.save(dataCheck);
			Filter filter = new Filter(Contract.class);
			String[] names = {"state","contractNo","name","endDate"};
			filter.eq("state", ContractStatusEnum.EXECUTE);
			filter.include(names);
			contracts = contractService.getListByFilter(filter).getValue();
			Date now = new Date();
			
			String name = "ContractCheck"+DateUtil.format(new Date(),"yyyy-MM-dd")+".html";
			DataCheckLog checkLog = new DataCheckLog();
			checkLog.setDate(new Date());
			if(id!=null){
				checkLog.setParentId(id);
			}
			checkLog.setName(name);
			checkLog.setStatus(CheckStatusEnum.UNFINISHED);
			dataCheckLogService.save(checkLog);
			try{
				File file = new File(System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+File.separator+"parkmanager.pb.war"+File.separator+"web"+File.separator+"checkHtml"+File.separator+name);
				if(!file.exists()){ 
					file.createNewFile();
				}
				BufferedWriter output = new BufferedWriter(new FileWriter(file));
				output.write("<title>合同自检</title><html><body><table>");
				for (Contract contract : contracts) {
					if(contract.getEndDate()!=null){
						if(contract.getEndDate().getTime()<now.getTime()){
							output.write("<tr><td><span style='color:red;'>当前日期："+DateUtil.format(now, "yyyy年MM月dd日")+"【"+contract.getContractNo()+"】的合同状态异常，合同截至日期"+DateUtil.format(contract.getEndDate(), "yyyy年MM月dd日")+"，当前状态为：执行中"+"</span></td></tr>");
							System.err.println("****************当前日期："+DateUtil.format(now, "yyyy年MM月dd日")+"【"+contract.getContractNo()+"】的合同状态异常，合同截至日期"+DateUtil.format(contract.getEndDate(), "yyyy年MM月dd日")+"，当前状态为：执行中");
						}else{
							output.write("<tr><td><span>【"+contract.getContractNo()+"】的合同状态正常"+"</span></td></tr>");
							System.out.println("===================【"+contract.getContractNo()+"】的合同状态正常");
						}
					}
				}
				output.write("</table></body></html>");
				output.close();
				dataCheck.setStatus(CheckStatusEnum.SUCCESS);
				dataCheck.setEndTime(new Date());
				dataCheckService.update(dataCheck);
				
				checkLog.setEndTime(new Date());
				checkLog.setStatus(CheckStatusEnum.SUCCESS);
				dataCheckLogService.update(checkLog);
			}catch(Exception e){
				System.out.println("=========合同状态自检Job执行失败========");
				dataCheck.setStatus(CheckStatusEnum.FAILURE);
				dataCheck.setEndTime(new Date());
				dataCheckService.update(dataCheck);
				
				checkLog.setEndTime(new Date());
				checkLog.setStatus(CheckStatusEnum.FAILURE);
				dataCheckLogService.update(checkLog);
				e.printStackTrace();
			}
			
			return true;
		}catch(Exception e){
			System.out.println("=========合同状态自检Job启动失败========");
			dataCheck.setStatus(CheckStatusEnum.FAILURE);
			dataCheck.setEndTime(new Date());
			dataCheckService.update(dataCheck);
			e.printStackTrace();
		}
		return false;
	}
	
}
