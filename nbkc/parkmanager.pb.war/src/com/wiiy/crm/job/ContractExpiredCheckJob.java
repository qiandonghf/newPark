package com.wiiy.crm.job;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Timer;

import org.springframework.context.ApplicationContext;

import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.crm.entity.Contract;
import com.wiiy.crm.entity.DataCheck;
import com.wiiy.crm.entity.DataCheckLog;
import com.wiiy.crm.job.RepeatJob.JobTask;
import com.wiiy.crm.preferences.enums.CheckStatusEnum;
import com.wiiy.crm.preferences.enums.CheckTypeEnum;
import com.wiiy.crm.preferences.enums.ContractStatusEnum;
import com.wiiy.crm.service.ContractService;
import com.wiiy.crm.service.DataCheckLogService;
import com.wiiy.crm.service.DataCheckService;
import com.wiiy.hibernate.Filter;

public class ContractExpiredCheckJob extends RepeatJob{
	
	protected ApplicationContext applicationContext;
	private ContractService contractService;
	private List<Contract> contracts = new ArrayList<Contract>();
	private DataCheckService dataCheckService;
	private DataCheckLogService dataCheckLogService;
	private Long id;
	
	public ContractExpiredCheckJob(ApplicationContext applicationContext,DataCheck dataCheck) {
		super(applicationContext);
		contractService =  applicationContext.getBean(ContractService.class);
		dataCheckService = applicationContext.getBean(DataCheckService.class);
		dataCheckLogService = applicationContext.getBean(DataCheckLogService.class);
		if(dataCheck.getId()!=null){
			id = dataCheck.getId();
		}
	}
	
	public void init(){
		new Timer().schedule(new JobTask(),0, 1000*60*60*24);
	}
	
	@Override
	protected void execute() {
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
			DataCheckLog checkLog = new DataCheckLog();
			checkLog.setDate(new Date());
			if(id!=null){
				checkLog.setParentId(id);
			}
			checkLog.setName(name);
			dataCheckLogService.save(checkLog);
		}catch(Exception e){
			System.out.println("=========合同状态自检Job启动失败========");
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
}
