package com.wiiy.core.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.core.entity.ContactAtt;
import com.wiiy.core.service.ContactAttService;

/**
 * @author my
 */
public class ContactAttAction extends JqGridBaseAction<ContactAtt>{
	
	private ContactAttService contactAttService;
	private Result result;
	private ContactAtt contactAtt;
	private Long id;
	private String ids;
	private String imgPath;
	
	public String attImage(){
		return "attImage";
	}
	
	public String save(){
		result = contactAttService.save(contactAtt);
		return JSON;
	}
	
	public String view(){
		result = contactAttService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = contactAttService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		ContactAtt dbBean = contactAttService.getBeanById(contactAtt.getId()).getValue();
		BeanUtil.copyProperties(contactAtt, dbBean);
		result = contactAttService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = contactAttService.deleteById(id);
		} else if(ids!=null){
			result = contactAttService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(ContactAtt.class));
	}
	
	@Override
	protected List<ContactAtt> getListByFilter(Filter fitler) {
		return contactAttService.getListByFilter(fitler).getValue();
	}
	
	
	public ContactAtt getContactAtt() {
		return contactAtt;
	}

	public void setContactAtt(ContactAtt contactAtt) {
		this.contactAtt = contactAtt;
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

	public void setContactAttService(ContactAttService contactAttService) {
		this.contactAttService = contactAttService;
	}
	
	public Result getResult() {
		return result;
	}

	public String getImgPath() {
		return imgPath;
	}

	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}

}
