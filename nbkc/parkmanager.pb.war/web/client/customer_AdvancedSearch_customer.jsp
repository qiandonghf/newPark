<%@page import="com.wiiy.crm.preferences.enums.DataTypeEnum"%>
<%@page import="com.wiiy.crm.entity.DataReportValue"%>
<%@page import="com.wiiy.crm.entity.DataProperty"%>
<%@page import="com.wiiy.crm.entity.DataReport"%>
<%@page import="com.wiiy.crm.entity.Staffer"%>
<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@page import="com.wiiy.crm.entity.IncubationInfo"%>
<%@page import="com.wiiy.crm.entity.CustomerInfo"%>
<%@page import="com.wiiy.crm.entity.Customer"%>
<%@page import="com.wiiy.commons.util.DateUtil"%>
<%@page import="com.wiiy.crm.dto.CustomerSearchResultDto"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
List<String> propertyList = (List<String>)session.getAttribute("propertys");
for(String property : propertyList){
// 	if(property.startsWith("customer.")){
// 		System.out.println(property);
// 	}
// 	if(property.startsWith("customerInfo.")){
// 		System.out.println(property);
// 	}
// 	if(property.startsWith("incubationInfo.")){
// 		System.out.println(property);
// 	}
// 	if(property.startsWith("legal.")){
// 		System.out.println(property);
// 	}
// 	if(property.startsWith("manager.")){
// 		System.out.println(property);
// 	}
}
boolean reportType = propertyList.contains("customer.reportType");
boolean hostName = propertyList.contains("customer.hostName");
boolean type = propertyList.contains("customer.type");
boolean customerType = propertyList.contains("customer.customerType");
boolean parkTime = propertyList.contains("customer.parkTime");
boolean technic = propertyList.contains("customer.technic");
boolean enterpriseType = propertyList.contains("customer.enterpriseType");

boolean zyjck = propertyList.contains("customerInfo.zyjck");
boolean ybnsr = propertyList.contains("customerInfo.ybnsr");
boolean businessNumber = propertyList.contains("customerInfo.businessNumber");
boolean regTime = propertyList.contains("customerInfo.regTime");
boolean taxNumberG = propertyList.contains("customerInfo.taxNumberG");
boolean taxNumberD = propertyList.contains("customerInfo.taxNumberD");
boolean taxAddress = propertyList.contains("customerInfo.taxAddress");
boolean webSite = propertyList.contains("customerInfo.webSite");
boolean organizationNumber = propertyList.contains("customerInfo.organizationNumber");
boolean regCapital = propertyList.contains("customerInfo.regCapital");
boolean realCapital = propertyList.contains("customerInfo.realCapital");
boolean regAddress = propertyList.contains("customerInfo.regAddress");
boolean inPark = propertyList.contains("customerInfo.inPark");
boolean managerAddress = propertyList.contains("customerInfo.managerAddress");
boolean inBuild = propertyList.contains("customerInfo.inBuild");
boolean research = propertyList.contains("customerInfo.research");
boolean userCount = propertyList.contains("customerInfo.userCount");
boolean userbsh = propertyList.contains("customerInfo.userbsh");
boolean userbs = propertyList.contains("customerInfo.userbs");
boolean userss = propertyList.contains("customerInfo.userss");
boolean userbk = propertyList.contains("customerInfo.userbk");
boolean userqt = propertyList.contains("customerInfo.userqt");
boolean userlxs = propertyList.contains("customerInfo.userlxs");
boolean usergj = propertyList.contains("customerInfo.usergj");
boolean userzj = propertyList.contains("customerInfo.userzj");
boolean usercj = propertyList.contains("customerInfo.usercj");
boolean shareholder = propertyList.contains("customerInfo.shareholder");
boolean businessScope = propertyList.contains("customerInfo.businessScope");
boolean memo = propertyList.contains("customerInfo.memo");

boolean status = propertyList.contains("incubationInfo.status");
boolean incubationInfoType = propertyList.contains("incubationInfo.type");
boolean incubateConfig = propertyList.contains("incubationInfo.incubateConfig");

