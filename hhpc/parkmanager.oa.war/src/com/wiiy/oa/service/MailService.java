package com.wiiy.oa.service;

import java.io.OutputStream;
import java.util.List;

import com.wiiy.core.mail.MailDto;
import com.wiiy.external.service.dto.Page;
import com.wiiy.hibernate.Result;


public interface MailService {
	
	/**
	 * 发送邮件
	 * @param host
	 * @param user
	 * @param pass
	 * @param pass2 
	 * @param mailDto
	 * @return
	 */
	Result<MailDto> send(String host,String smtpHost, String user, String pass,  MailDto mailDto,String folderName);
	
	/**
	 * 查看邮件
	 * @param host
	 * @param user
	 * @param pass
	 * @param folderName
	 * @param id
	 * @return
	 */
	Result<MailDto> mail(String host, String user, String pass,String protocol, String folderName, Integer id);
	Result<MailDto> mail(String host, String user, String pass,String protocol, String folderName, Integer id,boolean downloadAtt);
	
	/**
	 * 下载邮件附件
	 * @param host
	 * @param user
	 * @param pass
	 * @param folderName
	 * @param id
	 * @param partIndex
	 * @param out
	 * @return result.value(fileName);
	 */
	Result<String> downloadAttachment(String host, String user, String pass,String protocol, String folderName, Integer id, Integer partIndex, OutputStream out);
	
	/**
	 * 查看收件箱邮件
	 * @param host
	 * @param user
	 * @param pass
	 * @param id
	 * @return
	 */
	Result<MailDto> mailFromInbox(String host, String user, String pass, Integer id,String folderName);
	
	/**
	 * 查看发件箱邮件
	 * @param host
	 * @param user
	 * @param pass
	 * @param id
	 * @return
	 */
	Result<MailDto> mailFromSentItems(String host, String user, String pass, Integer id,String folderName);
	
	/**
	 * 删除邮件
	 * @param host
	 * @param user
	 * @param pass
	 * @param folderName
	 * @param id
	 * @return
	 */
	Result<?> delete(String host, String user, String pass, String folderName, Integer id);
	
	/**
	 * 删除收件箱邮件
	 * @param host
	 * @param user
	 * @param pass
	 * @param id
	 * @return
	 */
	Result<?> deleteFromInbox(String host, String user, String pass, Integer id,String folderName);
	
	/**
	 * 删除发件箱邮件
	 * @param host
	 * @param user
	 * @param pass
	 * @param id
	 * @return
	 */
	Result<?> deleteFromSentItems(String host, String user, String pass, Integer id,String folderName);

	/**
	 * 收件箱
	 * @param host
	 * @param user
	 * @param pass
	 * @param folderName
	 * @param start
	 * @param end
	 * @return
	 */
	Result<List<MailDto>> list(String host, String user, String pass,String protocol, String folderName, Page page,String subject,String content);
	
	/**
	 * 收件箱
	 * @param host
	 * @param user
	 * @param pass
	 * @param start
	 * @param end
	 * @return
	 */
	Result<List<MailDto>> receiveList(String host, String user, String pass,String folderName, Page page,String subject,String content);
	
	/**
	 * 发件箱
	 * @param host
	 * @param user
	 * @param pass
	 * @param start
	 * @param end
	 * @return
	 */
	Result<List<MailDto>> sendList(String host, String user, String pass,String folderName, Page page,String subject,String content);

	Result<List<MailDto>> draftList(String host, String user, String pass,String folderName, Page page,String subject, String content);

	Result<MailDto> saveDraft(String host, String smtphost, String user, String pass,
			MailDto mailDto,String folderName);

	Result<List<MailDto>> searchMail(String host,String user,String pass,String subject, String content, String mailFrom,String mailTo,String folderNmae);

}
