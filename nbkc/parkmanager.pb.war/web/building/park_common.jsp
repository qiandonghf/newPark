<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<div class="apptab" id="tableid">
	<ul>
		<%
			String path = request.getContextPath();
			String basePath = BaseAction.rootLocation+path+"/";
			String pageName = request.getParameter("pageName");
		%>
		<li class="apptabli<%if(pageName.equals("info")){%>over<%}%>"><a href="<%=basePath%>building!view.action?id=<%=request.getParameter("buildingId") %>">基本信息</a></li>
		<li class="apptabli<%if(pageName.equals("floor")){%>over<%}%>" ><a href="<%=basePath%>floor!floorView.action?id=<%=request.getParameter("buildingId") %>">楼层视图</a></li>
		<li class="apptabli<%if(pageName.equals("room")){%>over<%}%>" ><a href="<%=basePath%>room!listByBuildingId.action?id=<%=request.getParameter("buildingId") %>">房间信息</a></li>
	</ul>
</div>