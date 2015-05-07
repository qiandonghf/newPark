package com.wiiy.core.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.User;

/**
 * <br/>class-description 邮箱配置
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class UserEmailParam extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 用户
	 */
	@FieldDescription("用户")
	private User user;
	/**
	 * 邮箱帐号
	 */
	@FieldDescription("邮箱帐号")
	private String email;
	/**
	 * 密码
	 */
	@FieldDescription("密码")
	private String passwd;
	/**
	 * 昵称
	 */
	@FieldDescription("昵称")
	private String nickName;
	/**
	 * POP3服务器
	 */
	@FieldDescription("POP3服务器")
	private String pop3;
	/**
	 * SMTP服务器
	 */
	@FieldDescription("SMTP服务器")
	private String smtp;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 用户
	 */
	public User getUser(){
		return user;
	}
	public void setUser(User user){
		this.user = user;
	}
	/**
	 * 邮箱帐号
	 */
	public String getEmail(){
		return email;
	}
	public void setEmail(String email){
		this.email = email;
	}
	/**
	 * 密码
	 */
	public String getPasswd(){
		return passwd;
	}
	public void setPasswd(String passwd){
		this.passwd = passwd;
	}
	/**
	 * 昵称
	 */
	public String getNickName(){
		return nickName;
	}
	public void setNickName(String nickName){
		this.nickName = nickName;
	}
	/**
	 * POP3服务器
	 */
	public String getPop3(){
		return pop3;
	}
	public void setPop3(String pop3){
		this.pop3 = pop3;
	}
	/**
	 * SMTP服务器
	 */
	public String getSmtp(){
		return smtp;
	}
	public void setSmtp(String smtp){
		this.smtp = smtp;
	}
}