<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.oa.entity.Task"%>
<%@page import="com.wiiy.oa.activator.OaActivator"%>
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
	<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
	<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
	<link href="core/common/style/jquery-ui.css" rel="stylesheet" type="text/css"/>
	<link href="core/common/style/smartMenu.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
	<style type="text/css">
		.mouseoverGray{
			background: #f4f4f4;
		}
	</style>
	<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
	<script type="text/javascript" src="core/common/js/tools.js"></script>
	<script type="text/javascript" src="core/common/js/jquery.js"></script>
	<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
	<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
	<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
	<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
  	<script src="core/common/js/jquery-ui.min.js"></script>
	<script>
		$(document).ready(function() {
			initTip();
			var createMenu = [[{
				text: "编辑",
				classname: "smarty_menu_ico0",
				func: function() {
					fbStart('编辑任务','<%=basePath%>task!edit.action?id='+$(this).find(".id").val(),650,520);
				}
			},{
				text: "查看",
				classname: "smarty_menu_view",
				func: function() {
					fbStart('查看任务','<%=basePath%>task!view.action?id='+$(this).find(".id").val(),750,486);
				}
			}],[{
				text: "删除",
				classname: "smarty_menu_ico2",
				func: function() {
					if(confirm("您确认要删除吗?")){
						$.post("<%=basePath%>task!delete.action?id="+$(this).find(".id").val(),function(data){
							if(data.result.success){
								location.reload();
							} else {
								showTip(data.result.msg,2000);
								setTimeout("location.reload();",4000);
							}
						});
					}
				}
			}],[{
				text: "工作派送",
				classname: "smarty_menu_work",
				func: function() {
					$("#taskId").val($(this).find(".id").val());
					$("#selectUser").val("send");
					var ids = "";
					var departIds = $(this).find(".receiverId");
					if(departIds.size()>0){
						ids = ",";
						for(var i = 0; i < departIds.size(); i++){
							ids += departIds[i].value+",";
						}
					}
					fbStart('工作派送','<%=BaseAction.rootLocation%>/core/user!select2.action?ids='+ids,520,400);
				}
			}],[{
				text: "优先级",
				classname: "smarty_yu_ico0",
				data: [[{
					text: "高",
					classname: "smarty_yu_ico0",
					func: function() {
			            $.post("<%=basePath%>task!high.action?id="+$(this).find(".id").val(),function(){
							location.reload();
						});
					}
				},{
					text: "中",
					classname: "smarty_pu_ico0",
					func: function() {
						$.post("<%=basePath%>task!middle.action?id="+$(this).find(".id").val(),function(){
							location.reload();
						});
					}
				},{
					text: "低",
					classname: "smarty_di_ico0",
					func: function() {
						$.post("<%=basePath%>task!low.action?id="+$(this).find(".id").val(),function(){
							location.reload();
						});
					}
				}]]
			}],[{
				text: "设置进度",
				classname: "smarty_bai0_ico0",
				data: [[{
					text: "0%",
					classname: "smarty_bai0_ico0",
					func: function() {
						$.post("<%=basePath%>task!progress.action?id="+$(this).find(".id").val()+"&progress=0",function(){
							location.reload();
						});
					}
				}, {
					text: "25%",
					classname: "smarty_bai25_ico0",
					func: function() {
						$.post("<%=basePath%>task!progress.action?id="+$(this).find(".id").val()+"&progress=25",function(){
							location.reload();
						});
					}
				}, {
					text: "50%",
					classname: "smarty_bai50_ico0",
					func: function() {
						$.post("<%=basePath%>task!progress.action?id="+$(this).find(".id").val()+"&progress=50",function(){
							location.reload();
						});
					}
				},{
					text: "75%",
					classname: "smarty_bai75_ico0",
					func: function() {
						$.post("<%=basePath%>task!progress.action?id="+$(this).find(".id").val()+"&progress=75",function(){
							location.reload();
						});
					}
				},{
					text: "100%",
					classname: "smarty_bai100_ico0",
					func: function() {
						$.post("<%=basePath%>task!progress.action?id="+$(this).find(".id").val()+"&progress=100",function(){
							location.reload();
						});
					}
				}]]
			}],[{
				text: "中止任务",
				classname: "smarty_menu_stop",
				func: function() {
				 	if(confirm("您确认中止吗?")){
						$.post("<%=basePath%>task!aborted.action?id="+$(this).find(".id").val(),function(){
							location.reload();
						});
					}
				}
			},{
				text: "任务延期",
				classname: "smarty_menu_time",
				func: function() {
					fbStart('任务延期','<%=basePath%>web/task/task_edit_endTime.jsp?id='+$(this).find(".id").val(),420,178);
				}
			}],[{
				text: "设置部门",
				classname: "smarty_menu_org",
				func: function() {
					$("#taskId").val($(this).find(".id").val());
					var ids = "";
					var departIds = $(this).find(".departId");
					if(departIds.size()>0){
						ids = ",";
						for(var i = 0; i < departIds.size(); i++){
							ids += departIds[i].value+",";
						}
					}
					fbStart('设置部门','<%=basePath%>taskDepart!select.action?ids='+ids,420,240);
				}
			},{
				text: "设置项目",
				classname: "smarty_menu_porject",
				func: function() {
					$("#taskId").val($(this).find(".id").val());
					fbStart('设置项目','<%=basePath%>taskProject!select.action?id='+$(this).find(".projectId").val(),420,240);
				}
			}]];
			var ownerMenu = [[{
				text: "查看",
				classname: "smarty_menu_view",
				func: function() {
					fbStart('查看任务','<%=basePath%>task!view.action?id='+$(this).find(".id").val(),750,486);
				}
			}],[{
				text: "工作派送",
				classname: "smarty_menu_work",
				func: function() {
					$("#taskId").val($(this).find(".id").val());
					$("#selectUser").val("send");
					var ids = "";
					var departIds = $(this).find(".receiverId");
					if(departIds.size()>0){
						ids = ",";
						for(var i = 0; i < departIds.size(); i++){
							ids += departIds[i].value+",";
						}
					}
					fbStart('工作派送','<%=BaseAction.rootLocation%>/core/user!select2.action?ids='+ids,520,400);
				}
			}],[{
				text: "优先级",
				classname: "smarty_yu_ico0",
				data: [[{
					text: "高",
					classname: "smarty_yu_ico0",
					func: function() {
			            $.post("<%=basePath%>taskAppoint!high.action?id="+$(this).find(".id").val(),function(){
							location.reload();
						});
					}
				},{
					text: "中",
					classname: "smarty_pu_ico0",
					func: function() {
						$.post("<%=basePath%>taskAppoint!middle.action?id="+$(this).find(".id").val(),function(){
							location.reload();
						});
					}
				},{
					text: "低",
					classname: "smarty_di_ico0",
					func: function() {
						$.post("<%=basePath%>taskAppoint!low.action?id="+$(this).find(".id").val(),function(){
							location.reload();
						});
					}
				}]]
			}],[{
				text: "设置进度",
				classname: "smarty_bai0_ico0",
				data: [[{
					text: "0%",
					classname: "smarty_bai0_ico0",
					func: function() {
						$.post("<%=basePath%>taskAppoint!progress.action?id="+$(this).find(".id").val()+"&progress=0",function(){
							location.reload();
						});
					}
				}, {
					text: "25%",
					classname: "smarty_bai25_ico0",
					func: function() {
						$.post("<%=basePath%>taskAppoint!progress.action?id="+$(this).find(".id").val()+"&progress=25",function(){
							location.reload();
						});
					}
				}, {
					text: "50%",
					classname: "smarty_bai50_ico0",
					func: function() {
						$.post("<%=basePath%>taskAppoint!progress.action?id="+$(this).find(".id").val()+"&progress=50",function(){
							location.reload();
						});
					}
				},{
					text: "75%",
					classname: "smarty_bai75_ico0",
					func: function() {
						$.post("<%=basePath%>taskAppoint!progress.action?id="+$(this).find(".id").val()+"&progress=75",function(){
							location.reload();
						});
					}
				},{
					text: "100%",
					classname: "smarty_bai100_ico0",
					func: function() {
						$.post("<%=basePath%>taskAppoint!progress.action?id="+$(this).find(".id").val()+"&progress=100",function(){
							location.reload();
						});
					}
				}]]
			}],[{
				text: "中止任务",
				classname: "smarty_menu_stop",
				func: function() {
				 	if(confirm("您确认中止吗?")){
						$.post("<%=basePath%>taskAppoint!aborted.action?id="+$(this).find(".id").val(),function(){
							location.reload();
						});
					}
				}
			},{
				text: "任务延期",
				classname: "smarty_menu_time",
				func: function() {
					fbStart('任务延期','<%=basePath%>web/task/taskAppoint_edit_endTime.jsp?id='+$(this).find(".id").val(),420,178);
				}
			}],[{
				text: "设置部门",
				classname: "smarty_menu_org",
				func: function() {
					$("#taskId").val($(this).find(".id").val());
					var ids = "";
					var departIds = $(this).find(".departId");
					if(departIds.size()>0){
						ids = ",";
						for(var i = 0; i < departIds.size(); i++){
							ids += departIds[i].value+",";
						}
					}
					fbStart('设置部门','<%=basePath%>taskDepart!select.action?ids='+ids,420,240);
				}
			},{
				text: "设置项目",
				classname: "smarty_menu_porject",
				func: function() {
					$("#taskId").val($(this).find(".id").val());
					fbStart('设置项目','<%=basePath%>taskProject!select.action?id='+$(this).find(".projectId").val(),420,240);
				}
			}]];
			$(".me_me").smartMenu(createMenu,{name:'createMenu'});
			$(".me_other").smartMenu(createMenu,{name:'createMenu'});
			$(".other_me").smartMenu(ownerMenu,{name:'ownerMenu'});
			var width = window.parent.document.documentElement.clientWidth-(window.screenLeft-window.parent.screenLeft);
			$("#container").css("width",width);
			$("#dateList").css("height",getTabContentHeight()-110);
			$(".slide").css("height",getTabContentHeight()-155);
		});
		function setSelectedDeparts(departs){
			var ids = "";
			for(var i = 0; i < departs.length; i++){
				ids += departs[i].id+",";
			}
			ids = deleteLastCharWhenMatching(ids,",");
			$.post("<%=basePath%>task!setDepart.action?id="+$("#taskId").val()+"&ids="+ids,function(data){
				showTip(data.result.msg,2000);
				setTimeout("location.reload();",2000);
			});
		}
		function send(users){
			var ids = "";
			for(var i = 0; i < users.length; i++){
				ids += users[i].id+",";
			}
			ids = deleteLastCharWhenMatching(ids,",");
			$.post("<%=basePath%>task!taskSend.action?id="+$("#taskId").val()+"&ids="+ids,function(data){
				showTip(data.result.msg,2000);				
				setTimeout("location.reload();",2000);
			});
		}
		function setSelectedProject(project){
			$.post("<%=basePath%>task!setProject.action?id="+$("#taskId").val()+"&projectId="+project.id,function(data){
				showTip(data.result.msg,2000);				
				setTimeout("location.reload();",2000);
			});
		}
		function slide(id,img){
		  	if($("#"+id).is(':hidden')){
				$(".slide").slideUp();
				$(".slideImg").attr("src","core/common/images/oa_arrow.png");
				$("#"+id).slideDown();
				$("#"+img).attr("src","core/common/images/oa_arrowbtn.png");
			}else{
				$("#"+id).slideUp();
				$("#"+img).attr("src","core/common/images/oa_arrow.png");
			}
  		}		
		function deleteTaskDepartById(id){
			if(confirm("确定要删吗")){
				$.post("<%=basePath%>taskDepart!delete.action?id="+id,function(data){
					showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		setTimeout("parent.refresh();parent.fb.end();", 2000);
		        	}
				});
			}
		}
		function deleteTaskProjectById(id){
			if(confirm("确定要删吗")){
				$.post("<%=basePath%>taskProject!delete.action?id="+id,function(data){
					showTip(data.result.msg,2000);
		        	if(data.result.success){
		        		setTimeout("parent.refresh();parent.fb.end();", 2000);
		        	}
				});
			}
		}
		function hiddenTaskProjectById(id,id2){
			if(confirm("确定关闭吗")){
				$("#"+id).attr("style","display:none");
				$("#"+id2).attr("style","display:none");				
			}
		}
		function jumpPage(page){
			var url = "<%=basePath%>task!list.action";
			url += "?page="+page;
			if($("#title").val()){
				url += "&title="+$("#title").val();
			}
			if($('#op').val()){
				url += "&op="+$("#op").val();
			}
			if($('#endTime').val()){
				url += "&endTime="+$("#endTime").val();
			}
			if($('#status').val()){
				url += "&status="+$('#status').val();
			}
			if($("#creatorid").val()){
				url += "&creatorid="+$('#creatorid').val();
				url += "&creator="+$('#creatorname').val();
			}
			if($("#executorid").val()){
				url += "&executorid="+$('#executorid').val();
				url += "&executor="+$('#executorname').val();
			}
			url = encodeURI(url);
			location.href=url;
		}
		function doSearch(){
			jumpPage(1);
		}
		function selectCreator(){
			$("#selectUser").val("creator");
			fbStart('选择联系人','core/user!select2.action',520,400);
		}
		function selectExecutor(){
			$("#selectUser").val("executor");
			fbStart('选择执行人','core/user!select2.action',520,400);
		}
		function setSelectedUsers(users){
			if($("#selectUser").val()=='send'){
				send(users);
				return;
			}
			var ids = ",";
			var names = "";
			for(var i = 0; i < users.length; i++){
				ids += users[i].id+",";
				names += users[i].name+",";
			}
			$("#"+$("#selectUser").val()+"id").val(ids);
			$("#"+$("#selectUser").val()+"name").val(names);
		}
  </script>
