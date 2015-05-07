<%@page import="com.wiiy.crm.preferences.enums.DataTypeEnum"%>
<%@page import="com.wiiy.crm.dto.DataReportPropertyDto"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.crm.entity.DataReport"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@page import="com.wiiy.crm.entity.Customer"%>
<%@page import="com.wiiy.crm.preferences.enums.ReportStatusEnum"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
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
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
</head>
 
<body>
	<div>
	<div class="basediv" style="height:400px; overflow-x:hidden; overflow-y:scroll">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td colspan="2" class="tdcenterL" onmousemove="this.className='tdcenterLover'" onmouseout="this.className='tdcenterL'">项目</td>
				<td width="130" class="tdrightc" onmousemove="this.className='tdrightcover'" onmouseout="this.className='tdrightc'">统计值</td>
			</tr>
			<c:forEach items="${result.value}" var="property">
			<tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff'">
				<td width="10" class="lefttd">&nbsp;</td>
				<td width="663" class="lefttd" colspan="2">${property.property.name}</td>
			</tr>
			<c:forEach items="${property.propertyList}" var="subProperty" varStatus="s">
			<tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff'">
				<td width="10" class="lefttd">&nbsp;</td>
				<td width="663" class="lefttd" <c:if test="${subProperty.property.dataType eq null}">colspan='2'</c:if>><c:forEach begin="1" end="${subProperty.property.level}">&nbsp;&nbsp;&nbsp;&nbsp;</c:forEach>${subProperty.property.name}</td>
				<c:if test="${subProperty.property.dataType eq 'INT'}">
					<td class="centertd">${subProperty.icount}${subProperty.property.unit}</td>
				</c:if>
				<c:if test="${subProperty.property.dataType eq 'DOUBLE'}">
					<td class="centertd"><fmt:formatNumber value="${subProperty.dcount}" pattern="#0.00"/>${subProperty.property.unit}</td>
				</c:if>
				<c:if test="${subProperty.property.dataType eq 'SELECT'}"><td class="centertd">${subProperty.icount}</td></c:if>
			</tr>
			<c:if test="${subProperty.property.dataType eq 'SELECT' }">
				<c:forEach items="${subProperty.propertyList}" var="select" varStatus="s">
				<tr onmouseover="this.style.background='#f4f4f4'" onmouseout="this.style.background='#fff'">
					<td width="10" class="lefttd">&nbsp;</td>
					<td width="663" class="lefttd"><c:forEach begin="1" end="${subProperty.property.level}">&nbsp;&nbsp;&nbsp;&nbsp;</c:forEach>&nbsp;&nbsp;&nbsp;&nbsp;${select.name}</td>
					<td class="centertd">${select.icount}</td>
				</tr>
				</c:forEach>
			</c:if>
			</c:forEach>
			</c:forEach>
		</table>
	</div>
	<div class="buttondiv">
		<label><input name="Submit" type="button" class="closebtn" value="" onclick="parent.fb.end();" /></label>
	</div>
	</div>
</body>
</html>