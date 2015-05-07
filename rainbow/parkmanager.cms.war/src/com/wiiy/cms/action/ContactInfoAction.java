package com.wiiy.cms.action;

import java.util.List;
import com.wiiy.cms.entity.ContactInfo;
import com.wiiy.cms.entity.WaterMark;
import com.wiiy.cms.service.ContactInfoService;
import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

public class ContactInfoAction extends JqGridBaseAction<ContactInfo>{
	private ContactInfoService contactInfoService;
	private ContactInfo contactInfo;
	private Long id;
	private String ids;
	private Result result;

	public String list(){
		Filter filter = new Filter(ContactInfo.class);		
		return refresh(filter);
	}
	
	public String save(){
		result = contactInfoService.save(contactInfo);
		return JSON;
	}
	
	public String show() {
		List<ContactInfo> list = contactInfoService.getList().getValue();
		if (list != null && list.size() > 0) {
			result = Result.value(list.get(0));
		}
		return "show";
	}
	
	public String edit(){
		result = contactInfoService.getBeanById(id);
		return EDIT;
	}
	
	public String delete(){
		if(id!=null){
			result = contactInfoService.deleteById(id);
		}else if(ids!=null){
			result = contactInfoService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String update(){
		ContactInfo dbBean = contactInfoService.getBeanById(contactInfo.getId()).getValue();
		BeanUtil.copyProperties(contactInfo, dbBean);
		result = contactInfoService.update(dbBean);
		return JSON;
	}
	
	@Override
	protected List<ContactInfo> getListByFilter(Filter fitler) {
		return contactInfoService.getListByFilter(fitler).getValue();
	}
	
	public ContactInfo getContactInfo() {
		return contactInfo;
	}
	public void setContactInfo(ContactInfo contactInfo) {
		this.contactInfo = contactInfo;
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
	public Result getResult() {
		return result;
	}
	public void setResult(Result result) {
		this.result = result;
	}
	public void setContactInfoService(ContactInfoService contactInfoService) {
		this.contactInfoService = contactInfoService;
	}

}
