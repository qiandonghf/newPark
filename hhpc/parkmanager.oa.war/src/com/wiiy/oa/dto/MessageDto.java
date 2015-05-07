package com.wiiy.oa.dto;

import java.util.Date;
import java.util.List;


public class MessageDto {
	private int msgNo;
	private String msgUID;
	private String mailFrom;
	private String mailTo;
	private String mailCc;
	private String mailBcc;
	private Date receivedDate;
	private String context;
	private String subject;
	private Date sendDate;
	private List<AttDto> atts;
	private int attNo = 0;
	
	public int getMsgNo() {
		return msgNo;
	}
	public void setMsgNo(int msgNo) {
		this.msgNo = msgNo;
	}
	public int getAttNo() {
		return attNo;
	}
	public void setAttNo(int attNo) {
		this.attNo = attNo;
	}
	public String getMailFrom() {
		return mailFrom;
	}
	public void setMailFrom(String mailFrom) {
		this.mailFrom = mailFrom;
	}
	public String getMailTo() {
		return mailTo;
	}
	public void setMailTo(String mailTo) {
		this.mailTo = mailTo;
	}
	public Date getReceivedDate() {
		return receivedDate;
	}
	public void setReceivedDate(Date receivedDate) {
		this.receivedDate = receivedDate;
	}
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getMailCc() {
		return mailCc;
	}
	public void setMailCc(String mailCc) {
		this.mailCc = mailCc;
	}
	public List<AttDto> getAtts() {
		return atts;
	}
	public void setAtts(List<AttDto> atts) {
		this.atts = atts;
	}
	public Date getSendDate() {
		return sendDate;
	}
	public void setSendDate(Date sendDate) {
		this.sendDate = sendDate;
	}
	public String getMailBcc() {
		return mailBcc;
	}
	public void setMailBcc(String mailBcc) {
		this.mailBcc = mailBcc;
	}
	public String getMsgUID() {
		return msgUID;
	}
	public void setMsgUID(String msgUID) {
		this.msgUID = msgUID;
	}
}