package com.wiiy.oa.service.impl;

import java.io.OutputStream;
import java.util.List;

import com.wiiy.commons.util.DateUtil;
import com.wiiy.core.mail.MailDto;
import com.wiiy.core.mail.MailServer;
import com.wiiy.external.service.dto.Page;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.service.MailService;

public class MailServiceImpl implements MailService {

	public static final String POP3 = "pop3";
	public static final String IMAP = "imap";
	
	@Override
	public Result<MailDto> send(String host,String smtpHost, String user, String pass, MailDto mailDto,String folderName) {
		return MailServer.send(host, smtpHost, user, pass, mailDto,folderName);
	}

	@Override
	public Result<MailDto> mailFromInbox(String host, String user, String pass, Integer id,String folderName) {
		return mail(host, user, pass, IMAP, folderName, id);
	}
	
	@Override
	public Result<MailDto> mailFromSentItems(String host, String user, String pass, Integer id,String folderName) {
		return mail(host, user, pass, IMAP, folderName, id);
	}
	
	
	@Override
	public Result<String> downloadAttachment(String host, String user, String pass, String protocol, String folderName, Integer id, Integer partIndex, OutputStream out) {
		return MailServer.downloadAttachment(host, user, pass, protocol, folderName, id, partIndex, out);
	}
	@Override
	public Result<MailDto> mail(String host, String user, String pass, String protocol, String folderName, Integer id) {
		return mail(host, user, pass, protocol, folderName, id, false);
	}
	public Result<MailDto> mail(String host, String user, String pass, String protocol, String folderName, Integer id,boolean downloadAtt) {
		return MailServer.mail(host, user, pass, protocol, folderName, id, downloadAtt);
	}
	
	
	@Override
	public Result<?> deleteFromInbox(String host, String user, String pass, Integer id,String folderName) {
		return delete(host, user, pass, folderName, id);
	}
	
	@Override
	public Result<?> deleteFromSentItems(String host, String user, String pass, Integer id,String folderName) {
		return delete(host, user, pass, folderName, id);
	}
	
	@Override
	public Result<?> delete(String host, String user, String pass, String folderName, Integer id) {
		return MailServer.delete(host, user, pass, folderName, id);
	}
	//(page.getPageNo()-1)*page.getPageSize()+1, page.getPageNo()*page.getPageSize()
	public Result<List<MailDto>> list(String host, String user, String pass, String protocol, String folderName, Page page,String subject,String content) {
		return MailServer.list(host, user, pass, protocol, folderName, page, subject, content);
	}
	
	public Result<List<MailDto>> receiveList(String host, String user, String pass,String folderName, Page page,String subject,String content) {
		return list(host, user, pass, IMAP, folderName, page,subject,content);
	}

	@Override
	public Result<List<MailDto>> sendList(String host, String user, String pass,String folderName, Page page,String subject,String content) {
		return list(host, user, pass, IMAP, folderName,page,subject,content);
	}

	@Override
	public Result<List<MailDto>> draftList(String host, String user,
			String pass,String folderName, Page page, String subject, String content) {
		return list(host, user, pass, IMAP, folderName,page,subject,content);
	}

	@Override
	public Result<MailDto> saveDraft(String host, String smtphost,
			String user, String pass, MailDto mailDto,String folderName) {
		return MailServer.saveDraft(host, smtphost, user, pass, mailDto,folderName);
	}

	@Override
	public Result<List<MailDto>> searchMail(String host,String user,String pass,String subject, String content,
			String mailFrom, String mailTo,String folderName) {
		return MailServer.searchMail(host,user,pass,subject, content, mailFrom, mailTo,folderName);
	}

}
