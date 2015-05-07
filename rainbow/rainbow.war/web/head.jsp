
<%@ page language="java"
	import="java.util.*,com.wiiy.commons.action.BaseAction"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	String path = request.getContextPath();
	String basePath = BaseAction.rootLocation + path;
%>

	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		
		<title>彩虹科技</title>

		<link href="<%=BaseAction.rootLocation%>/web/css/bootstrap.min.css" rel="stylesheet">
		<link href="<%=BaseAction.rootLocation%>/web/css/main.css" rel="stylesheet">
	</head>
	
	<div class="container">
        <div class="masthead">
            <a href=" " class="top-logo-link">
                <img src="<%=BaseAction.rootLocation%>/web/image/logo.jpg" class="top-logo" alt="Blimp logo">
            </a>
            <ul class="nav nav-pills pull-right top-nav">
            	<li class="top-nav-item"><a href="<%=BaseAction.rootLocation%>/index.action?categoryName=首页"<c:if test="${categoryName eq '首页'}"> class="active" </c:if> >首页</a></li>
<%--             	<li class="top-nav-item"><a href="<%=BaseAction.rootLocation%>/list.action?categoryName=关于我们"<c:if test="${categoryName eq '关于我们'}"> class="active" </c:if> >关于我们</a></li>
 --%>           
 				<li class="top-nav-item"><a href="<%=BaseAction.rootLocation%>/content.action?article.id=3&categoryName=关于我们"<c:if test="${categoryName eq '关于我们'}"> class="active" </c:if> >关于我们</a></li>
                <li class="top-nav-item"><a href="<%=BaseAction.rootLocation%>/content.action?article.id=6&categoryName=产品服务"<c:if test="${categoryName eq '产品服务'}"> class="active" </c:if> >产品服务</a></li>
                <li class="top-nav-item"><a href="<%=BaseAction.rootLocation%>/list.action?article.typeId=11&categoryName=政策资讯"<c:if test="${categoryName eq '政策资讯'}"> class="active" </c:if> >政策资讯</a></li>
                <li class="top-nav-item"><a href="<%=BaseAction.rootLocation%>/listdoc.action?categoryName=资料下载"<c:if test="${categoryName eq '资料下载'}"> class="active" </c:if> >资料下载</a></li>
                <li class="top-nav-item"><a href="<%=BaseAction.rootLocation%>/listcase.action?categoryName=客户案例"<c:if test="${categoryName eq '客户案例'}"> class="active" </c:if> >客户案例</a></li>
            </ul>
        </div>
    </div>