package com.wiiy.cms.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.cms.entity.Mail;
import com.wiiy.cms.service.MailService;

/**
 * @author my
 */
public class MailAction extends JqGridBaseAction<Mail>{
	
	private MailService mailService;
	private Result result;
	private Mail mail;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = mailService.save(mail);
		return JSON;
	}
	
	public String view(){
		result = mailService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = mailService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		Mail dbBean = mailService.getBeanById(mail.getId()).getValue();
		BeanUtil.copyProperties(mail, dbBean);
		result = mailService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = mailService.deleteById(id);
		} else if(ids!=null){
			result = mailService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(Mail.class));
	}
	
	@Override
	protected List<Mail> getListByFilter(Filter fitler) {
		return mailService.getListByFilter(fitler).getValue();
	}
	
	
	public Mail getMail() {
		return mail;
	}

	public void setMail(Mail mail) {
		this.mail = mail;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public void setMailService(MailService mailService) {
		this.mailService = mailService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
