<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
		
		<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.js"></script>
		<script type="text/javascript" src="core/common/js/tools.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
		<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
		<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
		<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>

	</head>

	<body>
		<div class="basediv">
			<div class="divlays" style="margin: 0px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="layertdleft100">姓名:</td>
						<td class="layerright">${result.value.name}</td>
					</tr>
					
					<tr>
						<td class="layertdleft100">学历:</td>
						<td class="layerright">${result.value.degree.dataValue}</td>
					</tr>
					
					<tr>
						<td class="layertdleft100">专业:</td>
						<td class="layerright">${result.value.specialty}</td>
					</tr>
					<tr>
						<td class="layertdleft100">学位/职称:</td>
						<td class="layerright">${result.value.profession}</td>
					</tr>
					<tr>
						<td class="layertdleft100">手机:</td>
						<td class="layerright">${result.value.mobile}</td>
					</tr>
					<tr>
						<td class="layertdleft100">联系电话:</td>
						<td class="layerright">${result.value.phone}</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="buttondiv"></div>
		
		</form>
	</body>
</html>