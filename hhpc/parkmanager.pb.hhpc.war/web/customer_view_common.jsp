<%@page import="com.wiiy.commons.preferences.enums.UserTypeEnum"%>
<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<div class="pm_view_left">
	<ul>
		<%-- <% 
			Integer index = Integer.parseInt(request.getParameter("index"));
		%>
		<li <%if(index==0){%>class="overbg" style="border-top:none;"<%} else {%>class="pm_color"<%} %>><span><img src="parkmanager.pb/web/images/tipsico.png" /></span><a href="<%=basePath%>customer!view.action?id=<%=request.getParameter("customerId") %>">基本信息</a></li>
		<li <%if(index==1){%>class="overbg" style="border-top:none;"<%} else {%>class="pm_color"<%} %>><span><img src="parkmanager.pb/web/images/tipsico.png" /></span><a href="<%=basePath%>web/client/contect_list_byCustomerId.jsp?id=<%=request.getParameter("customerId") %>">联系人</a></li>
		<li <%if(index==2){%>class="overbg" style="border-top:none;"<%} else {%>class="pm_color"<%} %>><span><img src="parkmanager.pb/web/images/tipsico.png" /></span><a href="<%=basePath%>web/client/contectInfo_list_by_customerId.jsp?id=<%=request.getParameter("customerId") %>">走访记录</a></li>
		<li <%if(index==3){%>class="overbg" style="border-top:none;"<%} else {%>class="pm_color"<%} %>><span><img src="parkmanager.pb/web/images/tipsico.png" /></span><a href="<%=basePath%>web/client/project_view.jsp?id=<%=request.getParameter("customerId") %>">项目信息</a></li>
		<li <%if(index==4){%>class="overbg" style="border-top:none;"<%} else {%>class="pm_color"<%} %>><span><img src="parkmanager.pb/web/images/tipsico.png" /></span><a href="<%=basePath%>web/client/staffer_view_by_customerId.jsp?id=<%=request.getParameter("customerId") %>">主要人员</a></li>
		<li <%if(index==5){%>class="overbg" style="border-top:none;"<%} else {%>class="pm_color"<%} %>><span><img src="parkmanager.pb/web/images/tipsico.png" /></span><a href="<%=basePath%>web/client/knowledge_view.jsp?id=<%=request.getParameter("customerId") %>">知识产权</a></li>
		<%if(PbActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.Center)){ %>
		<li <%if(index==6){%>class="overbg" style="border-top:none;"<%} else {%>class="pm_color"<%} %>><span><img src="parkmanager.pb/web/images/tipsico.png" /></span><a href="<%=basePath%>contract!listByCustomerId.action?id=<%=request.getParameter("customerId") %>">合同信息</a></li>
		<li <%if(index==7){%>class="overbg" style="border-top:none;"<%} else {%>class="pm_color"<%} %>><span><img src="parkmanager.pb/web/images/tipsico.png" /></span><a href="<%=basePath%>bill!listByCustomerId.action?id=<%=request.getParameter("customerId") %>">账单信息</a></li>
		<%} %>
		<li <%if(index==8){%>class="overbg" style="border-top:none;"<%} else {%>class="pm_color"<%} %>><span><img src="parkmanager.pb/web/images/tipsico.png" /></span><a href="<%=basePath%>analyse!customerView.action?id=<%=request.getParameter("customerId") %>">数据填报</a></li>
		 --%>
		
		<% 
			Integer index = Integer.parseInt(request.getParameter("index"));
			boolean desktop = Boolean.parseBoolean(request.getParameter("desktop"));
		%>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerMessage_basicView")){ %>
		<li <%if(index==0){%>class="overbg" style="border-top:none;"<%} else {%>class="pm_color"<%} %>><span><img src="parkmanager.pb/web/images/tipsico.png" /></span><a href="<%=basePath%>customer!view.action?id=<%=request.getParameter("customerId") %>">基本信息</a></li>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_linkman")){ %>
		<li <%if(index==1){%>class="overbg" style="border-top:none;"<%} else {%>class="pm_color"<%} %>><span><img src="parkmanager.pb/web/images/tipsico.png" /></span><a href="<%=basePath%>web/client/contect_list_byCustomerId.jsp?id=<%=request.getParameter("customerId") %>&applyId=<%=request.getParameter("gardenApplyId") %>">联系人</a></li>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contectInfo")){ %>
		<li <%if(index==2){%>class="overbg" style="border-top:none;"<%} else {%>class="pm_color"<%} %>><span><img src="parkmanager.pb/web/images/tipsico.png" /></span><a href="<%=basePath%>web/client/contectInfo_list_by_customerId.jsp?id=<%=request.getParameter("customerId") %>&applyId=<%=request.getParameter("gardenApplyId") %>">走访记录</a></li>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customer_investmentView")){ %>
		<li <%if(index==3){%>class="overbg" style="border-top:none;"<%} else {%>class="pm_color"<%} %>><span><img src="parkmanager.pb/web/images/tipsico.png" /></span><a href="<%=basePath%>web/client/project_view.jsp?id=<%=request.getParameter("customerId") %>&applyId=<%=request.getParameter("gardenApplyId") %>">项目信息</a></li>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_staffer")){ %>
		<li <%if(index==4){%>class="overbg" style="border-top:none;"<%} else {%>class="pm_color"<%} %>><span><img src="parkmanager.pb/web/images/tipsico.png" /></span><a href="<%=basePath%>web/client/staffer_view_by_customerId.jsp?id=<%=request.getParameter("customerId") %>&applyId=<%=request.getParameter("gardenApplyId") %>">主要人员</a></li>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_knowledge")){ %>
		<li <%if(index==5){%>class="overbg" style="border-top:none;"<%} else {%>class="pm_color"<%} %>><span><img src="parkmanager.pb/web/images/tipsico.png" /></span><a href="<%=basePath%>web/client/knowledge_view.jsp?id=<%=request.getParameter("customerId") %>&applyId=<%=request.getParameter("gardenApplyId") %>">知识产权</a></li>
		<%} %>
		<%if(PbActivator.getSessionUser(request).getUserType().equals(UserTypeEnum.Center)){ %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_contractMessage")){ %>
		<li <%if(index==6){%>class="overbg" style="border-top:none;"<%} else {%>class="pm_color"<%} %>><span><img src="parkmanager.pb/web/images/tipsico.png" /></span><a href="<%=basePath%>contract!listByCustomerId.action?id=<%=request.getParameter("customerId") %>&applyId=<%=request.getParameter("gardenApplyId") %>">合同信息</a></li>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_bill_listByCustomer") && desktop == false){ %>
		<li <%if(index==7){%>class="overbg" style="border-top:none;"<%} else {%>class="pm_color"<%} %>><span><img src="parkmanager.pb/web/images/tipsico.png" /></span><a href="<%=basePath%>bill!listByCustomerId.action?id=<%=request.getParameter("customerId") %>&applyId=<%=request.getParameter("gardenApplyId") %>">账单信息</a></li>
		<%} %>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_dataFill") && desktop == false){ %>
		<li <%if(index==8){%>class="overbg" style="border-top:none;"<%} else {%>class="pm_color"<%} %>><span><img src="parkmanager.pb/web/images/tipsico.png" /></span><a href="<%=basePath%>analyse!customerView.action?id=<%=request.getParameter("customerId") %>&applyId=<%=request.getParameter("gardenApplyId") %>">数据填报</a></li>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customer_garden_view")){
			String applyId = request.getParameter("gardenApplyId");
			if(applyId!=null && !"".equals(applyId)){
		%>
		<li <%if(index==9){%>class="overbg" style="border-top:none;"<%} else {%>class="pm_color"<%} %>><span><img src="parkmanager.pb/web/images/tipsico.png" /></span><a href="<%=basePath%>garden!view.action?id=<%=applyId %>&customerId=<%=request.getParameter("customerId") %>">苗圃信息</a></li>
		<%}} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_changeMessage_view")){ %>
		<li <%if(index==10){%>class="overbg" style="border-top:none;"<%} else {%>class="pm_color"<%} %>><span><img src="parkmanager.pb/web/images/tipsico.png" /></span><a href="<%=basePath%>customerModifyLog!loadByCustomerId.action?id=<%=request.getParameter("customerId") %>">变更信息</a></li>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_policyMessage_view")){ %>
		<li <%if(index==11){%>class="overbg" style="border-top:none;"<%} else {%>class="pm_color"<%} %>><span><img src="parkmanager.pb/web/images/tipsico.png" /></span><a href="<%=basePath%>customerPolicy!loadByCustomerId.action?id=<%=request.getParameter("customerId") %>">政策支持</a></li>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_customerRiskCapital_view")){ %>
		<li <%if(index==12){%>class="overbg" style="border-top:none;"<%} else {%>class="pm_color"<%} %>><span><img src="parkmanager.pb/web/images/tipsico.png" /></span><a href="<%=basePath%>customerRiskCapital!loadByCustomerId.action?id=<%=request.getParameter("customerId") %>">风险投资</a></li>
		<%} %>
		<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_reward_view")){ %>
		<li <%if(index==13){%>class="overbg" style="border-top:none;"<%} else {%>class="pm_color"<%} %>><span><img src="parkmanager.pb/web/images/tipsico.png" /></span><a href="<%=basePath%>reward!loadByCustomerId.action?id=<%=request.getParameter("customerId") %>">奖励管理</a></li>
		<%} %>
	</ul>
</div>