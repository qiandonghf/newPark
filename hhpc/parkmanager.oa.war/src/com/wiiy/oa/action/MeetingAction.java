package com.wiiy.oa.action;

import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.Meeting;
import com.wiiy.oa.entity.MeetingAtt;
import com.wiiy.oa.service.MeetingAttService;
import com.wiiy.oa.service.MeetingService;

/**
 * @author my
 */
public class MeetingAction extends JqGridBaseAction<Meeting>{
	
	private MeetingService meetingService;
	private MeetingAttService meetingAttService;
	
	private Result result;
	private Meeting meeting;
	private Long id;
	private String ids;
	
	private String attAddress;
	private String attNames;
	private String attSizes;
	private String attPaths;
	
	
	public String save(){
		result = meetingService.save(meeting);
		return JSON;
	}
	
	public String view(){
		attNames = "";
		attSizes = "";
		attPaths = "";
		List<MeetingAtt> list = meetingAttService.getListByFilter(new Filter(MeetingAtt.class).eq("meetingId", id)).getValue();
		for (MeetingAtt meetingAtt : list) {
			attNames += meetingAtt.getName()+",";
			attSizes += meetingAtt.getSize()+",";
			attPaths += meetingAtt.getNewName()+",";
		}
		if(attNames.length()>0){
			attNames = attNames.substring(0, attNames.length()-1);
			attSizes = attSizes.substring(0, attSizes.length()-1);
			attPaths = attPaths.substring(0, attPaths.length()-1);
		}
		result = meetingService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		attNames = "";
		attSizes = "";
		attPaths = "";
		List<MeetingAtt> list = meetingAttService.getListByFilter(new Filter(MeetingAtt.class).eq("meetingId", id)).getValue();
		for (MeetingAtt meetingAtt : list) {
			attNames += meetingAtt.getName()+",";
			attSizes += meetingAtt.getSize()+",";
			attPaths += meetingAtt.getNewName()+",";
		}
		if(attNames.length()>0){
			attNames = attNames.substring(0, attNames.length()-1);
			attSizes = attSizes.substring(0, attSizes.length()-1);
			attPaths = attPaths.substring(0, attPaths.length()-1);
		}
		result = meetingService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		Meeting dbBean = meetingService.getBeanById(meeting.getId()).getValue();
		BeanUtil.copyProperties(meeting, dbBean);
		result = meetingService.update(dbBean,attAddress);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = meetingService.deleteById(id);
		} else if(ids!=null){
			result = meetingService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(Meeting.class));
	}
	
	@Override
	protected List<Meeting> getListByFilter(Filter fitler) {
		return meetingService.getListByFilter(fitler).getValue();
	}
	
	
	public Meeting getMeeting() {
		return meeting;
	}

	public void setMeeting(Meeting meeting) {
		this.meeting = meeting;
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

	public void setMeetingService(MeetingService meetingService) {
		this.meetingService = meetingService;
	}
	
	public Result getResult() {
		return result;
	}
	public String getAttNames() {
		return attNames;
	}

	public void setAttNames(String attNames) {
		this.attNames = attNames;
	}

	public String getAttSizes() {
		return attSizes;
	}

	public void setAttSizes(String attSizes) {
		this.attSizes = attSizes;
	}

	public String getAttPaths() {
		return attPaths;
	}

	public void setAttPaths(String attPaths) {
		this.attPaths = attPaths;
	}

	public void setMeetingAttService(MeetingAttService meetingAttService) {
		this.meetingAttService = meetingAttService;
	}
	public String getAttAddress() {
		return attAddress;
	}

	public void setAttAddress(String attAddress) {
		this.attAddress = attAddress;
	}

}
