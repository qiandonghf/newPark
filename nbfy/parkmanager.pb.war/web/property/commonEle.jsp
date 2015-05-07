<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
int index = Integer.parseInt(request.getParameter("index"));
String id = request.getParameter("labelId");
String labelType = request.getParameter("labelType");
String checkOut = request.getParameter("checkOut");
%>
	<div class="apptab" id="tableid">
		<ul>
			<a href="<%=basePath %>meterLabel!view.action?id=<%=id %>&checkOut=<%=checkOut %>"><li class="apptabli<%if(index==0){%>over<%} %>">基本信息</li></a>
			<a href="<%=basePath %>meterLabelRecord!waterEleView.action?labelId=<%=id %>&labelType=<%=labelType %>"><li class="apptabli<%if(index==1){%>over<%} %>" >抄表记录</li></a>
			<%if(checkOut.equals("GENERATED") || checkOut.equals("CKECKOUT")){%>
			<a href="<%=basePath %>meterLabelRecord!generateReport.action?labelId=<%=id %>&lableType=<%=labelType %>"><li class="apptabli<%if(index==2){%>over<%} %>" >收费报表</li></a>
			<%}  %>
		</ul>
	</div>