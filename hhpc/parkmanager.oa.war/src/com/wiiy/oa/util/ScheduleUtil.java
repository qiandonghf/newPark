package com.wiiy.oa.util;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.oa.dto.DayDto;
import com.wiiy.oa.dto.MonthDto;
import com.wiiy.oa.dto.WeekDto;
import com.wiiy.oa.preferences.enums.RepeatEnum;



public class ScheduleUtil {
	
	/**
	 * 根据重复规则及重复开始时间生成下一个重复的时间
	 * @param date
	 * @param repeat
	 * @return
	 */
	public static Date getNextRepeatDate(Date date, RepeatEnum repeat){
		if(repeat==RepeatEnum.NOREPEAT) throw new IllegalArgumentException("参数错误 重复类型不能为‘不重复’");
		switch(repeat){
		case EVERYDAY:
			return CalendarUtil.add(date, Calendar.DAY_OF_YEAR, 1).getTime();
		case EVERYWORKDAY:
			Calendar c = CalendarUtil.getCalendarInstance(date);
			while(c.get(Calendar.DAY_OF_WEEK)==Calendar.SATURDAY || c.get(Calendar.DAY_OF_WEEK)==Calendar.SUNDAY){
				c.add(Calendar.DAY_OF_YEAR, 1);
			}
			return c.getTime();
		case EVERYWEEK:
			return CalendarUtil.add(date, Calendar.WEEK_OF_YEAR, 1).getTime();
		case EVERYMONTH:
			return CalendarUtil.add(date, Calendar.MONTH, 1).getTime();
		case EVERYYEAR:
			return CalendarUtil.add(date, Calendar.YEAR, 1).getTime();
		}
		return null;
	}
	
	/**
	 * 根据重复规则生成重复日程 包括起始时间日程 即最少返回一条日程(在重复规则为不重复的情况下)
	 * @param startTime 重复开始时间
	 * @param endTime 重复结束时间
	 * @param repeat 重复方式
	 * @return
	 */
	public static List<Date> generateRepeartSchedule(Date startTime, Date endTime, RepeatEnum repeat){
		List<Date> list = new ArrayList<Date>();
		switch(repeat){
		case NOREPEAT:
			list.add(startTime);
			return list;
		case EVERYDAY:
			return everyDayRepeart(startTime, endTime);
		case EVERYWORKDAY:
			return everyWorkDayRepeart(startTime, endTime);
		case EVERYWEEK:
			return everyWeekRepeart(startTime, endTime);
		case EVERYMONTH:
			return everyMonthRepeart(startTime, endTime);
		case EVERYYEAR:
			return everyYearRepeart(startTime, endTime);
		}
		return list;
	}
	
	private static List<Date> everyDayRepeart(Date startTime, Date endTime) {
		List<Date> list = new ArrayList<Date>();
		Calendar c = CalendarUtil.getCalendarInstance(startTime);
		while(c.getTime().getTime()<endTime.getTime()){
			c.roll(Calendar.DAY_OF_YEAR, 1);
			list.add(c.getTime());
		}
		return list;
	}
	private static List<Date> everyWorkDayRepeart(Date startTime, Date endTime) {
		List<Date> list = new ArrayList<Date>();
		Calendar c = CalendarUtil.getCalendarInstance(startTime);
		while(c.getTime().getTime()<endTime.getTime()){
			c.roll(Calendar.DAY_OF_YEAR, 1);
			if(c.get(Calendar.DAY_OF_WEEK)!=Calendar.SATURDAY && c.get(Calendar.DAY_OF_WEEK)!=Calendar.SUNDAY){
				list.add(c.getTime());
			}
		}
		return list;
	}
	private static List<Date> everyWeekRepeart(Date startTime, Date endTime) {
		List<Date> list = new ArrayList<Date>();
		Calendar c = CalendarUtil.getCalendarInstance(startTime);
		while(c.getTime().getTime()<endTime.getTime()){
			c.roll(Calendar.WEEK_OF_YEAR, 1);
			list.add(c.getTime());
		}
		return list;
	}
	private static List<Date> everyMonthRepeart(Date startTime, Date endTime) {
		List<Date> list = new ArrayList<Date>();
		Calendar c = CalendarUtil.getCalendarInstance(startTime);
		while(c.getTime().getTime()<endTime.getTime()){
			c.roll(Calendar.MONTH, 1);
			list.add(c.getTime());
		}
		return list;
	}
	private static List<Date> everyYearRepeart(Date startTime, Date endTime) {
		List<Date> list = new ArrayList<Date>();
		Calendar c = CalendarUtil.getCalendarInstance(startTime);
		while(c.getTime().getTime()<endTime.getTime()){
			c.roll(Calendar.YEAR, 1);
			list.add(c.getTime());
		}
		return list;
	}
	
