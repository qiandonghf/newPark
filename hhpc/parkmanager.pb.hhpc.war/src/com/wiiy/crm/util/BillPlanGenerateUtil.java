package com.wiiy.crm.util;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.util.DateUtil;
import com.wiiy.crm.entity.BillPlanRent;
import com.wiiy.crm.preferences.enums.BillingMethodEnum;
import com.wiiy.crm.preferences.enums.PriceUnitEnum;
import com.wiiy.crm.preferences.enums.RentBillPlanEnum;
import com.wiiy.hibernate.Result;

public class BillPlanGenerateUtil {
	
	private static Date yearEnd = DateUtil.parse("2012-12-31");//年末结算日期
	private static Date[] yearMiddleDays = new Date[]{DateUtil.parse("2012-06-30"),DateUtil.parse("2012-12-31")};//年中结算日期
	
	public static void main(String[] args) {
		test();
//		testPlanDate();
	}
	
	public static void testPlanDate(){
		List<PlanDate> generatePlanDate = generatePlanDate(DateUtil.parse("2012-07-01"), DateUtil.parse("2014-01-01"),RentBillPlanEnum.YEAR);
		for (PlanDate planDate : generatePlanDate) {
			System.out.println("planDate.start:"+DateUtil.format(planDate.start)+"  end:"+DateUtil.format(planDate.end));
		}
	}
	public static void test(){
		RentBillPlanEnum rentBillPlan = RentBillPlanEnum.YEAR;
		BillingMethodEnum billingMethod = BillingMethodEnum.DAY;
		Date startDate = DateUtil.parse("2012-01-01");
		Date endDate = DateUtil.parse("2013-01-01");
		Double roomArea = 100d;
		Double price = 2d;
		PriceUnitEnum priceUnit = PriceUnitEnum.DAY;
		List<BillPlanRent> list = generate(rentBillPlan, billingMethod, startDate, endDate, roomArea, price, priceUnit).getValue();
		if(list!=null)
		for (BillPlanRent billPlanRent : list) {
			System.out.print("计划金额："+billPlanRent.getPlanFee());
			System.out.print("计费开始时间："+DateUtil.format(billPlanRent.getStartDate()));
			System.out.print("计费结束时间："+DateUtil.format(billPlanRent.getEndDate()));
//			System.out.print("计划付费时间："+DateUtil.format(billPlanRent.getPlanPayDate()));
			System.out.println();
		}
	}
	
	public static Result<List<BillPlanRent>> generate(RentBillPlanEnum rentBillPlan, BillingMethodEnum billingMethod, Date startDate, Date endDate, Double roomArea, Double price, PriceUnitEnum priceUnit) {
		return generate(rentBillPlan, billingMethod, startDate, endDate, roomArea, price, priceUnit, 0d);
	}
	
