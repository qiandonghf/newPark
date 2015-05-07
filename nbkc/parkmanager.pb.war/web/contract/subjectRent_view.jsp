<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
	<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
	<script type="text/javascript" src="core/common/js/jquery.js"></script>
	<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
	<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
	<script type="text/javascript" src="core/common/js/tools.js"></script>
	<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
	<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
	<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
	<script type="text/javascript">
		$(function(){
			initTip();
		});
	</script>
</head>

<body>
	<input type="hidden" value="${result.value.id}" name="subjectRent.id"/>
	<input type="hidden" id="saveFlag" value="${saveFlag}" name="saveFlag"/>
	<div class="basediv">
		<div class="divlays" style="margin:0px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100">租用地址：</td>
					<td class="layerright">${result.value.roomName}</td>
				</tr>
				<tr>
					<td class="layertdleft100">租用日期：</td>
					<td class="layerright">
						<fmt:formatDate value="${result.value.startDate}" pattern="yyyy-MM-dd"/>
						—
						<fmt:formatDate value="${result.value.endDate}" pattern="yyyy-MM-dd"/>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>租用面积：</td>
					<td class="layerright">
						<fmt:formatNumber value="${result.value.roomArea}" pattern="#0.00"/>&nbsp; 平方米
					</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>租金单价：</td>
					<td class="layerright">
						<fmt:formatNumber value="${result.value.rentPrice}" pattern="#0.00"/>${result.value.rentPriceUnit.title}
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">是否优惠：</td>
					<td class="layerright">${result.value.rebate.title}</td>
				</tr>
				<tr>
					<td class="layertdleft100"><p>优惠规则：</p></td>
					<td class="layerright">${result.value.rebateRuleId.dataValue}</td>
				</tr>
				<tr>
					<td class="layertdleft100">备注：</td>
					<td class="layerright"><div style="height: 70px;overflow: auto">${result.value.memo}</div></td>
				</tr>
			</table>
		</div>
		<div class="hackbox"></div>
	</div>
	<div class="buttondiv">
	</div>
</body>
</html>
