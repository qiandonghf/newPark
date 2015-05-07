<%@page import="com.wiiy.crm.entity.DataTemplate"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.crm.dto.DataPropertyDto"%>
<%@page import="com.wiiy.crm.entity.DataReportValue"%>
<%@page import="com.wiiy.commons.util.DateUtil"%>
<%@page import="com.wiiy.crm.entity.DataReportProperty"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/calendar/calendar.css" rel="stylesheet" type="text/css" />
<style>
body{font-size: 12px;font-family: tahoma,Helvetica, Arial, sans-serif,simsun;}
</style>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript">
	function loadReportByGroupId(id){
		if(id != ''){
			var url = "<%=basePath%>dataReport!loadReport.action?id="+id;
			$.post(url,function(data){
				var monthList = $("#monthList");
				monthList.empty();
				for(var i = 0; i < data.length; i++){
					if(data[i].templateId==1){
						var id = data[i].id;
						var name = data[i].name;
						var url = "<%=basePath%>dataReportToCustomer!view.action?reportId="+id+"&customerId="+${result.value.customerId};
						monthList.append("<a href='"+url+"'>"+name+"</a>");
						monthList.append("&nbsp;&nbsp;");	
					}
				}
			});
		}
	}
	loadReportByGroupId("${result.value.report.groupId}");
</script>
</head>

<body style="background: white;">
<center>
<%-- <div style="width: 700px;height:36px; font: bold 16px/36px ''; text-align:center;">
	<table width="100%">
		<tr>
			<td align="right" width="150">
			<select onchange="loadReportByGroupId(this.value)">
				<option value="">---请选择分组---</option>
				<c:forEach items="${reportGroupList}" var="group">
					<option value="${group.id}" <c:if test="${group.id eq result.value.report.groupId}">selected="selected"</c:if>>${group.name}</option>
				</c:forEach>
			</select>
			</td>
			<td>
				<span id="monthList">
					&nbsp;
				</span>
			</td>
		</tr>
	</table>
</div> --%>
</center>
<div style="height:36px; font: bold 16px/36px ''; text-align:center;">${result.value.customer.name}<strong style="padding-left: 50px;">${result.value.report.group.name}-${result.value.report.name}</strong></div>
<center>
<div style="width: 700px;">
	<%
		DataTemplate dataTemplate = (DataTemplate)request.getAttribute("dataTemplate");
		List<DataReportProperty> propertyList = (List<DataReportProperty>)request.getAttribute("propertyList");
		Map<Long, DataReportValue> valueMap = (Map<Long, DataReportValue>)request.getAttribute("dataReportValueMap");
		out.println(dataTemplate.getFormat().format(propertyList, valueMap));
	%>
</div>
</center>
<div class="buttondiv" style="padding-top: 5px;">
	<a href="javascript:void(0)" title="" onclick="window.close();" class="btn_bg"><span><img src="core/common/images/closebtnicon.gif"/>关闭</span></a>
</div>
</body>
</html>
