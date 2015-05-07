<%@page import="com.wiiy.commons.preferences.enums.UserTypeEnum"%>
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
<script type="text/javascript" src="core/common/js/jquery.js"></script>
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
	$(function(){
		$(".dataUrl").each(function(){
			var _this = this;
			$.post($(this).val(),function(data){
				if(data!='' && data.result!='' && data.result.success!='' && data.result.success){
					$(_this).prev().html(data.result.value);
				}
			});
		});
	});

	function evalList(){
		openService("项目评审",'/parkmanager.pb/web/images/icon/process_05_min.png',"<%=basePath%>garden!evalApplyList.action");
	}
	
	function projectList(){
		openService("查看项目",'/parkmanager.pb/web/images/icon/process_05_min.png',"<%=basePath%>garden!projects.action");
	}
</script>
<title>无标题文档</title>
</head>

<body>
 <div class="service">
		<!--servicetips-->
		<% if(PbActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.OTHER)){ %>
		<% if( PbActivator.getHttpSessionService().isInResourceMap("pb_gardenProject_eval")){
	    %>
	    <div class="servicetips" onclick="evalList();">
			<img src="parkmanager.pb/web/images/est.png" width="50" height="50" />
			<ul>
				<li class="title">项目评审<span style="margin-left: 5px;color: red;"></span></li>
				<li>入圃项目的评审工作</li>
			</ul>
		</div>
	    <%} %>
	    <%} %>
		<!--//servicetips-->
		<% if(PbActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.OTHER)){ %>
		<% if( PbActivator.getHttpSessionService().isInResourceMap("pb_gardenProject_projects")){
	    %>
		<!--servicetips-->
		<div class="servicetips" onclick="projectList();">
			<img src="parkmanager.pb/web/images/est.png" width="50" height="50" />
			<ul>
				<li class="title">项目库<span style="margin-left: 5px;color: red;"></span></li>
				<li>查看融资的入圃项目</li>
			</ul>
		</div>
	    <%} %>
	    <%} %>
 </div>
</body>
</html>

