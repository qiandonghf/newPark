package com.wiiy.core.mail;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Part;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

/**
 * 邮件发送类
 * 
 * @author Administrator
 * 
 */
public class MailUtil {

	public static final String HOST = "mail.teco-tech.com";
	public static final String USER = "aswan@teco-tech.com";
	public static final String PASS = "a123456";

	/**
	 * 邮件是否包含附件
	 * 
	 * @param part
	 * @return
	 * @throws Exception
	 */
	public static boolean isContainAttach(Part part) throws Exception {
		boolean attachflag = false;
		//System.out.println(part.getContentType());
		if (part.isMimeType("multipart/*")) {
			// 如果邮件体包含多部分
			Multipart mp = (Multipart) part.getContent();
			// 遍历每部分
			for (int i = 0; i < mp.getCount(); i++) {
				// 获得每部分的主体
				BodyPart bodyPart = mp.getBodyPart(i);
				String disposition = bodyPart.getDisposition();
				if ((disposition != null)
						&& ((disposition.equals(Part.ATTACHMENT))/* || (disposition
								.equals(Part.INLINE))*/)) {
					attachflag = true;
				} else if (bodyPart.isMimeType("multipart/*")) {
					attachflag = isContainAttach((Part) bodyPart);
				} else {
					String contype = bodyPart.getContentType();
					if (contype.toLowerCase().indexOf("application") != -1) {
						attachflag = true;
					}
					if (contype.toLowerCase().indexOf("name") != -1 && (contype.toUpperCase().indexOf("IMAGE/JPEG"))==-1) {
						attachflag = true;
					}
				}
			}
		} else if (part.isMimeType("message/rfc822")) {
			attachflag = isContainAttach((Part) part.getContent());
		}
		return attachflag;
	}

	/**
	 * 邮件群发
	 * 
	 * @param receiver
	 *            接收地址
	 * @param content
	 *            发送内容
	 * @throws Exception
	 */
	public static void send(String[] receivers, String content, String subject)
			throws Exception {
		Properties properties = new Properties();
		properties.put("mail.smtp.auth", "true");
		// 获得邮件会话对象
		Session session = Session.getDefaultInstance(properties, null);
		// 调试模式 可以在发送邮件的过程中在控制台显示过程信息
		session.setDebug(true);

		Message message = new MimeMessage(session);
		message.setSubject(subject);
		message.setFrom(new InternetAddress(USER));
		// RecipientType "to"-->收件人,"cc"-->抄送人地址,"bcc"-->密送地址
		for (String receiver : receivers) {
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(
					receiver));
		}
		message.setSentDate(new Date());// 发送日期

		Multipart multipart = new MimeMultipart("related");

		BodyPart bodyPart = new MimeBodyPart();
		bodyPart.setDataHandler(new DataHandler(content,
				"text/html;charset=utf-8"));// 网页格式

		multipart.addBodyPart(bodyPart);
		message.setContent(multipart);

