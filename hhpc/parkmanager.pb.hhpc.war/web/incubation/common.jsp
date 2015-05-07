<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
int index = Integer.parseInt(request.getParameter("index"));
String id = request.getParameter("investmentId");
%>
	<div class="apptab" id="tableid">
		<ul>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_project_viewBasic")||
				PbActivator.getHttpSessionService().isInResourceMap("pb_service_serviceWindow_incubation_viewBasic")){ %>
			<li class="apptabli<%if(index==0){%>over<%} %>"><a href="<%=basePath %>investment!view.action?id=<%=id %>">申请信息</a></li>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_businessPlan_legalView")||
				PbActivator.getHttpSessionService().isInResourceMap("pb_service_serviceWindow_legalView")){ %>
			<li class="apptabli<%if(index==1){%>over<%} %>" ><a href="<%=basePath %>investment!legalView.action?id=<%=id %>">法人信息</a></li>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_businessPlan_attrView")||
				PbActivator.getHttpSessionService().isInResourceMap("pb_service_serviceWindow_attrView")){ %>
			<li class="apptabli<%if(index==2){%>over<%} %>" ><a href="<%=basePath %>investment!attrView.action?id=<%=id %>">附件</a></li>
		<%} %>
		</ul>
	</div>