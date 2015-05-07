<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<div class="page">
	<input type="hidden" id="pageIndex" name="page.pageNo" value="${page.pageNo}"/>
	<span class="pres" <c:if test="${page.pageNo!=1}">onclick="jumpPage('${page.pageNo-1}')"</c:if>>上一页</span>
	<c:if test="${page.pageNo>=6}" var="gesix">
		<span class="num" onclick="jumpPage('1')">1</span>
		<span class="num" onclick="jumpPage('2')">2</span>
		<span class="numline">...</span>
		<c:forEach begin="${page.pageNo-2}" end="${page.pageNo+2}" var="index">
			<c:if test="${index<=page.count}">
				<c:if test="${index==page.pageNo}" var="currentIndex">
					<span class="numavtive">${index}</span>
				</c:if>
				<c:if test="${!currentIndex}">
					<span class="num" onclick="jumpPage('${index}')">${index}</span>
				</c:if>
			</c:if>
		</c:forEach>
		<c:if test="${page.count>page.pageNo+2}">
			<span class="numline">...</span>
		</c:if>
	</c:if>
	<c:if test="${!gesix}">
		<c:forEach begin="1" end="${page.pageNo+2}" var="index">
			<c:if test="${index<=page.count}">
			<c:if test="${index==page.pageNo}" var="currentIndex">
				<span class="numavtive">${index}</span>
			</c:if>
			<c:if test="${!currentIndex}">
				<span class="num" onclick="jumpPage('${index}')">${index}</span>
			</c:if>
			</c:if>
		</c:forEach>
		<c:if test="${page.count>page.pageNo+2}">
			<span class="numline">...</span>
		</c:if>
	</c:if>
	<span class="nexts" <c:if test="${page.pageNo!=page.count}">onclick="jumpPage('${page.pageNo+1}')"</c:if>>下一页</span>
</div>
