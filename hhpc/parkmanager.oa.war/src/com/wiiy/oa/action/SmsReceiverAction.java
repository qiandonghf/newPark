package com.wiiy.oa.action;

import java.util.List;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.entity.Sms;
import com.wiiy.oa.entity.SmsReceiver;
import com.wiiy.oa.service.SmsReceiverService;
import com.wiiy.oa.service.SmsService;

/**
 * @author my
 */
public class SmsReceiverAction extends JqGridBaseAction<SmsReceiver>{
	
	private SmsReceiverService smsReceiverService;
	private Result result;
	private SmsReceiver smsReceiver;
	private SmsService smsService;
	private Sms sms;
	private Long id;
	private String ids;
	private String type;
	
	public String saveSms(){
		String smsSign = ServletActionContext.getRequest().getParameter("smsSign");
		sms.setContent(sms.getContent()+smsSign);
		result  = smsService.save(sms,smsReceiver.getReceiverName());
		return JSON;
	}
	
	public String save(){
		result = smsReceiverService.save(smsReceiver);
		return JSON;
	}
	
	public String view(){
		result = smsReceiverService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = smsReceiverService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		SmsReceiver dbBean = smsReceiverService.getBeanById(smsReceiver.getId()).getValue();
		BeanUtil.copyProperties(smsReceiver, dbBean);
		result = smsReceiverService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = smsReceiverService.deleteById(id);
		} else if(ids!=null){
			result = smsReceiverService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String listBySmsId(){
		Filter filter = new Filter(SmsReceiver.class).eq("creatorId", OaActivator.getSessionUser().getId());
		filter.createAlias("sms", "sms");
		if(type.equals("send")){
			filter.eq("sms.sended",BooleanEnum.YES);
		}else{
			filter.eq("sms.sended",BooleanEnum.NO);
		}
		return refresh(filter);
	}
	
	public String list(){
		return refresh(new Filter(SmsReceiver.class));
	}
	
	@Override
	protected List<SmsReceiver> getListByFilter(Filter fitler) {
		return smsReceiverService.getListByFilter(fitler).getValue();
	}
	
	
	public SmsReceiver getSmsReceiver() {
		return smsReceiver;
	}

	public void setSmsReceiver(SmsReceiver smsReceiver) {
		this.smsReceiver = smsReceiver;
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

	public void setSmsReceiverService(SmsReceiverService smsReceiverService) {
		this.smsReceiverService = smsReceiverService;
	}
	
	public Result getResult() {
		return result;
	}
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	public Sms getSms() {
		return sms;
	}

	public void setSms(Sms sms) {
		this.sms = sms;
	}

	public void setSmsService(SmsService smsService) {
		this.smsService = smsService;
	}
}
