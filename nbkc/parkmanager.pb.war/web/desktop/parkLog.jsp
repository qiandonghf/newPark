<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="parkmanager.pb/web/style/pm_rbase.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/oawork.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/content.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/portal/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/portal/themes/icon.css"/>
<link rel="stylesheet" type="text/css" href="core/common/portal/portal.css"/>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<link href="parkmanager.oa/web/style/oawork.css" rel="stylesheet" type="text/css" />
 
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/js/righth.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" >
	function viewById(id){
		window.open("<%=basePath%>dataReportToCustomer!viewLog.action?id="+id);
	}
	function editDataReportById(id){
		fbStart('填报数据','<%=basePath %>dataReportToCustomer!editLog.action?id='+id,620,440,false);
	}
	function editInvestmentLogById(id){
		fbStart('招商轨迹','<%=basePath %>investmentLog!editLog.action?id='+id,500,295);
	}
	function editCustomerLogById(id){
		fbStart('客户信息更新变化','<%=basePath %>customerModifyLog!editLog.action?id='+id,500,150);
	}
</script>
</head>

<body>
<div class="gWel-info-more">
	<div class="gWel-info-more-nav">
		<div class="gWel-info-more-nav-a gWel-info-more-nav-a-on" style="width:150px;">
			<div class="gWel-info-more-nav-aText" style="width:150px;">园区日志（30天内）</div>
		</div>
	</div>
	<div class="gWel-info-more-line"></div>
	<div class="gWel-info-more-cnt">
		<ul class="list_sy_1_min">
			<c:forEach var="parkLog" items="${result.value}">
				<li>
					<c:if test="${parkLog.logType=='数据填报' }"><%-- <a href="<%=BaseAction.rootLocation %>/parkmanager.pb/dataReport!list.action" title="" class="unimp"> --%>【${parkLog.logType }】<!-- </a> --><a onclick="viewById(${parkLog.id})" href="javascript:void(0)" title=""> <c:if test="${fn:length(parkLog.logData)>12}">${fn:substring(parkLog.logData,0,12)}...</c:if><c:if test="${fn:length(parkLog.logData)<=12}">${parkLog.logData}</c:if></a>&nbsp;<span class="cor_999">${parkLog.logCustormer}</span>&nbsp;<span class="cor_999"><fmt:formatDate value="${parkLog.logTime }" pattern="yyyy-MM-dd"/>  </span></c:if>
					<c:if test="${parkLog.logType=='招商跟进' }"><%-- <a href="<%=BaseAction.rootLocation %>/parkmanager.pb/web/investment/investmentLog_list2.jsp" title="" class="unimp"> --%>【${parkLog.logType }】<!-- </a> --><a onclick="editInvestmentLogById(${parkLog.id})" href="javascript:void(0)" title=""><c:if test="${fn:length(parkLog.logData)>12}">${fn:substring(parkLog.logData,0,12)}...</c:if><c:if test="${fn:length(parkLog.logData)<=12}">${parkLog.logData}</c:if></a>&nbsp;<span class="cor_999"><fmt:formatDate value="${parkLog.logTime }" pattern="yyyy-MM-dd"/>  </span></c:if>
					<c:if test="${parkLog.logType=='客户信息更新变化' }"><!-- <a href="" title="" class="unimp"> -->【${parkLog.logType }】<!-- </a> --><a onclick="editCustomerLogById(${parkLog.id})" href="javascript:void(0)"><c:if test="${fn:length(parkLog.logData)>12}">${fn:substring(parkLog.logData,0,12)}...</c:if><c:if test="${fn:length(parkLog.logData)<=12}">${parkLog.logData}</c:if></a>&nbsp;<span class="cor_999">${parkLog.logCustormer}</span>&nbsp;<span class="cor_999"><fmt:formatDate value="${parkLog.logTime }" pattern="yyyy-MM-dd"/></span></c:if>
				</li>
			</c:forEach>
		</ul>
	</div>
</div>
<script type="text/javascript">
	function getIframeHeight(){
		return document.body.clientHeight;
	}
	parent.document.getElementById("console-cont-list").style.height = document.body.clientHeight;
</script> 
</body>
</html>
