<%@page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="com.wiiy.web.listener.InitListener"%>
<%@page import="com.wiiy.commons.util.StringUtil"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>

<div id="mainleft2"> 
   <c:set var="currentId" value="<%=request.getParameter("currentId") %>"></c:set>
   <!---企业专栏开始---->
   <c:if test="${not empty parentCategory }">
   <div class="parkleftlist"> 
      <!---左侧标题开始---->
       <h1 class="Title3"><p>${parentCategory.typeName }</p></h1>
       <!---左侧标题结束---->
       <ul>
       	 <c:forEach items="${currentCategories}" var="category">
       	 	<c:if test="${empty category.url}">
       	 		<c:if test="${category.kind=='SINGLE'}">
       	 		<li <c:if test="${category.id eq currentId }">class="hover"</c:if>>
	         		<em><img src="images/ico.gif" width="4" height="7" /></em>
	         		<a href="/view.action?categoryId=${category.id}">${category.typeName}</a>
	         	</li>
       	 		</c:if>
       	 		<c:if test="${category.kind=='LIST'}">
	         	<li <c:if test="${category.id eq currentId }">class="hover"</c:if>>
	         		<em><img src="images/ico.gif" width="4" height="7" /></em>
	         		<a href="/list.action?id=${category.id}">${category.typeName}</a>
	         	</li>
	         	</c:if>
			</c:if>
			<c:if test="${not empty category.url}">
				<li <c:if test="${category.id eq currentId }">class="hover"</c:if>>
					<em><img src="images/ico.gif" width="4" height="7" /></em>
					<c:if test="${category.kind=='SINGLE'}">
		         		<c:if test="${fn:indexOf(category.url, '?') != -1}">
			         		<a href="${category.url}&categoryId=${category.id}">${category.typeName}</a>
		         		</c:if>
		         		<c:if test="${fn:indexOf(category.url, '?') == -1}">
			         		<a href="${category.url}?categoryId=${category.id}">${category.typeName}</a>
		         		</c:if>
	         		</c:if>
       	 			<c:if test="${category.kind=='LIST'}">
		         		<c:if test="${fn:indexOf(category.url, '?') != -1}">
			         		<a href="${category.url}&id=${category.id}">${category.typeName}</a>
		         		</c:if>
		         		<c:if test="${fn:indexOf(category.url, '?') == -1}">
			         		<a href="${category.url}?id=${category.id}">${category.typeName}</a>
		         		</c:if>
		         	</c:if>
	         	</li>
			</c:if>
       	 </c:forEach>
       </ul>  
   </div>
   </c:if>
   <!---企业专栏结束----> 
   <div class="hackbox"></div>
 </div>