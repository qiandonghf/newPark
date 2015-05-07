<%@page import="com.wiiy.hibernate.Result"%>
<%@page import="com.wiiy.oa.entity.MeetingRoomRent"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@page import="com.wiiy.commons.util.CalendarUtil"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"  %>
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
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>

</head>

<body style="padding-bottom: 5px;">
<!--basediv-->
<%
	Result<MeetingRoomRent> result = (Result<MeetingRoomRent>)request.getAttribute("result"); 
	Calendar startTime = Calendar.getInstance();
	startTime.setTime(result.getValue().getRentTime());
	int hour = startTime.get(Calendar.HOUR_OF_DAY);
	int minute = startTime.get(Calendar.MINUTE);
%>
<div class="basediv">
<div class="divlays" style="margin:0px;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="layertdleft100">借用单位：</td>
        <td class="layerright" width="200">${result.value.company}</td>
        <td class="layertdleft100">借用事由：</td>
        <td class="layerright" width="150">${result.value.reason}</td> 
      </tr>
      <tr>
        <td class="layertdleft100">联系电话：</td>
        <td class="layerright">${result.value.phone}</td>
	 	<td class="layertdleft100">联系人：</td>
        <td class="layerright">${result.value.linkman}</td>
      </tr>
      <tr>
	 	<td class="layertdleft100">参会人数：</td>
        <td class="layerright" colspan="3" >${result.value.cnt}</td>
      </tr>
      <tr>
      	<td class="layertdleft100">借用时间：</td>
        <td class="layerright" colspan="3">
        	<table>
        		<tr>
        			<td><fmt:formatDate value="${result.value.rentTime}" pattern="yyyy-MM-dd"/></td>
        			<td></td>
        			<td>
        				<label>&nbsp;<c:if test="<%=hour<10 %>">0</c:if><%=hour %></label>时
						<label>&nbsp;<c:if test="<%=minute<10 %>">0</c:if><%=minute %></label>分
					</td>
        		</tr>
        	</table>
        </td>
		<td><input id="rentTimeHour"  name="rentTimeHour"  type="hidden" value="<fmt:formatDate value="${result.value.rentTime}" pattern="HH"/>"  /></td>
		<td><input id="rentTimeMinute" name="rentTimeMinute"  type="hidden" value="<fmt:formatDate value="${result.value.rentTime}" pattern="mm"/>"  /></td>
      </tr>
      <tr>
        <td class="layertdleft100">借用场所：</td>
        <td class="layerright" colspan="3">
          <div style="width:465px;height: 70px;word-break:break-all;overflow-y: auto; overflow-x: hidden;">${result.value.meetingRoom}</div>
        </td>
      </tr>
      <tr>
        <td class="layertdleft100">办公室意见：</td>
        <td class="layerright" colspan="3">
        	<div style="height: 70px;width: 465px; word-break:break-all; overflow-y: auto; overflow-x: hidden;">${result.value.approval}</div>
        </td>
      </tr>
</table>
<div class="hackbox"></div>
</div>
</div>
</body>
</html>