boolean legal_name = propertyList.contains("legal.name");
boolean legal_birth = propertyList.contains("legal.birth");
boolean legal_phone = propertyList.contains("legal.phone");
boolean legal_gender = propertyList.contains("legal.gender");
boolean legal_degree = propertyList.contains("legal.degree");
boolean legal_position = propertyList.contains("legal.position");
boolean legal_email = propertyList.contains("legal.email");

boolean manager_name = propertyList.contains("manager.name");
boolean manager_birth = propertyList.contains("manager.birth");
boolean manager_phone = propertyList.contains("manager.phone");
boolean manager_gender = propertyList.contains("manager.gender");
boolean manager_degree = propertyList.contains("manager.degree");
boolean manager_position = propertyList.contains("manager.position");
boolean manager_email = propertyList.contains("manager.email");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript">
	$(function(){
		$("#overflowAuto").height(window.parent.parent.document.documentElement.clientHeight-(window.screenTop-window.parent.parent.screenTop)-82);
	});
	
	function jumpPage(page){
		var url = "<%=basePath%>search.action";
		url += "?page="+page;
		url += "&tab=${tab}";
		location.href=url;
	}
</script>
</head>
<body>
	<div class="pm_msglist" id="msglist">
		<div class="emailtop">
			<div class="leftemail">
				<ul>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" class="" onclick="location.href='<%=basePath%>search!export.action'"><span><img src="core/common/images/xls_min.png"></span>导出</li>
					<li onmouseover="this.className='libg'" onmouseout="this.className=''" class="" onclick="parent.location.href='<%=basePath%>search!before.action'"><span><img src="core/common/images/back.png"></span>返回</li>
				</ul>
			</div>
		</div>
		<div id="overflowAuto" style="overflow-x:auto;overflow-y:auto">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_sy1" style="white-space:nowrap; table-layout:auto;">
			<colgroup>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr class="table_titlebgcolor" style="font-weight:bold;">
					<%
						out.println("<th scope='col'>企业编号</th>");
						out.println("<th scope='col'>企业名称</th>");
						if(reportType) out.println("<th scope='col'>上报类型</th>");
						if(hostName) out.println("<th scope='col'>跟踪引进</th>");
						if(type) out.println("<th scope='col'>企业性质</th>");
						if(customerType) out.println("<th scope='col'>企业分类</th>");
						if(parkTime) out.println("<th scope='col'>引进时间</th>");
						if(technic) out.println("<th scope='col'>产业类别</th>");
						if(enterpriseType) out.println("<th scope='col'>创业类型</th>");
						
						if(zyjck) out.println("<th scope='col'>自营进出口权</th>");
						if(ybnsr) out.println("<th scope='col'>一般纳税人</th>");
						if(businessNumber) out.println("<th scope='col'>工商注册号</th>");
						if(regTime) out.println("<th scope='col'>注册时间</th>");
						if(taxNumberG) out.println("<th scope='col'>国税登记号</th>");
						if(taxNumberD) out.println("<th scope='col'>地税登记号</th>");
						if(taxAddress) out.println("<th scope='col'>纳税所在地</th>");
						if(webSite) out.println("<th scope='col'>公司网址</th>");
						if(organizationNumber) out.println("<th scope='col'>组织机构代码</th>");
						if(regCapital) out.println("<th scope='col'>注册资金</th>");
						if(realCapital) out.println("<th scope='col'>实际到位资金</th>");
						if(regAddress) out.println("<th scope='col'>注册地址</th>");
						if(inPark) out.println("<th scope='col'>在园区内</th>");
						if(managerAddress) out.println("<th scope='col'>经营地址</th>");
						if(inBuild) out.println("<th scope='col'>在大厦内</th>");
						if(research) out.println("<th scope='col'>是否是研发机构</th>");
						if(userCount) out.println("<th scope='col'>企业总人数</th>");
						if(userbsh) out.println("<th scope='col'>博士后</th>");
						if(userbs) out.println("<th scope='col'>博士</th>");
						if(userss) out.println("<th scope='col'>硕士</th>");
						if(userbk) out.println("<th scope='col'>本科</th>");
						if(userqt) out.println("<th scope='col'>其他</th>");
						if(userlxs) out.println("<th scope='col'>留学生</th>");
						if(usergj) out.println("<th scope='col'>高级职称</th>");
						if(userzj) out.println("<th scope='col'>中级职称</th>");
						if(usercj) out.println("<th scope='col'>初级职称</th>");
						if(shareholder) out.println("<th scope='col'>股东构成</th>");
						if(businessScope) out.println("<th scope='col'>经营范围</th>");
						if(memo) out.println("<th scope='col'>备注</th>");
						
						if(status) out.println("<th scope='col'>孵化状态</th>");
						if(incubationInfoType) out.println("<th scope='col'>创业类型</th>");
						if(incubateConfig) out.println("<th scope='col'>入驻场所</th>");
						
						if(legal_name) out.println("<th scope='col'>法人姓名</th>");
						if(legal_birth) out.println("<th scope='col'>法人出生年月</th>");
						if(legal_phone) out.println("<th scope='col'>法人电话</th>");
						if(legal_gender) out.println("<th scope='col'>法人性别</th>");
						if(legal_degree) out.println("<th scope='col'>法人学历</th>");
						if(legal_position) out.println("<th scope='col'>法人职称</th>");
						if(legal_email) out.println("<th scope='col'>法人Email</th>");
						
						if(manager_name) out.println("<th scope='col'>总经理姓名</th>");
						if(manager_birth) out.println("<th scope='col'>总经理出生年月</th>");
						if(manager_phone) out.println("<th scope='col'>总经理电话</th>");
						if(manager_gender) out.println("<th scope='col'>总经理性别</th>");
						if(manager_degree) out.println("<th scope='col'>总经理学历</th>");
						if(manager_position) out.println("<th scope='col'>总经理职称</th>");
						if(manager_email) out.println("<th scope='col'>总经理Email</th>");
						
						DataReport report1 = (DataReport)session.getAttribute("report1");
						DataReport report2 = (DataReport)session.getAttribute("report2");
						List<DataProperty> dataPropertyList = (List<DataProperty>)session.getAttribute("dataPropertyList");
						if(dataPropertyList!=null)
						for(DataProperty dp : dataPropertyList){
							String name = dp.getName();
							if(dp.getName().equals("本期数") || dp.getName().equals("本年累计数")) {
								name = dp.getParentProperty().getName()+name;
							}
							if(report1!=null){
								out.println("<th scope='col'>"+report1.getGroup().getName()+"&nbsp; "+report1.getName()+"</br>"+name+"</th>");
							}
							if(report2!=null){
								out.println("<th scope='col'>"+report2.getGroup().getName()+"&nbsp; "+report2.getName()+"</br>"+name+"</th>");
							}
						}
					%>
				</tr>
			</thead>
			<tbody>
				<%
				Result<List<CustomerSearchResultDto>> result = (Result<List<CustomerSearchResultDto>>)request.getAttribute("result");
				List<CustomerSearchResultDto> list = result.getValue();
				if(list!=null)
				for(CustomerSearchResultDto dto : list){
					
					out.println("<tr>");
					
					Customer customer = dto.getCustomer();
					out.println("<td>"+customer.getCode()+"</td>");
					out.println("<td>"+customer.getName()+"</td>");
					
					if(reportType){if(customer.getReportType()!=null) out.println("<td>"+customer.getReportType().getTitle()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(hostName){if(customer.getHostName()!=null) out.println("<td>"+customer.getHostName()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					
					if(type){if(customer.getType()!=null) out.println("<td>"+customer.getType().getTitle()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(customerType){if(customer.getCustomerType()!=null) out.println("<td align='center'>"+customer.getCustomerType().getDataValue()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(parkTime){if(customer.getParkTime()!=null) out.println("<td>"+DateUtil.format(customer.getParkTime())+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(technic){if(customer.getTechnic()!=null) out.println("<td>"+customer.getTechnic().getDataValue()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(enterpriseType){if(customer.getEnterpriseType()!=null) out.println("<td>"+customer.getEnterpriseType().getDataValue()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					CustomerInfo customerInfo = customer.getCustomerInfo();
					
					if(zyjck){if(customerInfo.getZyjck()!=null) out.println("<td>"+customerInfo.getZyjck().getTitle()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(ybnsr){if(customerInfo.getYbnsr()!=null) out.println("<td>"+customerInfo.getYbnsr().getTitle()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(businessNumber){if(customerInfo.getBusinessNumber()!=null) out.println("<td>"+customerInfo.getBusinessNumber()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(regTime){if(customerInfo.getRegTime()!=null) out.println("<td>"+DateUtil.format(customerInfo.getRegTime())+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(taxNumberG){if(customerInfo.getTaxNumberG()!=null) out.println("<td>"+customerInfo.getTaxNumberG()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(taxNumberD){if(customerInfo.getTaxNumberD()!=null) out.println("<td>"+customerInfo.getTaxNumberD()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(taxAddress){if(customerInfo.getTaxAddress()!=null) out.println("<td>"+customerInfo.getTaxAddress().getDataValue()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(webSite){if(customerInfo.getWebSite()!=null) out.println("<td>"+customerInfo.getWebSite()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(organizationNumber){if(customerInfo.getOrganizationNumber()!=null) out.println("<td>"+customerInfo.getOrganizationNumber()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(regCapital){if(customerInfo.getRegCapital()!=null) out.println("<td>"+customerInfo.getRegCapital()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(realCapital){if(customerInfo.getRealCapital()!=null) out.println("<td>"+customerInfo.getRealCapital()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(regAddress){if(customerInfo.getRegAddress()!=null) out.println("<td>"+customerInfo.getRegAddress()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(inPark){if(customerInfo.getInPark()!=null) out.println("<td>"+customerInfo.getInPark().getTitle()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(managerAddress){if(customerInfo.getManagerAddress()!=null) out.println("<td>"+customerInfo.getManagerAddress()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(inBuild){if(customerInfo.getInBuild()!=null) out.println("<td>"+customerInfo.getInBuild().getTitle()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(research){if(customerInfo.getResearch()!=null) out.println("<td>"+customerInfo.getResearch()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(userCount){if(customerInfo.getUserCount()!=null) out.println("<td>"+customerInfo.getUserCount()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(userbsh){if(customerInfo.getUserbsh()!=null) out.println("<td>"+customerInfo.getUserbsh()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(userbs){if(customerInfo.getUserbs()!=null) out.println("<td>"+customerInfo.getUserbs()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(userss){if(customerInfo.getUserss()!=null) out.println("<td>"+customerInfo.getUserss()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(userbk){if(customerInfo.getUserbk()!=null) out.println("<td>"+customerInfo.getUserbk()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(userqt){if(customerInfo.getUserqt()!=null) out.println("<td>"+customerInfo.getUserqt()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(userlxs){if(customerInfo.getUserlxs()!=null) out.println("<td>"+customerInfo.getUserlxs()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(usergj){if(customerInfo.getUsergj()!=null) out.println("<td>"+customerInfo.getUsergj()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(userzj){if(customerInfo.getUserzj()!=null) out.println("<td>"+customerInfo.getUserzj()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(usercj){if(customerInfo.getUsercj()!=null) out.println("<td>"+customerInfo.getUsercj()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(shareholder){if(customerInfo.getShareholder()!=null) out.println("<td>"+customerInfo.getShareholder()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(businessScope){if(customerInfo.getBusinessScope()!=null) out.println("<td>"+customerInfo.getBusinessScope()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(memo){if(customerInfo.getMemo()!=null) out.println("<td>"+customerInfo.getMemo()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					IncubationInfo incubationInfo = customer.getIncubationInfo();
					if(status){if(incubationInfo.getStatusName()!=null) out.println("<td>"+incubationInfo.getStatusName()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					if(incubationInfoType) {
						out.println("<td>");
						if(incubationInfo.getOverseaEnterprise()==BooleanEnum.YES) out.println("留学生&nbsp;&nbsp;");
						if(incubationInfo.getUndergraduateEnterprise()==BooleanEnum.YES) out.println("大学生&nbsp;&nbsp; ");
						out.println("</td>");
					}
					if(incubateConfig){if(incubationInfo.getIncubateConfig()!=null) out.println("<td>"+incubationInfo.getIncubateConfig().getDataValue()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					Staffer legal = dto.getLegal();
					if(legal_name){if(legal!=null && legal.getName()!=null) out.println("<td>"+legal.getName()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					if(legal_birth){if(legal!=null && legal.getBirth()!=null) out.println("<td>"+DateUtil.format(legal.getBirth())+"</td>");
					else out.println("<td>&nbsp;</td>");}
					if(legal_phone){if(legal!=null && legal.getPhone()!=null) out.println("<td>"+legal.getPhone()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					if(legal_gender){if(legal!=null && legal.getGender()!=null) out.println("<td>"+legal.getGender().getTitle()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					if(legal_degree){if(legal!=null && legal.getDegree()!=null) out.println("<td>"+legal.getDegree().getDataValue()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					if(legal_position){if(legal!=null && legal.getPosition()!=null) out.println("<td>"+legal.getPosition().getDataValue()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					if(legal_email){if(legal!=null && legal.getEmail()!=null) out.println("<td>"+legal.getEmail()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					Staffer manager = dto.getManager();
					if(manager_name){if(manager!=null && manager.getName()!=null) out.println("<td>"+manager.getName()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					if(manager_birth){if(manager!=null && manager.getBirth()!=null) out.println("<td>"+DateUtil.format(manager.getBirth())+"</td>");
					else out.println("<td>&nbsp;</td>");}
					if(manager_phone){if(manager!=null && manager.getPhone()!=null) out.println("<td>"+manager.getPhone()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					if(manager_gender){if(manager!=null && manager.getGender()!=null) out.println("<td>"+manager.getGender().getTitle()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					if(manager_degree){if(manager!=null && manager.getDegree()!=null) out.println("<td>"+manager.getDegree().getDataValue()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					if(manager_position){if(manager!=null && manager.getPosition()!=null) out.println("<td>"+manager.getPosition().getDataValue()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					if(manager_email){if(manager!=null && manager.getEmail()!=null) out.println("<td>"+manager.getEmail()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
					Map<Long, Map<Long, Map<Long, DataReportValue>>> customerReportValueMap1 = (Map<Long, Map<Long, Map<Long, DataReportValue>>>)request.getAttribute("customerReportValueMap1");
					Map<Long, Map<Long, Map<Long, DataReportValue>>> customerReportValueMap2 = (Map<Long, Map<Long, Map<Long, DataReportValue>>>)request.getAttribute("customerReportValueMap2");
					if(dataPropertyList!=null)
					for(DataProperty dp : dataPropertyList){
						if(report1!=null) {
							String valueStr = "&nbsp;";
							if(customerReportValueMap1 !=null && customerReportValueMap1.get(customer.getId())!=null && customerReportValueMap1.get(customer.getId()).get(report1.getId())!=null && customerReportValueMap1.get(customer.getId()).get(report1.getId()).get(dp.getId())!=null){
								DataReportValue value = customerReportValueMap1.get(customer.getId()).get(report1.getId()).get(dp.getId());
								if(value!=null){
									if(dp.getDataType().equals(DataTypeEnum.DOUBLE)){
										if(value.getDoubleVal()!=null)
										valueStr += value.getDoubleVal();
									} else {
										if(value.getIntVal()!=null)
										valueStr += value.getIntVal();
									}
								}
							}
							out.println("<td>"+valueStr+"</td>");
						}
						if(report2!=null){
							String valueStr = "&nbsp;";
							if(customerReportValueMap2 !=null && customerReportValueMap2.get(customer.getId())!=null && customerReportValueMap2.get(customer.getId()).get(report2.getId())!=null && customerReportValueMap2.get(customer.getId()).get(report1.getId()).get(dp.getId())!=null){
								DataReportValue value = customerReportValueMap2.get(customer.getId()).get(report2.getId()).get(dp.getId());
								if(value!=null){
									if(dp.getDataType().equals(DataTypeEnum.DOUBLE)){
										if(value.getDoubleVal()!=null)
										valueStr += value.getDoubleVal();
									} else {
										if(value.getIntVal()!=null)
										valueStr += value.getIntVal();
									}
								}
							}
							out.println("<td>"+valueStr+"</td>");
						}
					}
					
					out.println("</tr>");
				}
				%>
			</tbody>    
		</table>
	</div>
	<jsp:include page="../pager.jsp" />
</div>
</body>
</html>
