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
</head>
<body>
<div>
<ul class="list_sy_1">
	<c:forEach items="${facilityOrderList}" var="facilityOrder">
		<li><a href="javascript:void(0);" onclick="fbStart('查看使用申请','<%=BaseAction.rootLocation %>/parkmanager.pb/facilityOrder!view.action?id=${facilityOrder.id}',500,242)" title="">${facilityOrder.facility.name }</a>&nbsp;${facilityOrder.customer.name }&nbsp;<fmt:formatDate value="${facilityOrder.startTime}" pattern="yyyy-MM-dd"/></li>
	</c:forEach>
</ul>
</div>
</body>
</html>