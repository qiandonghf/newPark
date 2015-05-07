<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<title>无标题文档</title>

<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="parkmanager.pb/web/style/ps.css"  />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>

</head>
<body>
<c:if test="${result.value == null || result.value == '[]' }">没有相关合同</c:if>
<c:forEach items="${result.value}" var="contract">
	<div class="psdiv" onclick="fbStart('查看合同','<%=basePath%>contract!simpleView.action?id='+${contract.id},765,437);">
		<img src="core/common/images/zlht.gif" width="89" height="109" />
		<ul>
			<li>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="55">名　称：</td>
						<td class="tdline">${contract.name}</td>
					</tr>
					<tr>
						<td>编　号：</td>
						<td class="tdline">${contract.contractNo}</td>
					</tr>
					<tr>
						<td>有效期：</td>
						<td class="tdline"><fmt:formatDate value="${contract.startDate}" pattern="yyyy-MM-dd"/>至<fmt:formatDate value="${contract.endDate}" pattern="yyyy-MM-dd"/></td>
					</tr>
					<tr>
						<td>状　态：</td>
						<td class="tdline">${contract.state.title}</td>
					</tr>
				</table>
			</li>
		</ul>
	</div>
</c:forEach>
</body>
</html>