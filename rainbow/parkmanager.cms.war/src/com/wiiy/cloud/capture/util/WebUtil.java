package com.wiiy.cloud.capture.util;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;


public class WebUtil {
	//<a href='/doc/xwzx/zxyw/2012_9_28/132712.shtml' target='_blank' title='2012中国科技创业计划大赛颁奖仪式隆重举行'>2012中国科技创业计划大赛颁奖仪式隆重举行</a>
		public static final String REGEX_A = "<a\\s+href=['\"]([^'\"]*)[^>]*>(.*?)</a>";		
		public static void main(String[] args) {
			String a = "asd<a href=\"/doc/xwzx/zxyw/2012_9_28/132712.shtml\" target='_blank' title='2012中国科技创业计划大赛颁奖仪式隆重举行'>2012中国科技创业计划大赛颁奖仪式隆重举行</a>asd";
			String a2 = "asd<a href='/doc/xwzx/zxyw/2012_9_28/132712.shtml' target='_blank' title='2012中国科技创业计划大赛颁奖仪式隆重举行'>2012中国科技创业计划大赛颁奖仪式隆重举行</a>asd";
			System.out.println(compile(a2, REGEX_A, 2));
		}
		
		public static String compile(String content,String regex, int groupId){
			//匹配是否是js弹出窗口,如果是的话,则获取js打开的url
			int start = content.indexOf("javascript:window.open(");
			int end = content.indexOf(",'')");
			if (start !=-1 && end !=0 && groupId == 1) {
				String path = content.substring(start, end) ;
				path = path.replace("javascript:window.open('", "");
				path = path.replace("',''", "");
				System.out.println(path);
				return "hhtz/"+path;
			}
			Pattern p = Pattern.compile(regex);
			Matcher m = p.matcher(content);
			if (m.find()) {				
				return m.group(groupId);
			}
			return "";
		}
		
		public static String compile(String content,String regex){
			return compile(content, regex, 0);
		}
		
		public static List<String> compiles(String content,String regex,int groupId){
			List<String> list = new ArrayList<String>();
			//创建正则对象
			Pattern p = Pattern.compile(regex);
			//获得正则匹配后的matcher对象
			Matcher m = p.matcher(content);
			//循环将匹配到的值添加到list列表
			while (m.find()) {
				list.add(m.group(groupId));
			}
			return list;
		}
		public static List<String> compiles(String content,String regex){
			return compiles(content, regex, 0);
		}
		
		public static String request(String url) {
			return request(url, null);
		}
		
		public static String request(String url, Map<String,String> params) {
			return request(url, "get", params);
		}
		
		
		public static String request(String url, String method, Map<String,String> params) {
			DefaultHttpClient httpClient =null ;
			try {
				//获得httpClient对象
				 httpClient = new DefaultHttpClient();
				 HttpResponse httpResponse = null;
				 //判断是post请求还是get请求
				if ("get".equalsIgnoreCase(method)) {
					if (params != null) {
						url += url.indexOf("?") != -1 ? "&" : "?";
						for (String key : params.keySet()) {
							url += key + "=" + params.get(key) + "&";
						}
					}
					//获得httpGet对象
					HttpGet httpGet = new HttpGet(url);
					//获得response流
					httpResponse = httpClient.execute(httpGet);
				} else if ("post".equalsIgnoreCase(method)) {
					//获得post请求对象
					HttpPost httpPost = new HttpPost(url);
					if (params != null) {
						List<NameValuePair> paramList = new ArrayList<NameValuePair>();
						for (String key : params.keySet()) {
							paramList.add(new BasicNameValuePair(key, params.get(key)));
						}
						//得到网页entity对象
						UrlEncodedFormEntity entity = new UrlEncodedFormEntity(paramList, "utf-8");
						httpPost.setEntity(entity);
					}
					//获得response流
					httpResponse = httpClient.execute(httpPost);
				}
				//转换为httpEntity对象
				HttpEntity entity = httpResponse.getEntity();				
				StringBuilder sb = new StringBuilder();
				if (entity != null) {
					//获得输入流
					InputStream is = entity.getContent();
					String charset = null;
					String flag = "content=\"text/html; charset=";
					int length = 0;
					byte[] array = new byte[9216];
					while ((length = is.read(array)) != -1) {
						String content = new String(array, 0, length, "UTF-8");
						//如果有字符编码,则获得改网页的字符编码
						if(content.indexOf(flag)!=-1){
							int start = content.indexOf(flag)+flag.length();
							int end = content.indexOf("\"",start);
							charset = content.substring(start,end);
						}
						//如果页面没有设置字符编码,则默认为gb2312
						if (charset == null) {
							charset = "gb2312" ;
						}
						//将inputStream转换为字符流
						sb.append(new String(array, 0, length, charset));
					}
				}
				
				return sb.toString();
			} catch (Exception e) {
				e.printStackTrace();
				return null;
			}
		}
		private static String getCharset(InputStream is) throws Exception {
			String charset = null;
			int length = 0;
			byte[] array = new byte[9192];
			String flag = "content=\"text/html; charset=";
			while ((length = is.read(array)) != -1) {
				String content = new String(array, 0, length, "UTF-8");
				if(content.indexOf(flag)!=-1){
					int start = content.indexOf(flag)+flag.length();
					int end = content.indexOf("\"",start);
					return content.substring(start,end);
				}
			}
			if (charset == null) {
				charset = "gb2312" ;
			}
			return charset;
		}
}