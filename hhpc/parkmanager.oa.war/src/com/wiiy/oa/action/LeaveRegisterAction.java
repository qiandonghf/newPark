package com.wiiy.oa.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.lang.annotation.Annotation;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.POIUtil;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;
import com.wiiy.oa.entity.LeaveApproval;
import com.wiiy.oa.entity.LeaveRegister;
import com.wiiy.oa.preferences.enums.LeaveTypeEnum;
import com.wiiy.oa.service.LeaveApprovalService;
import com.wiiy.oa.service.LeaveRegisterService;

public class LeaveRegisterAction extends JqGridBaseAction<LeaveRegister>{
	private LeaveRegisterService leaveRegisterService;
	private LeaveApprovalService leaveApprovalService;
	private LeaveRegister leaveRegister;
	private Long id;
	private String ids;
	private Result result;
	private List<LeaveTypeEnum> enumList;
	
	private String columns;
	private Class<?> recordClass = LeaveRegister.class;
	private String excelName;
	private InputStream inputStream;
	private String exportIds;

	public void setExportIds(String exportIds) {
		this.exportIds = exportIds;
	}

	public String list(){
		Filter filter = new Filter(LeaveRegister.class);
		return refresh(filter);
	}
	
	public String listApproval(){
		return refresh(new Filter(LeaveRegister.class).ne("approvals", "[]"));
	}
	
	public String add(){
		enumList = new ArrayList<LeaveTypeEnum>();
		for(LeaveTypeEnum type : LeaveTypeEnum.values()){
			enumList.add(type);
		}
		return "add";
	}
	
	public String save(){
		leaveRegister.setApprovals("[]");
		result = leaveRegisterService.save(leaveRegister);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = leaveRegisterService.deleteById(id);
		}
		if(ids!=null){
			result = leaveRegisterService.deleteByIds(ids);
		}
		return JSON;
	}
	
	//如果请假登记已经送审,则删除所有对应的审批记录
	public String deleteAll(){
		if(id!=null){
			List<LeaveApproval> laList = leaveApprovalService.getListByFilter(new Filter(LeaveApproval.class).eq("applyId", id)).getValue();
			if(laList.size()>0 && laList!=null){
				StringBuilder laIds = new StringBuilder();
				for(LeaveApproval la : laList){
					laIds.append(la.getId()).append(","); 
				}
				if(laIds.toString().endsWith(","))laIds.deleteCharAt(laIds.length()-1);
				leaveApprovalService.deleteByIds(laIds.toString());
			}
			result = leaveRegisterService.deleteById(id);
		}
		 return JSON;
	}
	
	public String edit(){
		result = leaveRegisterService.getBeanById(id);
		enumList = new ArrayList<LeaveTypeEnum>();
		for(LeaveTypeEnum type : LeaveTypeEnum.values()){
			enumList.add(type);
		}
		return EDIT;
	}
	
	public String update(){
		LeaveRegister dbean = leaveRegisterService.getBeanById(leaveRegister.getId()).getValue();
		BeanUtil.copyProperties(leaveRegister, dbean);
		result = leaveRegisterService.update(dbean);
		return JSON;
	}
	
	public String view(){
		result = leaveRegisterService.getBeanById(id);
		enumList = new ArrayList<LeaveTypeEnum>();
		for(LeaveTypeEnum type : LeaveTypeEnum.values()){
			enumList.add(type);
		}
		return VIEW;
	}
	
	public String export() throws UnsupportedEncodingException{
		Filter filter = new Filter(LeaveRegister.class);
		if(!exportIds.equals("") && exportIds!=null){
			filter.in("id",(Object[])StringUtil.splitToLongArray(exportIds));
		}
		page=0;//不要分页
		refresh(filter);
		excelName = StringUtil.URLEncoderToUTF8("请假登记表")+".xls";
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		POIUtil.export("请假登记表",generateExportColumns(columns),root,out,"yyyy-MM-dd HH:mm");
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
	
	@Override
	protected List<LeaveRegister> getListByFilter(Filter filter) {
		return leaveRegisterService.getListByFilter(filter).getValue();
	}
	public void setLeaveRegisterService(LeaveRegisterService leaveRegisterService) {
		this.leaveRegisterService = leaveRegisterService;
	}
	public LeaveRegister getLeaveRegister() {
		return leaveRegister;
	}
	public void setLeaveRegister(LeaveRegister leaveRegister) {
		this.leaveRegister = leaveRegister;
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

	public List<LeaveTypeEnum> getEnumList() {
		return enumList;
	}

	public void setEnumList(List<LeaveTypeEnum> enumList) {
		this.enumList = enumList;
	}

	public void setLeaveApprovalService(LeaveApprovalService leaveApprovalService) {
		this.leaveApprovalService = leaveApprovalService;
	}

	public String getExcelName() {
		return excelName;
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public void setColumns(String columns) {
		this.columns = columns;
	}

}
