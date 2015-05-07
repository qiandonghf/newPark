package com.wiiy.crm.job;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import org.springframework.context.ApplicationContext;

import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.core.entity.User;
import com.wiiy.crm.entity.Bill;
import com.wiiy.crm.preferences.enums.BillStatusEnum;
import com.wiiy.crm.service.BillService;
import com.wiiy.external.service.SMSPubService;
import com.wiiy.external.service.SysEmailSenderPubService;
import com.wiiy.hibernate.Filter;
import com.wiiy.pb.activator.PbActivator;

public class BillArrearsJob extends RepeatJob{
	
	protected ApplicationContext applicationContext;
	private BillService billService;
	private List<Bill> bills = new ArrayList<Bill>();
	
	public BillArrearsJob(ApplicationContext applicationContext) {
		super(applicationContext);
		billService =  applicationContext.getBean(BillService.class);
		//new Timer().schedule(new BillArrears(), CalendarUtil.getEarliest(CalendarUtil.add(Calendar.DAY_OF_MONTH, 1).getTime(),Calendar.DAY_OF_MONTH), 1000*60*60*24);
	}
	public void init(){
		new Timer().schedule(new JobTask(),CalendarUtil.getEarliest(CalendarUtil.add(new Date(), Calendar.DAY_OF_YEAR, 1).getTime(), Calendar.DAY_OF_YEAR), 1000*60*60*24);
	}
	@Override
	protected void execute() {
		bills = billService.getListByFilter(new Filter(Bill.class).eq("status", BillStatusEnum.UNPAID).le("planPayTime", (Calendar.getInstance().getTime()))).getValue();
	}
	
	public void sendMail(String receiverEmail,String content,String subject){
		SysEmailSenderPubService sysEmailSenderPubService = PbActivator.getService(SysEmailSenderPubService.class);
		sysEmailSenderPubService.send(receiverEmail, content,subject);
	}
	
	public void sendSms(String receiverMobile,String content, String receiverName){
		SMSPubService smsPubService = PbActivator.getService(SMSPubService.class);
		smsPubService.sendByAdmin(receiverMobile, content, receiverName);
	}
	class BillArrears extends TimerTask{
		@Override
		public void run() {
			if(bills!=null&&bills.size()>0){
				User user = PbActivator.getUserById(Long.valueOf(PbActivator.getAppConfig().getConfig("Writor").getParameter("billArrear")));
				String receiverEmail = user.getEmail();
				String content = "尊敬的"+user.getRealName()+"；欠费预警中有"+bills.size()+"条欠费信息需要处理；请尽快处理";
				String receiverMobile = "";
				if(user.getMobile()!=null){
					receiverMobile = user.getMobile();
				}
				String subject = "欠费信息提醒";
				sendMail(receiverEmail, content,subject);
				sendSms(receiverMobile, content, user.getRealName());
			}
		}
	}
}
