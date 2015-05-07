<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@page import="com.wiiy.pb.entity.FacilityOrder"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
</head>

<body>
<input type="hidden" value="${result.value.id}" name="facilityOrder.id"/>
<div class="basediv">
	<div class="divlays" style="margin:0px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="layertdleft100">企业名称：</td>
				<td class="layerright">${result.value.customer.name}</td>
			</tr>
			<tr>
				<td class="layertdleft100">使用时间起：</td>
				<td class="layerright"><fmt:formatDate value="${result.value.startTime}" pattern="yyyy-MM-dd HH:mm"/></td>
			</tr>
			<tr>
				<td class="layertdleft100">使用时间止：</td>
				<td class="layerright"><fmt:formatDate value="${result.value.endTime}" pattern="yyyy-MM-dd HH:mm"/></td>
			</tr>
			<tr>
				<td class="layertdleft100">合同：</td>
				<td class="layerright">${result.value.contractPath}</td>
			</tr>
			<tr>
				<td class="layertdleft100">备注：</td>
				<td class="layerright"><div style="height: 90px;overflow-y: auto; overflow-x: hidden;word-break:break-all; word-wrap:break-word;">${result.value.memo}</div></td>
			</tr>
		</table>
	</div>
	<div class="hackbox"></div>
</div>
<div style="height: 5px;">
</div>
</body>
</html>