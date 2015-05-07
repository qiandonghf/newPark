package com.wiiy.oa.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.LinkedHashMap;
import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.POIUtil;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.oa.entity.Archives;
import com.wiiy.oa.entity.MeetingRoomRent;
import com.wiiy.oa.service.MeetingRoomRentService;

/**
 * @author my
 */
public class MeetingRoomRentAction extends JqGridBaseAction<MeetingRoomRent>{
	
	private MeetingRoomRentService meetingRoomRentService;
	private Result result;
	private MeetingRoomRent meetingRoomRent;
	private Long id;
	private String ids;
	private String excelName;
	private InputStream inputStream;
	private String columns;

	public String save(){
		result = meetingRoomRentService.save(meetingRoomRent);
		return JSON;
	}
	
	public String view(){
		result = meetingRoomRentService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = meetingRoomRentService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		MeetingRoomRent dbBean = meetingRoomRentService.getBeanById(meetingRoomRent.getId()).getValue();
		BeanUtil.copyProperties(meetingRoomRent, dbBean);
		result = meetingRoomRentService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = meetingRoomRentService.deleteById(id);
		} else if(ids!=null){
			result = meetingRoomRentService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(MeetingRoomRent.class));
	}
	
	public String export() throws UnsupportedEncodingException{
		Filter filter = new Filter(MeetingRoomRent.class);
		page=0;//不要分页
		refresh(filter);
		excelName = StringUtil.URLEncoderToUTF8("会议室借用审批单列表")+".xls";
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		POIUtil.export("会议室借用审批单列表",generateExportColumns(columns),root,out,"yyyy-MM-dd HH:mm");
		inputStream = new ByteArrayInputStream(out.toByteArray());
		return "export";
	}
	private LinkedHashMap<String, String> generateExportColumns(String columns){
		LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();
		columns = columns.replace("{", "");
		columns = columns.replace("}", "");
		String[] properties = columns.split(",");
		for (String string : properties) {
			String[] ss = string.split(":");
			String field = ss[0].replace("\"", "");
			String description = ss[1].replace("\"", "");
			map.put(field, description);
		}
		return map;
	}
	public void setColumns(String columns) {
		this.columns = columns;
	}
	public InputStream getInputStream() {
		return inputStream;
	}

	public String getExcelName() {
		return excelName;
	}

	@Override
	protected List<MeetingRoomRent> getListByFilter(Filter fitler) {
		return meetingRoomRentService.getListByFilter(fitler).getValue();
	}
	
	
	public MeetingRoomRent getMeetingRoomRent() {
		return meetingRoomRent;
	}

	public void setMeetingRoomRent(MeetingRoomRent meetingRoomRent) {
		this.meetingRoomRent = meetingRoomRent;
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

	public void setMeetingRoomRentService(MeetingRoomRentService meetingRoomRentService) {
		this.meetingRoomRentService = meetingRoomRentService;
	}
	
	public Result getResult() {
		return result;
	}
	
}