	/**
	 * 生成资金计划
	 * @param rentBillPlan 结算方式
	 * @param billingMethod 计费方式
	 * @param startDate 起始日期
	 * @param endDate 结束日期
	 * @param roomArea 房间面积
	 * @param price 单价
	 * @param priceUnit 单位
	 * @return
	 */
	public static Result<List<BillPlanRent>> generate(RentBillPlanEnum rentBillPlan, BillingMethodEnum billingMethod, Date startDate, Date endDate, Double roomArea, Double price, PriceUnitEnum priceUnit,Double customPrice) {
		List<BillPlanRent> list = new ArrayList<BillPlanRent>();
		boolean success = true;
		switch (rentBillPlan) {
		case ONCE:
			switch (billingMethod) {
			case FIXED:
				list.add(createBillPlanRent(startDate, endDate, customPrice));
				break;
			case DAY:
				int days = calculateDays(startDate, endDate);
				if(priceUnit == PriceUnitEnum.MONTH) price = price/30;
				list.add(createBillPlanRent(startDate, endDate, days*price*roomArea));
				break;
			case MONTH:
				MonthDayCount md = calculateMonthDays(startDate, endDate);
				switch (priceUnit) {
				case MONTH:
					double p1 = (md.months*price+md.days*price/30)*roomArea;
					list.add(createBillPlanRent(startDate, endDate, p1));
					break;
				case DAY:
					double p2 = (md.months*price*30+md.days*price)*roomArea;
					list.add(createBillPlanRent(startDate, endDate, p2));
					break;
				default:
					success = false;
					break;
				}
				break;
			case HOUR:
			case YEAR:
			default:
				success = false;
				break;
			}
			break;
		case MONTH:
			switch (billingMethod) {
			case DAY:
				if(priceUnit == PriceUnitEnum.MONTH) price = price / 30;
				list.addAll(generateMonthDay(startDate, endDate, roomArea, price, RentBillPlanEnum.MONTH));
				break;
			case MONTH:
				if(priceUnit == PriceUnitEnum.DAY) price = price * 30;
				list.addAll(generateMonthMonth(startDate, endDate, roomArea, price, 1, RentBillPlanEnum.MONTH));
				break;
			case HOUR:
			case YEAR:
			default:
				success = false;
				break;
			}
			break;
		case THREEMONTH:
			switch (billingMethod) {
			case DAY:
				if(priceUnit == PriceUnitEnum.MONTH) price = price / 30;
				list.addAll(generateMonthDay(startDate, endDate, roomArea, price, RentBillPlanEnum.THREEMONTH));
				break;
			case MONTH:
				if(priceUnit == PriceUnitEnum.DAY) price = price * 30;
				list.addAll(generateMonthMonth(startDate, endDate, roomArea, price, 3, RentBillPlanEnum.THREEMONTH));
				break;
			case HOUR:
			case YEAR:
			default:
				success = false;
				break;
			}
			break;
		case SIXMONTH:
			switch (billingMethod) {
			case DAY:
				if(priceUnit == PriceUnitEnum.MONTH) price = price / 30;
				list.addAll(generateMonthDay(startDate, endDate, roomArea, price, RentBillPlanEnum.SIXMONTH));
				break;
			case MONTH:
				if(priceUnit == PriceUnitEnum.DAY) price = price * 30;
				list.addAll(generateMonthMonth(startDate, endDate, roomArea, price, 6, RentBillPlanEnum.SIXMONTH));
				break;
			case HOUR:
			case YEAR:
			default:
				success = false;
				break;
			}
			break;
		case YEAR:
			switch (billingMethod) {
			case DAY:
				if(priceUnit == PriceUnitEnum.MONTH) price = price / 30;
				list.addAll(generateMonthDay(startDate, endDate, roomArea, price, RentBillPlanEnum.YEAR));
				break;
			case MONTH:
				if(priceUnit == PriceUnitEnum.DAY) price = price * 30;
				list.addAll(generateMonthMonth(startDate, endDate, roomArea, price, 12, RentBillPlanEnum.YEAR));
				break;
			case HOUR:
			case YEAR:
			default:
				success = false;
				break;
			}
			break;
		case MIDDLEYEAR:
			switch (billingMethod) {
			case DAY:
				if(priceUnit == PriceUnitEnum.MONTH) price = price / 30;
				list.addAll(generateMonthDay(startDate, endDate, roomArea, price, RentBillPlanEnum.YEAR));
				break;
			case MONTH:
				if(priceUnit == PriceUnitEnum.DAY) price = price * 30;
				list.addAll(generateDateMonthDay(startDate, endDate, roomArea, price, RentBillPlanEnum.YEAR));
				break;
			case HOUR:
			case YEAR:
			default:
				success = false;
				break;
			}
			break;
		case ENDYEAR:
			success = false;
			break;
		}
		if(success){
			return Result.value(list);
		} else {
			return Result.failure("此算法暂未实现");
		}
	}
	
	private static List<BillPlanRent> generateMonthDay(Date startDate, Date endDate,Double roomArea, Double price, RentBillPlanEnum rentBillPlan){
		List<BillPlanRent> list = new ArrayList<BillPlanRent>();
		List<PlanDate> dateList = generatePlanDate(startDate, endDate, rentBillPlan);
		for (PlanDate planDate : dateList) {
			list.add(createBillPlanRent(planDate.start, planDate.end, price*roomArea*calculateDays(planDate.start, planDate.end)));
		}
		return list;
	}
	private static List<BillPlanRent> generateMonthMonth(Date startDate, Date endDate,Double roomArea, Double price,int months, RentBillPlanEnum rentBillPlan){
		List<BillPlanRent> list = new ArrayList<BillPlanRent>();
		List<PlanDate> dateList = generatePlanDate(startDate, endDate, rentBillPlan);
		for (PlanDate planDate : dateList) {
			Calendar s = getCalendar(planDate.start);
			Calendar e = getCalendar(planDate.end);
			if(s.get(Calendar.DAY_OF_MONTH)==e.get(Calendar.DAY_OF_MONTH)+1){
				list.add(createBillPlanRent(planDate.start, planDate.end, roomArea*price*months));
			} else {
				list.add(createBillPlanRent(planDate.start, planDate.end, roomArea*price/30*calculateDays(planDate.start, planDate.end)));
			}
		}
		return list;
	}
	private static List<BillPlanRent> generateDateMonthDay(Date startDate, Date endDate,Double roomArea, Double price, RentBillPlanEnum rentBillPlan){
		List<BillPlanRent> list = new ArrayList<BillPlanRent>();
		List<PlanDate> dateList = generatePlanDate(startDate, endDate, rentBillPlan);
		for (PlanDate planDate : dateList) {
			MonthDayCount md = calculateMonthDays(planDate.start, planDate.end);
			Double p = (md.months*price+md.days*price/30)*roomArea;
			list.add(createBillPlanRent(planDate.start, planDate.end, p));
		}
		return list;
	}
	
