package com.wiiy.core.mail;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Flags;
import javax.mail.Flags.Flag;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Part;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;
import javax.mail.search.AndTerm;
import javax.mail.search.BodyTerm;
import javax.mail.search.FromStringTerm;
import javax.mail.search.OrTerm;
import javax.mail.search.RecipientTerm;
import javax.mail.search.SearchTerm;
import javax.mail.search.SubjectTerm;

import com.wiiy.core.activator.CoreActivator;
import com.wiiy.external.service.dto.EmailAttDto;
import com.wiiy.external.service.dto.Page;
import com.wiiy.hibernate.Result;


public class MailServer {

	public static final String POP3 = "pop3";
	public static final String IMAP = "imap";

	public static Message getMessage(String user, Session session,MailDto mailDto) {
		Message message = null;
		try {
			message = new MimeMessage(session);
			message.setSubject(mailDto.getSubject());
			message.setFrom(new InternetAddress(user));
			// RecipientType "TO"-->收件人,"CC"-->抄送人地址,"BCC"-->密送地址
			String[] receivers = mailDto.getTo().split(";");
			for (String receiver : receivers) {
				if (!receiver.equals("")) {
					message.addRecipient(Message.RecipientType.TO,
							new InternetAddress(receiver));
				}
			}
			if (mailDto.getBcc() != null && mailDto.getBcc().length() > 0) {
				message.setRecipient(Message.RecipientType.BCC,
						new InternetAddress(mailDto.getBcc()));
			}
			if (mailDto.getCc() != null && mailDto.getCc().length() > 0) {
				message.setRecipient(Message.RecipientType.CC,
						new InternetAddress(mailDto.getCc()));
			}

			message.setSentDate(new Date());// 发送日期

			Multipart multipart = new MimeMultipart("related");
			if (mailDto.getContent().contains("<")
					&& mailDto.getContent().contains("</")) {
				// 设置邮件的文本内容
				BodyPart bodyPart = new MimeBodyPart();
				bodyPart.setContent(mailDto.getContent(),"text/html;charset=utf-8");
//				bodyPart.setDataHandler(new DataHandler(mailDto.getContent(),
//						"text/html;charset=utf-8"));// 网页格式
				multipart.addBodyPart(bodyPart);
				
				bodyPart = new MimeBodyPart();
				DataSource fds = new FileDataSource(CoreActivator.getBundleRootPath()+"/common/images/"+CoreActivator.getAppConfig().getConfig("msgLogo").getParameter("name")); 
				bodyPart.setDataHandler(new DataHandler(fds)); 
				bodyPart.setHeader("Content-ID","logo_mail.gif");
				
				multipart.addBodyPart(bodyPart);
			} else {
				MimeBodyPart contentPart = new MimeBodyPart();
				contentPart.setText(mailDto.getContent());
				multipart.addBodyPart(contentPart);
			}

			if (mailDto.getEmailAttDtoList() != null
					&& mailDto.getEmailAttDtoList().size() > 0) {
				List<EmailAttDto> attList = mailDto.getEmailAttDtoList();
				for (EmailAttDto att : attList) {
					MimeBodyPart attPart = new MimeBodyPart();
					File file = CoreActivator.getResourcesService()
							.getFileByPath(att.getNewName());
					DataHandler dataHandler = new DataHandler(
							new FileDataSource(file));
					attPart.setDataHandler(dataHandler);
					attPart.setFileName(MimeUtility.encodeText(att.getName()));
					multipart.addBodyPart(attPart);
				}
			}
			message.setContent(multipart, "text/html;charset=utf-8");
			return message;
		} catch (Exception e) {
			e.printStackTrace();
			return message;
		}
	}

