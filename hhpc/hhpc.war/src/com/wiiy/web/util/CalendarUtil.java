package com.wiiy.web.util;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class CalendarUtil {

	/**
	 * 当前时间Calendar实例
	 * 
	 * @return
	 */
	public static Calendar now() {
		return getCalendarInstance(new Date());
	}

	/**
	 * 本周时间第几天 从1开始
	 * 
	 * @param date
	 * @param firstDay
	 *            一周开始是星期几 Calendar.SUNDAY Calendar.MONDAY
	 * @return
	 */
	public static Date getWeekDateByIndex(Date date, int firstDay, int index) {
		Calendar calendar = rollWeekStart(date, firstDay);
		if (index < 1)
			throw new IllegalArgumentException();
		for (int i = 1; i < index; i++) {
			calendar.add(Calendar.DAY_OF_MONTH, 1);
		}
		return calendar.getTime();
	}

	/**
	 * 本周时间
	 * 
	 * @param date
	 * @param firstDay
	 *            一周开始是星期几 Calendar.SUNDAY Calendar.MONDAY
	 * @return
	 */
	public static List<Date> getWeekDates(Date date, int firstDay) {
		Calendar calendar = rollWeekStart(date, firstDay);
		List<Date> dateList = new ArrayList<Date>();
		for (int i = 0; i < 7; i++) {
			dateList.add(calendar.getTime());
			calendar.add(Calendar.DAY_OF_MONTH, 1);
		}
		return dateList;
	}

	/**
	 * 返回date所在周的第一天的日期实例
	 * 
	 * @param date
	 * @param firstDay
	 * @return
	 */
	public static Calendar rollWeekStart(Date date, int firstDay) {
		Calendar calendar = getCalendarInstance(date);
		int rollFirst = 6;
		switch (firstDay) {
		case Calendar.SUNDAY:
			rollFirst = calendar.get(Calendar.DAY_OF_WEEK) - Calendar.SUNDAY;
			break;
		case Calendar.MONDAY:
			if (calendar.get(Calendar.DAY_OF_WEEK) != Calendar.SUNDAY) {
				rollFirst = calendar.get(Calendar.DAY_OF_WEEK) - Calendar.MONDAY;
			}
			break;
		}
		calendar.add(Calendar.DAY_OF_MONTH, -1 * rollFirst);
		return calendar;
	}

	public static Calendar getCalendarInstance(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		return calendar;
	}

	public static Calendar add(int field, int amount) {
		return add(new Date(), field, amount);
	}

	public static Calendar add(Date date, int field, int amount) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(field, amount);
		return calendar;
	}

	public static Date getEarliest(int field) {
		return getEarliest(new Date(), field);
	}

	/**
	 * 以当前时间为基本时间 返回该日历字段的最早时间(今天最早:2012-06-04 00:00:00 今年最早:2012-01-01 00:00:00
	 * 等)
	 * 
	 * @param field
	 *            日历字段
	 * @return
	 */
	public static Date getEarliest(Date date, int field) {
		Calendar calendar = getCalendarInstance(date);
		switch (field) {
		case Calendar.YEAR:
			calendar.set(Calendar.MONTH, calendar.getMinimum(Calendar.MONTH));
		case Calendar.MONTH:
			calendar.set(Calendar.DAY_OF_MONTH, calendar.getMinimum(Calendar.DAY_OF_MONTH));
		case Calendar.DAY_OF_MONTH:
		case Calendar.DAY_OF_WEEK:
		case Calendar.DAY_OF_YEAR:
			calendar.set(Calendar.HOUR_OF_DAY, calendar.getMinimum(Calendar.HOUR_OF_DAY));
		case Calendar.HOUR_OF_DAY:
			calendar.set(Calendar.MINUTE, calendar.getMinimum(Calendar.MINUTE));
		case Calendar.MINUTE:
			calendar.set(Calendar.SECOND, calendar.getMinimum(Calendar.SECOND));
		case Calendar.SECOND:
			calendar.set(Calendar.MILLISECOND, calendar.getMinimum(Calendar.MILLISECOND));
		default:
			Calendar c = Calendar.getInstance();
			c.set(Calendar.YEAR, calendar.get(Calendar.YEAR));
			c.set(Calendar.MONTH, calendar.get(Calendar.MONTH));
			c.set(Calendar.DAY_OF_MONTH, calendar.get(Calendar.DAY_OF_MONTH));
			c.set(Calendar.HOUR_OF_DAY, calendar.get(Calendar.HOUR_OF_DAY));
			c.set(Calendar.MINUTE, calendar.get(Calendar.MINUTE));
			c.set(Calendar.SECOND, calendar.get(Calendar.SECOND));
			c.set(Calendar.MILLISECOND, calendar.get(Calendar.MILLISECOND));
			calendar.setTime(c.getTime());
			break;
		}
		return calendar.getTime();
	}

	public static Date getLatest(int field) {
		return getLatest(new Date(), field);
	}

	/**
	 * 以当前时间为基本时间 返回该日历字段的最晚时间(今天最晚:2012-06-04 23:23:59 今年最晚:2012-12-31 23:23:59
	 * 等)
	 * 
	 * @param field
	 *            日历字段
	 * @return
	 */
	public static Date getLatest(Date date, int field) {
		Calendar calendar = getCalendarInstance(date);
		switch (field) {
		case Calendar.YEAR:
			calendar.set(Calendar.MONTH, calendar.getMaximum(Calendar.MONTH));
		case Calendar.MONTH:
			calendar.set(Calendar.DAY_OF_MONTH, calendar.getMaximum(Calendar.DAY_OF_MONTH));
		case Calendar.DAY_OF_MONTH:
		case Calendar.DAY_OF_WEEK:
		case Calendar.DAY_OF_YEAR:
			calendar.set(Calendar.HOUR_OF_DAY, calendar.getMaximum(Calendar.HOUR_OF_DAY));
		case Calendar.HOUR_OF_DAY:
			calendar.set(Calendar.MINUTE, calendar.getMaximum(Calendar.MINUTE));
		case Calendar.MINUTE:
			calendar.set(Calendar.SECOND, calendar.getMaximum(Calendar.SECOND));
		case Calendar.SECOND:
			calendar.set(Calendar.MILLISECOND, calendar.getMaximum(Calendar.MILLISECOND));
		default:
			Calendar c = Calendar.getInstance();
			c.set(Calendar.YEAR, calendar.get(Calendar.YEAR));
			c.set(Calendar.MONTH, calendar.get(Calendar.MONTH));
			c.set(Calendar.DAY_OF_MONTH, calendar.get(Calendar.DAY_OF_MONTH));
			c.set(Calendar.HOUR_OF_DAY, calendar.get(Calendar.HOUR_OF_DAY));
			c.set(Calendar.MINUTE, calendar.get(Calendar.MINUTE));
			c.set(Calendar.SECOND, calendar.get(Calendar.SECOND));
			c.set(Calendar.MILLISECOND, calendar.get(Calendar.MILLISECOND));
			calendar.setTime(c.getTime());
			break;
		}
		return calendar.getTime();
	}

	public static Date[][] generateCalendar(Date date, int firstDay) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.set(Calendar.DAY_OF_MONTH, calendar.getMinimum(Calendar.DAY_OF_MONTH));
		Date[][] days = new Date[6][7];
		int week = calendar.get(Calendar.DAY_OF_WEEK);
		int row = 0;
		if (week == Calendar.SUNDAY) {
			for (int i = 0; i < 7; i++) {
				calendar.add(Calendar.DAY_OF_MONTH, -1);
				days[row][7 - i - 1] = calendar.getTime();
			}
			row++;
		} else {
			for (int i = 0; i < week - 1; i++) {
				calendar.add(Calendar.DAY_OF_MONTH, -1);
				days[row][week - i - 2] = calendar.getTime();
			}
		}
		calendar.setTime(date);
		calendar.set(Calendar.DAY_OF_MONTH, calendar.getMinimum(Calendar.DAY_OF_MONTH));
		for (int i = 0; i < calendar.getActualMaximum(Calendar.DAY_OF_MONTH); i++, week++) {
			if (week > 7) {
				week = week % 7;
				row++;
			}
			days[row][week - 1] = calendar.getTime();
			calendar.roll(Calendar.DAY_OF_MONTH, 1);
		}
		calendar.set(Calendar.DAY_OF_MONTH, calendar.getMinimum(Calendar.DAY_OF_MONTH));
		calendar.add(Calendar.MONDAY, 1);
		if (week > 7) {
			week = week % 7;
			row++;
		}
		while (row < days.length) {
			for (; week <= 7; week++) {
				days[row][week - 1] = calendar.getTime();
				calendar.add(Calendar.DAY_OF_MONTH, 1);
			}
			week = week % 7;
			row++;
		}
		if (firstDay != Calendar.SUNDAY) {
			int offset = firstDay - Calendar.SUNDAY;
			for (int i = 0; i < days.length; i++) {
				for (int j = 0; j < days[i].length; j++) {
					Calendar c = getCalendarInstance(days[i][j]);
					c.add(Calendar.DAY_OF_YEAR, offset);
					days[i][j] = c.getTime();
				}
			}
		}
		return days;
	}

	/**
	 * 生成 6*7 日历
	 * 
	 * @param date
	 *            当前时间
	 * @return
	 */
	public static Date[][] generateCalendar(Date date) {
		return generateCalendar(date, Calendar.SUNDAY);
	}

	public static void main(String[] args) {
		System.out.println(CalendarUtil.getEarliest(new Date(), Calendar.DAY_OF_MONTH).getTime());
		System.out.println(DateUtil.format(CalendarUtil.getEarliest(new Date(), Calendar.DAY_OF_MONTH), "yyyy-MM-dd HH:mm:ss sss"));
	}
}
