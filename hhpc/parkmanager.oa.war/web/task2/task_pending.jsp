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

	var pendingMenu = [[{
		text: "查看",
		classname: "smarty_menu_view",
		func: function() {
			fbStart('查看工作','<%=basePath%>task!view.action?id='+$(this).find(".id").val(),650,400);
		}
	}]];
	
	 $(document).ready(function() {
		 initTip();
		$(".pendingTask").smartMenu(pendingMenu,{name:'pendingMenu'});
		var h=window.parent.document.documentElement.clientHeight;
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
		$(".todowork").css({height:30});
		var sendH=h-$(".todowork").height()-90;
		$(".sendWorklist").css({height:sendH});
		$("#sendWorIframe").css({height:sendH});
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
	
	function singed(id){
	$.post("<%=basePath%>task!signed.action?id="+id,function(data){
		if(data.result.success){
			showTip("任务签收成功",2000);
			setTimeout("location.reload();window.parent.frames[2].location.reload();",2000);
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
		var url = "<%=basePath%>task!myPendingList.action";
		url += "?page="+page;
		url = encodeURI(url);
		location.href=url;
	}
  </script>
</head>
<body>
			<div class="todowork">
				<div class="task_title"><img src="parkmanager.oa/web/images/todoWork.png" /></div>
				<ul>
					<c:forEach items="${pengdingDtoList}" var="dto">
						<li class="pendingTask"><span><a href="javascript:singed(${dto.task.id});">签收
							<input type="hidden" class="projectId" value="${dto.task.projectId}"/>
							<input type="hidden" class="id" value="${dto.task.id}"/>
							<input type="hidden" class="receiverId" value="${dto.task.receiverId}"/>
							</a></span><a href="javascript:void(0)" onclick="viewTask(${dto.task.id});">
								<c:if test="${fn:length(dto.task.title)>=5}">·${fn:substring(dto.task.title,0,5) }...</c:if>
								<c:if test="${fn:length(dto.task.title)<5}">·${dto.task.title}</c:if>
							</a>
							<em>
								<c:if test="${dto.task.parentId!=null}">
								<fmt:formatDate value="${dto.task.createTime}" pattern="M"/>月<fmt:formatDate value="${dto.task.createTime}" pattern="dd"/>日
								 ${dto.name}派出
								<input type="hidden" id="1d" name="task.id" value="${dto.task.id}"/>
								</c:if>
								<c:if test="${dto.priorityName!=null}">
									由${dto.priorityName}转交
								</c:if>
							</em>
						</li>
					</c:forEach>
				</ul> 
			</div>
			<table style="height:65px;">
			<tr></tr>
			</table>
</body>


</html>