	public static Result<MailDto> saveDraft(String host, String smtpHost,String user, String pass, MailDto mailDto, String folderName) {
		try {
			Properties properties = new Properties();
			properties.put("mail.smtp.auth", "true");
			properties.put("mail.smtp.host", smtpHost);
			Session session = Session.getInstance(properties,
					new MyAuthenticator(user, pass));
			//session.setDebug(true);

			Message message = getMessage(user, session, mailDto);

			Store store = session.getStore(IMAP);
			store.connect(host, user, pass);
			Folder folder = store.getFolder(folderName);
			folder.open(Folder.READ_WRITE);
			folder.appendMessages(new Message[] { message });
			folder.close(true);
			store.close();
			return Result.success("保存草稿成功");
		} catch (Exception e) {
			e.printStackTrace();
			return Result.success("保存草稿失败");
		}
	}

	public static void main(String[] args) {
		Page page = new Page();
		page.setPageNo(1);
		page.setPageSize(10);
		page.setTotalCount(0);
	}
	
	/*
	 * host:IMAP协议
	 * smtpHost:smtp协议
	 * user:邮箱账号
	 * pass：邮箱密码
	 * mailDto：邮件内容
	 * folderName：发件箱
	 */
	public static Result<MailDto> send(String host, String smtpHost,String user, String pass, MailDto mailDto, String folderName) {
		try {
			Properties properties = new Properties();
			properties.put("mail.smtp.auth", "true");
			properties.put("mail.smtp.host", smtpHost);
			Session session = Session.getInstance(properties,
					new MyAuthenticator(user, pass));
			//session.setDebug(true);

			Message message = getMessage(user, session, mailDto);
			// 发送邮件
			Transport.send(message);

			Store store = session.getStore(IMAP);
			store.connect(host, user, pass);
			Folder folder = store.getFolder(folderName);
//			 Folder[] list = folder.list();
//			 for (Folder folder2 : list) {
//			 System.out.println(folder2.getFullName());
//			 }
			if(!host.equalsIgnoreCase("imap.163.com")){
				folder.open(Folder.READ_WRITE);
				folder.appendMessages(new Message[] { message });
				folder.close(true);
			}
			store.close();
			return Result.success("发送成功");
		} catch (Exception e) {
			return Result.failure("发送失败");
		}
	}

	public static Result<MailDto> mailFromInbox(String host, String user,String pass, Integer id, String folderName) {
		return mail(host, user, pass, IMAP, folderName, id);
	}

	public static Result<MailDto> mailFromSentItems(String host, String user,String pass, Integer id, String folderName) {
		return mail(host, user, pass, IMAP, folderName, id);
	}

	public static Result<String> downloadAttachment(String host, String user,String pass, String protocol, String folderName, Integer id,Integer partIndex, OutputStream out) {
		Properties properties = new Properties();
		properties.put("mail.smtp.auth", "true");
		try {
			Session session = Session.getDefaultInstance(properties, null);
			Store store = session.getStore(protocol);
			store.connect(host, user, pass);
			Folder folder = store.getFolder(folderName);
			try {
				folder.open(Folder.READ_WRITE);
			} catch (Exception e) {
				folder.open(Folder.READ_ONLY);
			}
			Message message = folder.getMessage(id);
			message.setFlag(Flag.SEEN, true);
			String fileName = downloadAttachment(message, partIndex, out);
			folder.close(true);
			store.close();
			return Result.value(fileName);
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure("邮箱连接失败");
		}
	}

	public static Result<MailDto> mail(String host, String user, String pass,String protocol, String folderName, Integer id) {
		return mail(host, user, pass, protocol, folderName, id, false);
	}

