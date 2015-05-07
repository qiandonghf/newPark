<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s" %> 
<%@ page language="java"
	import="java.util.*,com.wiiy.commons.action.BaseAction"
	pageEncoding="UTF-8"%>

<%
	String path = request.getContextPath();
	String basePath = BaseAction.rootLocation + path;
%>

<!DOCTYPE html>
<html lang="zh-cn">
	<jsp:include page="head.jsp" />
	<body>

		<div class="bannerbox">
			<div class="container">
				<div class="row">
					<div class="bannerimg">
						<img src="<%=BaseAction.rootLocation %>/web/image/banner2.jpg" class="bannerneiye" />
					</div>
				</div>
			</div>
		</div>
		<div class="container">
			<div class="row">
				<div class="col-md-9 col-md-push-3" style="padding-right:32px;">
					<!--mainbar-->
					<h4 class="newlist-title"><span class="titlenew">${articleType.typeName}</span>
					<ol class="breadcrumb">
						<li>
							当前位置：
						</li>
						<li>
							<a href="#">主页</a>
						</li>
						<li class="active">
							${categoryName}
						</li>
					</ol></h4>
					<div class="feature-text">
						<ul>
						<c:forEach items="${articleList}" var="article" varStatus="s">
							<li>
								<a href="<%=BaseAction.rootLocation%>/content.action?article.id=${article.id}&categoryName=${categoryName}">${article.title}</a><span><fmt:formatDate value="${article.pubTime }" pattern="yyyy-MM-dd" /></span>
							</li>
						</c:forEach>
						</ul>
						<nav>

					</nav>
					</div>
		<jsp:include page="pager.jsp"/> 
				</div>
	<jsp:include page="leftmenu.jsp" />
			</div>
		</div>
	<jsp:include page="foot.jsp" />
	</body>
</html>
