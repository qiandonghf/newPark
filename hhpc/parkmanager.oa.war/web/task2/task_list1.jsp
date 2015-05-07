<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.oa.entity.Task"%>
<%@page import="com.wiiy.oa.activator.OaActivator"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@page import="java.util.Map"%>
<%@page import="com.wiiy.oa.entity.Task"%>
<%@page import="org.apache.taglibs.standard.tag.common.core.ForEachSupport"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
long userId = OaActivator.getSessionUser(request).getId().longValue();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>无标题文档</title>
<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link href="core/common/style/smartMenu.css" rel="stylesheet" type="text/css" />
<link href="parkmanager.oa/web/style/task.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/righth.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript">
		 
	$(document).ready(function() {
		var h=window.document.documentElement.clientHeight;
		$(".taskcontent").css({height:h});
		$(".tasksidebar").css({height:h});
		$(".contentDiv").width(window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft));
		$(".sendWorklist li").each(function(i){
			$(".sendWorklist li .arrow").eq(i).click(function(){
				if($(".sendchild").eq(i).css("display")=="block")
				{$(".sendchild").eq(i).css({display:"none"});}
				else{
				$(".sendWorklist li .arrow img").attr("src","parkmanager.oa/web/images/taskup.gif");
				$(".sendWorklist li .arrow img").eq(i).attr("src","parkmanager.oa/web/images/taskdown.gif");
				$(".sendchild").css({display:"none"});
				$(".sendchild").eq(i).css({display:"block"});
				}
			});
		});
		var sendH=h-$(".todowork").height()-90;
		$(".sendWorklist").css({height:sendH});
		$("#task_main").css({height:h});
		$(".tasktab li").each(function(k){
			$(".tasktab li").eq(k).click(function(){
				$(".tasktab li").removeClass("livisited").addClass("lilink");
				$(".tasktab li").eq(k).removeClass("lilink").addClass("livisited");
			});
		});
	    });
	
	function setSelectedUsers(users){
		window.frames[0].setSelectedUsers(users);
	}
	function setSelectedUser(user){
		window.frames[0].setSelectedUser(user);
	}
	function setSelectedDeparts(departs){
		window.frames[0].setSelectedDeparts(departs);
	}
	function setSelectedProject(project){
		window.frames[0].setSelectedProject(project);
	}
  	function setDepartReload(){
  		window.frames[0].setDepartReload();
  	}
  	function setProjectReload(){
  		window.frames[0].setProjectReload();
  	}
  	function setReload(){
  		window.frames[0].setReload();
  	}
  	<%
	Map<String, ResourceDto> resourceMap = OaActivator.getHttpSessionService().getResourceMap();
	%>
  </script>
</head>
<body class="taskbg">
<div class="contentDiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" class="taskcontent" >
		 <iframe scrolling="no" frameborder="0" src="<%=basePath %>web/task2/task_send.jsp" width="100%" id="task_main" name="task_main"></iframe> 
	</td>
    <td width="32" valign="top">
		<div class="tasktab">
		<ul>
			<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_myJob")){ %>
			<a href="<%=basePath %>web/task2/task_send.jsp" target="task_main" style="text-decoration: none"><li class="livisited" >我<br/>的<br/>工<br/>作<br/></li></a>
			<%} %>
			<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_departWork")){ %>
			<a href="<%=basePath %>task!depList.action" target="task_main" style="text-decoration: none"><li class="lilink">部<br/>门<br/>工<br/>作<br/></li></a>
			<%} %>
			<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_projectWork")){ %>
			<a href="<%=basePath %>task!projectList.action" target="task_main" style="text-decoration: none"><li class="lilink">项<br/>目<br/>工<br/>作<br/></li></a>
			<%} %>
			<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_employee")){ %>
			<a href="<%=basePath %>task!employeeList.action" target="task_main" style="text-decoration: none"><li class="lilink">员<br/>工<br/>工<br/>作<br/></li></a>
			<%} %>
		</ul>
		</div>
	</td>
  </tr>
</table>
</div>
</body>


</html>
