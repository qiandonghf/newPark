package com.wiiy.crm.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.util.DateUtil;
import com.wiiy.commons.util.POIUtil;
import com.wiiy.commons.util.StringUtil;
import com.wiiy.commons.util.TreeUtil;
import com.wiiy.commons.util.dto.ExcelSheetDto;
import com.wiiy.core.entity.DataDict;
import com.wiiy.core.service.export.DataDictInitService;
import com.wiiy.crm.dto.CustomerQualificationSearchResultDto;
import com.wiiy.crm.dto.CustomerSearchResultDto;
import com.wiiy.crm.dto.CustomerVentureTypeSearchResultDto;
import com.wiiy.crm.dto.IncubationRouteSearchResultDto;
import com.wiiy.crm.entity.Brand;
import com.wiiy.crm.entity.Contect;
import com.wiiy.crm.entity.Copyright;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.entity.CustomerInfo;
import com.wiiy.crm.entity.CustomerQualification;
import com.wiiy.crm.entity.CustomerVentureType;
import com.wiiy.crm.entity.DataProperty;
import com.wiiy.crm.entity.DataReport;
import com.wiiy.crm.entity.DataReportValue;
import com.wiiy.crm.entity.DataTemplatePropertyConfig;
import com.wiiy.crm.entity.IncubationInfo;
import com.wiiy.crm.entity.IncubationRoute;
import com.wiiy.crm.entity.Patent;
import com.wiiy.crm.entity.ProjectApply;
import com.wiiy.crm.entity.Staffer;
import com.wiiy.crm.preferences.enums.DataTypeEnum;
import com.wiiy.crm.preferences.format.SearchReportFormat;
import com.wiiy.crm.service.BrandService;
import com.wiiy.crm.service.ContectService;
import com.wiiy.crm.service.CopyrightService;
import com.wiiy.crm.service.CustomerQualificationService;
import com.wiiy.crm.service.CustomerService;
import com.wiiy.crm.service.CustomerVentureTypeService;
import com.wiiy.crm.service.DataPropertyService;
import com.wiiy.crm.service.DataReportService;
import com.wiiy.crm.service.DataReportValueService;
import com.wiiy.crm.service.DataTemplatePropertyConfigService;
import com.wiiy.crm.service.IncubationRouteService;
import com.wiiy.crm.service.PatentService;
import com.wiiy.crm.service.ProjectApplyService;
import com.wiiy.crm.service.StafferService;
import com.wiiy.hibernate.Filter;
import com.wiiy.hibernate.Pager;
import com.wiiy.hibernate.Result;
import com.wiiy.pb.activator.PbActivator;

public class SearchAction {
	
	private DataTemplatePropertyConfigService dataTemplatePropertyConfigService;
	private CustomerService customerService;
	private StafferService stafferService;
	private IncubationRouteService incubationRouteService;
	private CustomerQualificationService customerQualificationService;
	private CustomerVentureTypeService customerVentureTypeService;
	private ContectService contectService;
	private PatentService patentService;
	private BrandService brandService;
	private CopyrightService copyrightService;
	private ProjectApplyService projectApplyService;
	private DataPropertyService dataPropertyService;
	private DataReportValueService dataReportValueService;
	private DataReportService dataReportService;
	
	private Result<?> result;
	private List<DataDict> incubationRouteList;
	private List<DataDict> technicList;
	private List<DataDict> qualificationList;
	private List<DataDict> taxadressList;
	private List<DataDict> incubateList;
	private List<DataDict> enterpriseTypeList;
	
	private List<DataProperty> propertyList;
	
	private String reportHtml;
	
	private String tab;
	private Pager pager;
	private Integer page;
	
	private String excelName;
	private InputStream inputStream;
	
	private List<ExcelSheetDto> sheetDtoList;
	private List<String> columns;
	
	public String before(){
		loadIncubationRoute();
		return "before";
	}
	
	public String export(){
		page = -1;
		excelName = StringUtil.URLEncoderToUTF8("综合查询结果")+".xls";
		sheetDtoList = new ArrayList<ExcelSheetDto>();
		exportCustomer();
		if(hasProperty("staffer")){
			exportStaffer();
		}
		if(hasProperty("incubationRoute")){
			exportIncubationRoute();
		}
		if(hasProperty("customerQualification")){
			exportCustomerQualification();
		}
		if(hasProperty("customerVentureType")){
			exportCustomerVentureType();
		}
		if(hasProperty("contect")){
			exportContect();
		}
		if(hasProperty("patent")){
			exportPatent();
		}
		if(hasProperty("brand")){
			exportBrand();
		}
		if(hasProperty("projectApply")){
			exportProjectApply();
		}
		if(hasProperty("copyright")){
			exportCopyright();
		}
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		POIUtil.export(sheetDtoList, out);
		inputStream = new ByteArrayInputStream(out.toByteArray());
		page = null;
		return "export";
	}
	
