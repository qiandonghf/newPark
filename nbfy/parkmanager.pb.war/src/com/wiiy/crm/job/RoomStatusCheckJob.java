package com.wiiy.crm.job;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Timer;

import org.springframework.context.ApplicationContext;

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

public class RoomStatusCheckJob extends RepeatJob{
	
	protected ApplicationContext applicationContext;
	private RoomService roomService;
	private ContractService contractService;
	private SubjectRentService rentService;
	
	private DataCheckService dataCheckService;
	private DataCheckLogService dataCheckLogService;
	
	private Long id;
	
	
	public RoomStatusCheckJob(ApplicationContext applicationContext,DataCheck dataCheck) {
		super(applicationContext);
		roomService = applicationContext.getBean(RoomService.class);
		contractService = applicationContext.getBean(ContractService.class);
		rentService = applicationContext.getBean(SubjectRentService.class);
		dataCheckService = applicationContext.getBean(DataCheckService.class);
		dataCheckLogService = applicationContext.getBean(DataCheckLogService.class);
		if(dataCheck.getId()!=null){
			id = dataCheck.getId();
		}
	}
	
	/*public void init(){
		new Timer().schedule(new JobTask(),CalendarUtil.getEarliest(CalendarUtil.add(new Date(), Calendar.DAY_OF_YEAR, 1).getTime(), Calendar.DAY_OF_YEAR), 1000*60*60*24);
	}*/
	
	public void init(){
		new Timer().schedule(new JobTask(),0, 1000*60*60*24);
	}
	
	@Override
	protected void execute() {
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
			/*List<Contract> contracts_closed = contractService.getListByFilter(filter).getValue();
			List<Contract> contracts_execute = contractService.getListByFilter(filter).getValue();
			*/
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
			String name = "RoomCheck"+DateUtil.format(new Date(),"yyyy-MM-dd")+".html";
			File file = new File(System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+File.separator+"parkmanager.pb.war"+File.separator+"web"+File.separator+"checkHtml"+File.separator+name);
			if(!file.exists()){ 
				file.createNewFile();
			}
			BufferedWriter output = new BufferedWriter(new FileWriter(file));
			output.write("<title>房间自检</title><html><body><table>");
			for (Room room : roomList) {
				if(room.getKind().getDataValue().equals("出租")){
					if(executeContractMap.get(room.getId())!=null){
						output.write("<tr><td><span>"+room.getBuilding().getName()+"【"+room.getName()+"】的房间状态正常"+"</span></td></tr>");
						System.out.println("================"+room.getBuilding().getName()+"【"+room.getName()+"】的房间状态正常");
					}else{
						output.write("<tr><td><span style='color:red;'>"+room.getBuilding().getName()+"【"+room.getName()+"】的房间状态不正常"+"</span></td></tr>");
						System.err.println("****************"+room.getBuilding().getName()+"【"+room.getName()+"】的房间状态不正常");
					}
				}else{
					if(executeContractMap.get(room.getId())!=null){
						output.write("<tr><td><span style='color:red;'>"+room.getBuilding().getName()+"【"+room.getName()+"】的房间状态不正常，有合同【"+executeContractMap.get(room.getId()).getContractNo()+"】在执行"+"</span></td></tr>");
						System.err.println("****************"+room.getBuilding().getName()+"【"+room.getName()+"】的房间状态不正常，有合同【"+executeContractMap.get(room.getId()).getContractNo()+"】在执行");
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
			DataCheckLog checkLog = new DataCheckLog();
			checkLog.setDate(new Date());
			if(id!=null){
				checkLog.setParentId(id);
			}
			checkLog.setName(name);
			dataCheckLogService.save(checkLog);
		}catch(Exception e){
			System.out.println("=========房间性质自检Job启动失败========");
			dataCheck.setStatus(CheckStatusEnum.FAILURE);
			dataCheck.setEndTime(new Date());
			if(dataCheck.getId()!=null){
				dataCheckService.update(dataCheck);
			}else{
				dataCheckService.save(dataCheck);
			}
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		try {
			File file = new File(System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+File.separator+"parkmanager.pb.war"+File.separator+"web"+File.separator+"checkHtml"+File.separator+"房间性质自检"+DateUtil.format(new Date())+".html");
			if(!file.exists()){ 
				file.createNewFile();
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
