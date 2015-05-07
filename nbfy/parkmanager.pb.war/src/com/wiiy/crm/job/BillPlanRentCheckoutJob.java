package com.wiiy.crm.job;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Timer;

import org.springframework.context.ApplicationContext;

import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.crm.entity.BillPlanRent;
import com.wiiy.crm.preferences.enums.BillPlanStatusEnum;
import com.wiiy.crm.service.BillPlanRentService;
import com.wiiy.hibernate.Filter;
import com.wiiy.pb.activator.PbActivator;

public class BillPlanRentCheckoutJob extends RepeatJob{
	
	protected ApplicationContext applicationContext;
	private BillPlanRentService billPlanRentService;
	private Integer aheadDays = 1;
	
	public BillPlanRentCheckoutJob(ApplicationContext applicationContext) {
		super(applicationContext);
		aheadDays = Integer.parseInt(PbActivator.getAppConfig().getConfig("billCheckoutDay").getParameter("day"));
		billPlanRentService = applicationContext.getBean(BillPlanRentService.class);
	}

	public void init(){
		new Timer().schedule(new JobTask(),CalendarUtil.getEarliest(CalendarUtil.add(new Date(), Calendar.DAY_OF_YEAR, 1).getTime(), Calendar.DAY_OF_YEAR), 1000*60*60*24);
	}
	
	@Override
	protected void execute() {
		List<BillPlanRent> list = billPlanRentService.getListByFilter(new Filter(BillPlanRent.class).eq("autoCheck",BooleanEnum.YES).eq("status",BillPlanStatusEnum.UNCHECK).le("planPayDate", CalendarUtil.add(CalendarUtil.getLatest(Calendar.DAY_OF_MONTH),Calendar.DAY_OF_MONTH,aheadDays).getTime())).getValue();
		billPlanRentService.checkout(list);
	}
}
