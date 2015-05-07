<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.oa.entity.Task"%>
<%@page import="com.wiiy.oa.activator.OaActivator"%>
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

	 var sendMenu = [[{
			text: "编辑",
			classname: "smarty_menu_ico0",
			func: function() {
				fbStart('编辑工作','<%=basePath%>task!edit.action?id='+$(this).find(".id").val(),650,500);
			}
		},{
			text: "查看",
			classname: "smarty_menu_view",
			func: function() {
				fbStart('查看工作','<%=basePath%>task!view.action?id='+$(this).find(".id").val(),650,400);
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
			text: "中止工作",
			classname: "smarty_menu_stop",
			func: function() {
			 	if(confirm("您确认中止吗?")){
					$.post("<%=basePath%>task!aborted.action?id="+$(this).find(".id").val(),function(){
						location.reload();
					});
				}
			}
		},{
			text: "工作延期",
			classname: "smarty_menu_time",
			func: function() {
				fbStart('工作延期','<%=basePath%>web/task/task_edit_endTime.jsp?id='+$(this).find(".id").val(),420,178);
			}
		},{
			text: "设置完成",
			classname: "smarty_menu_finish",
			func: function() {
				if(confirm("您确认要设置完成吗?")){
					 $.post("<%=basePath%>task!finished.action?id="+$(this).find(".id").val(),function(){
						location.reload();
					});
			 	}
			 }
		}]];
	 
	 $(document).ready(function() {
		 initTip();
		$(".sendTask").smartMenu(sendMenu,{name:'sendMenu'});
		var h=window.document.documentElement.clientHeight;
		if(h<200){
			h = h+85;
		}
		$(".tasksidebar").css({height:h});
			$(".sendWorklist li").each(function(i){
			$(".sendWorklist li .arrow").eq(i).click(function(){
				if($(".sendchild").eq(i).css("display")=="block"){
					$(".sendchild").eq(i).css({display:"none"});
					$(".sendWorklist li .arrow img").eq(i).attr("src","parkmanager.oa/web/images/taskup.gif");
				}else{
					$(".sendWorklist li .arrow img").attr("src","parkmanager.oa/web/images/taskup.gif");
					$(".sendWorklist li .arrow img").eq(i).attr("src","parkmanager.oa/web/images/taskdown.gif");
					$(".sendchild").css({display:"none"});
					$(".sendchild").eq(i).css({display:"block"});
				}
			});
		}); 
		var sendH=h-$(".todowork").height();
		$(".sendWorklist").css({height:sendH});
		
		var sendH=h-$("#todoWorkIframe").height()-40;
		if(sendH<100){
			sendH = sendH+89;
		}
		$(".sendWorklist").css({height:sendH});
	});
	
	function setSelectedDeparts(departs){
		var ids = "";
		for(var i = 0; i < departs.length; i++){
			ids += departs[i].id+",";
		}
		ids = deleteLastCharWhenMatching(ids,",");
		$.post("<%=basePath%>task!setDepart.action?id="+$("#taskId").val()+"&ids="+ids,function(data){
			if(data.result.success){
				showTip("部门设置成功",2000);
				setTimeout("location.reload();",2000);
			}
		});
	}
	
	function setSelectedUsers(users){
	var ids = "";
	for(var i = 0; i < users.length; i++){
		ids += users[i].id+",";
	}
	ids = deleteLastCharWhenMatching(ids,",");
	$.post("<%=basePath%>task!taskSend.action?id="+$("#taskId").val()+"&ids="+ids,function(data){
		if(data.result.success){
			showTip("工作派送成功",2000);
			setTimeout("location.reload();",2000);
		}
	});
	}
	
	function setSelectedUser(user){
		var ids = user.id;
		$.post("<%=basePath%>task!taskMove.action?id="+$("#taskId").val()+"&ids="+ids,function(data){
			if(data.result.success){
				showTip("工作移交成功",2000);
				setTimeout("location.reload();",2000);
			}
		});
		}
	
	function setSelectedProject(project){
	$.post("<%=basePath%>task!setProject.action?id="+$("#taskId").val()+"&projectId="+project.id,function(data){
		if(data.result.success){
			showTip("项目设置成功",2000);
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
		<div class="sendWork">
			<div class="task_title">
				<div class="page_min floatRt">
                    	<span>
                    	<c:if test="${pager.page==pager.total}" var="total">
                    		${pager.total}
                    	</c:if>
                    	<c:if test="${!total}">
							${pager.page}
						</c:if>
                    	/
                    	${pager.total}
                    	</span>
                    	<c:if test="${pager.page>1}" var="firstPage">
	                    	<a href="javascript:void(0)" title="上一页" class="pre" onclick="jumpPage(${pager.page-1})"></a>
                    	</c:if>
                    	<c:if test="${!firstPage}">
	                    	<a href="javascript:void(0)" title="上一页" class="pre"></a>
                    	</c:if>
                    	<c:if test="${pager.page<pager.total}" var="lastPage">
	                        <a href="javascript:void(0)" title="下一页" class="next" onclick="jumpPage(${pager.page+1})"></a>
                    	</c:if>
                    	<c:if test="${!lastPage}">
                        <a href="javascript:void(0)" title="下一页" class="next"></a>
                    	</c:if>
                </div>
				<img src="parkmanager.oa/web/images/sendWork.png" />
			</div>
			<!--sendWork-->
				<div class="sendWorklist scroll">
					<ul>
						<c:forEach items="${taskDtoList}" var="dto">
							<li class="sendTask"><span class="arrow"><a href="javascript:void(0)"><img src="parkmanager.oa/web/images/taskup.gif" /></a></span><a href="javascript:void(0)" onclick="viewTask(${dto.task.id});">
								<c:if test="${fn:length(dto.task.title)>=5}">·${fn:substring(dto.task.title,0,5) }...</c:if>
								<c:if test="${fn:length(dto.task.title)<5}">·${dto.task.title}</c:if>
							<input type="hidden" class="id" value="${dto.task.id}"/>
								<em><fmt:formatDate value="${dto.task.createTime}" pattern="M"/>月<fmt:formatDate value="${dto.task.createTime}" pattern="dd"/>日创建</em>
									<c:if test="${dto.task.childStatus eq 'FINISHED'}">
										<img class="lifinsh" src="parkmanager.oa/web/images/finsh.png" width="15" height="15" />
									</c:if>
									<c:if test="${dto.task.childStatus eq 'ABORTED'}">
										<img class="lifinsh" src="parkmanager.oa/web/images/stop.png" width="15" height="15" />
									</c:if>
								</a>
								<div class="sendchild" style="display:none">
								<dl>
									<c:forEach items="${dto.childTaskList}" var="task">
										<c:if test="${task.childStatus eq 'PENDING'}">
											<dd onmouseover="$(this).addClass('trover')" onmouseout="$(this).removeClass('trover')" onclick="viewTask(${task.id});"><img class="userico" src="parkmanager.oa/web/images/user.gif" />${task.creator}<em style="color:#ff5656">未签收</em></dd> 
										</c:if>
										<c:if test="${task.childStatus ne 'PENDING'}">
											<dd onmouseover="$(this).addClass('trover')" onmouseout="$(this).removeClass('trover')" onclick="viewTask(${task.id});"><span class="finsh">完成情况：<img src="core/common/images/bai<c:if test='${task.progress ne null}'>${task.progress}</c:if><c:if test='${task.progress eq null}'>0</c:if>.png" /></span><img class="userico" src="parkmanager.oa/web/images/user.gif" />${task.creator}
												<c:if test="${task.childStatus eq 'SIGNED'}">
													已签收
												</c:if>
												<c:if test="${task.childStatus eq 'ABORTED'}">
													已中止
												</c:if>
												<c:if test="${task.childStatus eq 'FINISHED'}">
													已完成
												</c:if>
											</dd>
										</c:if>
									</c:forEach>
								</dl>
							</div>
							</li>
						</c:forEach>
					</ul>
					</div>
			<!--//sendWork-->
			</div>
</body>


</html>
