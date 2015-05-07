<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.cms.entity.Article"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
Date curTime = new Date();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
</head>
<body>
<div>
	<ul class="list_sy_1">
		<c:forEach items="${articleList}" var="article">
	       <li><span class="layerright"><c:if test="${article.articleType.typeName!=null}">[${article.articleType.typeName}]</c:if></span><a href="javascript:void(0);" onclick="fbStart('查看文章','<%=BaseAction.rootLocation %>/parkmanager.cms/article!deskTopView.action?id=${article.id}',800,450)" title="${article.title}">
	       <c:if test="${fn:length(article.title)>=20}">${fn:substring(article.title,0,18)}</c:if><c:if test="${fn:length(article.title)<20}">${article.title}</c:if>
	       </a>&nbsp;<span class="cor_999"><fmt:formatDate value="${article.modifyTime}"  pattern="yyyy-MM-dd"/></span>
			<%													
				Article article = (Article)pageContext.getAttribute("article");
				Long d = curTime.getTime() - article.getModifyTime().getTime();
				int day = (int)((d)/86400000)+1;
				if(day<5 && day>-5){
			%>
		       <img src="core/common/images/5-120601152050-51.gif"/>
	      	 <%} %>
	       </li>
		</c:forEach>
     </ul>
</div>
</body>
</html>