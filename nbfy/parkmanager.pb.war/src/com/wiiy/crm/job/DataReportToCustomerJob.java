package com.wiiy.crm.job;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import org.springframework.context.ApplicationContext;

import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.crm.entity.DataReportToCustomer;
import com.wiiy.crm.preferences.enums.CustomerReportStatusEnum;
import com.wiiy.crm.service.DataReportToCustomerService;
import com.wiiy.external.service.SMSPubService;
import com.wiiy.hibernate.Filter;
import com.wiiy.pb.activator.PbActivator;

public class DataReportToCustomerJob extends RepeatJob{
	
	protected ApplicationContext applicationContext;
	private DataReportToCustomerService dataReportToCustomerService;
	private List<DataReportToCustomer> dataReportToCustomers = new ArrayList<DataReportToCustomer>();
	
	public DataReportToCustomerJob(ApplicationContext applicationContext) {
		super(applicationContext);
		dataReportToCustomerService =  applicationContext.getBean(DataReportToCustomerService.class);
		new Timer().schedule(new ContractExpired(), CalendarUtil.getEarliest(CalendarUtil.add(Calendar.DAY_OF_MONTH, 1).getTime(),Calendar.DAY_OF_MONTH), 1000*60*60*24);
	}

	public void init(){
		new Timer().schedule(new JobTask(),CalendarUtil.getEarliest(CalendarUtil.add(new Date(), Calendar.DAY_OF_YEAR, 1).getTime(), Calendar.DAY_OF_YEAR), 1000*60*60*24);
	}
	
	@Override
	protected void execute() {
		dataReportToCustomers = dataReportToCustomerService.getListByFilter(new Filter(DataReportToCustomer.class).ne("state", CustomerReportStatusEnum.PUB).le("report.finishTime", (Calendar.getInstance()).getTime())).getValue();
	}
	private boolean smsActive(){
		String msgSet = PbActivator.getAppConfig().getConfig("dataReportDunningRemind").getParameter("sms");
		if(msgSet.equals("active")){
			return true;
		}else{
			return false;
		}
	}
	
	public void sendSms(String receiverMobile,String content, String receiverName){
		SMSPubService smsPubService = PbActivator.getService(SMSPubService.class);
		if(smsPubService!=null)smsPubService.sendByAdmin(receiverMobile, content, receiverName);
	}
	
	class ContractExpired extends TimerTask{
		@Override
		public void run() {
			if(dataReportToCustomers!=null && dataReportToCustomers.size()>0){
				SMSPubService smsPubService = PbActivator.getService(SMSPubService.class);
				if(smsPubService!=null && smsActive()){
					for (DataReportToCustomer dataReportToCustomer : dataReportToCustomers) {
						if(dataReportToCustomer.getCustomer().getCustomerInfo().getCellphone()!=null){
							String receiverMobile = dataReportToCustomer.getCustomer().getCustomerInfo().getCellphone();
							String receiverName = dataReportToCustomer.getCustomer().getHostName();
							String content = PbActivator.getAppConfig().getConfig("dataReportDunningRemind").getParameter("smsModule");
							content = content.replace("${companyName}", dataReportToCustomer.getCustomer().getName());
							sendSms(receiverMobile, content,receiverName);
						}
					}
				}
			}
		}
	}
}
