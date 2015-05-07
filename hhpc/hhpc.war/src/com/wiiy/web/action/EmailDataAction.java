package com.wiiy.web.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.web.entity.EmailData;
import com.wiiy.web.service.EmailDataService;

/**
 * @author my
 */
public class EmailDataAction extends JqGridBaseAction<EmailData>{
	
	private EmailDataService emailDataService;
	private Result result;
	private EmailData emailData;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = emailDataService.save(emailData);
		return JSON;
	}
	
	public String view(){
		result = emailDataService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = emailDataService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		EmailData dbBean = emailDataService.getBeanById(emailData.getId()).getValue();
		BeanUtil.copyProperties(emailData, dbBean);
		result = emailDataService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = emailDataService.deleteById(id);
		} else if(ids!=null){
			result = emailDataService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(EmailData.class));
	}
	
	@Override
	protected List<EmailData> getListByFilter(Filter fitler) {
		return emailDataService.getListByFilter(fitler).getValue();
	}
	
	
	public EmailData getEmailData() {
		return emailData;
	}

	public void setEmailData(EmailData emailData) {
		this.emailData = emailData;
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

	public void setEmailDataService(EmailDataService emailDataService) {
		this.emailDataService = emailDataService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
