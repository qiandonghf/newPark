<%@page import="com.wiiy.crm.entity.Staffer"%>
<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@page import="com.wiiy.crm.entity.IncubationInfo"%>
<%@page import="com.wiiy.crm.entity.CustomerInfo"%>
<%@page import="com.wiiy.crm.entity.Customer"%>
<%@page import="com.wiiy.commons.util.DateUtil"%>
<%@page import="com.wiiy.crm.dto.CustomerSearchResultDto"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
List<String> propertyList = (List<String>)session.getAttribute("propertys");
boolean staffer_name = propertyList.contains("staffer.name");
boolean staffer_birth = propertyList.contains("staffer.birth");
boolean staffer_phone = propertyList.contains("staffer.phone");
boolean staffer_gender = propertyList.contains("staffer.gender");
boolean staffer_degree = propertyList.contains("staffer.degree");
boolean staffer_position = propertyList.contains("staffer.position");
boolean staffer_email = propertyList.contains("staffer.email");

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
		$("#overflowAuto").height(getTabContentHeight()-60);
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
		<div class="overflowAuto" id="overflowAuto">
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
						
						if(staffer_name) out.println("<th scope='col'>姓名</th>");
						if(staffer_birth) out.println("<th scope='col'>出生年月</th>");
						if(staffer_phone) out.println("<th scope='col'>电话</th>");
						if(staffer_gender) out.println("<th scope='col'>性别</th>");
						if(staffer_degree) out.println("<th scope='col'>学历</th>");
						if(staffer_position) out.println("<th scope='col'>职称</th>");
						if(staffer_email) out.println("<th scope='col'>Email</th>");
						
					%>
				</tr>
			</thead>
			<tbody>
				<%
				Result<List<Staffer>> result = (Result<List<Staffer>>)request.getAttribute("result");
				List<Staffer> list = result.getValue();
				if(list!=null)
				for(Staffer staffer : list){
					
					out.println("<tr>");
					
					out.println("<td>"+staffer.getCustomer().getCode()+"</td>");
					out.println("<td>"+staffer.getCustomer().getName()+"</td>");
					
					if(staffer_name){if(staffer!=null && staffer.getName()!=null) out.println("<td>"+staffer.getName()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					if(staffer_birth){if(staffer!=null && staffer.getBirth()!=null) out.println("<td>"+DateUtil.format(staffer.getBirth())+"</td>");
					else out.println("<td>&nbsp;</td>");}
					if(staffer_phone){if(staffer!=null && staffer.getPhone()!=null) out.println("<td>"+staffer.getPhone()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					if(staffer_gender){if(staffer!=null && staffer.getGender()!=null) out.println("<td>"+staffer.getGender().getTitle()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					if(staffer_degree){if(staffer!=null && staffer.getDegree()!=null) out.println("<td>"+staffer.getDegree().getDataValue()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					if(staffer_position){if(staffer!=null && staffer.getPosition()!=null) out.println("<td>"+staffer.getPosition().getDataValue()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					if(staffer_email){if(staffer!=null && staffer.getEmail()!=null) out.println("<td>"+staffer.getEmail()+"</td>");
					else out.println("<td>&nbsp;</td>");}
					
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