</head>
<body>
	<input type="hidden" id="selectUser"/>
	<input type="hidden" id="creatorid" value="${creatorid}"/>
	<input type="hidden" id="executorid" value="${executorid}"/>
	<input type="hidden" id="taskId"/>
	<div class="emailtop">
	<div class="leftemail">
		<ul>
			<li onmouseover="this.className='libg'" onmouseout="this.className=''" onclick="fbStart('新建任务','<%=basePath %>task!add.action',650,520);"><span><img src="core/common/images/emailadd.gif"/></span>新建</li>
		</ul>
	</div>
</div>
<div class="searchdiv">
	<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td width="40" align="right">主题：</td>
			<td width="130">
			<input type="hidden" value="${status}" id="status"/>
			<input id="title" type="text" class="inputauto" value="${title}"/></td>
			<td width="75" align="right">截止日期：</td>
			<td width="55"><select id="op" name="select">
					<option value="lt" <c:if test="${op eq 'lt'}">selected="selected"</c:if>>小于</option>
					<option value="ge" <c:if test="${op eq 'ge'}">selected="selected"</c:if>>大于</option>
					<option value="eq" <c:if test="${op eq 'eq'}">selected="selected"</c:if>>等于</option>
				</select></td>
			<td width="120">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td><input id="endTime" value="<fmt:formatDate value="${endTime}" pattern="yyyy-MM-dd"/>" name="endTime" type="text" class="inputauto" onclick="return showCalendar('endTime')" /></td>
						<td width="20" align="center"><img onclick="return showCalendar('endTime')" style="cursor:pointer; position: relative; left:-1px;" src="core/common/images/timeico.gif" width="20" height="22" /></td>
					</tr>
				</table>        
			</td>
			<td width="85" align="center"><input type="button" name="Submit" value="" class="searchbtn" onclick="doSearch()"/></td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
