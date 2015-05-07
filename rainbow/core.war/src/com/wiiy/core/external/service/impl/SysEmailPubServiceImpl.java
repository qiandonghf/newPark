package com.wiiy.core.external.service.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import org.hibernate.Session;

import com.wiiy.commons.util.BeanUtil;
import com.wiiy.core.activator.CoreActivator;
import com.wiiy.core.mail.MailDto;
import com.wiiy.core.mail.MailServer;
import com.wiiy.external.service.SysEmailSenderPubService;
import com.wiiy.external.service.dto.EmailDto;
import com.wiiy.external.service.dto.EmailReceiverDto;
import com.wiiy.hibernate.Result;

public class SysEmailPubServiceImpl extends TimerTask implements SysEmailSenderPubService {
	
	private List<MailDto> emailList = new ArrayList<MailDto>();
	private Timer timer;
	
	@Override
	public void run() {
		String emailPop3Host = CoreActivator.getAppConfig().getConfig("emailConfig").getParameter("emailPop3Host");
		String emailSmtpHost = CoreActivator.getAppConfig().getConfig("emailConfig").getParameter("emailSmtpHost");
		String username = CoreActivator.getAppConfig().getConfig("emailConfig").getParameter("username");
		String password = CoreActivator.getAppConfig().getConfig("emailConfig").getParameter("password");
		String folderName = "已发送";
		/*Iterator<MailDto> it = emailList.iterator();
		while(it.hasNext()){
			MailDto dto = it.next();
			MailServer.send(emailPop3Host, emailSmtpHost, username, password, dto,folderName);
			it.remove();
		}*/
		if(emailList.size()>0&&emailList!=null){
			int length = emailList.size();
			for(int i=0;i<length;i++){
				System.out.println(i);
				MailDto m = emailList.get(0);
				MailServer.send(emailPop3Host, emailSmtpHost, username, password, emailList.get(0),folderName);
				emailList.remove(0);
			}
		}
	}
	
	
	public SysEmailPubServiceImpl() {
		timer = new Timer();
		timer.schedule(this, 0, 1000*5);
	}


	@Override
	public Result<EmailDto> send(EmailDto email, Session session) {
		return send(email);
	}
	
	@Override
	public Result<EmailDto> send(EmailDto email) {
		MailDto dto = new MailDto();
		BeanUtil.copyProperties(email, dto);
		StringBuilder sb = new StringBuilder();
		for (EmailReceiverDto receiver : email.getReceiverList()) {
			sb.append(receiver.getAddress()).append(";");
		}
		dto.setTo(sb.toString());
		email.setId(1l);//邮件ID 不使用 此方法为向下兼容
		emailList.add(dto);
		return Result.value(email);
	}


	@Override
	public Result deleteById(Long id, Session session) {
		System.out.println("SysEmailPubServiceImpl.deleteById()");
		return null;
	}


	@Override
	public Result<EmailDto> send(String receiverEmail, String content,String subject) {
		MailDto dto = new MailDto();
		dto.setContent(content);
		dto.setTo(receiverEmail);
		dto.setSubject(subject);
		emailList.add(dto);
		return Result.success();
	}
	@Override
	public Result<EmailDto> send(String[] receiverEmail, String[] content,String subject) {
		for (int i=0;i<receiverEmail.length;i++) {
			MailDto dto = new MailDto();
			dto.setContent(content[i]);
			dto.setTo(receiverEmail[i]);
			dto.setSubject(subject);
			emailList.add(dto);
		}
		return Result.success();
	}

}
