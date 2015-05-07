package com.wiiy.crm.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.JqGridBaseAction;
import com.wiiy.commons.entity.TreeEntity;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.crm.dto.AnalyseDto;
import com.wiiy.crm.dto.DataReportDto;
import com.wiiy.crm.dto.DataStatisticDto;
import com.wiiy.crm.entity.DataProperty;
import com.wiiy.crm.entity.DataReport;
import com.wiiy.crm.entity.DataTemplate;
import com.wiiy.crm.entity.DataTemplatePropertyConfig;
import com.wiiy.crm.service.DataPropertyService;
import com.wiiy.crm.service.DataReportPropertyService;
import com.wiiy.crm.service.DataReportService;
import com.wiiy.crm.service.DataReportValueService;
import com.wiiy.crm.service.DataTemplatePropertyConfigService;
import com.wiiy.crm.service.DataTemplateService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Result;

public class AnalyseAction extends JqGridBaseAction<DataTemplate>{
	private DataTemplateService dataTemplateService;
	private DataTemplatePropertyConfigService dataTemplatePropertyConfigService;
	private DataReportPropertyService dataReportPropertyService;
	private DataReportValueService dataReportValueService;
	private DataPropertyService dataPropertyService;
	private DataReportService dataReportService;
 	private Long id;
 	private Long templateId;
	private Result result;
 	private String propertyIds;
 	private String ids;
 	private Long propertyId;
	private String propertyName;
 	
 	private List<DataReport> dataReportList;
	private List<DataProperty> dataPropertyList;
	private List<DataTemplatePropertyConfig> dtpcList; 
	private List<DataTemplate> dataTemplateList;
	private List<Integer> yearList;
	private List<Integer> monthList;
	
	private String time;
	/**
	 * 用于判断是不是从企业服务平台点进来的查看企业
	 */
	private boolean service;
	
	public String list(){
		dataTemplateList = dataTemplateService.getList().getValue();
		yearList = new ArrayList<Integer>();
		monthList = new ArrayList<Integer>();
		Integer curYear = Integer.parseInt(DateUtil.format(new Date(),"yyyy"));
		for(int i = curYear-10;i<curYear+4;i++){
			yearList.add(i);
		}
		for(int j=1;j<13;j++){
			monthList.add(j);
		}
		Integer cYear = Integer.parseInt(DateUtil.format(new Date(), "yyyy"));
		ServletActionContext.getRequest().setAttribute("cYear", cYear);
		return "list";
	}
	
	public String loadPropertyByTemplate(){
		dtpcList = dataTemplatePropertyConfigService.getListByFilter(new Filter(DataTemplatePropertyConfig.class).eq("templateId", templateId)).getValue();
		StringBuilder sb = new StringBuilder();
		for(DataTemplatePropertyConfig dtpc : dtpcList){
			sb.append(dtpc.getPropertyId()).append(",");  
		}
		if(sb.toString().endsWith(","))sb.deleteCharAt(sb.length()-1);
		String ids = sb.toString();
		List<DataProperty> list = new ArrayList<DataProperty>();
		if(id==null) {
			dataPropertyList = dataPropertyService.getListByConfigIds(ids).getValue();
		}else {
			dataPropertyList = dataPropertyService.getListByFilter(new Filter(DataProperty.class).eq("parentId",id)).getValue();
			for(DataProperty property : dataPropertyList){
				for(String iId : ids.split(",")){
					if(property.getId().equals(Long.parseLong(iId))){
						list.add(property);
					}
				}
			}
		}
		
		if(list.size()>0 && list!=null){
			for(DataProperty property : list){
				property.setText(property.getName());
				if(property.getLeaf()!=null){
					if(property.getLeaf()){
						property.setState(TreeEntity.STATE_OPEN);
					} else {
						property.setState(TreeEntity.STATE_CLOSED);
					}
				}
			}
			dataPropertyList = new ArrayList<DataProperty>(list);
		}else{
			for(DataProperty property : dataPropertyList){
				property.setText(property.getName());
				if(property.getLeaf()){
					property.setState(TreeEntity.STATE_OPEN);
				} else {
					property.setState(TreeEntity.STATE_CLOSED);
				}
				if(propertyIds!=null && !propertyIds.equals(null) && !propertyIds.equals("")){
					for(String sId : propertyIds.split(",")){
						Long lId = Long.parseLong(sId);
						if(property.getId().equals(lId)){
							property.setChecked(true);
						}
					}
				}
				
			}
		}	
		result = Result.value(dataPropertyList);
		return "rvalue";
	}
	