		// 发送邮件
		message.saveChanges(); // implicit with send()
		Transport transport = session.getTransport("smtp");
		transport.connect(HOST, USER, PASS);
		transport.sendMessage(message, message.getAllRecipients());
		transport.close();
	}

	/**
	 * 发送HTML邮件
	 * 
	 * @param receiver
	 *            接收地址
	 * @param content
	 *            发送内容
	 * @throws Exception
	 */
	public static void sendHTMLMail(String receiver, String subject,
			String content) throws Exception {
		Properties properties = new Properties();
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.host", HOST);
		Session session = Session.getDefaultInstance(properties,
				new SmtpAuthenticator(USER, PASS));
		session.setDebug(true);

		Message message = new MimeMessage(session);
		message.setSubject(subject);
		message.setFrom(new InternetAddress(USER));
		// RecipientType "TO"-->收件人,"CC"-->抄送人地址,"BCC"-->密送地址
		message.setRecipient(Message.RecipientType.TO, new InternetAddress(
				receiver));
		message.setSentDate(new Date());// 发送日期

		Multipart multipart = new MimeMultipart("related");

		BodyPart bodyPart = new MimeBodyPart();
		bodyPart.setDataHandler(new DataHandler(content,
				"text/html;charset=utf-8"));// 网页格式
		multipart.addBodyPart(bodyPart);

		message.setContent(multipart);

		// 发送邮件
		Transport.send(message);
	}

	/**
	 * 发送HTML附件邮件
	 * 
	 * @param receiver
	 *            接收地址
	 * @param content
	 *            发送内容
	 * @throws Exception
	 */
	public static void sendHTMLMailAtt(String receiver, String subject,
			String content) throws Exception {
		Properties properties = new Properties();
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.host", HOST);
		Session session = Session.getDefaultInstance(properties,
				new SmtpAuthenticator(USER, PASS));
		session.setDebug(true);

		Message message = new MimeMessage(session);
		message.setSubject(subject);
		message.setFrom(new InternetAddress(USER));
		// RecipientType "TO"-->收件人,"CC"-->抄送人地址,"BCC"-->密送地址
		message.setRecipient(Message.RecipientType.TO, new InternetAddress(
				receiver));
		message.setSentDate(new Date());// 发送日期

		Multipart multipart = new MimeMultipart("related");

		BodyPart bodyPart = new MimeBodyPart();
		bodyPart.setDataHandler(new DataHandler(content,
				"text/html;charset=utf-8"));// 网页格式
		multipart.addBodyPart(bodyPart);

		BodyPart attPart = new MimeBodyPart();
		attPart.setDataHandler(new DataHandler(new FileDataSource(new File(""))));
		multipart.addBodyPart(attPart);

		message.setContent(multipart);

		// 发送邮件
		Transport.send(message);
	}

	/**
	 * 发送文本邮件
	 * 
	 * @param receiver
	 *            接收地址
	 * @param content
	 *            发送内容
	 * @throws Exception
	 */
	public static void sendTextMail(String receiver, String subject,
			String content) throws Exception {
		Properties properties = new Properties();
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.host", HOST);
		Session session = Session.getDefaultInstance(properties,
				new SmtpAuthenticator(USER, PASS));
		session.setDebug(true);
		Message message = new MimeMessage(session);
		message.setFrom(new InternetAddress(USER));
		message.setRecipient(Message.RecipientType.TO, new InternetAddress(
				receiver));
		message.setSentDate(new Date());
		message.setSubject(subject);
		message.setText(content);
		Transport.send(message);
	}

	/**
	 * 发送文本邮件
	 * 
	 * @param receiver
	 *            接收地址
	 * @param content
	 *            发送内容
	 * @throws Exception
	 */
	public static void sendTextMail(String receiver, String subject,
			String content, Date sendDate) throws Exception {
		Properties properties = new Properties();
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.host", HOST);
		Session session = Session.getDefaultInstance(properties,
				new SmtpAuthenticator(USER, PASS));
		session.setDebug(true);
		Message message = new MimeMessage(session);
		message.setFrom(new InternetAddress(USER));
		message.setRecipient(Message.RecipientType.TO, new InternetAddress(
				receiver));
		message.setSentDate(new Date());
		message.setSubject(subject);
		message.setText(content);
		Transport.send(message);
	}

	/**
	 * * 获取发送邮件者信息
	 * 
	 * @return
	 * @throws MessagingException
	 */
	public static String getFrom(Message msg) throws MessagingException {
		InternetAddress[] address = (InternetAddress[]) msg.getFrom();
		String from = address[0].getAddress();
		if (from == null) {
			from = "";
		}
		String personal = address[0].getPersonal();
		if (personal == null) {
			personal = "";
		}
		String fromaddr = "<span>" + personal + "</span>&lt;" + from + "&gt;";
		return fromaddr;
	}

	/**  
     * 处理邮件内容  
     */  
	public static String getContent(Part part) throws Exception {   
        if (part.isMimeType("text/plain")) {   
            return (String) part.getContent();   
        } else if (part.isMimeType("text/html")) {   
            return (String) part.getContent();   
        } else if (part.isMimeType("multipart/*")) {   
            Multipart multipart = (Multipart) part.getContent();   
            return getContent(multipart.getBodyPart(0));   
        } else if (part.isMimeType("message/rfc822")) {   
            return getContent((Part) part.getContent());   
        }   
        return "";   
    }   

	/** * 获取邮件正文内容 * @return 
	 * @throws IOException 
	 * @throws MessagingException */
	public static String getBodyText(Part part) throws MessagingException, IOException {
		StringBuffer bodytext = new StringBuffer();
		String contentType=part.getContentType();
        if(contentType.toLowerCase().startsWith("text/plain")){
        	getMailContent(part,bodytext,true);
        }else {
        	getMailContent(part,bodytext,false);
        }
        if(bodytext.toString().equals("")){
			getMailContent(part,bodytext,true);
		}
		return bodytext.toString();
	}

	/**
	 * * 解析邮件，将得到的邮件内容保存到一个stringBuffer对象中，解析邮件 主要根据MimeType的不同执行不同的操作，一步一步的解析 * @param
	 * part * @throws MessagingException * @throws IOException
	 */
	public static void getMailContent(Part part,StringBuffer bodytext,boolean flag) throws MessagingException,
			IOException {
		String contentType = part.getContentType();
		int nameindex = contentType.indexOf("name");
		boolean conname = false;
		if (nameindex != -1) {
			conname = true;
		}
		//System.out.println("CONTENTTYPE:" + contentType);
		if (part.isMimeType("text/plain") && !conname && flag) {
			String content = (String) part.getContent();
			if(contentType.contains("US-ASCII")){
				content = new String(content.getBytes("iso-8859-1"),"gb2312");
			}
			if(!content.contains("<HTML>")){
				String text = "";
				while(content.contains("\r\n")){
					 int length = content.length();
					 text += content.substring(0, content.indexOf("\r\n"))+"<br/>";
					 content = content.substring(content.indexOf("\r\n") + 2, length);
				}
				text += content;
				bodytext.append(text);
			}else{
				bodytext.append(content);
			}
			flag = false;
		} else if (part.isMimeType("text/html") && !conname && flag==false) {
			bodytext.append((String) part.getContent());
		} else if (part.isMimeType("multipart/*")) {
			Multipart multipart = (Multipart) part.getContent();
			int count = multipart.getCount();
			for (int i = 0; i < count; i++) {
				getMailContent(multipart.getBodyPart(i),bodytext,flag);
			}
		} else if (part.isMimeType("message/rfc822")) {
			getMailContent((Part) part.getContent(),bodytext,flag);
		}
	}

	/**
	 * 获得邮件的收件人，抄送，和密送的地址和姓名，根据所传递的参数的不同 "to"----收件人 "cc"---抄送人地址 "bcc"---密送人地址
	 */
	public static String getTOAddress(Message message) throws Exception {
		return getMailAddress("TO", message);
	}

	/**
	 * 获得邮件的收件人，抄送，和密送的地址和姓名，---抄送人地址
	 */
	public static String getCCAddress(Message message) throws Exception {
		return getMailAddress("CC", message);
	}

	/**
	 * 获得邮件的收件人，抄送，和密送的地址和姓名，---密送人地址
	 */
	public static String getBCCAddress(Message message) throws Exception {
		return getMailAddress("BCC", message);
	}

	/**
	 * 获得邮件地址
	 * 
	 * @param type
	 *            类型，如收件人、抄送人、密送人
	 * @param mimeMessage
	 *            邮件消息
	 * @return
	 * @throws Exception
	 */
	public static String getMailAddress(String type, Message mimeMessage)
			throws Exception {
		String mailaddr = "";
		String addtype = type.toUpperCase();
		InternetAddress[] address = null;
		if (addtype.equals("TO") || addtype.equals("CC")
				|| addtype.equals("BCC")) {
			if (addtype.equals("TO")) {
				address = (InternetAddress[]) mimeMessage
						.getRecipients(Message.RecipientType.TO);
			} else if (addtype.equals("CC")) {
				address = (InternetAddress[]) mimeMessage
						.getRecipients(Message.RecipientType.CC);
			} else {
				address = (InternetAddress[]) mimeMessage
						.getRecipients(Message.RecipientType.BCC);
			}
			if (address != null && address.length>0) {
				for (int i = 0; i < address.length; i++) {
					// 先获取邮件地址
					String email = address[i].getAddress();
					if (email == null) {
						email = "";
					} else {
						email = MimeUtility.decodeText(email);
					}
					// 再取得个人描述信息
					String personal = address[i].getPersonal();
					if (personal == null) {
						personal = "";
					} else {
						personal = MimeUtility.decodeText(personal);
					}
					// 将个人描述信息与邮件地址连起来
					String compositeto = personal + "&lt;" + email + "&gt;";
					// 多个地址时，用逗号分开
					mailaddr += "," + compositeto;
				}
				mailaddr = mailaddr.substring(1);
			}
		} else {
			throw new Exception("错误的地址类型！!");
		}
		return mailaddr;
	}
	

	public static String getCid(Part p) throws MessagingException {
		String cidraw = null, cid = null;
		String[] headers = p.getHeader("Content-id");
		if (headers != null && headers.length > 0) {
			cidraw = headers[0];
		} else {
			return null;
		}
		if (cidraw.startsWith("<") && cidraw.endsWith(">")) {
			cid = "cid:" + cidraw.substring(1, cidraw.length() - 1);
		} else {
			cid = "cid:" + cidraw;
		}
		return cid;

	}

	public static String getFileName(Part part, boolean ascii)
			throws Exception {
		String fileName = part.getFileName();
		if (fileName == null) {
			return null;
		}
		if (ascii) {
			fileName = new String(fileName.getBytes("iso-8859-1"), "gb2312");
		}

		fileName = MimeUtility.decodeText(fileName);

		if (fileName != null) {
			int index = fileName.lastIndexOf("/");
			if (fileName.lastIndexOf("/") != -1) {
				fileName = fileName.substring(index + 1);
			}
		}
		return fileName;
	}

}

/**
 * SMTP认证
 */
class SmtpAuthenticator extends Authenticator {
	String username = null;
	String password = null;

	public SmtpAuthenticator(String username, String password) {
		this.username = username;
		this.password = password;
	}

	public PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication(this.username, this.password);
	}
}