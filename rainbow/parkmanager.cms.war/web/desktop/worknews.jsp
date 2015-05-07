<%@page import="com.wiiy.cms.util.CmsUtil"%>
<%@page import="com.wiiy.cloudService.entity.WebContent"%>
<%@page import="java.net.URL"%>
<%@page import="org.gnu.stealthp.rsslib.RSSParser"%>
<%@page import="org.gnu.stealthp.rsslib.RSSHandler"%>
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
<title>无标题文档</title>
<link href="core/common/style/base.css" rel="stylesheet" type="text/css" />
<link href="core/web/style/oawork.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/righth.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#resizable").css("height",getTabContentHeight());
	$("#body").attr("background","core/common/images/workbg.gif");
});
function vopen(url,name,w,h) {
	window.open(url,name,'height='+h+',width='+w+',top=100,left=150,toolbar=no,menubar=no,scrollbars=yes,resizable=yes, location=no,status=no');
}

function centerNews(id){
	addTab(parent.parent,'中心新闻','<%=basePath%>article!deskTopView.action?id='+id);
}

</script>
</head>
<body style="background:url(core/common/images/workbg.gif)">

<div class="oaworkbg"  id="resizable">
<div class="oanews">
	<div class="oaleft">
    	<h1><span>更多>></span><em class="em">中心新闻</em></h1>
        <ul style="padding-top:5px;">
			<c:forEach items="${articleList}" var="article">
				<li><span><fmt:formatDate value="${article.modifyTime}" pattern="yyyy-MM-dd"/></span><c:if test="${article.articleType.typeName!=null}">[${article.articleType.typeName}]</c:if>
				<a href="javascript:void(0)" onclick="centerNews(${article.id})">
				<c:if test="${fn:length(article.title)>=17}">${fn:substring(article.title,0,15)}</c:if>
				<c:if test="${fn:length(article.title)<17}">${article.title}</c:if>
				</a></li>
			</c:forEach>
        </ul>
    </div>
    <!--oaright-->
    <div class="oaright">
    	<h1><span><a href="javascript:void(0)"  onclick="javascript:vopen('http://www.nbbi.net/index.shtml','news',800,600);" style="text-decoration:none;color: #999999;">更多>></a></span><em class="em">动态新闻</em></h1>
    	<c:forEach items="${list}" var="webInfo">
    		<c:if test="${webInfo.title eq '动网科技'}">
    		<c:forEach items="${webInfo.webContentDtoList}" var="c">
	    		<c:if test="${c.image!=null}">
		        <div class="newcon">
		        <img src="${c.image}" width="150" height="110" /><h3><a href="javascript:void(0)" onclick="javascript:vopen('${c.link}','news',800,600);" style="text-decoration:none;color: #000000;">${c.title}</a></h3><p>
		        	<c:if test="${fn:length(c.memo)>=92}">${fn:substring(c.memo,0,90)}</c:if>
		        	<c:if test="${fn:length(c.memo)<92}">${c.memo}</c:if>
		        <a href="javascript:void(0)" onclick="javascript:vopen('${c.link}','news',800,600);">[详细]</a></p>
		        </div> 
		        </c:if>
	        </c:forEach>
    		</c:if>
        </c:forEach>
        <div class="oanewlist">
        	<ul>
        	<c:forEach items="${list}" var="webInfo">
        	<c:forEach items="${webInfo.webContentDtoList}" var="c2">
        		<c:if test="${c2.image==null}">
	            <li><span><fmt:formatDate value="${c2.publishedDate}" pattern="yyyy-MM-dd"/></span>
	            	<a href="javascript:void(0)" onclick="javascript:vopen('${c2.link}','news',800,600);">·${c2.title}</a>
	            	<em class="newlistspan"><!-- 来自：新华网 --></em>
	            </li> 
	            </c:if>
        	</c:forEach>
        	</c:forEach>
            </ul>
        </div>
    </div>
    <!--//oaright-->
</div>
</div>
</body>
</html>