	public static List<MonthDto> generateMonthWeekList(){
		return generateMonthWeekList(new Date());
	}
	/**
	 * 显示指定时间所在年份的周视图
	 * @param customDate
	 * @return
	 */
	public static List<MonthDto> generateMonthWeekList(Date customDate){
		Date firstSat = CalendarUtil.getWeekDateByIndex(CalendarUtil.getEarliest(customDate,Calendar.YEAR), Calendar.MONDAY, 6);
		Date yearFirstDay = null;
		if(CalendarUtil.getCalendarInstance(firstSat).get(Calendar.MONTH)==Calendar.JANUARY){
			yearFirstDay = CalendarUtil.getWeekDateByIndex(firstSat, Calendar.MONDAY, 1);
		} else {
			Calendar nextWeek = CalendarUtil.add(firstSat, Calendar.WEEK_OF_MONTH,1);
			yearFirstDay = CalendarUtil.getWeekDateByIndex(nextWeek.getTime(), Calendar.MONDAY, 1);
		}
		Calendar c = CalendarUtil.getCalendarInstance(yearFirstDay);
		List<MonthDto> monthList = new ArrayList<MonthDto>();
		MonthDto curMonth = new MonthDto();
		curMonth.setMonth(1);
		int weekIndex = 0;
		while (c.get(Calendar.YEAR)<=CalendarUtil.getCalendarInstance(customDate).get(Calendar.YEAR)) {
			curMonth.setYear(Integer.parseInt(DateUtil.format(customDate,"yyyy")));
			WeekDto week = new WeekDto();
			week.setWeek(++weekIndex);
			List<Date> dateList = new ArrayList<Date>();
			for (int j = 0; j < 7; j++) {
				dateList.add(c.getTime());
				c.add(Calendar.DAY_OF_YEAR, 1);
			}
			week.setDateList(dateList);
			Date sat = week.getDateList().get(5);
			if(CalendarUtil.getCalendarInstance(sat).get(Calendar.MONTH)+1==curMonth.getMonth()){
				curMonth.getWeekList().add(week);
			} else {
				int lastMonth = curMonth.getMonth();
				monthList.add(curMonth);
				curMonth = new MonthDto();
				curMonth.setMonth(lastMonth+1);
				curMonth.getWeekList().add(week);
			}
		}
		if(monthList.size()<12){
			monthList.add(curMonth);
		}
		return monthList;
	}
	/**
	 * 根据开始时间和结束时间,计算相差的天数
	 * @param beginDate
	 * @param endDate
	 * @return
	 */
	public static int getDiffDays(Date beginDate , Date endDate){
		Date bDate = DateUtil.parse(DateUtil.format(beginDate, "yyyy-MM-dd"));
		Date eDate = DateUtil.parse(DateUtil.format(endDate, "yyyy-MM-dd"));
		Long beginTime = bDate.getTime();
		Long endTime = eDate.getTime();
		
		int day = 0;
		if(beginTime.equals(endTime)){
			day = 0;//今天到期
		}else if(endTime > beginTime && endTime < (beginTime+86422222)){
			day = 1;//明天到期
		}else{
			Long day2 = endTime-beginTime;
			if(day2==(-86400000)){
				day = -1;
			}else{
				Double s = (double) ((endTime-beginTime)/86400000);
				day = (int)((endTime-beginTime)/86400000);
			}
		}
		return day;
	}
	/**
	 * 返回相连的五周天数,其中最后一周为当前周
	 * @return
	 */
	public static List<WeekDto> currWeek(){
		List<MonthDto> monthList = new ArrayList<MonthDto>();
		List<WeekDto> list = new ArrayList<WeekDto>();
		monthList = generateMonthWeekList();
		for (MonthDto monthDto : monthList) {
			MonthDto dto = new MonthDto();
			for (WeekDto weekDto : monthDto.getWeekList()) {
				List<WeekDto> weekDtoList = new ArrayList<WeekDto>();
				WeekDto week = new WeekDto();
				for(int i=0;i<5;i++){
				for (Date date : weekDto.getDateList()) {
					Calendar c = Calendar.getInstance();
					c.setTime(new Date());
					c.add(c.DAY_OF_YEAR, -7*i);
					if (CalendarUtil.getEarliest(date, Calendar.DAY_OF_YEAR)
							.getTime() == CalendarUtil.getEarliest(c.getTime(), Calendar.DAY_OF_YEAR).getTime()) {
						week = weekDto;
						list.add(week);
					}
				  }
				}
			}
		}
		return list;
	}	
	/**
	 * 指定时间所在年份的月视图
	 * @param curDate
	 * @return
	 */
	public static List<MonthDto> workSignList(Date curDate){
		List<MonthDto> list = generateMonthWeekList();
		List<MonthDto> monthList = new ArrayList<MonthDto>();
		for(MonthDto dto : list){
			Integer year = Integer.parseInt(DateUtil.format(curDate,"yyyy"));
			MonthDto newMonthDto = new MonthDto();
			
			newMonthDto.setMonth(dto.getMonth());
			newMonthDto.setYear(year);
			Integer month = dto.getMonth();
			int num = 0;
			switch(month){
				 case 1:
		         case 3:
		         case 5:
		         case 7:
		         case 8:
		         case 10:
		         case 12:
		             num=31;
		             break;
		         case 4:
		         case 6:
		         case 9:
		         case 11:
		             num=30;
		             break;
		         case 2:
		             num = isLeapYear(year)?29:28;
		             break;

			}
			
			List<DayDto> dayDtoList = new ArrayList<DayDto>();
			for(int j=1;j<num+1;j++){
				DayDto dayDto = new DayDto();
				if(j<10){
					String str = year+"-"+month+"-0"+j;
					try {
						Date newDate = new SimpleDateFormat("yyyy-MM-dd").parse(str);
						dayDto.setDate(newDate);
					} catch (ParseException e) {
						e.printStackTrace();
					}
				}else{
					String str = year+"-"+month+"-"+j;
					try {
						Date newDate = new SimpleDateFormat("yyyy-MM-dd").parse(str);
						dayDto.setDate(newDate);
					} catch (ParseException e) {
						e.printStackTrace();
					}
				}
				dayDto.setDaySign(j);
				dayDtoList.add(dayDto);
			}
			newMonthDto.setDayDtoList(dayDtoList);
			monthList.add(newMonthDto);
		}
		return monthList;
	}
	/**
	 * 判断是否是闰年
	 * @param year
	 * @return
	 */
	 public static boolean isLeapYear(int year){  
	     if((year%4==0)&&(year%100!=0)||(year%400==0)){
	    	 return true;
	     }else{
	     return false;
	     }  
	}
	
