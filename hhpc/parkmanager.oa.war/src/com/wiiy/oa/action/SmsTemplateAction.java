package com.wiiy.oa.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.entity.SmsTemplate;
import com.wiiy.oa.service.SmsTemplateService;

public class SmsTemplateAction extends JqGridBaseAction<SmsTemplate>{
	private SmsTemplateService smsTemplateService;
	private SmsTemplate smsTemplate;
	private Result result;
	private Long id;
	private String ids;
	
	public String loadSmsTemplate(){
		result = smsTemplateService.getListByFilter(new Filter(SmsTemplate.class).eq("creatorId", OaActivator.getSessionUser().getId()));
		return JSON;
	}
	
	public String save(){
		//将要存入表中的数据进行trim()处理
		String smsTemplateName = smsTemplate.getName().trim();
		String smsTemplateContent = smsTemplate.getContent().trim();
		smsTemplate.setName(smsTemplateName);
		smsTemplate.setContent(smsTemplateContent);
		result = smsTemplateService.save(smsTemplate);
		return JSON;
	}
	
	public String edit(){
		result = smsTemplateService.getBeanById(id);
		return EDIT;
	}
	public String view(){
		result = smsTemplateService.getBeanById(id);
		return VIEW;
	}
	
	public String delete(){
		if(id!=null){
			result = smsTemplateService.deleteById(id);
		}else if(ids!=null){
			result = smsTemplateService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String update(){
		//将要存入表中的数据进行trim()处理
		String smsTemplateName = smsTemplate.getName().trim();
		String smsTemplateContent = smsTemplate.getContent().trim();
		smsTemplate.setName(smsTemplateName);
		smsTemplate.setContent(smsTemplateContent);
		
		SmsTemplate dbBean = smsTemplateService.getBeanById(smsTemplate.getId()).getValue();
		BeanUtil.copyProperties(smsTemplate, dbBean);
		result = smsTemplateService.update(dbBean);
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(SmsTemplate.class);		
		return refresh(filter);
	}
	
	@Override
	protected List<SmsTemplate> getListByFilter(Filter fitler) {
		return smsTemplateService.getListByFilter(fitler).getValue();
	}
	
	public SmsTemplate getSmsTemplate() {
		return smsTemplate;
	}

	public void setSmsTemplate(SmsTemplate smsTemplate) {
		this.smsTemplate = smsTemplate;
	}

	public Result getResult() {
		return result;
	}

	public void setResult(Result result) {
		this.result = result;
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

	public void setSmsTemplateService(SmsTemplateService smsTemplateService) {
		this.smsTemplateService = smsTemplateService;
	}
}
