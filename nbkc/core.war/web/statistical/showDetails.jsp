<%@page import="com.wiiy.hibernate.Pager"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
Pager pager = (Pager)request.getAttribute("pager");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#content").css("height",getTabContentHeight()-30);
		//$("#container").height(369);
		if(<%=pager.getTotal()%> <=1)
			$(".page span").css("display","none");
	});
	
	function jumpPage(page){
		var url = "<%=basePath%>statistical!showDetails.action";
		url += "?page="+page+"&days=${days}";
		url +="&userId=${userId}";
		url = encodeURI(url);
		location.href=url;
	}
</script>
<style type="text/css">
	.noright{
		border-right:none;
	}
	#container{
		margin:5px;
		border:1px solid #c3c3c3;
		overflow:hidden;
		background-color:#fff;
		position:relative;
		padding-bottom:29px;
	}
	body{
		overflow:hidden;
	}
	.page{
		display:inline-block;
		text-align:center;
		border:0px;
	}
	.bottom{
		width:100%;
		text-align:center;
		background-color:#f2f2f2;
		position:absolute;
		bottom:0px;
	}
</style>
</head>

<body>
<div id="container">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="">
		<tr>
			<td width="50" class="tdcenter">序号</td>
			<td class="tdcenter">部门</td>
			<td class="tdcenter">登录IP</td>
			<td class="tdcenter">登录时间</td>
			<td class="tdcenter noright">内容</td>
		</tr>
		<%int i=(pager.getPage()-1)*pager.getRows(); %>
		<c:forEach items="${result.value}" var="dto">
			<tr onmouseout="this.style.background='#fff'" 
				onmouseover="this.style.background='#f4f4f4'"
				style="background:#fff;">
				<td class="crmcounttd"><%= ++i %></td>
				<td class="crmcounttd">${dto.depart}</td>
				<td class="crmcounttd">${dto.ip}</td>
				<td class="crmcounttd">${dto.time}</td>
				<td class="crmcounttd noright">${dto.content}</td>
			</tr>
		</c:forEach>
	</table>
	<div class="bottom">
		<%@include file="../pager.jsp" %>
	</div>
</div>
</body>
</html>
