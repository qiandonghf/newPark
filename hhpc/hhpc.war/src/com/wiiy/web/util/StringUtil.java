package com.wiiy.web.util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

public class StringUtil {
	
	
	/**
	 * 检测并修正分隔字符串
	 * @param string
	 * @param regex 分割符(可以为长字符串)
	 * @return
	 */
	public static String checkSplitString(String string, String regex){
		String[] ids = string.split(regex);
		List<String> list = new ArrayList<String>();
		for (String id : ids) {
			if(id.trim().length()>0){
				list.add(id);
			}
		}
		string = "";
		for (String id : list) {
			string += id + ",";
		}
		if(string.endsWith(",")) string = string.substring(0,string.length()-1);
		return string;
	}
	
	/**
	 * 分割字符串 返回integer型数据
	 * @param string
	 * @param regex 分割符(可以为长字符串)
	 * @return
	 */
	public static Integer[] splitToIntegerArray(String string, String regex){
		String[] ids = string.split(regex);
		Integer[] array = new Integer[ids.length];
		int i = 0;
		for (String id : ids) {
			if(id.trim().length()>0){
				array[i++] = Integer.parseInt(id.trim());
			}
		}
		return array;
	}
	/**
	 * ,分割字符串 返回integer型数据
	 * @param string
	 * @return
	 */
	public static Integer[] splitToIntegerArray(String string){
		return splitToIntegerArray(string, ",");
	}
	
	/**
	 * 分割字符串 返回long型数据
	 * @param string
	 * @param regex 分割符(可以为长字符串)
	 * @return
	 */
	public static Long[] splitToLongArray(String string, String regex){
		String[] ids = string.split(regex);
		Long[] array = new Long[ids.length];
		int i = 0;
		for (String id : ids) {
			if(id.trim().length()>0){
				array[i++] = Long.parseLong(id.trim());
			}
		}
		return array;
	}
	/**
	 * ,分割字符串 返回long型数据
	 * @param string
	 * @return
	 */
	public static Long[] splitToLongArray(String string){
		return splitToLongArray(string, ",");
	}
	
	/**
	 * ISOToUTF8
	 * @param s
	 * @return
	 */
	public static String ISOToUTF8(String s){
		try {
			return new String(s.getBytes("ISO-8859-1"),"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return s;
		}
	}
	
	/**
	 * ISOToUTF8
	 * @param s
	 * @return
	 */
	public static String UTF8ToISO(String s){
		try {
			return new String(s.getBytes("UTF-8"),"ISO-8859-1");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return s;
		}
	}
	
	/**
	 * URLEncoderToUTF8
	 * @param s
	 * @return
	 */
	public static String URLEncoderToUTF8(String s){
		try {
			return URLEncoder.encode(s,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return s;
		}
	}
	
	/**
	 * 将首字母转换为大写
	 * @param string
	 * @return
	 */
	public static String convertFirstCharToUpperCase(String string){
		if(string!=null && string.length()>1){
			return Character.toUpperCase(string.charAt(0))+string.substring(1);
		}
		return string;
	}
	
	/**
	 * 将首字母转换为小写
	 * @param string
	 * @return
	 */
	public static String convertFirstCharToLowerCase(String string){
		if(string!=null && string.length()>1){
			return Character.toLowerCase(string.charAt(0))+string.substring(1);
		}
		return string;
	}
	/**
	 * 如果string 以exp开头或以exp结尾则截去
	 * 
	 * @param string
	 * @param exp
	 * @return
	 */
	public static String trim(String string, String exp) {
		while (string.startsWith(exp)) {
			string = string.replaceFirst(exp, "");
		}
		while (string.endsWith(exp)) {
			string = string.substring(0, string.lastIndexOf(exp));
		}
		return string;
	}

}
