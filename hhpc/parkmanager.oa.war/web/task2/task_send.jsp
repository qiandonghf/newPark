<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.oa.entity.Task"%>
<%@page import="com.wiiy.oa.activator.OaActivator"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@page import="java.util.Map"%>
<%@page import="com.wiiy.oa.entity.TaskLog"%>
<%@page import="com.wiiy.oa.dto.TaskDto"%>
<%@page import="org.apache.taglibs.standard.tag.common.core.ForEachSupport"%>
<%@page import="com.wiiy.oa.preferences.enums.SubTaskStatusEnum"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<link href="parkmanager.oa/web/style/task.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/righth.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript">
	var createMenu = [
	    [
		<%
		Map<String, ResourceDto> resourceMap = OaActivator.getHttpSessionService().getResourceMap();
		boolean flag = false;
		if(OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_editTasking")){
			flag = true;
		%>
			{text: "编辑",
			classname: "smarty_menu_ico0",
				func: function() {
					fbStart('编辑工作','<%=basePath%>task!edit.action?id='+$(this).find(".id").val(),650,500);
				}
			}
		<%}%>
		<%
		if(OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_viewTasking")){
			if(flag){
				%>,<%
			}
			flag = true;
			%>
			{text: "查看",
			classname: "smarty_menu_view",
			func: function() {
				fbStart('查看工作','<%=basePath%>task!view.action?id='+$(this).find(".id").val(),650,400);
			}
			}
		<%}%>
		]
	    ,
	    
	    [
		<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_delTasking")){
		%>
			{text: "删除",
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
			}
		<%}%>
		]
	    ,
	    [
		<%
			flag = false;
			if(OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_taskSend")){
				flag = true;
		%>
		   {text: "派送",
			classname: "smarty_menu_appoint",
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
				fbStart('工作派送','<%=BaseAction.rootLocation%>/core/user!select2.action?ids='+ids+'&id='+1,520,400);
			}
		}
		<%}%> 
		<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_taskMove")){
			if(flag){
		%>
		   ,
		<%}
			flag = true;
		%> 
		 	{text: "移交",
			classname: "smarty_menu_transfer",
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
				fbStart('工作移交','<%=BaseAction.rootLocation%>/core/user!select.action?ids='+ids+'&id='+1,520,400);
			}
		}
		<%}%> 
		]
	    ,
	    [
	     
		<%
			flag = false;
			if(OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_level")){
				flag = true;
		%>
		   {text: "优先级",
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
		}
		<%}%> 
		<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_progress")){
			if(flag){
		%>
		,
		<%}
			flag = true;
		%> 
			{text: "设置进度",
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
		}
		<%}%> 
		]
	    ,
	    [
		<%
			flag = false;
			if(OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_stop")){
		%>
			   {text: "中止工作",
				classname: "smarty_menu_stop",
				func: function() {
				 	if(confirm("您确认中止吗?")){
						$.post("<%=basePath%>task!aborted.action?id="+$(this).find(".id").val(),function(){
							location.reload();
						});
					}
				}
			}
		<%}%> 
		<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_delay")){
			if(flag){
		%>
		,
		<%}
			flag = true;
		%>
		[
		{text: "工作延期",
			classname: "smarty_menu_time",
			func: function() {
				fbStart('工作延期','<%=basePath%>web/task/task_edit_endTime.jsp?id='+$(this).find(".id").val(),420,178);
			}
		}
		<%}%> 
		<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_setFinish")){
			if(flag){
		%>
		,
		<%}
			flag = true;
		%> 
		{text: "设置完成",
			classname: "smarty_menu_finish",
			func: function() {
				if(confirm("您确认要设置完成吗?")){
					 $.post("<%=basePath%>task!finished.action?id="+$(this).find(".id").val(),function(){
						location.reload();
					});
			 	}
			 }
		}
		<%}%> 
		]
	    ,
	    [
		<%
			flag = false;
			if(OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_setDepart")){
				flag = true;
		%>
		   {text: "设置部门",
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
			}
		   <%}%> 
		   <%if(OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_setProject")){
				if(flag){
			%>
		   ,
		   <%}
				flag = true;
			%> 
		   {text: "设置项目",
			classname: "smarty_menu_porject",
			func: function() {
				$("#taskId").val($(this).find(".id").val());
				fbStart('设置项目','<%=basePath%>taskProject!select.action?id='+$(this).find(".projectId").val(),420,240);
			}
		}
		<%}%>  
		]]];
	
	 $(document).ready(function() {
		initTip();
		$(".liTask").smartMenu(createMenu,{name:'createMenu'});
		var h=window.parent.document.documentElement.clientHeight;
		var h2 = h-50;
		$(".taskcontet").css({height:h2});
		$(".tasksidebar").css({height:h});
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
		var sendH=h-$("#todoWorkIframe").height()-200;
		$(".sendWorklist").css({height:sendH});
		var sendIframe = sendH+170;
		$("#sendWorIframe").css({height:sendIframe});
		$("#todoworkWorIframe").css({height:h2});
	});
	
	function setSelectedDeparts(departs){
		window.frames[2].setSelectedDeparts(departs);
	}
	
	function setSelectedUsers(users){
		window.frames[2].setSelectedUsers(users);
	}
	
	function setSelectedUser(user){
		window.frames[2].setSelectedUser(user);
		}
	
	function setSelectedProject(project){
		window.frames[2].setSelectedProject(project);
	}
	
	function singed(id){
	$.post("<%=basePath%>task!signed.action?id="+id,function(data){
		if(data.result.success){
			showTip("任务签收成功",2000);
			setTimeout("location.reload();",2000);
		}
	});
	}
	function setReload(){
  		location.reload();
  	}
  
	function viewTask(id){
		fbStart('查看工作','<%=basePath%>task!view.action?id='+id,650,400);
	}
	function jumpPage(page){
		var url = "<%=basePath%>task!mySendTaskList.action";
		url += "?page="+page;
		url = encodeURI(url);
		location.href=url;
	}
  </script>
