<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<div class="pm_view_left">
	<ul>
		<% 
			Integer index = Integer.parseInt(request.getParameter("index"));
		%>
		<li <%if(index==0){%>class="overbg" style="border-top:none;"<%} else {%>class="pm_color"<%} %>><span><img src="parkmanager.pb/web/images/tipsico.png" /></span><a href="<%=basePath%>customer!view.action?id=<%=request.getParameter("customerId") %>">基本信息</a></li>
		<li <%if(index==1){%>class="overbg" style="border-top:none;"<%} else {%>class="pm_color"<%} %>><span><img src="parkmanager.pb/web/images/tipsico.png" /></span><a href="<%=basePath%>/web/client/project_view.jsp?id=<%=request.getParameter("customerId") %>">项目信息</a></li>
		<li <%if(index==2){%>class="overbg" style="border-top:none;"<%} else {%>class="pm_color"<%} %>><span><img src="parkmanager.pb/web/images/tipsico.png" /></span><a href="<%=basePath%>/web/client/staffer_view_by_customerId.jsp?id=<%=request.getParameter("customerId") %>">主要人员</a></li>
		<li <%if(index==3){%>class="overbg" style="border-top:none;"<%} else {%>class="pm_color"<%} %>><span><img src="parkmanager.pb/web/images/tipsico.png" /></span><a href="<%=basePath%>/web/client/knowledge_view.jsp?id=<%=request.getParameter("customerId") %>">知识产权</a></li>
	</ul>
</div>