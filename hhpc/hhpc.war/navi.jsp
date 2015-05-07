<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.cms.entity.ArticleType"%>
<%@page import="com.wiiy.cms.preferences.enums.ArticleKindEnum"%>
<%@page import="com.wiiy.cms.entity.Article"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>

<div id="nav">
  <ul id="menu">
  	<c:forEach items="${categoryList}" var="category" varStatus="s">
		<c:if test="${category.level eq 0}">
		<li>
		<c:if test="${empty category.url}">
			<c:if test="${category.kind=='SINGLE'}"><a href="/viewt.action?id=${category.id}" >${category.typeName}</a></c:if>
			<c:if test="${category.kind=='LIST'}"><a>${category.typeName}</a></c:if>
		</c:if>
		<c:if test="${not empty category.url}">
			<a href="${category.url}">${category.typeName}</a>
		</c:if>
		<ul>
		<c:forEach items="${categoryList}" var="subCategory" varStatus="s1">
			<c:if test="${subCategory.level eq 1 and subCategory.parentId eq category.id}">
				<c:if test="${empty subCategory.url}">
					<c:if test="${subCategory.kind=='SINGLE'}">
						<li><a href="/view.action?categoryId=${subCategory.id}">${subCategory.typeName}</a></li>
					</c:if>
					<c:if test="${subCategory.kind=='LIST'}">
						<li><a href="/list.action?id=${subCategory.id}">${subCategory.typeName}</a></li>
					</c:if>
				</c:if>
				<c:if test="${not empty subCategory.url}">
					<c:if test="${subCategory.kind=='SINGLE'}">
						<c:if test="${fn:indexOf(subCategory.url, '?') != -1}">
							<li><a href="${subCategory.url}&categoryId=${subCategory.id}">${subCategory.typeName}</a></li>
		         		</c:if>
		         		<c:if test="${fn:indexOf(subCategory.url, '?') == -1}">
							<li><a href="${subCategory.url}?categoryId=${subCategory.id}">${subCategory.typeName}</a></li>
		         		</c:if>
					</c:if>
					<c:if test="${subCategory.kind=='LIST'}">
						<c:if test="${fn:indexOf(subCategory.url, '?') != -1}">
							<li><a href="${subCategory.url}&id=${subCategory.id}">${subCategory.typeName}</a></li>
		         		</c:if>
		         		<c:if test="${fn:indexOf(subCategory.url, '?') == -1}">
							<li><a href="${subCategory.url}?id=${subCategory.id}">${subCategory.typeName}</a></li>
		         		</c:if>
					</c:if>
				</c:if>
			</c:if>
		</c:forEach>
		</ul>
		</li>
		</c:if>
	</c:forEach>
  </ul>
</div>
<div class="hackbox"> </div>