<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String index = request.getParameter("index");
%>
<div class="datalist">
	<ul>
		<li><a <%if(index.equals("0")) out.print("class=\"libg\"");%> href="parkmanager.pb/statistic!customerParkStatus.action">企业入驻情况表</a></li>
		<li><a <%if(index.equals("1")) out.print("class=\"libg\"");%> href="parkmanager.pb/statistic!customerIncubationStatus.action">企业孵化状态表</a></li>
		<li><a <%if(index.equals("2")) out.print("class=\"libg\"");%> href="parkmanager.pb/statistic!customerTechnic.action">企业技术领域统计表</a></li>
		<li><a <%if(index.equals("3")) out.print("class=\"libg\"");%> href="parkmanager.pb/statistic!customerLabel.action">企业分类统计表</a></li>
<%-- 		<li><a <%if(index.equals("4")) out.print("class=\"libg\"");%> href="parkmanager.pb/statistic!customerIncubationStatus.action">企业经济概况表</a></li>
		<li><a <%if(index.equals("5")) out.print("class=\"libg\"");%> href="parkmanager.pb/statistic!customerIncubationStatus.action">企业获天使投资情况表</a></li>
		<li><a <%if(index.equals("6")) out.print("class=\"libg\"");%> href=parkmanager.pb/statistic!customerIncubationStatus.action>企业融资项目情况表</a></li> --%>
		<li><a <%if(index.equals("7")) out.print("class=\"libg\"");%> href="parkmanager.pb/statistic!registeredCapital.action">企业注册资本情况表</a></li>
		<li><a <%if(index.equals("8")) out.print("class=\"libg\"");%> href="parkmanager.pb/statistic!customerStaffer.action">企业从业人员情况表</a></li>
		<li><a <%if(index.equals("9")) out.print("class=\"libg\"");%> href="parkmanager.pb/statistic!propertyRight.action">企业知识产权情况表</a></li>
		<li><a <%if(index.equals("10")) out.print("class=\"libg\"");%> href="parkmanager.pb/statistic!productTechnic.action">企业产品情况表</a></li>
		<%-- <li><a <%if(index.equals("11")) out.print("class=\"libg\"");%> href="parkmanager.pb/statistic!customerIncubationStatus.action">企业项目申报情况表</a></li> --%>
	</ul>
</div>