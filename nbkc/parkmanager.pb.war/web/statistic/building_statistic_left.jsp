<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String index = request.getParameter("index");
%>
<div class="datalist">
	<ul>
		<li><a <%if(index.equals("0")) out.print("class=\"libg\"");%> href="<%=basePath%>building!buildingCensus.action">楼宇总览</a></li>
		<li><a <%if(index.equals("1")) out.print("class=\"libg\"");%> href="<%=basePath%>building!buildingRent.action">出租率统计</a></li>
		<li><a <%if(index.equals("2")) out.print("class=\"libg\"");%> href="<%=basePath%>room!rentDetail.action">出租明细表</a></li>
		<li><a <%if(index.equals("3")) out.print("class=\"libg\"");%> href="<%=basePath%>room!parkmanageList.action">孵化用房管理表</a></li>
	</ul>
</div>