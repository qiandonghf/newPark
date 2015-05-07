<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.oa.entity.Task"%>
<%@page import="com.wiiy.oa.activator.OaActivator"%>
<%@page import="com.wiiy.oa.entity.Task"%>
<%@page import="org.apache.taglibs.standard.tag.common.core.ForEachSupport"%>
<%@page import="com.wiiy.commons.util.DateUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
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
var imageMenuData= [[
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
             		%>
             	    ,	
             	    <%}
             			flag = true;
             		%>
             	    	{text: "查看",
             			classname: "smarty_menu_view",
             			func: function() {
             				fbStart('查看工作','<%=basePath%>task!view.action?id='+$(this).find(".id").val(),650,400);
             			}
             		}
             	    <%}%>
             	    ],[
             		<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_delTasking")){%>
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
             	    ],[
             		<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_level")){%>   
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
             		<%
             			if(OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_progress")){
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
             	    ],[
             		<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_stop")){%>    
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
             		<%
             			if(OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_delay")){
             				if(flag){
             		%>      
             	    ,
             	    <%}
             			flag = true;
             		%>
             	    	{text: "工作延期",
             			classname: "smarty_menu_time",
             				func: function() {
             					fbStart('工作延期','<%=basePath%>web/task/task_edit_endTime.jsp?id='+$(this).find(".id").val(),420,178);
             				}
             			}
             	    	<%}%>
             			<%
             				if(OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_setFinish")){
             					if(flag){
             			%>
             	    	,
             	    	<%}
             				flag = true;
             			%>
             	    	{
             			text: "设置完成",
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
             	    ],[
             		<%if(OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_setDepart")){%>   
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
             		<%
             			if(OaActivator.getHttpSessionService().isInResourceMap("oa_tasking_setProject")){
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
             	    ]];
	
	$(document).ready(function() {
		initTip();
		var h=window.document.documentElement.clientHeight;
		$(".taskcontet").css({height:h});
		$(".liTask<%=OaActivator.getSessionUser(request).getId()%>").smartMenu(imageMenuData,{name:'imageMenuData'});
		var h2=window.parent.document.documentElement.clientHeight-75;
		/* var pager = $("#pagerT").val();
		var h2;
		if(pager!=null){
			h2 = h-120;
		}else{
			h2 = h-100;
		} */
		$(".taskcontet").css({height:h2});    
	});
	
	function setSelectedProject(project){
		$.post("<%=basePath%>task!setProject.action?id="+$("#taskId").val()+"&projectId="+project.id,function(data){
			if(data.result.success){
				showTip("项目设置成功");
				setTimeout("location.reload();",2000);
			}
		});
		}
	
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
	
	function projectList(){
		fbStart('项目管理','<%=basePath%>taskProject!list.action',500,370);
	}
 
	function search(){
		var t;
		var id = $("#id").val();
		var title = $("#title").val();
		if(title=="请输入标题"){
			t = "无上良品";
		}else{
			t = title;
		}
		var curMonth = $("#cMonth").val();
		if(curMonth==""){
			curMonth==null;
		}
		var curYear = $("#cYear").val();
		if(curYear==""){
			curYear==null;
		}
		var src = "<%=basePath%>task!viewProject.action?id="+id+"&title="+t+"&curMonth="+curMonth+"&curYear="+curYear;
		parent.frames[0].location = src;
	}
	
	function viewTask(id){
		fbStart('查看工作','<%=basePath%>task!view.action?id='+id,650,400);
	}
	function jumpPage(page){
		var url = "<%=basePath%>task!viewProject.action";
		url += "?page="+page+'&id=${id}';
		url = encodeURI(url);
		location.href=url;
	}
	 </script>
	 </head>
	 <body>
	<div class="tasklisttitle">
			<div class="tasksearch">
			<form action="" method="post">
			<input type="hidden" value="${param.id}" id="id"/>
			<input type="hidden" value="${param.id}" class="projectId"/>
			<input type="hidden" id="taskId"/>
					<table width="285" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
							<input id="title" type="text" class="taskinput" value="请输入标题" onclick="if(this.defaultValue==this.value){this.value=''}" onblur="if(this.value==''){this.value=this.defaultValue}"/></td>
							<td><select id="cYear">
								 <option value=""></option> 
									<c:forEach items="${years}" var="year">
										<option <c:if test='${year==curYear}'>selected="selected"</c:if> value="${year}" >${year}年</option>
									</c:forEach>
								</select></td>
							<td><label>
								<select id="cMonth">
								 <option value=""></option> 
									<c:forEach items="${months}" var="month">
										<option <c:if test='${month==curMonth}'>selected="selected"</c:if> value="${month}" >${month}月</option>
									</c:forEach>
								</select>
							</label></td>
							<td><input name="" type="button" class="taskbtn" value="" onclick="search();"/></td>
							 <td width="25" align="center"><img onclick="projectList();" src="parkmanager.oa/web/images/taskset.png" width="19" height="19" /></td>
						</tr>
					</table>
			</form>
			</div>
			<img src="parkmanager.oa/web/images/project.png" />
			</div>
	 <c:if test="${taskWorkDtoList!=null}">
	 	 <div class="taskcontet" >
				<ul>
					<c:forEach items="${taskWorkDtoList}" var="dto">
					<li class="liTask${dto.task.receiverId}" onmouseover="$(this).addClass('trover')" onmouseout="$(this).removeClass('trover')" onclick="viewTask(${dto.task.id});">
						<input class="id" type="hidden" value="${dto.task.id}"/>
						<input class="departId" type="hidden" value="${dto.task.id}"/>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="15" align="center">
											<c:if test="${dto.task.priority ne null}">
													<c:if test="${dto.task.priority eq 'HIGH'}">
														<img src="core/common/images/gthred.png" width="4" height="10" />
													</c:if>
													<c:if test="${dto.task.priority eq 'MIDDLE'}">
														<img src="core/common/images/gthyellow.png" width="4" height="10" />
													</c:if>
													<c:if test="${dto.task.priority eq 'LOW'}">
														<img src="core/common/images/gthblue.png" width="4" height="10" />
													</c:if>
											</c:if>
										</td>
										<td>
											<c:if test="${fn:length(dto.task.atts)>0}"> 
												<td width="15" align="center"><img src="core/common/images/uploadfj.gif" width="7" height="12" /></td>
											</c:if> 
											<c:if test="${fn:length(dto.task.atts)<=0}"> 
												<td width="15" align="center"></td>
											</c:if> 
										</td>
										<td>${dto.task.title}
											<span class="taskgray">
													执行人:${dto.task.creator}
											</span>
											<c:if test="${dto.task.childStatus eq 'FINISHED'}">
												<img class="lifinsh" src="parkmanager.oa/web/images/finsh.png" width="15" height="15" />
											</c:if>
											<c:if test="${dto.task.childStatus eq 'ABORTED'}">
												<img class="lifinsh" src="parkmanager.oa/web/images/stop.png" width="15" height="15" />
											</c:if>
										</td>
										<c:if test="${dto.task.childStatus ne 'FINISHED'}">
											<c:if test="${dto.task.childStatus ne 'ABORTED'}">
												<c:if test="${dto.day==1}">
													<td width="80" class="taskfnormal">明天到期</td>
												</c:if>
												<c:if test="${dto.day>1}">
													<td width="80" class="taskfnormal">${dto.day}天后到期</td>
												</c:if>
												<c:if test="${dto.day==0}">
													<td width="80" class="taskfnormal">今天到期</td>
												</c:if>
												<c:if test="${dto.day<0}">
													<td width="80" class="taskfred">已逾期${-dto.day}天</td>
												</c:if>
											</c:if>
										</c:if>
									</tr>
								</table></td>
							</tr>
							<tr>
								<td><table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="15" align="center">&nbsp;</td>
										<td width="15" align="center">&nbsp;</td>
										<td width="120" class="taskgray">${dto.name}
											<input type="hidden" class="departId" value="${dto.depIds}"/>
											<input type="hidden" class="projectId" value="${dto.task.projectId}"/>
										</td>
										<td class="taskgraypr">开始时间：<fmt:formatDate value="${dto.task.startTime}" pattern="M"/>月<fmt:formatDate value="${dto.task.startTime}" pattern="dd"/>日  完成情况：<img src="core/common/images/bai${dto.task.progress}_min.png" /></td>
									</tr>
								</table></td>
							</tr>
						</table>
					</li>
					</c:forEach>
				</ul>
			</div>
			<c:if test="${id!=null}">
				<input type="hidden" id="pagerT" value="1"/>
				<div style=" width: 100%; padding-left: 200px; background:#f2f2f2; ">
					<%@include file="../pager.jsp" %>
				</div>
			</c:if>
	</c:if>
</body>
</html>
			