package com.wiiy.crm.job;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import org.springframework.context.ApplicationContext;

import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.core.entity.User;
import com.wiiy.crm.entity.BillPlanFacility;
import com.wiiy.crm.entity.BillPlanRent;
import com.wiiy.crm.entity.Deposit;
import com.wiiy.crm.preferences.enums.BillPlanStatusEnum;
import com.wiiy.crm.service.BillPlanFacilityService;
import com.wiiy.crm.service.BillPlanRentService;
import com.wiiy.crm.service.DepositService;
import com.wiiy.external.service.SMSPubService;
import com.wiiy.hibernate.Filter;
import com.wiiy.pb.activator.PbActivator;

public class BillPlanCheckJob extends RepeatJob{
	
	protected ApplicationContext applicationContext;
	private DepositService depositService;
	private BillPlanFacilityService billPlanFacilityService;
	private BillPlanRentService billPlanRentService;
	private int depositSize = 0;
	private int billPlanFacilitySize = 0;
	private int billPlanRentListSize = 0;
	
	public BillPlanCheckJob(ApplicationContext applicationContext) {
		super(applicationContext);
		depositService =  applicationContext.getBean(DepositService.class);
		billPlanFacilityService =  applicationContext.getBean(BillPlanFacilityService.class);
		billPlanRentService =  applicationContext.getBean(BillPlanRentService.class);
		//new Timer().schedule(new BillArrears(), CalendarUtil.getEarliest(CalendarUtil.add(Calendar.DAY_OF_MONTH, 1).getTime(),Calendar.DAY_OF_MONTH), 1000*60*60*24);
	}
	
	public void init(){
		new Timer().schedule(new JobTask(),CalendarUtil.getEarliest(CalendarUtil.add(new Date(), Calendar.DAY_OF_YEAR, 1).getTime(), Calendar.DAY_OF_YEAR), 1000*60*60*24);
	}
	
	@Override
	protected void execute() {
		billPlanFacilitySize = billPlanFacilityService.getRowCount(new Filter(BillPlanFacility.class).eq("status", BillPlanStatusEnum.UNCHECK).le("planPayDate", (Calendar.getInstance().getTime())));
		billPlanRentListSize = billPlanRentService.getRowCount(new Filter(BillPlanRent.class).eq("status", BillPlanStatusEnum.UNCHECK).le("planPayDate", (Calendar.getInstance().getTime())));
		depositSize = depositService.getRowCount(new Filter(Deposit.class).eq("status", BillPlanStatusEnum.UNCHECK));
	}
	public void sendSms(String receiverMobile,String content, String receiverName){
		SMSPubService smsPubService = PbActivator.getService(SMSPubService.class);
		smsPubService.sendByAdmin(receiverMobile, content, receiverName);
	}
	class BillArrears extends TimerTask{
		@Override
		public void run() {
			int size = depositSize+billPlanFacilitySize+billPlanRentListSize;
			if(size!=0){
				User user = PbActivator.getUserById(Long.valueOf(PbActivator.getAppConfig().getConfig("Writor").getParameter("billPlan")));
				String content = "尊敬的"+user.getRealName()+"；资金计划中有"+size+"条出账信息需要处理；请尽快处理";
				String receiverMobile = "";
				if(user.getMobile()!=null){
					receiverMobile = user.getMobile();
				}
				sendSms(receiverMobile, content, user.getRealName());
			}
		}
	}
}
