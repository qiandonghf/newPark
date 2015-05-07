<%@page import="com.wiiy.cms.entity.Article"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.web.listener.InitListener"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title><%=InitListener.webParam.getName() %></title>

<!---样式---->
	<jsp:include page="style.jsp"></jsp:include>
<!---样式结束----> 
</head>
<body>

<!---顶部开始---->
	<jsp:include page="header.jsp"></jsp:include>
<!---顶部结束----> 

<!---导航开始---->
	<jsp:include page="navi.jsp"></jsp:include>
<!---导航结束----> 

<!---焦点图开始---->
	<jsp:include page="view_photo.jsp"></jsp:include>
<!---焦点图结束---->

<!---主体内容开始---->
<div id="main" style="padding-top:25px;"> 
  
  <!---主体内容左侧开始---->
 	<jsp:include page="main_left.jsp">
 		<jsp:param value="${article.typeId }" name="currentId"/>
 	</jsp:include>
  <!---主体内容左侧结束----> 
  
  <!---主体内容右侧开始---->
  <div id="mainright2"> 
    <!---左侧标题开始---->
    <h1 class="Title5">
      <p>
      	      当前位置：<a href="index.action">首页</a>》
	      <c:if test="${not empty category && not empty category.parentType}"> 
	      	<c:if test="${category.parentType.typeName != '网站首页' }">
				<c:if test="${category.kind=='SINGLE'}">
					<a href="javascript:;">${category.parentType.typeName}</a>》
				</c:if>
				<c:if test="${category.kind=='LIST'}">
					<a href="javascript:;">${category.parentType.typeName}</a>》
				</c:if>
			</c:if>
	      </c:if>
	      <c:if test="${not empty category}">
			<c:if test="${category.kind=='SINGLE'}">
				<a href="javascript:;">${category.typeName}</a>
			</c:if>
			<c:if test="${category.kind=='LIST'}">
		      	<c:if test="${not empty category.url}">
      				<c:if test="${fn:indexOf(category.url, '?') != -1}">
						<a href="${category.url}&id=${category.id}">${category.typeName}</a>
	         		</c:if>
	         		<c:if test="${fn:indexOf(category.url, '?') == -1}">
						<a href="${category.url}?id=${category.id}">${category.typeName}</a>
	         		</c:if>
				</c:if>
				<c:if test="${empty category.url}">
					<a href="list.action?id=${category.id}">${category.typeName}</a>
				</c:if>		      	
			</c:if>	
	      </c:if>
      </p>
    </h1>
    <!---左侧标题结束---->  
    
    <!---服务平台具体内容开始---->
    <div class="servicesinfo">
		<h2></h2>
    	<c:set value="${article.photo }" var="p"></c:set>
		<%
		String photo = "";
		if(pageContext.getAttribute("p") != null){
			photo = pageContext.getAttribute("p").toString();
	 	 	int pos = -1;
	 	 	if(photo != null && (pos=photo.lastIndexOf(".")) != -1){
	 	 		photo = photo.substring(0,pos)+"335-240"+photo.substring(pos);
 	 	%>
        <img width="112" height="132" src="core/resources/<%=photo%>" />		
 	 	<%}}else{%>
		<img width="112" height="132" src="core/common/images/topxiao.gif" />
		<%}%>
		<ul>
			<li>
				<p><font style="font-size:16px; font-weight:bold; color:#c41210;">${article.title }</font> （${article.subtitle }）    </p>
				<p>${article.content }</p>
			</li>
		</ul>
		<div class="hackbox"></div>
    </div>
    <!---服务平台具体内容结束----> 
    <c:if test="${not empty articleMap }">
    	<%
    	HashMap<Integer,Article> map = 
			(HashMap<Integer,Article>)request.getAttribute("articleMap");
    	Article lastArticle = map.get(1);
    	Article nextArticle = map.get(2);
    	if(!(lastArticle == null && nextArticle == null)){
    	%>
	    <!---nextpage---->
	    <div class="nextpage">
	      <p><span>上一篇：
	      	  <%if(lastArticle != null){ %>
	      	  <% String content = lastArticle.getTitle();
		      	if(content.length() > 21){
		    		content = content.substring(0,20);
		    		content += "...";
		        }
		       %>
		      <a title="<%=lastArticle.getTitle() %>" href="showView.action?id=<%=lastArticle.getId() %>&pos=<%=lastArticle.getRecord() %>"><%=content %></a>
		      <%}else{%>
		      <a href="javascript:;">没有了</a>
		       <%}%>
	      </span>下一篇：
	          <%if(nextArticle != null){ %>
	          <% String content = nextArticle.getTitle();
		      	if(content.length() > 21){
		    		content = content.substring(0,20);
		    		content += "...";
		        }
		       %>
		      <a title="<%=nextArticle.getTitle() %>" href="showView.action?id=<%=nextArticle.getId() %>&pos=<%=nextArticle.getRecord() %>"><%=content %></a>
	      	  <%} else{%>
		      <a href="javascript:;">没有了</a>
		       <%}%>
	      </p>
	    </div>
	    <!---nextpage---->
	    <%} %>
    </c:if>
    <div class="hackbox"></div>
  </div>
  <!---主体内容右侧结束---->
  
  <div class="hackbox"></div>
</div>
<!---主体内结束----> 

<!---底部开始---->
	<jsp:include page="footer.jsp"></jsp:include>
<!---底部结束---->

</body>
</html>