	private static BillPlanRent createBillPlanRent(Date startDate, Date endDate, Double planFee){
		BillPlanRent billPlanRent = new BillPlanRent();
		billPlanRent.setEndDate(endDate);
		billPlanRent.setStartDate(startDate);
		billPlanRent.setPlanFee(planFee);
		return billPlanRent;
	}
	
	private static Calendar getCalendar(Date date){
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		return c;
	}
	
	private static MonthDayCount calculateMonthDays(Date start, Date end){
		if(start.getTime()>end.getTime()) return null;
		else {
			MonthDayCount count = new MonthDayCount();
			Calendar s = getCalendar(start);
			Calendar e = getCalendar(end);
			while(s.getTime().getTime()<e.getTime().getTime()) {
				s.add(Calendar.MONTH, 1);
				s.add(Calendar.DAY_OF_MONTH, -1);
				if(s.getTime().getTime()<=e.getTime().getTime()){
					count.months++;
					s.add(Calendar.DAY_OF_MONTH, 1);
				} else {
					s.add(Calendar.MONTH, -1);
					count.days = calculateDays(s.getTime(), e.getTime());
					break;
				}
			}
			return count;
		}
	}
	private static int calculateDays(Date start, Date end){
		if(start.getTime()>end.getTime()) return -1;
		else {
			int count = 0;
			Calendar s = getCalendar(start);
			Calendar e = getCalendar(end);
			if(e.get(Calendar.YEAR)==s.get(Calendar.YEAR)){
				debug("年份相等结束时间年份加1");
				int e_y_days = e.get(Calendar.DAY_OF_YEAR);
				int e_y_days_max = e.getActualMaximum(Calendar.DAY_OF_YEAR);
				e.add(Calendar.YEAR,1);
				int e_n_y_days = e.get(Calendar.DAY_OF_YEAR);
				count = e_y_days-(e_n_y_days+e_y_days_max);
				debug("年份加1时间多了"+(e_n_y_days+e_y_days_max-e_y_days)+"天");
				debug("现在天数为"+count);
			}
			int s_y_days = s.get(Calendar.DAY_OF_YEAR);
			int s_y_days_max = s.getActualMaximum(Calendar.DAY_OF_YEAR);
			count += s_y_days_max - s_y_days;
			debug("起始年天数"+(s_y_days_max - s_y_days));
			debug("现在天数为"+count);
			int e_y_days = e.get(Calendar.DAY_OF_YEAR);
			debug("结束年天数"+e_y_days);
			count += e_y_days;
			debug("现在天数为"+count);
			debug("起始年年份加1判断是否小于结束年年份");
			s.add(Calendar.YEAR, 1);
			while(e.get(Calendar.YEAR)>s.get(Calendar.YEAR)) {
				int days = s.getActualMaximum(Calendar.DAY_OF_YEAR);
				debug("起始年年份加1小于结束年年份  年份加1 天数加"+days);
				count += days;
				debug("现在天数为"+count);
				s.add(Calendar.YEAR, 1);
				debug("起始年年份加1判断是否小于结束年年份");
			}
			debug("起始年年份加1不小于结束年年份");
			debug("计算完成 总天数为"+count);
			return count;
		}
	}
	
