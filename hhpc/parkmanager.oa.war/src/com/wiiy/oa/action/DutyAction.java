package com.wiiy.oa.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.LinkedHashMap;
import java.util.List;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.util.BeanUtil;
import com.wiiy.commons.util.POIUtil;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

import com.wiiy.oa.activator.OaActivator;
import com.wiiy.oa.entity.Duty;
import com.wiiy.oa.entity.Supply;
import com.wiiy.oa.service.DutyService;

/**
 * @author my
 */
public class DutyAction extends JqGridBaseAction<Duty>{
	
	private DutyService dutyService;
	private Result result;
	private Duty duty;
	private Long id;
	private String ids;
	
	private String userName;

	private String excelName;
	private InputStream inputStream;
	private String columns;
	private String exportIds;

	public void setExportIds(String exportIds) {
		this.exportIds = exportIds;
	}
	public String add(){
		userName = OaActivator.getSessionUser().getUsername();
		return "add";
	}
	
	public String export(){
		Filter filter = new Filter(Duty.class);
		if(!exportIds.equals("") && exportIds!=null){
			filter.in("id",(Object[])StringUtil.splitToLongArray(exportIds));
		}
		page=0;//不要分页
		refresh(filter);
		excelName = StringUtil.URLEncoderToUTF8("值班情况登记表")+".xls";
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		POIUtil.export("值班情况登记表", generateExportColumns(columns), root, out);
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
	
	public String save(){
		result = dutyService.save(duty);
		return JSON;
	}
	
	public String view(){
		result = dutyService.getBeanById(id);
		return VIEW;
	}
	
	public String edit(){
		result = dutyService.getBeanById(id);
		return EDIT;
	}
	
	public String update(){
		Duty dbBean = dutyService.getBeanById(duty.getId()).getValue();
		BeanUtil.copyProperties(duty, dbBean);
		result = dutyService.update(dbBean);
		return JSON;
	}
	
	public String delete(){
		if(id!=null){
			result = dutyService.deleteById(id);
		} else if(ids!=null){
			result = dutyService.deleteByIds(ids);
		}
		return JSON;
	}
	
	public String list(){
		return refresh(new Filter(Duty.class));
	}
	
	@Override
	protected List<Duty> getListByFilter(Filter fitler) {
		return dutyService.getListByFilter(fitler).getValue();
	}
	
	
	public Duty getDuty() {
		return duty;
	}

	public void setDuty(Duty duty) {
		this.duty = duty;
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

	public void setDutyService(DutyService dutyService) {
		this.dutyService = dutyService;
	}
	
	public Result getResult() {
		return result;
	}
	public String getExcelName() {
		return excelName;
	}

	public void setExcelName(String excelName) {
		this.excelName = excelName;
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

	public String getColumns() {
		return columns;
	}

	public void setColumns(String columns) {
		this.columns = columns;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
}
