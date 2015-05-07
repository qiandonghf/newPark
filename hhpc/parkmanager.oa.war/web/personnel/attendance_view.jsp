<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.hibernate.Result"%>
<%@page import="com.wiiy.oa.entity.UserSign"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
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
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/uploadify-v3.1/uploadify.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
</head>
<body>
<div class="basediv">
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">登记人：</td>
      <td class="layerright">${result.value.user.realName}</td>
    </tr>
    <tr>
      <td class="layertdleft100">登记时间：</td>
      <td class="layerright" width="280px"><fmt:formatDate value="${result.value.signTime}" pattern="yyyy-MM-dd"/>
				<%
						Result<UserSign> result = (Result<UserSign>)request.getAttribute("result"); 
						Calendar signTime = Calendar.getInstance();
						signTime.setTime(result.getValue().getSignTime());
						int hour = signTime.get(Calendar.HOUR_OF_DAY);
						int minute = signTime.get(Calendar.MINUTE);
				%>
				<c:if test="<%=hour<10 %>">0</c:if><%=hour %>&nbsp;时
				<c:if test="<%=minute<10 %>">0</c:if><%=minute %>&nbsp;分
	 </td>
    </tr>
    <tr>
      <td class="layertdleft100">班次：</td>
      <td width="100" class="layerright">
      		<c:forEach items="${workClassList}" var="workClass">
         		<c:if test="${result.value.workClassId == workClass.id}"></c:if>${workClass.name}  	
        	</c:forEach> </td>
    </tr>
    <tr>
      <td class="layertdleft100">补签标识：</td>
      <td class="layerright">${result.value.signType.title }</td>
    </tr>
    <tr>
      <td class="layertdleft100">迟到或早退原因：</td>
      <td><div style="height: 70px; width:280px;word-break:break-all;overflow-x: hidden;overflow-y: auto">${result.value.reason}</div></td>
    </tr>
  </table>
</div>
</div>
<div style="height: 5px;"></div>
</body>
</html>
