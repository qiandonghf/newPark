<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.oa.entity.Notice"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
Date date = new Date();
request.setAttribute("date",date);
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
	<div class="gWel-info-more">
		<div class="gWel-info-more-nav">
			<div class="gWel-info-more-nav-a gWel-info-more-nav-a-on" style="width:170px;">
             	<div class="gWel-info-more-nav-aText" style="width:170px;">公告</div>
         	</div>
      	</div>
      	<div class="gWel-info-more-line"></div>
      	<div class="gWel-info-more-cnt">
			<ul class="list_sy_1_min">
				<c:forEach items="${list}" var="notice">
					<li><a href="javascript:void(0)" onclick="fbStart('查看公告','<%=basePath %>notice!view.action?id=${notice.id}',510,274);">${notice.name }</a>&nbsp;<span class="cor_999"><fmt:formatDate value="${notice.issueTime }" pattern="yyyy-MM-dd"/></span><c:if test="${notice.issueTime.year eq date.year && notice.issueTime.month eq date.month && notice.issueTime.date eq date.date}"><img src="core/common/images/5-120601152050-51.gif"></c:if></li>
				</c:forEach>
			</ul>
			<p class="console-list-more"><a href="javascript:void(0)" title="" onclick="parent.addTab(parent.parent.parent.parent,'公告管理','<%=BaseAction.rootLocation %>/parkmanager.oa/web/information/notice_list.jsp')">查看全部&gt;&gt;</a></p>
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