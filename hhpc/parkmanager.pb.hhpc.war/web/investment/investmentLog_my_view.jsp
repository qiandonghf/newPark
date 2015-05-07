<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"%>
<%@taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="<%=BaseAction.rootLocation %>/" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>无标题文档</title>
		
		<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
		<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
		
	</head>

	<body>
		<form action="<%=basePath %>investmentLog!myUpdate.action" method="post" name="form1" id="form1">
			<input type="hidden" value="${result.value.id}" name="investmentLog.id"/>
			<div class="basediv">
			<div class="divlays" style="margin:0px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="layertdleft100">项目名称：</td>
						<td class="layerright">${result.value.investment.name}</td>
					</tr>
					<tr>
						<td class="layertdleft100">项目方联系人：</td>
						<td class="layerright">${result.value.userName}</td>
					</tr>
					<tr>
						<td class="layertdleft100">招商人员：</td>
						<td class="layerright">${result.value.linkMan}</td>
					</tr>
					<tr>
						<td class="layertdleft100">时间：</td>
						<td class="layerright"><fmt:formatDate value="${result.value.linkTime}" pattern="yyyy-MM-dd"/></td>
					</tr>
					<tr>
						<td class="layertdleft100">内容：</td>
						<td class="layerright"><div style="height: 150px;width: 367px;overflow-X: hidden;overflow-Y: auto;word-wrap: break-word;word-break: normal; ">${result.value.content}</div></td>
					</tr>
				</table>
			</div>
			<div class="hackbox"></div>
		</div>
		<div style="height: 5px;"></div>
	</form>
	</body>
</html>