	 public static String gainDayOfWeek(Date receiveDate){
			Calendar c = Calendar.getInstance();
			c.setTime(receiveDate);
			int num = c.get(Calendar.DAY_OF_WEEK);
			String weekDay = "";
			if(num==1){
				weekDay = "day7";
			}
			if(num==2){
				weekDay = "day1";
			}
			if(num==3){
				weekDay = "day2";
			}
			if(num==4){
				weekDay = "day3";
			}
			if(num==5){
				weekDay = "day4";
			}
			if(num==6){
				weekDay = "day5";
			}
			if(num==7){
				weekDay = "day6";
			}
			return weekDay;
		}
	 
	 public static List<DayDto> getCurMonthData(Date curDate){
		 List<DayDto> dayDtoList = new ArrayList<DayDto>();
		 List<MonthDto> monthDtoList = workSignList(curDate);
		 for(MonthDto monthDto : monthDtoList){
			 Integer curMonth = Integer.parseInt(DateUtil.format(curDate,"MM"));
			 if(curMonth == monthDto.getMonth()){
				 dayDtoList = monthDto.getDayDtoList();
			 }
		 }
		 return dayDtoList;
	 }
	 
	/**
	 * 显示指定时间所在年份的周视图
	 * @param customDate
	 * @return
	 */
	public static List<MonthDto> weekInMonthList(Date customDate){
		List<MonthDto> list = generateMonthWeekList(customDate);
		List<MonthDto> monthList = new ArrayList<MonthDto>();
		Integer forDate = Integer.parseInt(DateUtil.format(customDate, "M"));
		for(MonthDto m : list){
			if(forDate == m.getMonth()){
				monthList.add(m);
			}
		}
		/*for(MonthDto m : list){
			for(WeekDto dto : m.getWeekList()){
				for(Date d : dto.getDateList()){
					String newDate = DateUtil.format(d, "yyyy-MM-dd");
					if(forDate.equals(newDate)){
						monthList.add(m);
					}
				}
			}
		}*/
		return monthList;
	}
 
	public static List<MonthDto> workDayCount(Date customDate){
		List<MonthDto> list = workSignList(customDate);
		List<MonthDto> monthList = new ArrayList<MonthDto>();
		Integer month = Integer.parseInt(DateUtil.format(customDate, "MM"));
		for(MonthDto m : list){
			if(m.getMonth()==month){
				monthList.add(m);
			}
		}
		return monthList;
	}
		
	public static void main(String[] args) {
		List<MonthDto> list = weekInMonthList(new Date());
		for(MonthDto m : list){
			System.out.println("-----------"+m.getMonth()+"----------");
			for(WeekDto dto : m.getWeekList()){
				System.out.print("-----------"+dto.getWeek()+"----------");
				for(Date d : dto.getDateList()){
					System.out.print(DateUtil.format(d,"yyyy-MM-dd")+"    ");
				}
				System.out.println();
			}
		}
		
		
	}
}