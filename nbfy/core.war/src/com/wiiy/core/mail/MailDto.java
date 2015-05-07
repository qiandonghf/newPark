package com.wiiy.core.mail;

import java.util.ArrayList;

import com.wiiy.external.service.dto.EmailAttDto;
import com.wiiy.external.service.dto.EmailDto;


public class MailDto extends EmailDto{
	
	private String to;//接收人
	private String cc;//抄送人
	private String bcc;//密送
	private Boolean readed;//状态
	private Integer level;//优先级
	
	public void setId(int id){
		setId((long)id);
	}
	
	public void addAtt(EmailAttDto att){
		emailAttDtoList.add(att);
	}
	
	public MailDto() {
		emailAttDtoList = new ArrayList<EmailAttDto>();
	}
	
	public String getTo() {
		return to;
	}
	public void setTo(String to) {
		this.to = to;
	}
	public String getCc() {
		return cc;
	}
	public void setCc(String cc) {
		this.cc = cc;
	}
	public String getBcc() {
		return bcc;
	}
	public void setBcc(String bcc) {
		this.bcc = bcc;
	}
	public Boolean getReaded() {
		return readed;
	}
	public void setReaded(Boolean readed) {
		this.readed = readed;
	}
	public Integer getLevel() {
		return level;
	}
	public void setLevel(Integer level) {
		this.level = level;
	}

}
