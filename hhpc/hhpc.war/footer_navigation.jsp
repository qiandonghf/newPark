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
 		<jsp:param value="${category.id }" name="currentId"/>
 	</jsp:include>
  <!---主体内容左侧结束----> 
  
  <!---主体内容右侧开始---->
  <div id="mainright2"> 
    <!---左侧标题开始---->
    <h1 class="Title5">
      <p>
      	      当前位置：<a href="index.action">首页</a>&nbsp;&nbsp;》
	      <c:if test="${not empty category && not empty category.parentType}"> 
			<a>${category.parentType.typeName}</a>&nbsp;&nbsp;》
	      </c:if>
	      <c:if test="${not empty category}">
			<a>${category.typeName}</a>	      	
	      </c:if>
      </p>
    </h1>
    <!---左侧标题结束---->  
    
    <!---企业介绍具体内容开始---->
	<div class="parkinfo">
		<ul>
			<li>
			<!-- 顶级 -->
			<c:forEach items="${all}" var="category" varStatus="s">
			<c:if test="${category.level eq 0}">
			<p class="webdaohang"> <strong>${category.typeName}</strong><br />
			<c:forEach items="${all}" var="subCategory">
				<c:if test="${subCategory.level eq 1 and subCategory.parentId eq category.id}">
					<c:if test="${empty subCategory.url}">
						<c:if test="${subCategory.kind=='SINGLE'}">
							<a target="_blank" href="/view.action?categoryId=${subCategory.id}">${subCategory.typeName}</a>
						</c:if>
						<c:if test="${subCategory.kind=='LIST'}">
							<a target="_blank" href="/list.action?id=${subCategory.id}">${subCategory.typeName}</a>
						</c:if>
					</c:if>
					<c:if test="${not empty subCategory.url}">
						<c:if test="${subCategory.kind=='SINGLE'}">
							<c:if test="${fn:indexOf(subCategory.url, '?') != -1}">
								<a  target="_blank" href="${subCategory.url}&categoryId=${subCategory.id}">${subCategory.typeName}</a>
			         		</c:if>
			         		<c:if test="${fn:indexOf(subCategory.url, '?') == -1}">
								<a target="_blank" href="${subCategory.url}?categoryId=${subCategory.id}">${subCategory.typeName}</a>
			         		</c:if>
						</c:if>
						<c:if test="${subCategory.kind=='LIST'}">
							<c:if test="${fn:indexOf(subCategory.url, '?') != -1}">
								<a target="_blank" href="${subCategory.url}&id=${subCategory.id}">${subCategory.typeName}</a>
			         		</c:if>
			         		<c:if test="${fn:indexOf(subCategory.url, '?') == -1}">
								<a target="_blank" href="${subCategory.url}?id=${subCategory.id}">${subCategory.typeName}</a>
			         		</c:if>
						</c:if>
					</c:if>
				</c:if>
			</c:forEach>
			</p><br/><div class="hackbox"></div>
			</c:if>
			</c:forEach>
			</li>
		</ul>
    </div>
    <!---企业介绍具体内容结束----> 
    
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
