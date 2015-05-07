<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
</head>

<body>
<form action="<%=basePath %>billPlanRent!update.action" method="post" name="form1" id="form1">
<input type="hidden" value="${result.value.id}" name="billPlanRent.id" />
<div class="basediv">
	<div class="divlays" style="margin:0px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="layertdleft100">租赁房间：</td>
				<td class="layerright">${result.value.roomName}</td>
			</tr>
			<tr>
				<td class="layertdleft100">费用类型：</td>
				<td class="layerright">${result.value.feeType.title}</td>
			</tr>
			<tr>
				<td class="layertdleft100">计划金额：</td>
				<td class="layerright"><fmt:formatNumber value="${result.value.planFee}" pattern="#0.00"/>&nbsp; 元 本期设置优惠之前的金额 </td>
			</tr>
			<tr>
				<td class="layertdleft100">实际金额：</td>
				<td class="layerright"><fmt:formatNumber value="${result.value.realFee}" pattern="#0.00"/>&nbsp; 元 本期实际需要支付的金额  </td>
			</tr>
			<tr>
				<td class="layertdleft100">计费日期：</td>
				<td class="layerright"><fmt:formatDate value="${result.value.startDate}" pattern="yyyy-MM-dd"/>&nbsp;—&nbsp;<fmt:formatDate value="${result.value.endDate}" pattern="yyyy-MM-dd"/></td>
			</tr>
			<tr>
				<td class="layertdleft100">计划付费日期：</td>
				<td class="layerright"><fmt:formatDate value="${result.value.planPayDate}" pattern="yyyy-MM-dd"/></td>
			</tr>
			<%-- <tr>
				<td class="layertdleft100">自动出帐：</td>
				<td class="layerright">${result.value.autoCheck.title}&nbsp;&nbsp;${result.value.status.title}</td>
			</tr> --%>
			<tr>
				<td class="layertdleft100">备注：</td>
				<td class="layerright"><div style="height:50px;overflow-x: hidden;overflow-y:auto  ">${result.value.memo}</div></td>
			</tr>
		</table>
	</div>
	<div class="hackbox"></div>
</div>
<div style="height: 5px;"></div>
</form>
</body>
</html>