</div>
<div id="container" class="contentDiv">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td valign="top">
				<div class="oataskborder" id="resizable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" id="lsittable">
						<tr>
							<td width="35" class="tdleftc">序号</td>
							<td width="17" class="tdleftc"><label><img src="core/common/images/gth.png" width="4" height="10" /></label></td>
							<td width="20" class="tdleftc"><img src="core/common/images/uploadfj.gif" width="7" height="12" /></td>
							<td class="tdcenterL">主题</td>
							<td width="200" class="tdleftc">部门</td>
							<td width="80" class="tdleftc">截止日期</td>
							<td width="50" class="tdrightc"><img src="core/common/images/bai0.png" width="14" height="14" style="position:relative; left:-2px;" /></td>
						</tr>
					</table>
					<div id="dateList" style="overflow-x: hidden;overflow-y: auto; ">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" id="lsittable">
						<c:forEach items="${taskList}" var="task" varStatus="s">
						<%-- <%	 Task task = (Task)pageContext.getAttribute("task");
						Set<TaskAppoint> appoints = task.getTaskAppoints();
						boolean exist = false;
						for(TaskAppoint appoint : appoints){
							if(userId == appoint.getReceiverId().longValue()){
								exist = true;
								break;
							}
						}
						String className  = "";
						if(exist && appoints.size()==1 && userId == task.getCreatorId().longValue()){
							className = "me_me";
						}
						if(!exist && userId == task.getCreatorId().longValue()){
							className = "me_other task_one";
						}
						if(exist && userId != task.getCreatorId().longValue()){
							className = "other_me task_two";
						}
						
						%>
						<tr class="<%=className %>" onmouseover="$(this).addClass('mouseoverGray')" onmouseout="$(this).removeClass('mouseoverGray')">
							<%  
								String priorityColor = "";
								if(task.getPriority()!=null){
									switch(task.getPriority()){
										case LOW:
											priorityColor = "blue";
											break;
										case MIDDLE:
											priorityColor = "yellow";
											break;
										case HIGH:
											priorityColor = "red";
											break;
									}
								}
							%> --%>
							<%-- <td width="35"  class="centertd">${s.index+1}</td>
							<td width="17" class="centertd"><label><c:if test="${task.priority ne null}"><img src="core/common/images/gth<%=priorityColor %>.png" width="4" height="10" /></c:if>&nbsp; </label></td>
							<td width="20" class="centertd"><c:if test="${fn:length(task.atts)>0}"><img src="core/common/images/uploadfj.gif" width="7" height="12" /></c:if>&nbsp;</td>
							<td class="lefttd" onclick="fbStart('查看任务','<%=basePath%>task!view.action?id=${task.id}',750,486);">${task.title}<input class="id" type="hidden" value="${task.id}"/><input type="hidden" class="projectId" value="${task.projectId}"/><c:forEach items="${task.taskAppoints}" var="appoint"><input class="receiverId" type="hidden" value="${appoint.receiverId}"/>&nbsp;</c:forEach></td>
							<td width="200" class="centertd"><c:forEach items="${task.departConfigs}" var="config">${config.depart.name}<input class="departId" type="hidden" value="${config.departId}"/>&nbsp;</c:forEach></td>
							<td width="80" class="centertd"><fmt:formatDate value="${task.endTime}" pattern="yyyy-MM-dd"/></td>
							 --%><td width="50" class="centertd"><img src="core/common/images/bai${task.progress}.png" width="14" height="14" /></td>
						</tr>
						</c:forEach>
					</table>
					</div>
					<%@include file="../pager.jsp" %>
				</div>
			</td>
			<td width="210" valign="top" style=" padding-top:5px;">
		  	<div class="oasidebar" id="oasidebar">
				<div class="oasidebartitle"><span><img onclick="slide('listmenu1','img1')" class="slideImg" id="img1" src="core/common/images/oa_arrowbtn.png" /></span>我的工作</div>
				<div id="listmenu1" class="slide">
					<div class="oasidelistzh">
						<ul>
							<li>
							<a href="<%=basePath %>task!list.action">所有工作</a>
							</li>
						</ul>
					</div>
					<div class="oataskbg">
						<ul>
							<li><img src="core/common/images/oneself.png" /><span>我→我</span></li>
							<li><img src="core/common/images/oethers.png" /><span>我→别人</span>(需要别人签收的)</li>
							<li><img src="core/common/images/threee.png" /><span>别人→我</span>(需要我签收的)</li>
						</ul>
					</div>
					<div class="oasidelistzh">
						<ul>
							<li onclick="location.href='<%=basePath %>task!list.action?status=pending'"><span <c:if test="${status=='pending'}">class="libg"</c:if>>我待办的工作</span>(<span class="psred"><strong>${myTaskAmountDto.pending}</strong></span>)</li>
							<li>
							　　<span class="gray">其中</span>
							<a href="<%=basePath %>task!list.action?status=normal">正常(<span class="psred"><strong>${myTaskAmountDto.normal}</strong></span>)</a>
							<a href="<%=basePath %>task!list.action?status=delay">逾期(<span class="psred"><strong>${myTaskAmountDto.delay}</strong></span>)</a>
							</li>
							<li onclick="location.href='<%=basePath %>task!list.action?status=sended'"><span <c:if test="${status=='sended'}">class="libg"</c:if>>我派出的工作</span></li>
							<li onclick="location.href='<%=basePath %>task!list.action?status=signed'"><span <c:if test="${status=='signed'}">class="libg"</c:if>>待签收的工作</span>(<span class="psred"><strong onclick="location.href='<%=basePath %>task!list.action?status=signed'">${myTaskAmountDto.signed}</strong></span>)</li>
						</ul>
					</div>
				</div>
				
				<div class="oasidebartitle"><span><a href="javascript:void(0)" onclick="fbStart('新建部门','<%=basePath %>web/task/taskDepart_add.jsp',300,80);">新建</a><img class="slideImg" onclick="slide('listmenu2','img2')" id="img2" src="core/common/images/oa_arrow.png" /></span>部门工作</div>
				<div id="listmenu2" class="slide" style="overflow-x:hidden; overflow-y:auto;display: none;">
					<div class="oasidelistzh">
						<ul>
							<c:forEach items="${departDtoList}" var="dto" varStatus="status">
							<li onmouseover="$('#dep${status.index}').css({display:''})" onmouseout="$('#dep${status.index}').css({display:'none'})"><span class="btnwei" id="dep${status.index}" style="display:none"><span class="renamebtnadd" onclick="fbStart('重命名','<%=basePath%>taskDepart!edit.action?id='+${dto.depart.id},300,60);"></span><span class="delbtnadd" onclick="deleteTaskDepartById('${dto.depart.id}')"></span></span>${dto.depart.name}</li>
							<li class="lidownline">
							<a href="<%=basePath %>task!list.action?departId=${dto.depart.id}&status=unfinish">待办(<span class="psred"><strong>${dto.unfinish}</strong></span>)</a>
							<a href="<%=basePath %>task!list.action?departId=${dto.depart.id}&status=overdue">逾期(<span class="psred"><strong>${dto.overdue}</strong></span>)</a>
							</li>
							</c:forEach>
						</ul>
					</div>
				</div>
				
				<div class="oasidebartitle"><span><a href="javascript:void(0)" onclick="fbStart('新建项目','<%=basePath %>web/task/taskProject_add.jsp',300,80);">新建</a><img class="slideImg" onclick="slide('listmenu3','img3')" id="img3" src="core/common/images/oa_arrow.png" /></span>项目工作</div>
				<div id="listmenu3" class="slide" style="overflow-x:hidden; overflow-y:auto;display: none;">
					<div class="oasidelistzh">
						<ul>
							<c:forEach items="${projectDtoList}" var="dto" varStatus="status">
							<li id="product1${status.index}" onmouseover="$('#product${status.index}').css({display:''})" onmouseout="$('#product${status.index}').css({display:'none'})"><span class="btnwei" id="product${status.index}" style="display:none;"><span class="renamebtnadd" onclick="fbStart('重命名','<%=basePath%>taskProject!edit.action?id='+${dto.project.id},300,60);"></span><span class="delbtnadd" onclick="deleteTaskProjectById('${dto.project.id}')"></span><span class="closebtn" onclick="hiddenTaskProjectById('product1${status.index}','product2${status.index}')"></span></span>${dto.project.name}</li>
							<li id="product2${status.index}" class="lidownline">
							<a href="<%=basePath %>task!list.action?projectId=${dto.project.id}&status=unfinish">待办(<span class="psred"><strong>${dto.unfinish}</strong></span>)</a>
							<a href="<%=basePath %>task!list.action?projectId=${dto.project.id}&status=overdue">逾期(<span class="psred"><strong>${dto.overdue}</strong></span>)</a>
							</li>
							</c:forEach>
						</ul>
					</div>
					<div class="hackbox"></div>
				</div>
				<div class="oasidebartitle"><span><img class="slideImg" onclick="slide('listmenu4','img4')" id="img4" src="core/common/images/oa_arrow.png" /></span>他人工作</div>
				<div id="listmenu4" class="listmenu"  style="overflow-x:hidden; overflow-y:auto; display:none;">
				<div class="oasidelistsearch">
					<ul>
						<li><table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td colspan="2"><span style="color:#666">请选择任务创建人：</span></td>
								</tr>
								<tr>
									<td width="158"><input id="creatorname" type="text" class="sinput" value="${creator}"/></td>
									<td width="20"><img onclick="selectCreator()" style="position:relative; left:-2px;" src="core/common/images/outdiv.gif" /></td>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td colspan="2"><span style="color:#666">请选择任务执行人：</span></td>
								</tr>
								<tr>
									<td width="158"><input id="executorname" type="text" class="sinput" value="${executor}"/></td>
									<td width="20"><img onclick="selectExecutor()" style="position:relative; left:-2px;" src="core/common/images/outdiv.gif" /></td>
									<td>&nbsp;</td>
								</tr>
								<tr >
									<td style="padding-top:5px; padding-left:1px;"><input name="" type="button" class="oasearchbtn" value="" onclick="doSearch()"/></td>
								</tr>
							</table>
						</li>
					</ul>
				</div>
				<div class="hackbox"></div>
				</div>
			</div>
			</td>
		</tr>
  	</table>
</div>
</body>

</html>