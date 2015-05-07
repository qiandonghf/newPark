package com.wiiy.crm.job;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import org.springframework.context.ApplicationContext;

import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.crm.entity.Contract;
import com.wiiy.crm.preferences.enums.ContractStatusEnum;
import com.wiiy.crm.service.ContractService;
import com.wiiy.external.service.SMSPubService;
import com.wiiy.external.service.SysEmailSenderPubService;
import com.wiiy.hibernate.Filter;
import com.wiiy.pb.activator.PbActivator;

public class ContractExpiredJob extends RepeatJob{
	
	protected ApplicationContext applicationContext;
	private ContractService contractService;
	private List<Contract> contracts = new ArrayList<Contract>();
	private Integer days = 1;
	
	public ContractExpiredJob(ApplicationContext applicationContext) {
		super(applicationContext);
		days = Integer.parseInt(PbActivator.getAppConfig().getConfig("contractDueRemindDays").getParameter("day"));
		contractService =  applicationContext.getBean(ContractService.class);
		new Timer().schedule(new ContractExpired(), CalendarUtil.getEarliest(CalendarUtil.add(Calendar.DAY_OF_MONTH, 1).getTime(),Calendar.DAY_OF_MONTH), 1000*60*60*24);
	}
	
	public void init(){
		new Timer().schedule(new JobTask(),CalendarUtil.getEarliest(CalendarUtil.add(new Date(), Calendar.DAY_OF_YEAR, 1).getTime(), Calendar.DAY_OF_YEAR), 1000*60*60*24);
	}
	
	@Override
	protected void execute() {
		//提前15天提醒
		Calendar remindTime = Calendar.getInstance();
		remindTime.setTime(new Date());
		remindTime.set(Calendar.DATE, remindTime.get(Calendar.DATE) + days);
		contracts = contractService.getListByFilter(new Filter(Contract.class).eq("state", ContractStatusEnum.EXECUTE).le("endDate", remindTime.getTime())).getValue();
	}
	
	public void sendMail(String receiverEmail,String content,String subject){
		SysEmailSenderPubService sysEmailSenderPubService = PbActivator.getService(SysEmailSenderPubService.class);
		sysEmailSenderPubService.send(receiverEmail, content,subject);
	}
	
	public void sendSms(String receiverMobile,String content, String receiverName){
		SMSPubService smsPubService = PbActivator.getService(SMSPubService.class);
		smsPubService.sendByAdmin(receiverMobile, content, receiverName);
	}
	
	private boolean emailActive(){
		String msgSet =  PbActivator.getAppConfig().getConfig("contractRemind").getParameter("email");
		if(msgSet.equals("active")){
			return true;
		}else{
			return false;
		}
	}
	
	private boolean smsActive(){
		String msgSet =  PbActivator.getAppConfig().getConfig("contractRemind").getParameter("sms");
		if(msgSet.equals("active")){
			return true;
		}else{
			return false;
		}
	}
	class ContractExpired extends TimerTask{
		@Override
		public void run() {
			for (Contract contract : contracts) {
				String receiverEmail = contract.getManager().getEmail();
				String content = "尊敬的"+contract.getManager().getRealName()+"；您的合同【"+contract.getName()+"】已到期";
				String receiverMobile = "";
				if(contract.getManager().getMobile()!=null){
					receiverMobile = contract.getManager().getMobile();
				}
				String subject = "合同到期提醒";
				if(emailActive()){
					sendMail(receiverEmail,content,subject);
				}
				if(smsActive()){
					sendSms(receiverMobile, content, contract.getManager().getRealName());
				}
			}
		}
	}
}
