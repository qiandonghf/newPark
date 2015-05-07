<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.oa.entity.Task"%>
<%@page import="com.wiiy.oa.activator.OaActivator"%>
<%@page import="com.wiiy.oa.dto.TaskDto"%>
<%@page import="org.apache.taglibs.standard.tag.common.core.ForEachSupport"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
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
<script type="text/javascript" src="core/common/FusionChartsFree/JSClass/FusionCharts.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
	  var imageMenuData = [[{
			text: "查看",
			classname: "smarty_menu_view",
			func: function() {
				fbStart('查看工作','<%=basePath%>task!view.action?id='+$(this).find(".id").val(),750,486);
			}
		}]];
	
			$(".liTask").smartMenu(imageMenuData,{name:'imageMenuData'});
			var h=window.document.documentElement.clientHeight;
				$(".taskcontent").css({height:h});
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
		$(".tasklist").height()+66;
		});
	
	function setReload(){
  		location.reload();
  	}
  
 
  </script>
</head>
<body>
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="351" height="100%" valign="top"><div class="tasksidebar">
			<div class="task_qiucknav">
				<ul>
					<li class="tasklink"><a href="<%=basePath %>web/task2/task_send.jsp">签收与派出的工作</a></li>
					<li class="taskactive"><span class="taskactive_arrow"></span><a href="<%=basePath %>task!finish.action">已完成的工作</a></li>
				</ul>
			</div>
			<!--taskimg-->
			<div  class="taskimg" id="chartdiv"> FusionCharts. </div>
			<script type="text/javascript">
				var chart = new FusionCharts('<%=BaseAction.rootLocation%>/core/common/FusionChartsFree/Charts/FCF_Column2D.swf', "ChartId", "330", "200");
				chart.setDataURL(escape("<%=basePath%>task!taskXML.action"));	
				chart.render("chartdiv");
			</script>
			<!--taskimg-->
			<!--tasktable-->
			<div class="tasktable"  style="overflow-y:scroll; overflow-x:hidden;height:130px">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="tasktableth">周数</td>
					<td width="50" class="tasktableth">完成</td>
					<td width="50" class="tasktableth">中止</td>
				</tr>
				<c:forEach items="${finishWorkDtoList}" var="dto">
					<tr>
						<td class="tasktabletd">
							第${dto.week}周 
						<a href="<%=basePath%>task!viewFinishWork.action?week=${dto.week}" target="finishWork" class="crmcounttdlink" style="text-decoration:none;color:#666;">
							<c:forEach items="${dto.dateList}"  var="startDate" begin="0" end="0">
			            		<fmt:formatDate value="${startDate}"  pattern="M" var="startDateString"/>
			            		<c:if test="${startDateString<10}">
			            			0${startDateString}月
			            		</c:if>
			            		<c:if test="${startDateString>9}">
			            			${startDateString}月
			            		</c:if>
			            	</c:forEach>
			            	<c:forEach items="${dto.dateList}"  var="startDate" begin="0" end="0">
			            		<fmt:formatDate value="${startDate}"  pattern="dd" var="startDateString"/>${startDateString}日
			            	</c:forEach>
							-
							<c:forEach items="${dto.dateList}" var="endDate" begin="6" end="6">
			            		<fmt:formatDate value="${endDate}"  pattern="M" var="endDateString"/>
			            		<c:if test="${endDateString<10}">
			            			0${endDateString}月
			            		</c:if>
			            		<c:if test="${endDateString>9}">
			            			${endDateString}月
			            		</c:if>
			            	</c:forEach><c:forEach items="${dto.dateList}" var="endDate" begin="6" end="6">
			            		<fmt:formatDate value="${endDate}"  pattern="dd" var="endDateString"/>${endDateString}日
			            	</c:forEach>
			            </a>
						</td>
						<td class="tasktabletd">${dto.finishNum}</td>
						<td class="tasktabletdred">${dto.abortedNum}</td>
					</tr>
				</c:forEach>
			</table>

			</div>
			<!--//tasktable-->
		</div></td>
		<td valign="top"><div class="tasklist">
				 <iframe scrolling="auto" src="<%=basePath %>task!viewFinishWork.action?week=${week}" id="finishWork" name="finishWork" frameborder="0" width="100%" height="465px;"></iframe>
		</div></td>
	</tr>
</table>	
</body>


</html>