	@SuppressWarnings("unchecked")
	private void exportCustomer() {
		
		searchCustomer();
		columns = new ArrayList<String>();
		List<Object[]> dataList = new ArrayList<Object[]>();
		List<String> propertyList = (List<String>) getSessionAttribute("propertys");
		
		columns.add("企业编号");
		columns.add("企业名称");
		boolean reportType = checkColumn(propertyList, "customer.reportType", "上报类型");
		boolean hostName = checkColumn(propertyList, "customer.hostName", "跟踪引进");
		boolean type = checkColumn(propertyList, "customer.type", "企业性质");
		boolean parkTime = checkColumn(propertyList, "customer.parkTime", "引进时间");
		boolean technic = checkColumn(propertyList, "customer.technic", "产业类别");
		boolean enterpriseType = checkColumn(propertyList, "customer.enterpriseType", "创业类型");
		boolean zyjck = checkColumn(propertyList, "customer.zyjck", "自营进出口权");
		boolean ybnsr = checkColumn(propertyList, "customer.ybnsr", "自营进出口权");
		
		boolean businessNumber = checkColumn(propertyList, "customerInfo.businessNumber","工商注册号");
		boolean regTime = checkColumn(propertyList, "customerInfo.regTime","注册时间");
		boolean taxNumberG = checkColumn(propertyList, "customerInfo.taxNumberG","国税登记号");
		boolean taxNumberD = checkColumn(propertyList, "customerInfo.taxNumberD","地税登记号");
		boolean taxAddress = checkColumn(propertyList, "customerInfo.taxAddress","纳税所在地");
		boolean webSite = checkColumn(propertyList, "customerInfo.webSite","公司地址");
		boolean organizationNumber = checkColumn(propertyList, "customerInfo.organizationNumber","组织机构代码");
		boolean regCapital = checkColumn(propertyList, "customerInfo.regCapital","注册资金");
		boolean realCapital = checkColumn(propertyList, "customerInfo.realCapital","实际到位资金");
		boolean regAddress = checkColumn(propertyList, "customerInfo.regAddress","注册地址");
		boolean inPark = checkColumn(propertyList, "customerInfo.inPark","在园区内");
		boolean managerAddress = checkColumn(propertyList, "customerInfo.managerAddress","经营地址");
		boolean inBuild = checkColumn(propertyList, "customerInfo.inBuild","在大厦内");
		boolean research = checkColumn(propertyList, "customerInfo.research","是否是研发机构");
		boolean userCount = checkColumn(propertyList, "customerInfo.userCount","企业总人数");
		boolean userbsh = checkColumn(propertyList, "customerInfo.userbsh","博士后");
		boolean userbs = checkColumn(propertyList, "customerInfo.userbs","博士");
		boolean userss = checkColumn(propertyList, "customerInfo.userss","硕士");
		boolean userbk = checkColumn(propertyList, "customerInfo.userbk","本科");
		boolean userqt = checkColumn(propertyList, "customerInfo.userqt","其他");
		boolean userlxs = checkColumn(propertyList, "customerInfo.userlxs","留学生");
		boolean usergj = checkColumn(propertyList, "customerInfo.usergj","高级职称");
		boolean userzj = checkColumn(propertyList, "customerInfo.userzj","中级职称");
		boolean usercj = checkColumn(propertyList, "customerInfo.usercj","初级职称");
		boolean shareholder = checkColumn(propertyList, "customerInfo.shareholder","股东构成");
		boolean businessScope = checkColumn(propertyList, "customerInfo.businessScope","经营范围");
		boolean memo = checkColumn(propertyList, "customerInfo.memo","备注");

		boolean status = checkColumn(propertyList, "incubationInfo.status","孵化状态");
		boolean incubationInfoType = checkColumn(propertyList, "incubationInfo.type","创业类型");
		boolean incubateConfig = checkColumn(propertyList, "incubationInfo.incubateConfig","入驻场所");

		boolean legal_name = checkColumn(propertyList, "legal.name","法人姓名");
		boolean legal_birth = checkColumn(propertyList, "legal.birth","法人出生年月");
		boolean legal_phone = checkColumn(propertyList, "legal.phone","法人电话");
		boolean legal_gender = checkColumn(propertyList, "legal.gender","法人性别");
		boolean legal_degree = checkColumn(propertyList, "legal.degree","法人学历");
		boolean legal_position = checkColumn(propertyList, "legal.position","法人职称");
		boolean legal_email = checkColumn(propertyList, "legal.email","法人Email");

		boolean manager_name = checkColumn(propertyList, "manager.name","总经理姓名");
		boolean manager_birth = checkColumn(propertyList, "manager.birth","总经理出生年月");
		boolean manager_phone = checkColumn(propertyList, "manager.phone","总经理电话");
		boolean manager_gender = checkColumn(propertyList, "manager.gender","总经理性别");
		boolean manager_degree = checkColumn(propertyList, "manager.degree","总经理学历");
		boolean manager_position = checkColumn(propertyList, "manager.position","总经理职称");
		boolean manager_email = checkColumn(propertyList, "manager.email","总经理Email");
		
		DataReport report1 = (DataReport)getSessionAttribute("report1");
		DataReport report2 = (DataReport)getSessionAttribute("report2");
		List<DataProperty> dataPropertyList = (List<DataProperty>)getSessionAttribute("dataPropertyList");
		if(dataPropertyList!=null)
		for(DataProperty dp : dataPropertyList){
			String name = dp.getName();
			if(dp.getName().equals("本期数") || dp.getName().equals("本年累计数")) {
				name = dp.getParentProperty().getName()+name;
			}
			if(report1!=null){
				columns.add(report1.getName()+":"+name);
			}
			if(report2!=null){
				columns.add(report2.getName()+":"+name);
			}
		}
		
		List<CustomerSearchResultDto> list = (List<CustomerSearchResultDto>) result.getValue();
		if(list!=null)
		for(CustomerSearchResultDto dto : list){
			List<Object> datas = new ArrayList<Object>();
			Customer customer = dto.getCustomer();
			datas.add(customer.getCode());
			datas.add(customer.getName());
			if(reportType){if(customer.getReportType()!=null) datas.add(customer.getReportType().getTitle());
			else datas.add("");}
			if(hostName){if(customer.getHostName()!=null) datas.add(customer.getHostName());
			else datas.add("");}
			if(type){if(customer.getType()!=null) datas.add(customer.getType().getTitle());
			else datas.add("");}
			if(parkTime){if(customer.getParkTime()!=null) datas.add(DateUtil.format(customer.getParkTime()));
			else datas.add("");}
			if(technic){if(customer.getTechnic()!=null) datas.add(customer.getTechnic().getDataValue());
			else datas.add("");}
			if(enterpriseType){if(customer.getEnterpriseType()!=null) datas.add(customer.getEnterpriseType().getDataValue());
			else datas.add("");}
			CustomerInfo customerInfo = customer.getCustomerInfo();
			if(zyjck){if(customerInfo.getZyjck()!=null) datas.add(customerInfo.getZyjck().getTitle());
			else datas.add("");}
			if(ybnsr){if(customerInfo.getYbnsr()!=null) datas.add(customerInfo.getYbnsr().getTitle());
			else datas.add("");}
			if(businessNumber){if(customerInfo.getBusinessNumber()!=null) datas.add(customerInfo.getBusinessNumber());
			else datas.add("");}
			if(regTime){if(customerInfo.getRegTime()!=null) datas.add(DateUtil.format(customerInfo.getRegTime()));
			else datas.add("");}
			if(taxNumberG){if(customerInfo.getTaxNumberG()!=null) datas.add(customerInfo.getTaxNumberG());
			else datas.add("");}
			if(taxNumberD){if(customerInfo.getTaxNumberD()!=null) datas.add(customerInfo.getTaxNumberD());
			else datas.add("");}
			if(taxAddress){if(customerInfo.getTaxAddress()!=null) datas.add(customerInfo.getTaxAddress().getDataValue());
			else datas.add("");}
			if(webSite){if(customerInfo.getWebSite()!=null) datas.add(customerInfo.getWebSite());
			else datas.add("");}
			if(organizationNumber){if(customerInfo.getOrganizationNumber()!=null) datas.add(customerInfo.getOrganizationNumber());
			else datas.add("");}
			if(regCapital){if(customerInfo.getRegCapital()!=null) datas.add(customerInfo.getRegCapital());
			else datas.add("");}
			if(realCapital){if(customerInfo.getRealCapital()!=null) datas.add(customerInfo.getRealCapital());
			else datas.add("");}
			if(regAddress){if(customerInfo.getRegAddress()!=null) datas.add(customerInfo.getRegAddress());
			else datas.add("");}
			if(inPark){if(customerInfo.getInPark()!=null) datas.add(customerInfo.getInPark().getTitle());
			else datas.add("");}
			if(managerAddress){if(customerInfo.getManagerAddress()!=null) datas.add(customerInfo.getManagerAddress());
			else datas.add("");}
			if(inBuild){if(customerInfo.getInBuild()!=null) datas.add(customerInfo.getInBuild().getTitle());
			else datas.add("");}
			if(research){if(customerInfo.getResearch()!=null) datas.add(customerInfo.getResearch());
			else datas.add("");}
			if(userCount){if(customerInfo.getUserCount()!=null) datas.add(customerInfo.getUserCount());
			else datas.add("");}
			if(userbsh){if(customerInfo.getUserbsh()!=null) datas.add(customerInfo.getUserbsh());
			else datas.add("");}
			if(userbs){if(customerInfo.getUserbs()!=null) datas.add(customerInfo.getUserbs());
			else datas.add("");}
			if(userss){if(customerInfo.getUserss()!=null) datas.add(customerInfo.getUserss());
			else datas.add("");}
			if(userbk){if(customerInfo.getUserbk()!=null) datas.add(customerInfo.getUserbk());
			else datas.add("");}
			if(userqt){if(customerInfo.getUserqt()!=null) datas.add(customerInfo.getUserqt());
			else datas.add("");}
			if(userlxs){if(customerInfo.getUserlxs()!=null) datas.add(customerInfo.getUserlxs());
			else datas.add("");}
			if(usergj){if(customerInfo.getUsergj()!=null) datas.add(customerInfo.getUsergj());
			else datas.add("");}
			if(userzj){if(customerInfo.getUserzj()!=null) datas.add(customerInfo.getUserzj());
			else datas.add("");}
			if(usercj){if(customerInfo.getUsercj()!=null) datas.add(customerInfo.getUsercj());
			else datas.add("");}
			if(shareholder){if(customerInfo.getShareholder()!=null) datas.add(customerInfo.getShareholder());
			else datas.add("");}
			if(businessScope){if(customerInfo.getBusinessScope()!=null) datas.add(customerInfo.getBusinessScope());
			else datas.add("");}
			if(memo){if(customerInfo.getMemo()!=null) datas.add(customerInfo.getMemo());
			else datas.add("");}
			IncubationInfo incubationInfo = customer.getIncubationInfo();
			if(status){if(incubationInfo.getStatusName()!=null) datas.add(incubationInfo.getStatusName());
			else datas.add("");}
			
			if(incubationInfoType) {
				String value = "";
				if(incubationInfo.getOverseaEnterprise()==BooleanEnum.YES) value += "留学生 ";
				if(incubationInfo.getUndergraduateEnterprise()==BooleanEnum.YES) value += "大学生 ";
				datas.add(value);
			}
			if(incubateConfig){if(incubationInfo.getIncubateConfig()!=null) datas.add(incubationInfo.getIncubateConfig().getDataValue());
			else datas.add("");}
			
			Staffer legal = dto.getLegal();
			if(legal_name){if(legal!=null && legal.getName()!=null) datas.add(legal.getName());
			else datas.add("");}
			if(legal_birth){if(legal!=null && legal.getBirth()!=null) datas.add(DateUtil.format(legal.getBirth()));
			else datas.add("");}
			if(legal_phone){if(legal!=null && legal.getPhone()!=null) datas.add(legal.getPhone());
			else datas.add("");}
			if(legal_gender){if(legal!=null && legal.getGender()!=null) datas.add(legal.getGender().getTitle());
			else datas.add("");}
			if(legal_degree){if(legal!=null && legal.getDegree()!=null) datas.add(legal.getDegree().getDataValue());
			else datas.add("");}
			if(legal_position){if(legal!=null && legal.getPosition()!=null) datas.add(legal.getPosition().getDataValue());
			else datas.add("");}
			if(legal_email){if(legal!=null && legal.getEmail()!=null) datas.add(legal.getEmail());
			else datas.add("");}
			
			Staffer manager = dto.getManager();
			if(manager_name){if(manager!=null && manager.getName()!=null) datas.add(manager.getName());
			else datas.add("");}
			if(manager_birth){if(manager!=null && manager.getBirth()!=null) datas.add(DateUtil.format(manager.getBirth()));
			else datas.add("");}
			if(manager_phone){if(manager!=null && manager.getPhone()!=null) datas.add(manager.getPhone());
			else datas.add("");}
			if(manager_gender){if(manager!=null && manager.getGender()!=null) datas.add(manager.getGender().getTitle());
			else datas.add("");}
			if(manager_degree){if(manager!=null && manager.getDegree()!=null) datas.add(manager.getDegree().getDataValue());
			else datas.add("");}
			if(manager_position){if(manager!=null && manager.getPosition()!=null) datas.add(manager.getPosition().getDataValue());
			else datas.add("");}
			if(manager_email){if(manager!=null && manager.getEmail()!=null) datas.add(manager.getEmail());
			else datas.add("");}
			
			Map<Long, Map<Long, Map<Long, DataReportValue>>> customerReportValueMap1 = (Map<Long, Map<Long, Map<Long, DataReportValue>>>)getRequest().getAttribute("customerReportValueMap1");
			Map<Long, Map<Long, Map<Long, DataReportValue>>> customerReportValueMap2 = (Map<Long, Map<Long, Map<Long, DataReportValue>>>)getRequest().getAttribute("customerReportValueMap2");
			if(dataPropertyList!=null)
			for(DataProperty dp : dataPropertyList){
				if(report1!=null) {
					String valueStr = "";
					if(customerReportValueMap1.get(customer.getId())!=null && customerReportValueMap1.get(customer.getId()).get(report1.getId())!=null && customerReportValueMap1.get(customer.getId()).get(report1.getId()).get(dp.getId())!=null){
						DataReportValue value = customerReportValueMap1.get(customer.getId()).get(report1.getId()).get(dp.getId());
						if(value!=null)
						if(dp.getDataType().equals(DataTypeEnum.DOUBLE)){
							if(value.getDoubleVal()!=null)
							valueStr += value.getDoubleVal();
						} else {
							if(value.getIntVal()!=null)
							valueStr += value.getIntVal();
						}
					}
					datas.add(valueStr);
				}
				if(report2!=null){
					String valueStr = "";
					if(customerReportValueMap2.get(customer.getId())!=null && customerReportValueMap2.get(customer.getId()).get(report2.getId())!=null && customerReportValueMap2.get(customer.getId()).get(report1.getId()).get(dp.getId())!=null){
						DataReportValue value = customerReportValueMap2.get(customer.getId()).get(report2.getId()).get(dp.getId());
						if(value!=null)
						if(dp.getDataType().equals(DataTypeEnum.DOUBLE)){
							if(value.getDoubleVal()!=null)
							valueStr += value.getDoubleVal();
						} else {
							if(value.getIntVal()!=null)
							valueStr += value.getIntVal();
						}
					}
					datas.add(valueStr);
				}
			}
			dataList.add(datas.toArray());
		}
		
		String sheetName = "企业信息主表";
		ExcelSheetDto sheet = new ExcelSheetDto();
		sheet.setSheetName(sheetName);
		String[] columnArray = new String[columns.size()];
		columns.toArray(columnArray);
		sheet.setColumns(columnArray);
		sheet.setDataList(dataList);
		sheetDtoList.add(sheet);
	}
	private void exportStaffer() {
		
		searchStaffer();
		columns = new ArrayList<String>();
		List<Object[]> dataList = new ArrayList<Object[]>();
		List<String> propertyList = (List<String>) getSessionAttribute("propertys");
		
		columns.add("企业编号");
		columns.add("企业名称");
		
		boolean staffer_name = checkColumn(propertyList, "staffer.name", "姓名");
		boolean staffer_birth = checkColumn(propertyList, "staffer.birth", "出生年月");
		boolean staffer_phone = checkColumn(propertyList, "staffer.phone","电话");
		boolean staffer_gender = checkColumn(propertyList, "staffer.gender", "性别");
		boolean staffer_degree = checkColumn(propertyList, "staffer.degree", "学历");
		boolean staffer_position = checkColumn(propertyList, "staffer.position", "职位");
		boolean staffer_email = checkColumn(propertyList, "staffer.email", "email");
		
		List<Staffer> list = (List<Staffer>) result.getValue();
		if(list!=null)
		for(Staffer staffer : list){
			List<Object> datas = new ArrayList<Object>();
			datas.add(staffer.getCustomer().getCode());
			datas.add(staffer.getCustomer().getName());
			if(staffer_name){if(staffer!=null && staffer.getName()!=null) datas.add(staffer.getName());
			else datas.add("");}
			if(staffer_birth){if(staffer!=null && staffer.getBirth()!=null) datas.add(DateUtil.format(staffer.getBirth()));
			else datas.add("");}
			if(staffer_phone){if(staffer!=null && staffer.getPhone()!=null) datas.add(staffer.getPhone());
			else datas.add("");}
			if(staffer_gender){if(staffer!=null && staffer.getGender()!=null) datas.add(staffer.getGender().getTitle());
			else datas.add("");}
			if(staffer_degree){if(staffer!=null && staffer.getDegree()!=null) datas.add(staffer.getDegree().getDataValue());
			else datas.add("");}
			if(staffer_position){if(staffer!=null && staffer.getPosition()!=null) datas.add(staffer.getPosition().getDataValue());
			else datas.add("");}
			if(staffer_email){if(staffer!=null && staffer.getEmail()!=null) datas.add(staffer.getEmail());
			else datas.add("");}
			dataList.add(datas.toArray());
		}
		
		String sheetName = "企业人才实名表";
		ExcelSheetDto sheet = new ExcelSheetDto();
		sheet.setSheetName(sheetName);
		String[] columnArray = new String[columns.size()];
		columns.toArray(columnArray);
		sheet.setColumns(columnArray);
		sheet.setDataList(dataList);
		sheetDtoList.add(sheet);
	}
	private void exportIncubationRoute() {
		searchIncubationRoute();
		columns = new ArrayList<String>();
		List<Object[]> dataList = new ArrayList<Object[]>();
		List<String> propertyList = (List<String>) getSessionAttribute("propertys");
		
		columns.add("企业编号");
		columns.add("企业名称");
		
		for(DataDict route : incubationRouteList){
			if(propertyList.contains("incubationRoute."+route.getId())) columns.add(route.getDataValue());
		}
		
		List<IncubationRouteSearchResultDto> list = (List<IncubationRouteSearchResultDto>) result.getValue();
		if(list!=null)
		for(IncubationRouteSearchResultDto dto : list){
			List<Object> datas = new ArrayList<Object>();
			datas.add(dto.getCustomer().getCode());
			datas.add(dto.getCustomer().getName());
			for(DataDict route : incubationRouteList){
				if(propertyList.contains("incubationRoute."+route.getId())) {
					datas.add(DateUtil.format(dto.getMap().get(route.getId()).getTime()));
				}
			}
			dataList.add(datas.toArray());
		}
		
		String sheetName = "企业孵化过程表";
		ExcelSheetDto sheet = new ExcelSheetDto();
		sheet.setSheetName(sheetName);
		String[] columnArray = new String[columns.size()];
		columns.toArray(columnArray);
		sheet.setColumns(columnArray);
		sheet.setDataList(dataList);
		sheetDtoList.add(sheet);
	}
	private void exportCustomerQualification() {
		searchCustomerQualification();
		columns = new ArrayList<String>();
		List<Object[]> dataList = new ArrayList<Object[]>();
		List<String> propertyList = (List<String>) getSessionAttribute("propertys");
		
		columns.add("企业编号");
		columns.add("企业名称");
		
		for(DataDict route : qualificationList){
			if(propertyList.contains("customerQualification."+route.getId())) columns.add(route.getDataValue());
		}
		
		List<CustomerQualificationSearchResultDto> list = (List<CustomerQualificationSearchResultDto>) result.getValue();
		if(list!=null)
		for(CustomerQualificationSearchResultDto dto : list){
			List<Object> datas = new ArrayList<Object>();
			datas.add(dto.getCustomer().getCode());
			datas.add(dto.getCustomer().getName());
			for(DataDict route : qualificationList){
				if(propertyList.contains("customerQualification."+route.getId())) {
					datas.add(DateUtil.format(dto.getMap().get(route.getId()).getTime()));
				}
			}
			dataList.add(datas.toArray());
		}
		
		String sheetName = "企业资质表";
		ExcelSheetDto sheet = new ExcelSheetDto();
		sheet.setSheetName(sheetName);
		String[] columnArray = new String[columns.size()];
		columns.toArray(columnArray);
		sheet.setColumns(columnArray);
		sheet.setDataList(dataList);
		sheetDtoList.add(sheet);
	}
	private void exportCustomerVentureType() {
		searchCustomerVentureType();
		columns = new ArrayList<String>();
		List<Object[]> dataList = new ArrayList<Object[]>();
		List<String> propertyList = (List<String>) getSessionAttribute("propertys");
		
		columns.add("企业编号");
		columns.add("企业名称");
		
		for(DataDict route : enterpriseTypeList){
			columns.add(route.getDataValue());
		}
		
		List<CustomerVentureTypeSearchResultDto> list = (List<CustomerVentureTypeSearchResultDto>) result.getValue();
		if(list!=null)
		for(CustomerVentureTypeSearchResultDto dto : list){
			List<Object> datas = new ArrayList<Object>();
			datas.add(dto.getCustomer().getCode());
			datas.add(dto.getCustomer().getName());
			for(DataDict dd : enterpriseTypeList){
				if(dto.getMap().get(dd.getId())!=null) {
					datas.add("√");
				} else {
					datas.add("-");
				}
			}
			dataList.add(datas.toArray());
		}
		
		String sheetName = "企业创业类型表";
		ExcelSheetDto sheet = new ExcelSheetDto();
		sheet.setSheetName(sheetName);
		String[] columnArray = new String[columns.size()];
		columns.toArray(columnArray);
		sheet.setColumns(columnArray);
		sheet.setDataList(dataList);
		sheetDtoList.add(sheet);
	}
	private void exportContect() {
		searchContect();
		columns = new ArrayList<String>();
		List<Object[]> dataList = new ArrayList<Object[]>();
		List<String> propertyList = (List<String>) getSessionAttribute("propertys");
		
		columns.add("企业编号");
		columns.add("企业名称");
		
		boolean contect_position = checkColumn(propertyList, "contect.position", "职位");
		boolean contect_name = checkColumn(propertyList, "contect.name", "姓名");
		boolean contect_phone = checkColumn(propertyList, "contect.phone", "电话");
		boolean contect_mobile = checkColumn(propertyList, "contect.mobile", "手机");
		boolean contect_email = checkColumn(propertyList, "contect.email", "email");
		boolean contect_qq = checkColumn(propertyList, "contect.qq", "QQ");
		
		List<Contect> list = (List<Contect>) result.getValue();
		if(list!=null)
		for(Contect contect : list){
			
			List<Object> datas = new ArrayList<Object>();
			datas.add(contect.getCustomer().getCode());
			datas.add(contect.getCustomer().getName());
			
			if(contect_position){if(contect!=null && contect.getPosition()!=null) datas.add(contect.getPosition());
			else datas.add("");}
			if(contect_name){if(contect!=null && contect.getName()!=null) datas.add(contect.getName());
			else datas.add("");}
			if(contect_phone){if(contect!=null && contect.getPhone()!=null) datas.add(contect.getPhone());
			else datas.add("");}
			if(contect_mobile){if(contect!=null && contect.getMobile()!=null) datas.add(contect.getMobile());
			else datas.add("");}
			if(contect_email){if(contect!=null && contect.getEmail()!=null) datas.add(contect.getEmail());
			else datas.add("");}
			if(contect_qq){if(contect!=null && contect.getQq()!=null) datas.add(contect.getQq());
			else datas.add("");}
			dataList.add(datas.toArray());
		}
		
		String sheetName = "联系人表";
		ExcelSheetDto sheet = new ExcelSheetDto();
		sheet.setSheetName(sheetName);
		String[] columnArray = new String[columns.size()];
		columns.toArray(columnArray);
		sheet.setColumns(columnArray);
		sheet.setDataList(dataList);
		sheetDtoList.add(sheet);
	}
	private void exportPatent() {
		searchPatent();
		columns = new ArrayList<String>();
		List<Object[]> dataList = new ArrayList<Object[]>();
		List<String> propertyList = (List<String>) getSessionAttribute("propertys");
		
		columns.add("企业编号");
		columns.add("企业名称");
		
		boolean patent_name = checkColumn(propertyList, "patent.name", "专利名称");
		boolean patent_type = checkColumn(propertyList, "patent.type", "专利类别");
		boolean patent_applyTime = checkColumn(propertyList, "patent.applyTime", "申请日期");
		boolean patent_buyTime = checkColumn(propertyList, "patent.buyTime", "授权公告日");
		boolean patent_summery = checkColumn(propertyList, "patent.summery", "授权情况");
		
		List<Patent> list = (List<Patent>) result.getValue();
		if(list!=null)
		for(Patent patent : list){
			
			List<Object> datas = new ArrayList<Object>();
			datas.add(patent.getCustomer().getCode());
			datas.add(patent.getCustomer().getName());
			
			if(patent_name){if(patent!=null && patent.getName()!=null) datas.add(patent.getName());
			else datas.add("");}
			if(patent_type){if(patent!=null && patent.getType()!=null) datas.add(patent.getType().getDataValue());
			else datas.add("");}
			if(patent_applyTime){if(patent!=null && patent.getApplyTime()!=null) datas.add(DateUtil.format(patent.getApplyTime()));
			else datas.add("");}
			if(patent_buyTime){if(patent!=null && patent.getBuyTime()!=null) datas.add(DateUtil.format(patent.getBuyTime()));
			else datas.add("");}
			if(patent_summery){if(patent!=null && patent.getSummery()!=null) datas.add(patent.getSummery());
			else datas.add("");}
			
			dataList.add(datas.toArray());
		}
		
		String sheetName = "专利表";
		ExcelSheetDto sheet = new ExcelSheetDto();
		sheet.setSheetName(sheetName);
		String[] columnArray = new String[columns.size()];
		columns.toArray(columnArray);
		sheet.setColumns(columnArray);
		sheet.setDataList(dataList);
		sheetDtoList.add(sheet);
	}
	private void exportBrand() {
		searchBrand();
		columns = new ArrayList<String>();
		List<Object[]> dataList = new ArrayList<Object[]>();
		List<String> propertyList = (List<String>) getSessionAttribute("propertys");
		
		columns.add("企业编号");
		columns.add("企业名称");
		
		boolean brand_name = checkColumn(propertyList, "brand.name", "商标名称");
		boolean brand_brandNo = checkColumn(propertyList, "brand.brandNo", "商标编号");
		boolean brand_grantDate = checkColumn(propertyList, "brand.grantDate", "商标生效时间");
		
		List<Brand> list = (List<Brand>) result.getValue();
		if(list!=null)
		for(Brand brand : list){
			
			List<Object> datas = new ArrayList<Object>();
			datas.add(brand.getCustomer().getCode());
			datas.add(brand.getCustomer().getName());
			
			if(brand_name){if(brand!=null && brand.getName()!=null) datas.add(brand.getName());
			else datas.add("");}
			if(brand_brandNo){if(brand!=null && brand.getBrandNo()!=null) datas.add(brand.getBrandNo());
			else datas.add("");}
			if(brand_grantDate){if(brand!=null && brand.getGrantDate()!=null) datas.add(DateUtil.format(brand.getGrantDate()));
			else datas.add("");}
			
			dataList.add(datas.toArray());
		}
		
		String sheetName = "商标表";
		ExcelSheetDto sheet = new ExcelSheetDto();
		sheet.setSheetName(sheetName);
		String[] columnArray = new String[columns.size()];
		columns.toArray(columnArray);
		sheet.setColumns(columnArray);
		sheet.setDataList(dataList);
		sheetDtoList.add(sheet);
	}
	private void exportProjectApply() {
		searchProjectApply();
		columns = new ArrayList<String>();
		List<Object[]> dataList = new ArrayList<Object[]>();
		List<String> propertyList = (List<String>) getSessionAttribute("propertys");
		
		columns.add("企业编号");
		columns.add("企业名称");
		
		boolean projectApply_name = checkColumn(propertyList, "projectApply.name", "项目名称");
		boolean projectApply_checkTime = checkColumn(propertyList, "projectApply.checkTime", "验收时间");
		
		List<ProjectApply> list = (List<ProjectApply>) result.getValue();
		if(list!=null)
		for(ProjectApply projectApply : list){
			
			List<Object> datas = new ArrayList<Object>();
			datas.add(projectApply.getCustomer().getCode());
			datas.add(projectApply.getCustomer().getName());
			
			if(projectApply_name){if(projectApply!=null && projectApply.getName()!=null) datas.add(projectApply.getName());
			else datas.add("");}
			if(projectApply_checkTime){if(projectApply!=null && projectApply.getCheckTime()!=null) datas.add(DateUtil.format(projectApply.getCheckTime()));
			else datas.add("");}
			
			dataList.add(datas.toArray());
		}
		
		String sheetName = "项目产品表";
		ExcelSheetDto sheet = new ExcelSheetDto();
		sheet.setSheetName(sheetName);
		String[] columnArray = new String[columns.size()];
		columns.toArray(columnArray);
		sheet.setColumns(columnArray);
		sheet.setDataList(dataList);
		sheetDtoList.add(sheet);
	}
	private void exportCopyright() {
		searchCopyright();
		columns = new ArrayList<String>();
		List<Object[]> dataList = new ArrayList<Object[]>();
		List<String> propertyList = (List<String>) getSessionAttribute("propertys");
		
		columns.add("企业编号");
		columns.add("企业名称");
		
		boolean copyright_name = checkColumn(propertyList, "copyright.name", "著作权名称");
		boolean copyright_serialNo = checkColumn(propertyList, "copyright.serialNo", "证书号");
		boolean copyright_effectivetime = checkColumn(propertyList, "copyright.effectivetime", "发证时间");
		
		List<Copyright> list = (List<Copyright>) result.getValue();
		if(list!=null)
		for(Copyright copyright : list){
			
			List<Object> datas = new ArrayList<Object>();
			datas.add(copyright.getCustomer().getCode());
			datas.add(copyright.getCustomer().getName());
			
			if(copyright_name){if(copyright!=null && copyright.getName()!=null) datas.add(copyright.getName());
			else datas.add("");}
			if(copyright_serialNo){if(copyright!=null && copyright.getSerialNo()!=null) datas.add(copyright.getSerialNo());
			else datas.add("");}
			if(copyright_effectivetime){if(copyright!=null && copyright.getEffectivetime()!=null) datas.add(DateUtil.format(copyright.getEffectivetime()));
			else datas.add("");}
			
			dataList.add(datas.toArray());
		}
		
		String sheetName = "软件著作权表";
		ExcelSheetDto sheet = new ExcelSheetDto();
		sheet.setSheetName(sheetName);
		String[] columnArray = new String[columns.size()];
		columns.toArray(columnArray);
		sheet.setColumns(columnArray);
		sheet.setDataList(dataList);
		sheetDtoList.add(sheet);
	}


