<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.hibernate.Result"%>
<%@ page import="com.wiiy.oa.entity.OutRegister"%>
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
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
</head>

<body>
<div class="basediv">
	<div class="divlays" style="margin:0px;">
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	      <td class="layertdleft">开始时间：
	      </td>
	      <td class="layerright">
	      	<%
				Result<OutRegister> result = (Result<OutRegister>)request.getAttribute("result"); 
				Calendar startTime = Calendar.getInstance();
				startTime.setTime(result.getValue().getStartTime());
				int year = startTime.get(Calendar.YEAR);
				int month = startTime.get(Calendar.MONTH)+1;
				int day = startTime.get(Calendar.DATE);
				int hour = startTime.get(Calendar.HOUR_OF_DAY);
			%>
	       	<label><%=year %></label>
			年
			<label><%=month %></label>
			月
			<label><%=day %></label>
			日 
			<c:if test="<%=hour<10%>">0</c:if><%=hour %>
			时
		  </td>
		</tr>
	   	<tr>
	      <td class="layertdleft">结束时间：</td>
	       <td class="layerright">
	       <%
			Calendar endTime = Calendar.getInstance();
			endTime.setTime(result.getValue().getEndTime());
			int year1 = endTime.get(Calendar.YEAR);
			int month1 = endTime.get(Calendar.MONTH)+1;
			int day1 = endTime.get(Calendar.DATE);
			int hour1 = endTime.get(Calendar.HOUR_OF_DAY);
		  %>
	       	<label><%=year1 %></label>
			年
			<label><%=month1 %></label>
			月
			<label><%=day1 %></label>
			日 
			<c:if test="<%=hour1<10%>">0</c:if><%=hour1 %>
			时
			</td>
		    </tr>
			<tr>
		      <td class="layertdleft">外出事由：</td>
		      <td><div style="height: 50px; width:280px;word-break:break-all;overflow-x: hidden;overflow-y: auto">${result.value.reason}</div></td>
		    </tr>
		  </table>
		</div>
	  </div>
	  <div style="height: 5px;"></div>
</body>
</html>
