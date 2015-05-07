package com.wiiy.web.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {

	public static final String DEFAULT_PATTERN = "yyyy-MM-dd";
	public static final String FULL_PATTERN = "yyyy-MM-dd HH:mm:ss";

	public static final SimpleDateFormat simpleDateFormat = new SimpleDateFormat();

	public static Date now() {
		return new Date();
	}

	public static Date parse(String source) {
		return parse(source, DEFAULT_PATTERN);
	}

	public static Date parse(String source, String pattern) {
		try {
			simpleDateFormat.applyPattern(pattern);
			return simpleDateFormat.parse(source);
		} catch (ParseException e) {
			throw new RuntimeException(e);
		}
	}

	public static String format(Date date) {
		return format(date, DEFAULT_PATTERN);
	}

	public static String format(Date date, String pattern) {
		simpleDateFormat.applyPattern(pattern);
		return simpleDateFormat.format(date);
	}
	
}