	private boolean checkColumn(List<String> propertyList, String fieldName, String label){
		if(propertyList.contains(fieldName)) {
			columns.add(label);
			return true;
		} else return false;
	}

	public String execute(){
		if(tab.equals("result")) {
			resetCriteria();
		}
		if(tab.equals("customer")) {
			searchCustomer();
		} else if(tab.equals("staffer")) {
			searchStaffer();
		} else if(tab.equals("incubationRoute")) {
			searchIncubationRoute();
		} else if(tab.equals("customerQualification")) {
			searchCustomerQualification();
		} else if(tab.equals("customerVentureType")) {
			searchCustomerVentureType();
		} else if(tab.equals("contect")) {
			searchContect();
		} else if(tab.equals("patent")) {
			searchPatent();
		} else if(tab.equals("brand")) {
			searchBrand();
		} else if(tab.equals("projectApply")) {
			searchProjectApply();
		} else if(tab.equals("copyright")) {
			searchCopyright();
		}
		return tab;
	}
	
	private void searchStafferId(){
		if(hasCriterias("staffer")){
			Map<String,String[]> map = getCriteriasMap();
			Filter filter = new Filter(Staffer.class);
			filter.include("id").include("customerId");
			setCriterias(map,filter,"staffer");
			List<Staffer> list = stafferService.getListByFilter(filter).getValue();
			List<Long> idList = new ArrayList<Long>();
			List<Long> customerIdList = new ArrayList<Long>();
			for (Staffer bean : list) {
				idList.add(bean.getId());
				customerIdList.add(bean.getCustomerId());
			}
			if(filter.getCriterionsCount()!=0)
				mergeCustomerId(customerIdList);
			setSessionAttribute("stafferIdList", idList);
		}
	}
	
