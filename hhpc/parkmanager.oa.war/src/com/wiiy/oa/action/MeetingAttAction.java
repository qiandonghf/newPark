package com.wiiy.oa.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.oa.entity.MeetingAtt;
import com.wiiy.oa.service.MeetingAttService;

/**
 * @author my
 */
public class MeetingAttAction extends JqGridBaseAction<MeetingAtt>{
	
	private MeetingAttService meetingAttService;
	private Result result;
	private MeetingAtt meetingAtt;
	private Long id;
	private String ids;
	
	private String attAddress;
	
	public String save(){
		result = meetingAttService.save(meetingAtt,attAddress);
		return JSON;
	}
	
	public String view(){
		result = meetingAttService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = meetingAttService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		MeetingAtt dbBean = meetingAttService.getBeanById(meetingAtt.getId()).getValue();
		BeanUtil.copyProperties(meetingAtt, dbBean);
		result = meetingAttService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = meetingAttService.deleteById(id);
		} else if(ids!=null){
			result = meetingAttService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		Filter filter = new Filter(MeetingAtt.class);
		filter.createAlias("meeting","meeting");
		return refresh(filter);
	}
	
	@Override
	protected List<MeetingAtt> getListByFilter(Filter fitler) {
		return meetingAttService.getListByFilter(fitler).getValue();
	}
	
	
	public MeetingAtt getMeetingAtt() {
		return meetingAtt;
	}

	public void setMeetingAtt(MeetingAtt meetingAtt) {
		this.meetingAtt = meetingAtt;
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

	public void setMeetingAttService(MeetingAttService meetingAttService) {
		this.meetingAttService = meetingAttService;
	}
	
	public Result getResult() {
		return result;
	}
	public String getAttAddress() {
		return attAddress;
	}

	public void setAttAddress(String attAddress) {
		this.attAddress = attAddress;
	}
}