	public static Result<MailDto> mail(String host, String user, String pass,String protocol, String folderName, Integer id, boolean downloadAtt) {
		Properties properties = new Properties();
		properties.put("mail.smtp.auth", "true");
		try {
			Session session = Session.getDefaultInstance(properties, null);
			Store store = session.getStore(protocol);
			store.connect(host, user, pass);
			Folder folder = store.getFolder(folderName);
			try {
				folder.open(Folder.READ_WRITE);
			} catch (Exception e) {
				folder.open(Folder.READ_ONLY);
			}
			Message message = folder.getMessage(id);
			message.setFlag(Flag.SEEN, true);

			MailDto dto = new MailDto();
			dto.setId(message.getMessageNumber());

			if (message.getSubject() != null) {
				MimeMessage part = (MimeMessage) message;
				String[] head = part.getHeader("SUBJECT");
				String subject = "";
				for (String str : head) {
					subject = new String(str.getBytes("ISO8859_1"), "GBK");
				}
				subject = MimeUtility.decodeText(subject);
				//System.out.println("SUBJECT: " + subject);
				subject = subject.replaceAll("<", "&lt;");
				subject = subject.replaceAll(">", "&gt;");
				dto.setSubject(MimeUtility.decodeText(subject));
			} else {
				dto.setSubject("");
			}
			dto.setSendDate(message.getSentDate());
			if (message.getFrom() != null) {
				if (!((InternetAddress[]) message.getFrom())[0].getAddress()
						.contains("MISSING-HOST-NAME")) {
					dto.setSender(((InternetAddress[]) message.getFrom())[0]
							.getAddress());
				} else {
					dto.setSender(((InternetAddress[]) message.getFrom())[0]
							.getPersonal());
				}
			}
			dto.setTo(MailUtil.getTOAddress(message));
			dto.setBcc(MailUtil.getBCCAddress(message));
			dto.setCc(MailUtil.getCCAddress(message));
			// dto.setContent(MailUtil.getContent(message));
			dto.setContent(MailUtil.getBodyText(message));
			dto.setContainAttach(MailUtil.isContainAttach(message));
			if (message.getHeader("X-Priority") != null) {
				dto.setLevel(Integer.parseInt(message.getHeader("X-Priority")[0]
						.substring(0, 1)));
			} else {
				dto.setLevel(5);
			}
			dto.setReaded(message.getFlags().contains(Flag.SEEN));
			parseMessage(message, dto, downloadAtt);
			folder.close(true);
			store.close();
			return Result.value(dto);
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure("邮箱连接失败");
		}
	}

	/**
	 * 下载附件
	 * 
	 * @param message
	 * @param out
	 * @return
	 * @throws Exception
	 */
	private static String downloadAttachment(Message message,Integer partIndex, OutputStream out) throws Exception {
		String contentType = message.getContentType();
		Object content = message.getContent();
		if (content instanceof Multipart) {
			Multipart multipart = (Multipart) content;
			BodyPart part = multipart.getBodyPart(partIndex);
			String disposition = part.getDisposition();
			if (disposition.equalsIgnoreCase(Part.ATTACHMENT)
					|| disposition.equalsIgnoreCase(Part.INLINE)) {
				boolean ascii = false;
				if (contentType.contains("US-ASCII")) {
					ascii = true;
				}
				String fileName = MailUtil.getFileName(part, ascii);
				part.getFileName();
				InputStream in = part.getInputStream();
				byte[] array = new byte[1024 * 64];
				int length;
				while ((length = in.read(array)) != -1) {
					out.write(array, 0, length);
				}
				in.close();
				out.close();
				return fileName;
			}
		}
		return null;
	}

	/**
	 * 解析邮件
	 * 
	 * @param message
	 * @param downloadAtt
	 * @throws Exception
	 */
	private static void parseMessage(Message message, MailDto dto,boolean downloadAtt) throws Exception {
		String contentType = message.getContentType();
		Object content = message.getContent();
		if (content instanceof Multipart) {
			boolean ascii = false;
			if (contentType.toLowerCase().contains("gb2312")) {
				ascii = true;
			}
			handleMultipart((Multipart) content, dto, downloadAtt, ascii);
		} /*
		 * else if(contentType.startsWith("text/plain") ||
		 * contentType.startsWith("text/html")){ InputStream in =
		 * message.getInputStream(); BufferedReader reader = new
		 * BufferedReader(new InputStreamReader(in)); StringBuilder sb = new
		 * StringBuilder(); while (reader.ready()) {
		 * sb.append(reader.readLine()).append("<br/>"); } //
		 * dto.setContent(sb.toString()); }
		 */
	}

