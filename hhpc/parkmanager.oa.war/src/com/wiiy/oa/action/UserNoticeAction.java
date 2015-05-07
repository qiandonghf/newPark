package com.wiiy.oa.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.oa.entity.UserNotice;
import com.wiiy.oa.service.UserNoticeService;

/**
 * @author my
 */
public class UserNoticeAction extends JqGridBaseAction<UserNotice>{
	
	private UserNoticeService userNoticeService;
	private Result result;
	private UserNotice userNotice;
	private Long id;
	private String ids;
	
	
	public String save(){
		result = userNoticeService.save(userNotice);
		return JSON;
	}
	
	public String view(){
		result = userNoticeService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = userNoticeService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		UserNotice dbBean = userNoticeService.getBeanById(userNotice.getId()).getValue();
		BeanUtil.copyProperties(userNotice, dbBean);
		result = userNoticeService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = userNoticeService.deleteById(id);
		} else if(ids!=null){
			result = userNoticeService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(UserNotice.class));
	}
	
	@Override
	protected List<UserNotice> getListByFilter(Filter fitler) {
		return userNoticeService.getListByFilter(fitler).getValue();
	}
	
	
	public UserNotice getUserNotice() {
		return userNotice;
	}

	public void setUserNotice(UserNotice userNotice) {
		this.userNotice = userNotice;
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

	public void setUserNoticeService(UserNoticeService userNoticeService) {
		this.userNoticeService = userNoticeService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
