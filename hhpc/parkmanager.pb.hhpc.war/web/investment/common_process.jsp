<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
int index = Integer.parseInt(request.getParameter("index"));
String id = request.getParameter("investmentProcessId");
String type=request.getParameter("TYPE");
%>
	<div class="apptab" id="tableid">
		<ul>
			<li class="apptabli<%if(index==0){%>over<%} %>"><a href="<%=basePath %>investmentProcess!view.action?id=<%=id %>&processViewTYPE=<%=type %>">基本信息</a></li>
			<li class="apptabli<%if(index==1){%>over<%} %>" ><a href="<%=basePath %>investmentProcess!approvalView.action?id=<%=id %>&processViewTYPE=<%=type %>">流程单轨迹</a></li>
	</ul>
	</div>