	/**
	 * 解析 multipart
	 * 
	 * @param multipart
	 * @param downloadAtt
	 * @throws MessagingException
	 * @throws IOException
	 */
	private static void handleMultipart(Multipart multipart, MailDto dto,boolean downloadAtt, boolean ascii) throws Exception {
		for (int i = 0, n = multipart.getCount(); i < n; i++) {
			if (multipart.getBodyPart(i).getContentType().toLowerCase()
					.contains("gb2312")) {
				ascii = true;
			}
			handlePart(i, multipart.getBodyPart(i), dto, downloadAtt, ascii);
		}
	}

	/**
	 * 解析指定part,从中提取文件
	 * 
	 * @param downloadAtt
	 * @param multipart
	 * @throws Exception
	 */
	private static void handlePart(int partIndex, Part part, MailDto dto,boolean downloadAtt, boolean ascii) throws Exception {
		String disposition = part.getDisposition();
		if (disposition == null) {
			String contentType = part.getContentType();
			if (contentType.toLowerCase().contains("gb2312")) {
				ascii = true;
			}
			//System.out.println("part" + partIndex + ": " + contentType);
			Object content = part.getContent();
			if (content instanceof Multipart) {
				handleMultipart((Multipart) content, dto, downloadAtt, ascii);
			} else if (contentType.startsWith("text/plain")
					|| contentType.startsWith("text/html")) {
				InputStream in = part.getInputStream();
				BufferedReader reader = new BufferedReader(
						new InputStreamReader(in));
				StringBuilder sb = new StringBuilder();
				while (reader.ready()) {
					sb.append(reader.readLine()).append("<br/>");
				}
			} else if (contentType.toUpperCase().startsWith("IMAGE/JPEG")) {
				InputStream inputStream = part.getInputStream();
				Date uploadTime = new Date();
				String imgName = MailUtil.getFileName(part, ascii);
				if (imgName != null) {
					String newImgName = new SimpleDateFormat("yyyyMMddHHmmss")
							.format(uploadTime);
					if (imgName.indexOf(".") >= 0) {
						newImgName += imgName.substring(imgName
								.lastIndexOf("."));
					}
					String path = "mail/imgs/" + newImgName;
					CoreActivator.getResourcesService().saveFile(path,
							inputStream);

					String htmlImgName = part.getDataHandler().getName();
					//System.out.println("图片名称:" + htmlImgName);
					String newContent = dto.getContent().replaceAll(
							"cid:" + htmlImgName, "core/resources/" + path);
					dto.setContent(newContent);
				}
			}
		} else if (disposition.equalsIgnoreCase(Part.ATTACHMENT)) {
			EmailAttDto mailAtt = new EmailAttDto();
			String fileName = MailUtil.getFileName(part, ascii);
			if (fileName == null)
				return;
			mailAtt.setName(fileName);

			mailAtt.setPartIndex(partIndex);
			mailAtt.setSize(part.getInputStream().available());
			//System.out.println("part" + partIndex + " 附件：" + fileName);
			if (downloadAtt) {
				InputStream inputStream = part.getInputStream();
				Date uploadTime = new Date();
				String newFileName = new SimpleDateFormat("yyyyMMddHHmmss")
						.format(uploadTime);
				if (fileName.indexOf(".") >= 0) {
					newFileName += fileName
							.substring(fileName.lastIndexOf("."));
				}
				String path = "mail/attachments/" + newFileName;
				mailAtt.setNewName(path);
				CoreActivator.getResourcesService().saveFile(path, inputStream);
			}
			dto.addAtt(mailAtt);
		} else if (disposition.equalsIgnoreCase(Part.INLINE)) {
			InputStream inputStream = part.getInputStream();
			Date uploadTime = new Date();
			String imgName = MailUtil.getFileName(part, ascii);
			if (imgName != null) {
				String newImgName = new SimpleDateFormat("yyyyMMddHHmmss")
						.format(uploadTime);
				if (imgName.indexOf(".") >= 0) {
					newImgName += imgName.substring(imgName.lastIndexOf("."));
				}
				String path = "mail/imgs/" + newImgName;
				CoreActivator.getResourcesService().saveFile(path, inputStream);

				String CID = MailUtil.getCid(part);
				//System.out.println("CID: "+MailUtil.getCid(part));
				if(CID!=null){
					String newContent = dto.getContent().replace(""+CID, "core/resources/" + path);
					dto.setContent(newContent);
				}
			}
		}
	}