	private void searchStaffer() {
		Filter filter = new Filter(Staffer.class);
		filter.in("customerId", getSessionCustomerIdList().toArray());
		if(getSessionAttribute("stafferIdList")!=null){
			filter.in("id", getSessionIdList("stafferIdList").toArray());
		}
		setPager(filter);
		List<Staffer> stafferList = stafferService.getListByFilter(filter).getValue();
		result = Result.value(stafferList);
	}
	
	private void searchCopyrightId() {
		if(hasCriterias("copyright")){
			Map<String,String[]> map = getCriteriasMap();
			Filter filter = new Filter(Copyright.class);
			filter.include("id").include("customerId");
			setCriterias(map,filter,"copyright");
			List<Copyright> list = copyrightService.getListByFilter(filter).getValue();
			List<Long> idList = new ArrayList<Long>();
			List<Long> customerIdList = new ArrayList<Long>();
			for (Copyright bean : list) {
				idList.add(bean.getId());
				customerIdList.add(bean.getCustomerId());
			}
			if(filter.getCriterionsCount()!=0)
				mergeCustomerId(customerIdList);
			setSessionAttribute("copyrightIdList", idList);
		}
	}
	private void searchCopyright() {
		Filter filter = new Filter(Copyright.class);
		filter.in("customerId", getSessionCustomerIdList().toArray());
		if(getSessionAttribute("copyrightIdList")!=null){
			filter.in("id", getSessionIdList("copyrightIdList").toArray());
		}
		setPager(filter);
		List<Copyright> copyrightList = copyrightService.getListByFilter(filter).getValue();
		result = Result.value(copyrightList);
	}

	private void searchProjectApplyId() {
		if(hasCriterias("projectApply")){
			Map<String,String[]> map = getCriteriasMap();
			Filter filter = new Filter(ProjectApply.class);
			filter.include("id").include("customerId");
			setCriterias(map,filter,"projectApply");
			List<ProjectApply> list = projectApplyService.getListByFilter(filter).getValue();
			List<Long> idList = new ArrayList<Long>();
			List<Long> customerIdList = new ArrayList<Long>();
			for (ProjectApply bean : list) {
				idList.add(bean.getId());
				customerIdList.add(bean.getCustomerId());
			}
			if(filter.getCriterionsCount()!=0)
				mergeCustomerId(customerIdList);
			setSessionAttribute("projectApplyIdList", idList);
		}
	}
	private void searchProjectApply() {
		Filter filter = new Filter(ProjectApply.class);
		filter.in("customerId", getSessionCustomerIdList().toArray());
		if(getSessionAttribute("projectApplyIdList")!=null){
			filter.in("id", getSessionIdList("projectApplyIdList").toArray());
		}
		setPager(filter);
		List<ProjectApply> projectApplyList = projectApplyService.getListByFilter(filter).getValue();
		result = Result.value(projectApplyList);
	}

