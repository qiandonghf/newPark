<%@page import="com.wiiy.crm.entity.Bill"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
</head>
<body>
<div class="oatask">
	<h2>收款：</h2>
	<ul class="list_sy_1">
		<c:forEach items="${result.value}" var="bill">
		<li class="">
			<a href="javascript:void(0)" onclick="addTab(parent.parent,'费用结算','parkmanager.pb/bill!list.action')">${bill.billType.typeName}：（<fmt:formatDate value="${bill.planPayTime}" pattern="MM/dd"/>）</a><strong class="cor_f00">￥<fmt:formatNumber value="${bill.factPayment}" pattern="#0.00"/></strong>&nbsp;</a>
			<span class="cor_999"><c:if test="${fn:length(bill.customer.shortName)>0}" var="shortName">${bill.customer.shortName}</c:if><c:if test="${!shortName}">${bill.customer.name}</c:if></span>
		</li>
		</c:forEach>
	</ul>
	<h2 style="margin-top:-5px;">应收汇总：</h2>
	<div class="calculate">共<a href="javascript:void(0)" onclick="addTab(parent.parent,'费用结算','parkmanager.pb/bill!list.action')">${count}</a>家企业需收款&nbsp;&nbsp;&nbsp;&nbsp;应收总计：<a href="javascript:void(0)" onclick="addTab(parent.parent,'费用结算','parkmanager.pb/bill!list.action')">￥<fmt:formatNumber value="${sum}" pattern="#0.00"/></a>元</div>
</div>
</body>
</html>