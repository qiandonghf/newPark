<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String index = request.getParameter("index");
%>
<div class="datalist">
	<ul>
		<li><a <%if(index.equals("0")) out.print("class=\"libg\"");%> href="<%=basePath%>statistic!billCostByDay.action">日结算报表</a></li>
		<li><a <%if(index.equals("1")) out.print("class=\"libg\"");%> href="<%=basePath%>statistic!billCostByMonth.action">月结算报表</a></li>
		<li><a <%if(index.equals("2")) out.print("class=\"libg\"");%> href="<%=basePath%>statistic!billCostByYear.action">年结算报表</a></li>
		<li><a <%if(index.equals("3")) out.print("class=\"libg\"");%> href="<%=basePath%>statistic!billCostByCustomer.action">分户明细表</a></li>
		<li><a <%if(index.equals("4")) out.print("class=\"libg\"");%> href="<%=basePath%>statistic!billCostByProperty.action">物业应收实收统计表</a></li>
		<%-- <li><a <%if(index.equals("5")) out.print("class=\"libg\"");%> href="<%=basePath%>statistic!customerContract.action">企业收费情况表</a></li> --%>
	</ul>
</div>