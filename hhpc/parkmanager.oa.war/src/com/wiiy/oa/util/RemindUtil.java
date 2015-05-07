package com.wiiy.oa.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;

import org.apache.struts2.ServletActionContext;

import com.wiiy.external.service.SMSPubService;
import com.wiiy.external.service.SysEmailSenderPubService;
import com.wiiy.oa.activator.OaActivator;

public class RemindUtil {
	public static void sendSms(String receiverMobile, String content,
			String receiverName,SMSPubService smsPubService) {
		smsPubService.send(receiverMobile, content, receiverName);
	}

	public static void sendMail(String receiverName,String receiverEmail,String subject,String content,SysEmailSenderPubService sysEmailSenderPubService){
		if(receiverEmail == null){
			receiverEmail = "";
		}
		sysEmailSenderPubService.send(receiverEmail,content,subject);
	}

	
	public static boolean emailActive(String config){
		String msgSet =  OaActivator.getAppConfig().getConfig(config).getParameter("email");
		if(msgSet.equals("active")){
			return true;
		}else{
			return false;
		}
	}
	
	public static boolean smsActive(String config){
		String msgSet =  OaActivator.getAppConfig().getConfig(config).getParameter("sms");
		if(msgSet.equals("active")){
			return true;
		}else{
			return false;
		}
	}
	
	public static StringBuffer parseHTML(String str){
		URL url = OaActivator.getURL(str);
		InputStreamReader Inputreader;
		StringBuffer data = new StringBuffer();
		try {
			Inputreader = new InputStreamReader(url.openStream(),"utf-8");
			BufferedReader br = new BufferedReader(Inputreader);
			String temp=br.readLine();
			while( temp!=null){
				data.append(temp+"\n");
				temp=br.readLine(); 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return data;
	}
	
	public static String basePath(){
		String path=OaActivator.getAppConfig().getConfig("ip").getParameter("value");
		return "http://"+OaActivator.getAppConfig().getConfig("ip").getParameter("value")+"/";
	}
}
