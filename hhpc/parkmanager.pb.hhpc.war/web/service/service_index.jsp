<%@page import="com.wiiy.pb.activator.PbActivator"%>
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
<link href="parkmanager.pb/web/style/user.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript">
	function openService(plugin,icon,url){
		if (parent.$('#tt').tabs('exists',plugin)){
			parent.$('#tt').tabs('select', plugin);
		} else {
			parent.$('#tt').tabs('add',{
				title:plugin,
				iconCls:'icon-reload',
				content: '<iframe src="'+url+'" frameborder="0" height="'+(parent.document.documentElement.clientHeight-147)+'" width="100%"></iframe>',
				closable:true
			});
		}
		var dotIndex = icon.lastIndexOf(".");
		icon = icon.substring(0,dotIndex)+icon.substring(dotIndex);
		addTabIcon(plugin,icon);
	}
	function addTabIcon(title,icon){
		var span = parent.$('#tt').find("span:contains('"+title+"')");
		span.next().css("background","url('"+icon+"') no-repeat");
	}
	
	function applyList(){
		<% if( PbActivator.getHttpSessionService().
				isInResourceMap("pb_service_serviceWindow_check")){
        %>
		openService("入圃查询",'/parkmanager.pb/web/images/icon/process_05_min.png',"<%=basePath%>garden!applyList.action?info=WINDOW");
		<%}%>
	}
	
	function incubationList(){
		<% if( PbActivator.getHttpSessionService().
				isInResourceMap("pb_service_serviceWindow_incubation_check")){
        %>
		openService("入孵查询",'parkmanager.pb/web/images/icon/projectadmin_01_min.png',"<%=basePath%>investment!list.action?info=WINDOW&type=NEW");
		<%}%>
	}
	
	function addIncubation(){
		<% if( PbActivator.getHttpSessionService().
				isInResourceMap("pb_service_serviceWindow_incubation_add")){
        %>
		fbStart('新建入孵申请','<%=basePath%>web/incubation/incubation_add.jsp?info=WINDOW',700,507);
		<%}%>
	}

</script>
<title>无标题文档</title>
</head>

<body>
 <div class="service">
		<!--servicetips-->
		<div class="servicetips">
		  <img src="parkmanager.pb/web/images/est.png" width="50" height="50" />		
		  <ul>
		  	<li class="title">苗圃项目</li>
			<li onclick="window.open('<%=basePath%>web/garden/garden_apply_add.jsp?source=WINDOW','入圃申请','scrollbars=yes,resizable=no,width=730,height=620')">入圃申请</li>
			<li><a href="javascript:;" onclick="applyList();">入圃查询</a></li>
		  </ul>
	    </div>
		<!--//servicetips-->
		<!--servicetips-->
		<div class="servicetips">
		  <img src="parkmanager.pb/web/images/zdxx.png" width="50" height="50" />		
		  <ul>
		  	<li class="title">企业入孵</li>
			<li onclick="addIncubation();">入孵申请</li>
			<li><a href="javascript:;" onclick="incubationList();">入孵查询</a></li>
		  </ul>
   </div>
 </div>
</body>
</html>