	private void searchBrandId() {
		if(hasCriterias("brand")){
			Map<String,String[]> map = getCriteriasMap();
			Filter filter = new Filter(Brand.class);
			filter.include("id").include("customerId");
			setCriterias(map,filter,"brand");
			List<Brand> list = brandService.getListByFilter(filter).getValue();
			List<Long> idList = new ArrayList<Long>();
			List<Long> customerIdList = new ArrayList<Long>();
			for (Brand bean : list) {
				idList.add(bean.getId());
				customerIdList.add(bean.getCustomerId());
			}
			if(filter.getCriterionsCount()!=0)
				mergeCustomerId(customerIdList);
			setSessionAttribute("brandIdList", idList);
		}
	}
	private void searchBrand() {
		Filter filter = new Filter(Brand.class);
		filter.in("customerId", getSessionCustomerIdList().toArray());
		if(getSessionAttribute("brandIdList")!=null){
			filter.in("id", getSessionIdList("brandIdList").toArray());
		}
		setPager(filter);
		List<Brand> brandList = brandService.getListByFilter(filter).getValue();
		result = Result.value(brandList);
	}

	private void searchPatentId() {
		if(hasCriterias("patent")){
			Map<String,String[]> map = getCriteriasMap();
			Filter filter = new Filter(Patent.class);
			filter.include("id").include("customerId");
			setCriterias(map,filter,"patent");
			List<Patent> list = patentService.getListByFilter(filter).getValue();
			List<Long> idList = new ArrayList<Long>();
			List<Long> customerIdList = new ArrayList<Long>();
			for (Patent bean : list) {
				idList.add(bean.getId());
				customerIdList.add(bean.getCustomerId());
			}
			if(filter.getCriterionsCount()!=0)
				mergeCustomerId(customerIdList);
			setSessionAttribute("patentIdList", idList);
		}
	}
	private void searchPatent() {
		Filter filter = new Filter(Patent.class);
		filter.in("customerId", getSessionCustomerIdList().toArray());
		if(getSessionAttribute("patentIdList")!=null){
			filter.in("id", getSessionIdList("patentIdList").toArray());
		}
		setPager(filter);
		List<Patent> patentList = patentService.getListByFilter(filter).getValue();
		result = Result.value(patentList);
	}

	private void searchContectId() {
		if(hasCriterias("contect")){
			Map<String,String[]> map = getCriteriasMap();
			Filter filter = new Filter(Contect.class);
			filter.include("id").include("customerId");
			setCriterias(map,filter,"contect");
			List<Contect> list = contectService.getListByFilter(filter).getValue();
			List<Long> idList = new ArrayList<Long>();
			List<Long> customerIdList = new ArrayList<Long>();
			for (Contect bean : list) {
				idList.add(bean.getId());
				customerIdList.add(bean.getCustomerId());
			}
			if(filter.getCriterionsCount()!=0)
				mergeCustomerId(customerIdList);
			setSessionAttribute("contectIdList", idList);
		}
	}
	private void searchContect() {
		Filter filter = new Filter(Contect.class);
		filter.in("customerId", getSessionCustomerIdList().toArray());
		if(getSessionAttribute("contectIdList")!=null){
			filter.in("id", getSessionIdList("contectIdList").toArray());
		}
		setPager(filter);
		List<Contect> contectList = contectService.getListByFilter(filter).getValue();
		result = Result.value(contectList);
	}

	private void searchIncubationRouteId() {
		if(hasCriterias("incubationRoute.crm")){
			Map<String,String[]> map = getCriteriasMap();
			Map<String,Map<String,Object>> criterionMaps = new HashMap<String, Map<String,Object>>();
			for (String key : map.keySet()) {
				if(key.startsWith("incubationRoute.crm")){
					if(map.get(key)!=null){
						int start = key.indexOf("crm.");
						int end = key.indexOf(".", start+5);
						String routeId = key.substring(start,end);
						if(criterionMaps.get(routeId)==null){
							Map<String,Object> geleMap = new HashMap<String, Object>();
							criterionMaps.put(routeId, geleMap);
						} else {
							criterionMaps.get(routeId).put(key, DateUtil.parse(map.get(key)[0]));
						}
					}
				}
			}
			for (String key : criterionMaps.keySet()) {
				Filter filter = new Filter(IncubationRoute.class);
				filter.eq("routeId", key);
				Map<String, Object> subMap = criterionMaps.get(key);
				for (String key2 : subMap.keySet()) {
					if(key2.endsWith("ge")) filter.ge("time", subMap.get(key2));
					if(key2.endsWith("le")) filter.le("time", subMap.get(key2));
				}
				List<IncubationRoute> list = incubationRouteService.getListByFilter(filter).getValue();
				List<Long> customerIdList = new ArrayList<Long>();
				for (IncubationRoute incubationRoute : list) {
					customerIdList.add(incubationRoute.getCustomerId());
				}
				mergeCustomerId(customerIdList);
			}
		}
	}
	
	private void searchCustomerQualificationId() {
		if(hasCriterias("customerQualification.crm")){
			Map<String,String[]> map = getCriteriasMap();
			Map<String,Map<String,Object>> criterionMaps = new HashMap<String, Map<String,Object>>();
			for (String key : map.keySet()) {
				if(key.startsWith("customerQualification.crm")){
					if(map.get(key)!=null){
						int start = key.indexOf("crm.");
						int end = key.indexOf(".", start+5);
						String qualificationId = key.substring(start,end);
						if(criterionMaps.get(qualificationId)==null){
							Map<String,Object> geleMap = new HashMap<String, Object>();
							criterionMaps.put(qualificationId, geleMap);
						} else {
							criterionMaps.get(qualificationId).put(key, DateUtil.parse(map.get(key)[0]));
						}
					}
				}
			}
			for (String key : criterionMaps.keySet()) {
				Filter filter = new Filter(CustomerQualification.class);
				filter.eq("qualificationId", key);
				Map<String, Object> subMap = criterionMaps.get(key);
				for (String key2 : subMap.keySet()) {
					if(key2.endsWith("ge")) filter.ge("time", subMap.get(key2));
					if(key2.endsWith("le")) filter.le("time", subMap.get(key2));
				}
				List<CustomerQualification> list = customerQualificationService.getListByFilter(filter).getValue();
				List<Long> customerIdList = new ArrayList<Long>();
				for (CustomerQualification customerQualification : list) {
					customerIdList.add(customerQualification.getCustomerId());
				}
				mergeCustomerId(customerIdList);
			}
		}
	}
	
	private void searchCustomerVentureTypeId() {
		if(hasCriterias("customerVentureType")){
			Map<String,String[]> map = getCriteriasMap();
			Filter filter = new Filter(CustomerVentureType.class);
			setCriterias(map,filter,"customerVentureType");
			List<CustomerVentureType> list = customerVentureTypeService.getListByFilter(filter).getValue();
			List<Long> customerIdList = new ArrayList<Long>();
			for (CustomerVentureType customerVentureType : list) {
				customerIdList.add(customerVentureType.getCustomerId());
			}
			mergeCustomerId(customerIdList);
		}
	}
	
	private void searchIncubationRoute() {
		Filter filter = new Filter(IncubationRoute.class);
		filter.in("customerId", getSessionCustomerIdList().toArray());
		if(page!=null){
			if(page!=-1){
				pager = new Pager(page,15*9);
				filter.pager(pager);
			}
		} else {
			pager = new Pager(1,15*9);
			filter.pager(pager);
		}
		List<IncubationRoute> routeList = incubationRouteService.getListByFilter(filter).getValue();
		if(pager!=null){
			pager.setRows(pager.getRows()/9);
			pager.setRecords(pager.getRecords()/9);
		}
		Map<Long, IncubationRouteSearchResultDto> dtoMap = new HashMap<Long, IncubationRouteSearchResultDto>();
		DataDictInitService dataDictInitService = PbActivator.getDataDictInitService();
		incubationRouteList = dataDictInitService.getDataDictByParentId("crm.0025");
		for (IncubationRoute incubationRoute : routeList) {
			Long customerId = incubationRoute.getCustomerId();
			if(dtoMap.get(customerId)==null){
				dtoMap.put(customerId, createIncubationRouteSearchResultDto(customerId));
			} 
			dtoMap.get(customerId).getMap().put(incubationRoute.getRouteId(), incubationRoute);
		}
		List<IncubationRouteSearchResultDto> list = new ArrayList<IncubationRouteSearchResultDto>(dtoMap.values());
		result = Result.value(list);
	}
	
	private void searchCustomerQualification() {
		Filter filter = new Filter(CustomerQualification.class);
		filter.in("customerId", getSessionCustomerIdList().toArray());
		if(page!=null){
			if(page!=-1){
				pager = new Pager(page,15*9);
				filter.pager(pager);
			}
		} else {
			pager = new Pager(1,15*9);
			filter.pager(pager);
		}
		List<CustomerQualification> customerQualificationList = customerQualificationService.getListByFilter(filter).getValue();
		if(pager!=null){
			pager.setRows(pager.getRows()/9);
			pager.setRecords(pager.getRecords()/9);
		}
		Map<Long, CustomerQualificationSearchResultDto> dtoMap = new HashMap<Long, CustomerQualificationSearchResultDto>();
		DataDictInitService dataDictInitService = PbActivator.getDataDictInitService();
		qualificationList = dataDictInitService.getDataDictByParentId("crm.0027");
		for (CustomerQualification customerQualification : customerQualificationList) {
			Long customerId = customerQualification.getCustomerId();
			if(dtoMap.get(customerId)==null){
				dtoMap.put(customerId, createCustomerQualificationSearchResultDto(customerId));
			} 
			dtoMap.get(customerId).getMap().put(customerQualification.getQualificationId(), customerQualification);
		}
		List<CustomerQualificationSearchResultDto> list = new ArrayList<CustomerQualificationSearchResultDto>(dtoMap.values());
		result = Result.value(list);
	}
	
