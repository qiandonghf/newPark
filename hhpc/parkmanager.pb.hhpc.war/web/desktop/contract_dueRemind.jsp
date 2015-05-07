<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

<link rel="stylesheet" type="text/css" href="core/common/style/oawork.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
</head>
<body>
<div>
	<input type="hidden"  value="${result.value }"/>
	<div class="gWel-info-more">
		<div class="gWel-info-more-nav">
			<div class="gWel-info-more-nav-a gWel-info-more-nav-a-on" style="width:170px;">
             	<div class="gWel-info-more-nav-aText" style="width:170px;">合同到期提醒（30天内）</div>
         	</div>
      	</div>
      	<div class="gWel-info-more-line"></div>
      	<div class="gWel-info-more-cnt">
			<ul class="list_sy_1_min">
				<c:forEach items="${contractList}" var="contract">
					<li><a href="javascript:void(0)" onclick="fbStart('查看合同','<%=basePath %>contract!view.action?id=${contract.id}',765,467);">【${contract.item.title}】<fmt:formatDate value="${contract.endDate}" pattern="MM-dd"/>到期</a>&nbsp;<span class="cor_999"><c:if test="${fn:length(contract.customer.shortName)>0}" var="shortName">${contract.customer.shortName}</c:if><c:if test="${!shortName}">${contract.customer.name}</c:if></span></li>
				</c:forEach>
			</ul>
			<p class="console-list-more"><a href="javascript:void(0)" title="" onclick="parent.addTab(parent.parent.parent.parent,'合同到期','<%=BaseAction.rootLocation %>/parkmanager.pb/web/contract/contract_list.jsp')">查看全部&gt;&gt;</a></p>
		</div>
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