	public String loadDataReportById(){
		dataReportList = dataReportService.getListByFilter(new Filter(DataReport.class).eq("templateId", templateId)).getValue();
		List<String> groupName = new ArrayList<String>(); 
		List<DataReportDto> dtoList = new ArrayList<DataReportDto>(); 
		if(dataReportList!=null && dataReportList.size()>0){
			for(DataReport d : dataReportList){
				if(!groupName.contains(d.getGroup().getName())){
					groupName.add(d.getGroup().getName());
				}
			}
			for(String s : groupName){
				DataReportDto dto = new DataReportDto();
				dto.setGroupName(s);
				List<DataReport> drList = new ArrayList<DataReport>();
				for(DataReport d : dataReportList){
					if(s.equals(d.getGroup().getName())){
						drList.add(d);
					}
				}
				dto.setDataReportList(drList);
				dtoList.add(dto);
			}
		}
		result = Result.value(dtoList);
		return JSON;
	}
	
	public String count(){
		try {
			propertyName = new String(propertyName.getBytes("ISO8859_1"),"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String[] t = time.split(":");
		AnalyseDto dto = new AnalyseDto();
		dto.setsYear(Integer.parseInt(t[0]));
		dto.setsMonth(Integer.parseInt(t[1]));
		dto.seteYear(Integer.parseInt(t[2]));
		dto.seteMonth(Integer.parseInt(t[3]));
		dto.setIds(ids);
		dto.setPropertyId(propertyId);
		dto.setTemplateId(templateId);
		dto.setPropertyName(propertyName);
		result = Result.value(dto);
		
		dataTemplateList = dataTemplateService.getList().getValue();
		yearList = new ArrayList<Integer>();
		monthList = new ArrayList<Integer>();
		Integer curYear = Integer.parseInt(DateUtil.format(new Date(),"yyyy"));
		for(int i = curYear-10;i<curYear+4;i++){
			yearList.add(i);
		}
		for(int j=1;j<13;j++){
			monthList.add(j);
		}
		return "list";
	}
	
	public String dataXML(){
		AnalyseDto dto = new AnalyseDto();
		if(time!=null){
			String[] t = time.split(":");
			dto.setsYear(Integer.parseInt(t[0]));
			dto.setsMonth(Integer.parseInt(t[1]));
			dto.seteYear(Integer.parseInt(t[2]));
			dto.seteMonth(Integer.parseInt(t[3]));
			dto.setIds(ids);
			dto.setPropertyId(propertyId);
		}
		StringBuffer sb=new StringBuffer();
		List<DataStatisticDto> sDto = dataReportService.getCountDto(dto);
		sb.append("<graph showNames='1' decimalPrecision='0' formatNumberScale='0' showLimits='1' showhovercap='1' yAxisMaxValue='5'>\n");
		for(DataStatisticDto s : sDto){
			if(s.getdValue()==null && s.getiValue()!=null){
				sb.append("\n"+"   <set name='"+s.getName()+"' value='"+s.getiValue()+"' color='#FF4040'/>");
			}
			if(s.getiValue()==null && s.getdValue()!=null){
				sb.append("\n"+"   <set name='"+s.getName()+"' value='"+s.getdValue()+"' color='#FF4040'/>");
			}
			if(s.getiValue()==null && s.getdValue()==null){
				sb.append("\n"+"   <set name='"+s.getName()+"' value='0' color='#FF4040'/>");
			}
		}
		 sb.append("\n</graph>");
		try {
			 ServletActionContext.getResponse().setContentType("text/html;charset=gb2312");
			 PrintWriter writer=ServletActionContext.getResponse().getWriter();
			 writer.write(sb.toString());
			 writer.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public String customerView(){
		dataTemplateList = dataTemplateService.getList().getValue();
		yearList = new ArrayList<Integer>();
		monthList = new ArrayList<Integer>();
		Integer curYear = Integer.parseInt(DateUtil.format(new Date(),"yyyy"));
		for(int i = curYear-10;i<curYear+4;i++){
			yearList.add(i);
		}
		for(int j=1;j<13;j++){
			monthList.add(j);
		}
		Integer cYear = Integer.parseInt(DateUtil.format(new Date(), "yyyy"));
		ServletActionContext.getRequest().setAttribute("cYear", cYear);
		return "customerView";
	}
	
	public String customerCount(){
		try {
			propertyName = new String(propertyName.getBytes("ISO8859_1"),"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String[] t = time.split(":");
		AnalyseDto dto = new AnalyseDto();
		dto.setsYear(Integer.parseInt(t[0]));
		dto.setsMonth(Integer.parseInt(t[1]));
		dto.seteYear(Integer.parseInt(t[2]));
		dto.seteMonth(Integer.parseInt(t[3]));
		dto.setPropertyId(propertyId);
		dto.setPropertyName(propertyName);
		dto.setTemplateId(templateId);
		ServletActionContext.getRequest().setAttribute("dto", dto);
		ServletActionContext.getRequest().setAttribute("id", id);
		
		
		dataTemplateList = dataTemplateService.getList().getValue();
		yearList = new ArrayList<Integer>();
		monthList = new ArrayList<Integer>();
		Integer curYear = Integer.parseInt(DateUtil.format(new Date(),"yyyy"));
		for(int i = curYear-10;i<curYear+4;i++){
			yearList.add(i);
		}
		for(int j=1;j<13;j++){
			monthList.add(j);
		}
		return "customerView";
	}
	
	public String dataXML2(){
		AnalyseDto dto = new AnalyseDto();
		if(time!=null){
			String[] t = time.split(":");
			dto.setsYear(Integer.parseInt(t[0]));
			dto.setsMonth(Integer.parseInt(t[1]));
			dto.seteYear(Integer.parseInt(t[2]));
			dto.seteMonth(Integer.parseInt(t[3]));
			dto.setPropertyId(propertyId);
		}
		StringBuffer sb=new StringBuffer();
		List<DataStatisticDto> sDto = dataReportService.getCountDto2(dto,id);
		sb.append("<graph showNames='1' decimalPrecision='0' formatNumberScale='0' showLimits='1' showhovercap='1' yAxisMaxValue='5'>\n");
		for(DataStatisticDto s : sDto){
			if(s.getdValue()==null && s.getiValue()!=null){
				sb.append("\n"+"   <set name='"+s.getName()+"' value='"+s.getiValue()+"' color='#FF4040'/>");
			}
			if(s.getiValue()==null && s.getdValue()!=null){
				sb.append("\n"+"   <set name='"+s.getName()+"' value='"+s.getdValue()+"' color='#FF4040'/>");
			}
			if(s.getiValue()==null && s.getdValue()==null){
				sb.append("\n"+"   <set name='"+s.getName()+"' value='0' color='#FF4040'/>");
			}
		}
		 sb.append("\n</graph>");
		try {
			 ServletActionContext.getResponse().setContentType("text/html;charset=gb2312");
			 PrintWriter writer=ServletActionContext.getResponse().getWriter();
			 writer.write(sb.toString());
			 writer.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@Override
	protected List<DataTemplate> getListByFilter(Filter filter) {
		return dataTemplateService.getListByFilter(filter).getValue();
	}
	
	public void setDataTemplateService(DataTemplateService dataTemplateService) {
		this.dataTemplateService = dataTemplateService;
	}
	public void setDataTemplatePropertyConfigService(
			DataTemplatePropertyConfigService dataTemplatePropertyConfigService) {
		this.dataTemplatePropertyConfigService = dataTemplatePropertyConfigService;
	}
	public void setDataReportPropertyService(
			DataReportPropertyService dataReportPropertyService) {
		this.dataReportPropertyService = dataReportPropertyService;
	}
	public void setDataReportValueService(
			DataReportValueService dataReportValueService) {
		this.dataReportValueService = dataReportValueService;
	}
	public List<DataTemplate> getDataTemplateList() {
		return dataTemplateList;
	}
	public void setDataTemplateList(List<DataTemplate> dataTemplateList) {
		this.dataTemplateList = dataTemplateList;
	}
	public List<Integer> getYearList() {
		return yearList;
	}
	public void setYearList(List<Integer> yearList) {
		this.yearList = yearList;
	}
	public List<Integer> getMonthList() {
		return monthList;
	}
	public void setMonthList(List<Integer> monthList) {
		this.monthList = monthList;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public List<DataProperty> getDataPropertyList() {
		return dataPropertyList;
	}
	public void setDataPropertyList(List<DataProperty> dataPropertyList) {
		this.dataPropertyList = dataPropertyList;
	}
	public void setDataPropertyService(DataPropertyService dataPropertyService) {
		this.dataPropertyService = dataPropertyService;
	}
	public Result getResult() {
		return result;
	}
	public void setResult(Result result) {
		this.result = result;
	}
	public List<DataTemplatePropertyConfig> getDtpcList() {
		return dtpcList;
	}
	public void setDtpcList(List<DataTemplatePropertyConfig> dtpcList) {
		this.dtpcList = dtpcList;
	}
	public Long getTemplateId() {
		return templateId;
	}
	public void setTemplateId(Long templateId) {
		this.templateId = templateId;
	}
	public String getPropertyIds() {
		return propertyIds;
	}

	public void setPropertyIds(String propertyIds) {
		this.propertyIds = propertyIds;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public void setDataReportService(DataReportService dataReportService) {
		this.dataReportService = dataReportService;
	}

	public List<DataReport> getDataReportList() {
		return dataReportList;
	}

	public void setDataReportList(List<DataReport> dataReportList) {
		this.dataReportList = dataReportList;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}
	public Long getPropertyId() {
		return propertyId;
	}

	public void setPropertyId(Long propertyId) {
		this.propertyId = propertyId;
	}

	public String getPropertyName() {
		return propertyName;
	}

	public void setPropertyName(String propertyName) {
		this.propertyName = propertyName;
	}

	public boolean isService() {
		return service;
	}

	public void setService(boolean service) {
		this.service = service;
	}
	
	
}