	private void searchCustomerVentureType() {
		Filter filter = new Filter(CustomerVentureType.class);
		filter.in("customerId", getSessionCustomerIdList().toArray());
		if(page!=null){
			if(page!=-1){
				pager = new Pager(page,15*9);
				filter.pager(pager);
			}
		} else {
			pager = new Pager(1,15*9);
			filter.pager(pager);
		}
		List<CustomerVentureType> typeList = customerVentureTypeService.getListByFilter(filter).getValue();
		if(pager!=null){
			pager.setRows(pager.getRows()/9);
			pager.setRecords(pager.getRecords()/9);
		}
		Map<Long, CustomerVentureTypeSearchResultDto> dtoMap = new HashMap<Long, CustomerVentureTypeSearchResultDto>();
		DataDictInitService dataDictInitService = PbActivator.getDataDictInitService();
		enterpriseTypeList = dataDictInitService.getDataDictByParentId("crm.0030");
		for (CustomerVentureType customerVentureType : typeList) {
			Long customerId = customerVentureType.getCustomerId();
			if(dtoMap.get(customerId)==null){
				dtoMap.put(customerId, createCustomerVentureTypeSearchResultDto(customerId));
			} 
			dtoMap.get(customerId).getMap().put(customerVentureType.getVentureTypeId(), customerVentureType);
		}
		List<CustomerVentureTypeSearchResultDto> list = new ArrayList<CustomerVentureTypeSearchResultDto>(dtoMap.values());
		result = Result.value(list);
	}
	
	private CustomerVentureTypeSearchResultDto createCustomerVentureTypeSearchResultDto(Long customerId){
		CustomerVentureTypeSearchResultDto dto = new CustomerVentureTypeSearchResultDto();
		dto.setCustomerId(customerId);
		dto.setCustomer(customerService.getBeanById(customerId).getValue());
		Map<String,CustomerVentureType> map = new HashMap<String, CustomerVentureType>();
		for (DataDict route : enterpriseTypeList) {
			map.put(route.getId(), null);
		}
		dto.setMap(map);
		return dto;
	}
	
	private CustomerQualificationSearchResultDto createCustomerQualificationSearchResultDto(Long customerId){
		CustomerQualificationSearchResultDto dto = new CustomerQualificationSearchResultDto();
		dto.setCustomerId(customerId);
		dto.setCustomer(customerService.getBeanById(customerId).getValue());
		Map<String,CustomerQualification> map = new HashMap<String, CustomerQualification>();
		for (DataDict route : qualificationList) {
			map.put(route.getId(), null);
		}
		dto.setMap(map);
		return dto;
	}
	
	private IncubationRouteSearchResultDto createIncubationRouteSearchResultDto(Long customerId){
		IncubationRouteSearchResultDto dto = new IncubationRouteSearchResultDto();
		dto.setCustomerId(customerId);
		dto.setCustomer(customerService.getBeanById(customerId).getValue());
		Map<String,IncubationRoute> map = new HashMap<String, IncubationRoute>();
		for (DataDict route : incubationRouteList) {
			map.put(route.getId(), null);
		}
		dto.setMap(map);
		return dto;
	}

	private void searchCustomerId() {
			Map<String,String[]> map = getCriteriasMap();
			Filter cfilter = new Filter(Customer.class);
			cfilter.include("id").include("name");
			setCriterias(map,cfilter,"customer");
			if(hasCriterias("customerInfo")){
				cfilter.createAlias("customerInfo", "customerInfo");
				setCriteriasWithAlias(map,cfilter,"customerInfo");
			}
			if(hasCriterias("incubationInfo")){
				cfilter.createAlias("incubationInfo", "incubationInfo");
				cfilter.createAlias("incubationInfo.status", "incubationInfoStatus");
				setCriteriasWithAlias(map,cfilter,"incubationInfo");
			}
			List<Customer> customerList = customerService.getListByFilter(cfilter).getValue();
			List<Long> customerIdList = new ArrayList<Long>();
			for (Customer customer : customerList) {
				customerIdList.add(customer.getId());
			}
			setSessionAttribute("customerIdList", customerIdList);
	}
	
	private boolean hasProperty(String criteria){
		boolean exist = false;
		List<String> propertyList = (List<String>) getSessionAttribute("propertys");
		for(String property : propertyList){
			if(property.startsWith(criteria)) {
				exist = true;
				break;
			}
		}
		return exist;
	}
	
	private boolean hasCriterias(String criteria){
		boolean exist = false;
		Map<String, String[]> map = getCriteriasMap();
		for(String key : map.keySet()){
			if(key.startsWith(criteria)) {
				String[] value = map.get(key);
				if(value!=null && value.length>0 && value[0] != null && value[0].length()>0) {
					exist = true;
					break;
				}
			}
		}
		return exist;
	}
	
	private void searchLegalId(){
		if(hasCriterias("legal")){
			Map<String,String[]> map = getCriteriasMap();
			Filter filter = new Filter(Staffer.class);
			filter.eq("legal", BooleanEnum.YES);
			filter.include("id").include("customerId");
			setCriterias(map,filter,"legal");
			List<Staffer> list = stafferService.getListByFilter(filter).getValue();
			List<Long> idList = new ArrayList<Long>();
			List<Long> customerIdList = new ArrayList<Long>();
			for (Staffer bean : list) {
				idList.add(bean.getId());
				customerIdList.add(bean.getCustomerId());
			}
			if(filter.getCriterionsCount()!=1)
				mergeCustomerId(customerIdList);
			setSessionAttribute("legalIdList", idList);
		}
	}
	
	private void searchManagerId(){
		if(hasCriterias("manager")){
			Map<String,String[]> map = getCriteriasMap();
			Filter filter = new Filter(Staffer.class);
			filter.eq("manager", BooleanEnum.YES);
			filter.include("id").include("customerId");
			setCriterias(map,filter,"manager");
			List<Staffer> list = stafferService.getListByFilter(filter).getValue();
			List<Long> idList = new ArrayList<Long>();
			List<Long> customerIdList = new ArrayList<Long>();
			for (Staffer bean : list) {
				idList.add(bean.getId());
				customerIdList.add(bean.getCustomerId());
			}
			if(filter.getCriterionsCount()!=1)
				mergeCustomerId(customerIdList);
			setSessionAttribute("managerIdList", idList);
		}
	}
	
	private void searchPropertyId() {
		Map<String,String[]> map = getCriteriasMap();
		String dr1 = map.get("dataReport1")[0];
		String dr2 = map.get("dataReport2")[0];
		Long reportId1 = null;
		if(dr1!=null && dr1.length()>0){
			reportId1 = Long.parseLong(dr1);
			DataReport report1 = dataReportService.getBeanById(reportId1).getValue();
			setSessionAttribute("report1", report1);
		}
		Long reportId2 = null;
		if(dr2!=null && dr2.length()>0){
			reportId2 = Long.parseLong(dr2);
			DataReport report2 = dataReportService.getBeanById(reportId2).getValue();
			setSessionAttribute("report2", report2);
		}
		Map<Long,Map<String,Double>> criterionMaps = new HashMap<Long, Map<String,Double>>();
		Set<Long> propertyIds = new HashSet<Long>();
		for (String key : map.keySet()) {
			if(key.startsWith("property.") && (key.endsWith("ge") || key.endsWith("le"))){
				if(map.get(key)!=null && map.get(key).length>0 && map.get(key)[0].trim().length()>0){
					int start = "property.".length();
					int end = key.length()-3;
					Long propertyId = Long.parseLong(key.substring(start,end));
					propertyIds.add(propertyId);
					if(criterionMaps.get(propertyId)==null){
						Map<String,Double> geleMap = new HashMap<String, Double>();
						criterionMaps.put(propertyId, geleMap);
					}
					criterionMaps.get(propertyId).put(key, Double.parseDouble(map.get(key)[0]));
				}
			}
		}
		setSessionAttribute("reportPropertyMap", criterionMaps);
		if(criterionMaps.size()==0) return;
		List<DataProperty> dpList = dataPropertyService.getListByFilter(new Filter(DataProperty.class).in("id", propertyIds.toArray())).getValue();
		Map<Long,DataProperty> dpMap = new HashMap<Long, DataProperty>();
		for (DataProperty dataProperty : dpList) {
			dpMap.put(dataProperty.getId(), dataProperty);
		}
		
		List<DataReportValue> dataReport1List = new ArrayList<DataReportValue>();
		List<DataReportValue> dataReport2List = new ArrayList<DataReportValue>();
		for (Long propertyId : criterionMaps.keySet()) {
			Filter filter = new Filter(DataReportValue.class);
			filter.createAlias("property", "property");
			filter.createAlias("reportCustomer", "reportCustomer");
			filter.eq("property.propertyId", propertyId);
			DataTypeEnum dt = dpMap.get(propertyId).getDataType();
			Map<String, Double> subMap = criterionMaps.get(propertyId);
			for (String key : subMap.keySet()) {
				if(key.endsWith("ge")) {
					if(dt.equals(DataTypeEnum.DOUBLE)) 
						filter.ge("doubleVal", subMap.get(key));
					else if(dt.equals(DataTypeEnum.INT))
						filter.ge("intVal", subMap.get(key).intValue());
					
				}
				if(key.endsWith("le")) {
					if(dt.equals(DataTypeEnum.DOUBLE)) 
						filter.le("doubleVal", subMap.get(key));
					else if(dt.equals(DataTypeEnum.INT))
						filter.le("intVal", subMap.get(key).intValue());
				}
			}
			if(reportId1!=null){
				filter.eq("reportCustomer.reportId", reportId1);
				List<DataReportValue> drvl = dataReportValueService.getListByFilter(filter).getValue();
				dataReport1List.addAll(drvl);
			}
			if(reportId2!=null){
				filter.eq("reportCustomer.reportId", reportId2);
				List<DataReportValue> drvl = dataReportValueService.getListByFilter(filter).getValue();
				dataReport2List.addAll(drvl);
			}
		}
		Set<Long> customerId1 = new HashSet<Long>();
		for (DataReportValue dataReportValue : dataReport1List) {
			customerId1.add(dataReportValue.getReportCustomer().getCustomerId());
		}
		Set<Long> customerId2 = new HashSet<Long>();
		for (DataReportValue dataReportValue : dataReport2List) {
			customerId1.add(dataReportValue.getReportCustomer().getCustomerId());
		}
		customerId1.retainAll(customerId2);
		if(criterionMaps.size()>0){
			mergeCustomerId(customerId1);
		}
	}
	
