<%@page import="com.wiiy.oa.dto.TaskDto"%>
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
<link href="core/common/style/work.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	      <td width="80" class="oawordtdleft">&nbsp;</td>
	      <td class="oawordtd">日报</td>
	      <td class="oawordtd">周报</td>
	      <td class="oawordtd">月报</td>
	    </tr>
	    <tr id="writeReport">
	      <td class="oawordtdleft">写</td>
	      <td class="oawordtd"><a href="javascript:void(0)" title="写日报" onclick='javascript:windowOpen("<%=BaseAction.rootLocation %>/parkmanager.oa/workDayReport!addDayReport.action","weeks",800,600);'><img src="core/common/images/write.png" width="16" height="16" /></a></td>
	      <td class="oawordtd"><a href="javascript:void(0)" title="写周报" onclick='javascript:windowOpen("<%=BaseAction.rootLocation %>/parkmanager.oa/workReport!addWeekReport.action","weeks",800,600);'><img src="core/common/images/write.png" width="16" height="16" /></a></td>
	      <td class="oawordtd"><a href="javascript:void(0)" title="写月报" onclick='javascript:windowOpen("<%=BaseAction.rootLocation %>/parkmanager.oa/workReport!addMonthReport.action","month",800,600);'><img src="core/common/images/write.png" width="16" height="16" /></a></td>
	    </tr>
	    <tr>
	      <td class="oawordtdleft">看下级</td>
	      <td class="oawordtd">${result.value.dayCount}</td>
	      <td class="oawordtd"><span id="weekCount">${result.value.weekCount}</span></td>
	      <td class="oawordtd"><span id="monthCount">${result.value.monthCount}</span></td>
	    </tr>
	    <tr>
	      <td class="oawordtdleft">提交情况</td>
	      <td class="oawordtd"><img src="core/web/images/tjqc.png" width="10" height="10" onclick="addTab(parent.parent,'我的汇报','parkmanager.oa/workReport!list.action')"/></td>
	      <td class="oawordtd"><img src="core/web/images/tjqc.png" width="10" height="10" onclick="addTab(parent.parent,'我的汇报','parkmanager.oa/workReport!list.action')"/></td>
	      <td class="oawordtd"><img src="core/web/images/tjqc.png" width="10" height="10" onclick="addTab(parent.parent,'我的汇报','parkmanager.oa/workReport!list.action')"/></td>
	    </tr>
	    <tr>
	      <td class="oawordtdleft">汇总</td>
	      <td class="oawordtd"><img src="core/web/images/countwork.png" onclick="addTab(parent.parent,'个人工作汇总','parkmanager.oa/workDayReport!dayCountList.action')"/></td>
	      <td class="oawordtd"><img src="core/web/images/countwork.png" onclick="addTab(parent.parent,'个人工作汇总','parkmanager.oa/workReport!workCountList.action')"/></td>
	      <td class="oawordtd"><img src="core/web/images/countwork.png" onclick="addTab(parent.parent,'个人工作汇总','parkmanager.oa/workReport!workMonthCountList.action')"/></td>    
	    </tr>
	 </table> 
</div>
</body>
</html>