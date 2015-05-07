package com.wiiy.pb.util;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

import com.wiiy.commons.util.CalendarUtil;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.pb.dto.MonthDto;
import com.wiiy.pb.dto.WeekDto;
import com.wiiy.pb.entity.MeterLabelRecord;



public class FacilityUtil {
	
	public static List<MonthDto> generateMonthWeekList(){
		return generateMonthWeekList(new Date());
	}
	/**
	 * 根据时间参数,显示参数所属年份的周视图
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
	 * @param beginDate,endDate
	 * @author qc
	 */
	public static int getDiffDays(Date beginDate , Date endDate){
		Long beginTime = beginDate.getTime();
		Long endTime = endDate.getTime();
		int day = (int)((endTime-beginTime)/86400000)+1;
		return day;
	}
	/**
	 * 返回相连的五周天数,其中最后一周为当前周
	 * @author qc
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
	 * 根据下标序号num,返回一周的时间,默认 num=0时,为当前周
	 * @param num
	 * @return weekDto
	 */
	public static WeekDto generateWeekList(Date date,Integer num){
		WeekDto dto = new WeekDto();
		List<MonthDto> monthList = new ArrayList<MonthDto>();
		monthList = generateMonthWeekList(date);
		for (MonthDto monthDto : monthList) {
			for(WeekDto weekDto : monthDto.getWeekList()){
				for(Date d : weekDto.getDateList()){
					Calendar c = Calendar.getInstance();
					c.setTime(new Date());
					c.add(c.DAY_OF_YEAR,-7*num);
					if (CalendarUtil.getEarliest(d, Calendar.DAY_OF_YEAR).getTime() == CalendarUtil.getEarliest(c.getTime(), Calendar.DAY_OF_YEAR).getTime()) {
						dto = weekDto;
						dto.setYear(monthDto.getYear());
					}
					
			  }
			}
		}
		//如果日期所在的周不属于当前年份,则参数年份+1
		Integer paramYear = Integer.parseInt(DateUtil.format(date,"yyyy"));
		String nextYear = (paramYear+1)+"-7";
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM");
		try {
			Date newDate = fmt.parse(nextYear);
			if(dto.getDateList()==null){
				monthList = generateMonthWeekList(newDate);
				for (MonthDto monthDto : monthList) {
					for(WeekDto weekDto : monthDto.getWeekList()){
						for(Date d : weekDto.getDateList()){
							Calendar c = Calendar.getInstance();
							c.setTime(new Date());
							c.add(c.DAY_OF_YEAR,-7*num);
							if (CalendarUtil.getEarliest(d, Calendar.DAY_OF_YEAR).getTime() == CalendarUtil.getEarliest(c.getTime(), Calendar.DAY_OF_YEAR).getTime()) {
								dto = weekDto;
								dto.setYear(monthDto.getYear());
							}
					  }
					}
				}
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	public static void main(String[] args) {
		Date nextYear = CalendarUtil.add(new Date(), Calendar.WEEK_OF_YEAR, 1).getTime();
		Date nextYear2 = CalendarUtil.add(nextYear, Calendar.WEEK_OF_YEAR, 1).getTime();
		WeekDto dto = generateWeekList(nextYear2, -1);
		for(Date d : dto.getDateList()){
			System.out.print(DateUtil.format(d, "yyyy-MM-dd")+"  ");
		}
		
		
	}
}