	private void handleProperty(Filter filter,String prefix){
		handleProperty(filter, prefix, false);
	}
	private void handleProperty(Filter filter,String prefix,boolean includePrefix){
		List<String> propertyList = (List<String>) getSessionAttribute("propertys");
		for (String property : propertyList) {
			if(property.startsWith(prefix)) {
				if(includePrefix) {
					filter.include(property);
				} else {
					filter.include(property.replace(prefix+".", ""));
				}
			}
		}
		if(prefix.equals("customer")){
			filter.include("id").include("name").include("code");
		} else {
			filter.include("customer.code").include("customer.name");
		}
	}
	
	private void searchCustomer() {
		Filter cfilter = new Filter(Customer.class);
		cfilter.in("id", getSessionCustomerIdList().toArray());
		setPager(cfilter);
		List<Customer> customerList = customerService.getListByFilter(cfilter).getValue();
		
		Map<Long,Staffer> legalMap = new HashMap<Long, Staffer>();
		if(hasProperty("legal")){
			Filter lfilter = new Filter(Staffer.class);
			lfilter.in("customerId", getSessionCustomerIdList().toArray());
			if(getSessionIdList("legalIdList")!=null){
				lfilter.in("id", getSessionIdList("legalIdList").toArray());
			}
			List<Staffer> legalList = stafferService.getListByFilter(lfilter).getValue();
			for (Staffer staffer : legalList) {
				legalMap.put(staffer.getCustomerId(), staffer);
			}
		}
		
		Map<Long,Staffer> managerMap = new HashMap<Long, Staffer>();
		if(hasProperty("manager")){
			Filter mfilter = new Filter(Staffer.class);
			mfilter.in("customerId", getSessionCustomerIdList().toArray());
			if(getSessionIdList("managerIdList")!=null){
				mfilter.in("id", getSessionIdList("managerIdList").toArray());
			}
			List<Staffer> managerList = stafferService.getListByFilter(mfilter).getValue();
			for (Staffer staffer : managerList) {
				managerMap.put(staffer.getCustomerId(), staffer);
			}
		}
		
		if(hasProperty("propertyId")){
			searchProperty();
		}else{
			getRequest().getSession().setAttribute("report1", null);
			getRequest().getSession().setAttribute("report2", null);
		}
		
		List<CustomerSearchResultDto> dtoList = new ArrayList<CustomerSearchResultDto>();
		for (Customer customer : customerList) {
			CustomerSearchResultDto dto = new CustomerSearchResultDto();
			dto.setCustomer(customer);
			dto.setLegal(legalMap.get(customer.getId()));
			dto.setManager(managerMap.get(customer.getId()));
			dtoList.add(dto);
		}
		result = Result.value(dtoList);
	}
	
	@SuppressWarnings("unchecked")
	private void searchProperty() {
		
		Long reportId1 = null;
		if(getSessionAttribute("report1")!=null){
			reportId1 = ((DataReport)getSessionAttribute("report1")).getId();
		}
		Long reportId2 = null;
		if(getSessionAttribute("report2")!=null){
			reportId2 = ((DataReport)getSessionAttribute("report2")).getId();
		}
		
		
		List<Long> propertyIds = new ArrayList<Long>();
		for (String property : getSessionPropertyList()) {
			if(property.startsWith("propertyId")){
				propertyIds.add(Long.parseLong(property.replace("propertyId", "")));
			}
		}
		List<DataProperty> dpList = dataPropertyService.getListByFilter(new Filter(DataProperty.class).in("id", propertyIds.toArray())).getValue();
		setSessionAttribute("dataPropertyList", dpList);
		
		Map<Long,DataProperty> dpMap = new HashMap<Long, DataProperty>();
		for (DataProperty dataProperty : dpList) {
			dpMap.put(dataProperty.getId(), dataProperty);
		}
		List<DataReportValue> dataReport1List = new ArrayList<DataReportValue>();
		List<DataReportValue> dataReport2List = new ArrayList<DataReportValue>();
		
		Map<Long,Map<String,Double>> criterionMaps = (Map<Long, Map<String, Double>>) getSessionAttribute("reportPropertyMap");
		for (Long propertyId : dpMap.keySet()) {
			Filter filter = new Filter(DataReportValue.class);
			filter.createAlias("property", "property");
			filter.createAlias("reportCustomer", "reportCustomer");
			filter.eq("property.propertyId", propertyId);
			filter.in("reportCustomer.customerId", getSessionCustomerIdList().toArray());
			DataTypeEnum dt = dpMap.get(propertyId).getDataType();
			Map<String, Double> subMap = criterionMaps.get(propertyId);
			if(subMap!=null) {
				for (String key : subMap.keySet()) {
					if(key.endsWith("ge")) {
						if(dt.equals(DataTypeEnum.DOUBLE)) 
							filter.ge("doubleVal", subMap.get(key));
						else if(dt.equals(DataTypeEnum.INT))
							filter.ge("intVal", subMap.get(key).intValue());
					}
					if(key.endsWith("le")) {
						if(dt.equals(DataTypeEnum.DOUBLE)) 
							filter.le("doubleVal", subMap.get(key));
						else if(dt.equals(DataTypeEnum.INT))
							filter.le("intVal", subMap.get(key).intValue());
					}
				}
			}
			
			if(reportId1!=null){
				filter.eq("reportCustomer.reportId", reportId1);
				List<DataReportValue> drvl = dataReportValueService.getListByFilter(filter).getValue();
				dataReport1List.addAll(drvl);
			}
			if(reportId2!=null){
				filter.eq("reportCustomer.reportId", reportId2);
				List<DataReportValue> drvl = dataReportValueService.getListByFilter(filter).getValue();
				dataReport2List.addAll(drvl);
			}
		}
		Map<Long, Map<Long, Map<Long,DataReportValue>>> customerReportValueMap1 = listToMap(dataReport1List);
		Map<Long, Map<Long, Map<Long,DataReportValue>>> customerReportValueMap2 = listToMap(dataReport2List);
		
		getRequest().setAttribute("customerReportValueMap1", customerReportValueMap1);
		getRequest().setAttribute("customerReportValueMap2", customerReportValueMap2);
	}
	