	public static Result<?> deleteFromInbox(String host, String user,String pass, Integer id, String folderName) {
		return delete(host, user, pass, folderName, id);
	}

	public static Result<?> deleteFromSentItems(String host, String user,String pass, Integer id, String folderName) {
		return delete(host, user, pass, folderName, id);
	}

	public static Result<?> delete(String host, String user, String pass,String folderName, Integer id) {
		Properties properties = new Properties();
		properties.put("mail.smtp.auth", "true");
		try {
			Session session = Session.getDefaultInstance(properties, null);
			Store store = session.getStore("imap");
			store.connect(host, user, pass);
			Folder folder = store.getFolder(folderName);
			folder.open(Folder.READ_WRITE);
			Message message = folder.getMessage(id);
//			message.setFlag(Flags.Flag.DELETED, true);
			if (!message.isSet(Flags.Flag.DELETED)) {
				message.setFlag(Flags.Flag.DELETED, true);
			}
			folder.close(true);
			store.close();
			return Result.success("邮件删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure("邮箱连接失败");
		}
	}

	public static Result<List<MailDto>> list(String host, String user,String pass, String protocol, String folderName, Page page,String subject, String content) {
		int start = (page.getPageNo() - 1) * page.getPageSize() + 1;
		int end = page.getPageNo() * page.getPageSize();
		Properties properties = new Properties();
		properties.put("mail.smtp.auth", "true");
		/*properties.put("mail.imap.auth.login.disable", "true");
		properties.setProperty("mail.store.protocol","imap");
		properties.setProperty("mail.debug", "false");
		properties.setProperty("mail.imap.host", host);
		properties.setProperty("mail.imap.port", 143+"");*/
		try {
			Session session = Session.getDefaultInstance(properties, null);
			Store store = session.getStore(protocol);
			//store.connect(host, 143, "wy@nbbi.net", "wy@nbbi.net");
			store.connect(host, user, pass);
			Folder folder = store.getFolder(folderName);
			try {
				folder.open(Folder.READ_WRITE);
			} catch (Exception e) {
				folder.open(Folder.READ_ONLY);
			}
			System.out.println(folder.getUnreadMessageCount());
			Message[] messages = null;
			if (content != null && content.length() > 0 || subject != null
					&& subject.length() > 0) {
				SubjectTerm subjectTerm = null;
				if (subject != null && subject.length() > 0) {
					subjectTerm = new SubjectTerm(subject);
				}
				BodyTerm contentTerm = null;
				if (content != null && content.length() > 0) {
					contentTerm = new BodyTerm(content);
				}
				if (subjectTerm != null && contentTerm == null) {
					messages = folder.search(subjectTerm);
				} else if (contentTerm != null && subjectTerm == null) {
					messages = folder.search(contentTerm);
				} else {
					messages = folder.search(new OrTerm(subjectTerm,
							contentTerm));
				}
				page.setTotalCount(folder.getMessageCount());
			} else {
				page.setTotalCount(folder.getMessageCount());
				System.out.println("邮件总数: " + folder.getMessageCount());
				if (end <= folder.getMessageCount()) {
					messages = folder.getMessages(folder.getMessageCount()
							- end + 1, folder.getMessageCount() - start + 1);
				} else {
					messages = folder.getMessages(1, folder.getMessageCount()
							- start + 1);
				}
			}
			List<MailDto> mailDtoList = new ArrayList<MailDto>();
			for (int i = messages.length - 1; i >= 0; i--) {
				Message message = messages[i];
				MailDto dto = new MailDto();
				if (null != message.getSubject()) {
					System.out.println(message.getMessageNumber() + ": "
							+ message.getSubject());
					dto.setSubject(message.getSubject());
				} else {
					//System.out.println(message.getMessageNumber() + ": 无主题");
					dto.setSubject("");
				}
				dto.setId(message.getMessageNumber());
				dto.setSendDate(message.getSentDate());
				if (message.getFrom() != null) {
					if(((InternetAddress[]) message.getFrom()).length>0){
						String sender = ((InternetAddress[]) message.getFrom())[0]
								.getPersonal();
						if(sender!=null){
							dto.setSender(sender);
						}else{
							sender = ((InternetAddress[]) message.getFrom())[0].getAddress();
							dto.setSender(sender);
						}
					}
				}
				dto.setTo(MailUtil.getTOAddress(message));
				dto.setBcc(MailUtil.getBCCAddress(message));
				dto.setCc(MailUtil.getCCAddress(message));
				dto.setContainAttach(MailUtil.isContainAttach(message));
				if (message.getHeader("X-Priority") != null) {
					dto.setLevel(Integer.parseInt((message
							.getHeader("X-Priority")[0]).substring(0, 1)));
				} else {
					dto.setLevel(5);
				}
				dto.setReaded(message.getFlags().contains(Flag.SEEN));
				mailDtoList.add(dto);
			}
			folder.close(true);
			store.close();
			return Result.value(mailDtoList);
		} catch (javax.mail.AuthenticationFailedException e){
			e.printStackTrace();
			return Result.failure("用户名与密码不匹配");
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure("邮箱连接失败");
		}
	}

	public static Result<List<MailDto>> searchMail(String host, String user,
			String pass, String subject, String content, String mailFrom,
			String mailTo,String folderName) {
		Properties properties = new Properties();
		properties.put("mail.smtp.auth", "true");
		try {
			Session session = Session.getDefaultInstance(properties, null);
			Store store = session.getStore("imap");
			store.connect(host, user, pass);
			Folder folder = store.getFolder(folderName);
			try {
				folder.open(Folder.READ_WRITE);
			} catch (Exception e) {
				folder.open(Folder.READ_ONLY);
			}
			Message[] messages = null;
			ArrayList list = new ArrayList();
			SubjectTerm subjectTerm = null;
			if (subject != null && subject.length() > 0) {
				subjectTerm = new SubjectTerm(subject);
				list.add(subjectTerm);
			}
			BodyTerm contentTerm = null;
			if (content != null && content.length() > 0) {
				contentTerm = new BodyTerm(content);
				list.add(contentTerm);
			}
			FromStringTerm fromStringTerm = null;
			if(mailFrom !=null && mailFrom.length()>0){
				fromStringTerm = new FromStringTerm(mailFrom);
				list.add(fromStringTerm);
			}
			SearchTerm recipientTerm = null;
			if(mailTo !=null && mailTo.length()>0){
				recipientTerm = new RecipientTerm(Message.RecipientType.TO, new InternetAddress(mailTo));
				list.add(recipientTerm);
			}
			if(list.size()>0){
				SearchTerm[] sterms = new SearchTerm[list.size()];
				for (int i = 0; i < sterms.length; i++) {
                	sterms[i] = (SearchTerm) list.get(i);
				}
				messages = folder.search(new AndTerm(sterms));
			}
			
			List<MailDto> mailDtoList = new ArrayList<MailDto>();
			for (int i = messages.length - 1; i >= 0; i--) {
				Message message = messages[i];
				MailDto dto = new MailDto();
				if (message.getSubject() != null) {
					System.out.println(message.getMessageNumber() + ": "
							+ message.getSubject());
					dto.setSubject(message.getSubject());
				} else {
					//System.out.println(message.getMessageNumber() + ": 无主题");
					dto.setSubject("");
				}
				dto.setId(message.getMessageNumber());
				dto.setSendDate(message.getSentDate());
				if (message.getFrom() != null) {
					String sender = ((InternetAddress[]) message.getFrom())[0]
							.getPersonal();
					if(sender!=null){
						dto.setSender(sender);
					}else{
						sender = ((InternetAddress[]) message.getFrom())[0].getAddress();
						dto.setSender(sender);
					}

				}
				dto.setTo(MailUtil.getTOAddress(message));
				dto.setBcc(MailUtil.getBCCAddress(message));
				dto.setCc(MailUtil.getCCAddress(message));
				dto.setContainAttach(MailUtil.isContainAttach(message));
				if (message.getHeader("X-Priority") != null) {
					dto.setLevel(Integer.parseInt((message
							.getHeader("X-Priority")[0]).substring(0, 1)));
				} else {
					dto.setLevel(5);
				}
				dto.setReaded(message.getFlags().contains(Flag.SEEN));
				mailDtoList.add(dto);
			}
			folder.close(true);
			store.close();
			return Result.value(mailDtoList);
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure("邮箱连接失败");
		}
	}
	
	public static Result<Integer[]> mailNums(
			String host, String user,String pass, 
			String protocol,String folderName) {
		Properties properties = new Properties();
		properties.put("mail.smtp.auth", "true");
		Integer[] nums = new Integer[3];
		Folder folder = null;
		Store store = null;
		try {
			Session session = Session.getDefaultInstance(properties, null);
			store = session.getStore(protocol);
			store.connect(host, user, pass);
			folder = store.getFolder(folderName);
			try {
				folder.open(Folder.READ_WRITE);
			} catch (Exception e) {
				folder.open(Folder.READ_ONLY);
			}
			nums[0] = folder.getMessageCount();
			nums[1] = folder.getUnreadMessageCount();
			nums[2] = folder.getNewMessageCount();
			folder.close(true);
			store.close();
			return Result.value(nums);
		} catch (javax.mail.AuthenticationFailedException e){
			e.printStackTrace();
			return Result.failure("用户名与密码不匹配");
		} catch (Exception e) {
			e.printStackTrace();
			return Result.failure("邮箱连接失败");
		}
	}
}


/**
 * SMTP认证
 */
class MyAuthenticator extends Authenticator {
	String username = null;
	String password = null;

	public MyAuthenticator(String username, String password) {
		this.username = username;
		this.password = password;
	}

	public PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication(this.username, this.password);
	}
}

/*class JSubjectTerm extends StringTerm{
    
    public JSubjectTerm(String pattern){
          super(pattern);
    }

     (non-Javadoc)
     * 核心： 主要的就是扩展SearchTerm的match(Message message) 方法
     * @see javax.mail.search.SearchTerm#match(javax.mail.Message)
     
    public boolean match(Message message){
          String subject = "";
      //以下使用自定义的类MimeMessageParser类来实现对MimeMessage的解析
      //来获得特定邮件的主题
          MimeMessageParser mmp = MimeMessageParser.getMessageParser((MimeMessage)message);
          try{
            //调用MimeMessageParser类的getSubject()方法来获得邮件的主题
                subject = mmp.getSubject();    
          }catch(Exception ex){
                //ignore exception
                return false;
          }
          if(subject == null) return false;
          return super.match(subject);
    }
    
    //注意一定要覆写StringTerm的equals(Object object)方法，具体理由请参看Effective Java
    public boolean equals(Object obj) {
          if (! (obj instanceof JSubjectTerm)) {
                return false;
          }
          return super.equals(obj);
    }
}*/