</head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="351"><div class="tasksidebar">
			<input type="hidden" id="selectUser"/>
			<input type="hidden" id="creatorid" value="${creatorid}"/>
			<input type="hidden" id="executorid" value="${executorid}"/>
			<input type="hidden" id="taskId"/>
			<div class="task_qiucknav">
				<ul>
					<li class="taskactive"><span class="taskactive_arrow"></span><a href="<%=basePath %>web/task2/task_send.jsp">签收与派出的工作</a></li>
					<%
						if(OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_finished")){
					%>
					<li class="tasklink"><a href="<%=basePath %>task!finish.action">已完成的工作</a></li>
					<%} %>
				</ul>
			</div>
		
			<!--todowork-->
				<iframe src="<%=basePath %>task!myPendingList.action" frameborder="0" id="todoWorkIframe" width="100%" ></iframe>
			<!--todowork-->
			<!--sendWork-->
			
				<iframe src="<%=basePath %>task!mySendTaskList.action" frameborder="0" width="100%" id="sendWorIframe" height="100%"></iframe>
			
		
			<!--//sendWork-->
		</div>
		</td>
		
		<td valign="top"><div class="tasklist">
			<div class="tasklisttitle">
			<div class="tasksearch">
			<%
				if(OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_signTasking")){
			%>
			<input name="" type="button" class="task_add" onmouseover="this.className='task_add_over'" onmouseout="this.className='task_add'" onclick="fbStart('新建工作','<%=basePath %>task!add.action',650,500);" />
			<%} %>
			</div>
			<img src="parkmanager.oa/web/images/work.png" /></div>
				<iframe src="<%=basePath %>task!myWorkList.action" frameborder="0" width="100%" id="todoworkWorIframe" height="100%"></iframe>
		</div>
		</td>
	</tr>
</table>	
</body>


</html>