	@SuppressWarnings("unchecked")
	private List<String> getSessionPropertyList() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		return (List<String>)session.getAttribute("propertys");
	}

	private Map<Long, Map<Long, Map<Long,DataReportValue>>> listToMap(List<DataReportValue> dataReportList){
		Map<Long, Map<Long, Map<Long,DataReportValue>>> customerReportValueMap = new HashMap<Long, Map<Long, Map<Long,DataReportValue>>>();
		for (DataReportValue dataReportValue : dataReportList) {
			Long customerId = dataReportValue.getReportCustomer().getCustomerId();
			Long reportId = dataReportValue.getReportCustomer().getReportId();
			if(customerReportValueMap.get(customerId)==null) {
				Map<Long,Map<Long, DataReportValue>> valueMap = new HashMap<Long, Map<Long,DataReportValue>>();
				customerReportValueMap.put(customerId, valueMap);
			}
			Map<Long,Map<Long, DataReportValue>> customerMap = customerReportValueMap.get(customerId);
			if(customerMap.get(reportId)==null){
				Map<Long, DataReportValue> valueMap = new HashMap<Long, DataReportValue>();
				customerMap.put(reportId, valueMap);
			}
			Map<Long, DataReportValue> valueMap = customerMap.get(reportId);
			valueMap.put(dataReportValue.getProperty().getPropertyId(), dataReportValue);
		}
		return customerReportValueMap;
	}

	private void debug(Object... ss){
		for (Object s : ss) {
			System.out.print(s+"\t");
		}
		System.out.println();
	}
	
	private HttpServletRequest getRequest(){
		return ServletActionContext.getRequest();
	}
	
	private void setSessionAttribute(String name, Object value){
		getRequest().getSession().setAttribute(name, value);
	}
	
	private Object getSessionAttribute(String name){
		return getRequest().getSession().getAttribute(name);
	}
	
	@SuppressWarnings("unchecked")
	private void mergeCustomerId(Collection<Long> customerIdList){
		String name = "customerIdList";
		List<Long> allList = (List<Long>) getSessionAttribute(name);
		allList.retainAll(customerIdList);
		setSessionAttribute(name, allList);
	}
	
	private List<Long> getSessionCustomerIdList(){
		List<Long> list = getSessionIdList("customerIdList");
		if(list.size()==0) list.add(-1l);
		return list;
	}
	
	@SuppressWarnings("unchecked")
	private List<Long> getSessionIdList(String name){
		return (List<Long>) getSessionAttribute(name);
	}
	
	private void setPager(Filter filter) {
		if(page!=null){
			if(page!=-1){
				pager = new Pager(page,15);
				filter.pager(pager);
			}
		} else {
			pager = new Pager(1,15);
			filter.pager(pager);
		}
	}
	
	@SuppressWarnings("unchecked")
	private Map<String,String[]> getCriteriasMap(){
		return (Map<String, String[]>) getSessionAttribute("criterias");
	}
	
	private void setCriteriasWithAlias(Map<String, String[]> map, Filter filter, String prefix){
		for (String key : map.keySet()) {
			if(key.startsWith(prefix)){
				if(key.endsWith("like")) {
					setLikeCriterias(filter, key.substring(0, key.indexOf(".like")), map.get(key));
				}
				if(key.endsWith("eq")) {
					setEqCriterias(filter, key.substring(0, key.indexOf(".eq")), map.get(key));
				}
				if(key.endsWith("in")) {
					setInCriterias(filter, key.substring(0, key.indexOf(".in")), map.get(key));
				}
				if(key.endsWith("le")) {
					setLeCriterias(filter, key.substring(0, key.indexOf(".le")), map.get(key));
				}
				if(key.endsWith("ge")) {
					setGeCriterias(filter, key.substring(0, key.indexOf(".ge")), map.get(key));
				}
			}
		}
	}
	
	private String getAliasField(String field){
		int count = 0;
		int index = -1;
		while((index = field.indexOf(".", index+1)) != -1){
			count++;
		}
		if(count==2){
			index = field.indexOf(".");
			String pre = field.substring(0, index);
			String cen = field.substring(index+1,index+2).toUpperCase();
			String suf = field.substring(index+2);
			field = pre + cen + suf;
			return field;
		} else return field;
	}
	
	private void setCriterias(Map<String, String[]> map, Filter filter, String prefix){
		prefix = prefix + ".";
		for (String key : map.keySet()) {
			if(key.startsWith(prefix)){
				if(key.endsWith("like")) {
					setLikeCriterias(filter, key.substring(key.indexOf(prefix)+prefix.length(), key.indexOf(".like")), map.get(key));
				}
				if(key.endsWith("eq")) {
					setEqCriterias(filter, key.substring(key.indexOf(prefix)+prefix.length(), key.indexOf(".eq")), map.get(key));
				}
				if(key.endsWith("in")) {
					setInCriterias(filter, key.substring(key.indexOf(prefix)+prefix.length(), key.indexOf(".in")), map.get(key));
				}
				if(key.endsWith("le")) {
					setLeCriterias(filter, key.substring(key.indexOf(prefix)+prefix.length(), key.indexOf(".le")), map.get(key));
				}
				if(key.endsWith("ge")) {
					setGeCriterias(filter, key.substring(key.indexOf(prefix)+prefix.length(), key.indexOf(".ge")), map.get(key));
				}
			}
		}
	}
	
	private Class<?> getFieldType(Filter filter, String field) {
		try {
			Class<?> clazz = filter.getBeanClass();
			if (field.indexOf(".") == -1) {
				return clazz.getDeclaredField(field).getType();
			} else {
				String[] fields = field.split("\\.");
				for (String string : fields) {
					clazz = clazz.getDeclaredField(string).getType();
				}
				return clazz;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	private void setLeCriterias(Filter filter, String field, String[] values) {
		Class<?> fieldType = getFieldType(filter,field);
		Object value = null;
		if (fieldType.equals(Integer.class) && values[0].trim().length()>0) {
			value = Integer.valueOf(values[0].trim());
		} else if (fieldType.equals(Double.class) && values[0].trim().length()>0) {
			value = Double.valueOf(values[0].trim());
		} else if (fieldType.equals(Date.class) && values[0].trim().length()>0) {
			value = DateUtil.parse(values[0].trim());
		} else if (fieldType.equals(BigDecimal.class) && values[0].trim().length()>0){
			value = BigDecimal.valueOf(Double.valueOf(values[0].trim()));
		}
		if(value!=null){
			field = getAliasField(field);
			debug(field,"le",value);
			filter.le(field, value);
		}
	}

	private void setGeCriterias(Filter filter, String field,String[] values){
		Class<?> fieldType = getFieldType(filter,field);
		Object value = null;
		if (fieldType.equals(Integer.class) && values[0].trim().length()>0) {
			value = Integer.valueOf(values[0].trim());
		} else if (fieldType.equals(Double.class) && values[0].trim().length()>0) {
			value = Double.valueOf(values[0].trim());
		} else if (fieldType.equals(Date.class) && values[0].trim().length()>0) {
			value = DateUtil.parse(values[0].trim());
		} else if (fieldType.equals(BigDecimal.class) && values[0].trim().length()>0){
			value = BigDecimal.valueOf(Double.valueOf(values[0].trim()));
		}
		if(value!=null){
			field = getAliasField(field);
			debug(field,"ge",value);
			filter.ge(field, value);
		}
		
	}

	private void setInCriterias(Filter filter,String field,String[] values){
		Class<?> fieldType = getFieldType(filter,field);
		Object[] value = null;
		if(fieldType.equals(String.class)) {
			value = getStringArray(values);
		} else if(fieldType.equals(Long.class)) {
			value = getLongArray(values);
		} else if(fieldType.getGenericSuperclass().toString().startsWith("java.lang.Enum")){
			Enum<?>[] enums = (Enum[]) fieldType.getEnumConstants();
			List<Object> list = new ArrayList<Object>();
			for (int j = 0; j < values.length; j++) {
				for (int i = 0; i < enums.length; i++) {
					if(enums[i].name().equals(values[j].trim())){
						list.add(enums[i]);
						break;
					}
				}
			}
			value = list.toArray();
		}
		if(value!=null && value.length>0){
			field = getAliasField(field);
			debug(field,"in",value);
			filter.in(field, value);
		}
	}
	
	private Object[] getStringArray(String[] values) {
		String[] array = new String[values.length];
		for (int i = 0; i < array.length; i++) {
			if(values[i].trim()!=null){
				array[i] = values[i].trim();
			}
		}
		return array;
	}
	private Object[] getLongArray(String[] values) {
		Long[] array = new Long[values.length];
		for (int i = 0; i < array.length; i++) {
			if(values[i].trim()!=null){
				array[i] = Long.parseLong(values[i].trim());
			}
		}
		return array;
	}

	private void setEqCriterias(Filter filter,String field,String[] values){
		Class<?> fieldType = getFieldType(filter,field);
		Object value = null;
		if(values[0].trim().length()>0){
			if(fieldType.equals(String.class)) {
				value = values[0].trim();
			} else if(fieldType.equals(Long.class)) {
				value = Long.parseLong(values[0].trim());
			} else if(fieldType.getGenericSuperclass().toString().startsWith("java.lang.Enum")){
				Enum<?>[] enums = (Enum[]) fieldType.getEnumConstants();
				for (int i = 0; i < enums.length; i++) {
					if(enums[i].name().equals(values[0].trim())){
						value = enums[i];
						break;
					}
				}
			} 
		}
		if(value!=null) {
			field = getAliasField(field);
			debug(field,"eq",value);
			filter.eq(field, value);
		}
	}
	private void setLikeCriterias(Filter filter,String field,String[] values){
		if(values[0].trim().length()>0){
			field = getAliasField(field);
			debug(field,"like",values[0]);
			filter.like(field, values[0]);
		}
	}

	@SuppressWarnings("unchecked")
	private void resetCriteria() {
		
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		
		String[] propertys = request.getParameterValues("property");
		if(propertys!=null){
			session.setAttribute("propertys", Arrays.asList(propertys));
		}else{
			session.setAttribute("propertys", new ArrayList<String>());
		}
		Map<String,String[]> parameterMap = request.getParameterMap();
		if(parameterMap!=null){
			Map<String,String[]> map = new HashMap<String, String[]>();
			for (String key : parameterMap.keySet()) {
				map.put(key, parameterMap.get(key));
			}
			setSessionAttribute("criterias", map);
		}
		
		searchCustomerId();
		searchBrandId();
		searchContectId();
		searchCopyrightId();
		searchIncubationRouteId();
		searchCustomerQualificationId();
		searchCustomerVentureTypeId();
		searchLegalId();
		searchManagerId();
		searchPatentId();
		searchProjectApplyId();
		searchPropertyId();
		searchStafferId();
	}

	@SuppressWarnings("unchecked")
	public String loadIncubationRoute(){
		DataDictInitService dataDictInitService = PbActivator.getDataDictInitService();
		if(dataDictInitService!=null){
			incubationRouteList = dataDictInitService.getDataDictByParentId("crm.0025");
			qualificationList = dataDictInitService.getDataDictByParentId("crm.0027");
			taxadressList = dataDictInitService.getDataDictByParentId("crm.0028");
			incubateList = dataDictInitService.getDataDictByParentId("crm.0026");
			technicList = dataDictInitService.getDataDictByParentId("crm.0002");
			enterpriseTypeList = dataDictInitService.getDataDictByParentId("crm.0030");
		}
		List<DataTemplatePropertyConfig> configList = dataTemplatePropertyConfigService.getListByFilter(new Filter(DataTemplatePropertyConfig.class).eq("templateId", 1l)).getValue();
		propertyList = new ArrayList<DataProperty>();
		for (DataTemplatePropertyConfig dataTemplatePropertyConfig : configList) {
			propertyList.add(dataTemplatePropertyConfig.getProperty());
		}
		propertyList = TreeUtil.generateTree(propertyList);
		reportHtml = new SearchReportFormat().format(propertyList);
		return "rvalue";
	}
	
	public Result<?> getResult() {
		return result;
	}

	public List<DataDict> getIncubationRouteList() {
		return incubationRouteList;
	}

	public List<DataDict> getTechnicList() {
		return technicList;
	}

	public List<DataDict> getQualificationList() {
		return qualificationList;
	}

	public List<DataDict> getTaxadressList() {
		return taxadressList;
	}

	public List<DataDict> getIncubateList() {
		return incubateList;
	}

	public void setDataTemplatePropertyConfigService(
			DataTemplatePropertyConfigService dataTemplatePropertyConfigService) {
		this.dataTemplatePropertyConfigService = dataTemplatePropertyConfigService;
	}

	public List<DataProperty> getPropertyList() {
		return propertyList;
	}

	public String getReportHtml() {
		return reportHtml;
	}

	public String getTab() {
		return tab;
	}

	public void setTab(String tab) {
		this.tab = tab;
	}

	public Pager getPager() {
		return pager;
	}

	public void setPager(Pager pager) {
		this.pager = pager;
	}

	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}

	public void setStafferService(StafferService stafferService) {
		this.stafferService = stafferService;
	}

	public void setIncubationRouteService(
			IncubationRouteService incubationRouteService) {
		this.incubationRouteService = incubationRouteService;
	}

	public void setBrandService(BrandService brandService) {
		this.brandService = brandService;
	}

	public void setCopyrightService(CopyrightService copyrightService) {
		this.copyrightService = copyrightService;
	}

	public void setProjectApplyService(ProjectApplyService projectApplyService) {
		this.projectApplyService = projectApplyService;
	}

	public void setContectService(ContectService contectService) {
		this.contectService = contectService;
	}

	public void setPatentService(PatentService patentService) {
		this.patentService = patentService;
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public void setDataPropertyService(DataPropertyService dataPropertyService) {
		this.dataPropertyService = dataPropertyService;
	}

	public void setDataReportValueService(DataReportValueService dataReportValueService) {
		this.dataReportValueService = dataReportValueService;
	}

	public void setDataReportService(DataReportService dataReportService) {
		this.dataReportService = dataReportService;
	}

	public void setTechnicList(List<DataDict> technicList) {
		this.technicList = technicList;
	}

	public void setTaxadressList(List<DataDict> taxadressList) {
		this.taxadressList = taxadressList;
	}

	public String getExcelName() {
		return excelName;
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public List<DataDict> getEnterpriseTypeList() {
		return enterpriseTypeList;
	}

	public void setCustomerQualificationService(CustomerQualificationService customerQualificationService) {
		this.customerQualificationService = customerQualificationService;
	}

	public void setCustomerVentureTypeService(CustomerVentureTypeService customerVentureTypeService) {
		this.customerVentureTypeService = customerVentureTypeService;
	}
	
}