	private static List<PlanDate> generatePlanDate(Date start,Date end,RentBillPlanEnum method){
		List<PlanDate> list = new ArrayList<PlanDate>();
		Calendar s = getCalendar(start);
		Calendar e = getCalendar(end);
		switch (method) {
		case MONTH:
			while(s.getTime().getTime()<e.getTime().getTime()){
				PlanDate d = new PlanDate();
				list.add(d);
				d.start = s.getTime();
				s.add(Calendar.MONTH, 1);
				s.add(Calendar.DAY_OF_MONTH, -1);
				if(s.getTime().getTime()>e.getTime().getTime()){
					d.end = e.getTime();
					break;
				}
				d.end = s.getTime();
				s.add(Calendar.DAY_OF_MONTH, 1);
			}
			break;
		case THREEMONTH:
			while(s.getTime().getTime()<e.getTime().getTime()){
				PlanDate d = new PlanDate();
				list.add(d);
				d.start = s.getTime();
				s.add(Calendar.MONTH, 3);
				s.add(Calendar.DAY_OF_MONTH, -1);
				if(s.getTime().getTime()>e.getTime().getTime()){
					d.end = e.getTime();
					break;
				}
				d.end = s.getTime();
				s.add(Calendar.DAY_OF_MONTH, 1);
			}
			break;
		case SIXMONTH:
			while(s.getTime().getTime()<e.getTime().getTime()){
				PlanDate d = new PlanDate();
				list.add(d);
				d.start = s.getTime();
				s.add(Calendar.MONTH, 6);
				s.add(Calendar.DAY_OF_MONTH, -1);
				if(s.getTime().getTime()>e.getTime().getTime()){
					d.end = e.getTime();
					break;
				}
				d.end = s.getTime();
			}
			break;
		case YEAR:
			while(s.getTime().getTime()<e.getTime().getTime()){
				PlanDate d = new PlanDate();
				list.add(d);
				d.start = s.getTime();
				s.add(Calendar.YEAR, 1);
				s.add(Calendar.DAY_OF_MONTH, -1);
				if(s.getTime().getTime()>e.getTime().getTime()){
					d.end = e.getTime();
					break;
				}
				d.end = s.getTime();
				s.add(Calendar.DAY_OF_MONTH, 1);
			}
			break;
		case MIDDLEYEAR:
			Calendar c6 = getCalendar(yearMiddleDays[0]);
			Calendar c12 = getCalendar(yearMiddleDays[1]);
			while(s.getTime().getTime()<e.getTime().getTime()){
				PlanDate d = new PlanDate();
				list.add(d);
				d.start = s.getTime();
				int year = s.get(Calendar.YEAR);
				int month = s.get(Calendar.MONTH);
				if(month<=c6.get(Calendar.MONTH)){//前半年
					c6.set(Calendar.YEAR,year);
					if(e.getTime().getTime()<c6.getTime().getTime()){
						d.end = e.getTime();
						break;
					} else {
						d.end = c6.getTime();
						c6.add(Calendar.DAY_OF_MONTH, 1);
						s.setTime(c6.getTime());
						c6.add(Calendar.DAY_OF_MONTH, -1);
					}
				} else {//后半年
					c12.set(Calendar.YEAR,year);
					if(e.getTime().getTime()<c12.getTime().getTime()){
						d.end = e.getTime();
						break;
					} else {
						d.end = c12.getTime();
						c12.add(Calendar.DAY_OF_MONTH, 1);
						s.setTime(c12.getTime());
						c12.add(Calendar.DAY_OF_MONTH, -1);
					}
				}
			}
			break;
		case ENDYEAR:
			Calendar c = getCalendar(yearEnd);
			while(s.getTime().getTime()<e.getTime().getTime()){
				PlanDate d = new PlanDate();
				list.add(d);
				d.start = s.getTime();
				int year = s.get(Calendar.YEAR);
				c.set(Calendar.YEAR, year);
				if(e.getTime().getTime()<c.getTime().getTime()){
					d.end = e.getTime();
					break;
				} else {
					d.end = c.getTime();
					c.add(Calendar.DAY_OF_MONTH, 1);
					s.setTime(c.getTime());
					c.add(Calendar.DAY_OF_MONTH, -1);
				}
			}
			break;
		default:
			break;
		}
		return list;
	}
	
	public static void debug(String string){
//		System.out.println(string);
	}
}
class MonthDayCount{
	int months;
	int days;
	@Override
	public String toString() {
		return "months:"+months+"  days:"+days;
	}
}
class PlanDate{
	Date start;
	Date end;
	
	public PlanDate() {
	}
	
	public PlanDate(Date start, Date end) {
		super();
		this.start = start;
		this.end = end;
	}
}