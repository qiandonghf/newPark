<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String jumpPage = "jumpPage";
	if(request.getParameter("jumpPage")!=null) {
		jumpPage = request.getParameter("jumpPage");
	}
%>
<div style="margin:10px 0;" class="pageNav fontGreen f14">
<c:if test="${pager.total==0}" var="nodata"><div style="margin-left: 200px;">无数据显示</div></c:if>
<c:if test="${!nodata}">
	<c:if test="${pager.index==1}" var="first">
		<span class="na f12">首页</span>
	</c:if>
	<c:if test="${!first}">
		<a onclick="<%=jumpPage %>(1)" style="cursor: pointer;">首页</a>
	</c:if>
	<c:if test="${pager.index>1}" var="hasPre">
		<a href="javascript:void(0)" onclick="<%=jumpPage %>(${pager.index-1})" style="cursor: pointer;">上一页</a>
	</c:if>
	<c:if test="${!hasPre}">
		<span class="na f12">上一页</span>
	</c:if>
	
	<c:set var="displayCount" value="7"/>
	<c:set var="displayHalf" value="3"/>
	
	<c:if test="${pager.count<=displayCount}" var="displayAll">
		<c:forEach begin="1" end="${pager.count}" var="i">
			<c:if test="${i==pager.index}" var="current">
				<strong>${i}</strong>
			</c:if>
			<c:if test="${!current}">
				<a href="javascript:void(0)" onclick="<%=jumpPage %>(${i})">${i}</a>
			</c:if>
		</c:forEach>
	</c:if>
	
	<c:if test="${!displayAll}">
	
		<c:if test="${pager.index-displayHalf>0}" var="hasPreHalf">
			<c:forEach begin="0" end="${displayHalf}" var="i">
				<c:if test="${i==displayHalf}" var="current">
					<strong>${pager.index-(displayHalf-i)}</strong>
				</c:if>
				<c:if test="${!current}">
					<a href="javascript:void(0)" onclick="<%=jumpPage %>(${pager.index-(displayHalf-i)})">${pager.index-(displayHalf-i)}</a>
				</c:if>
			</c:forEach>
		</c:if>
		<c:if test="${!hasPreHalf}">
			<c:forEach begin="1" end="${pager.index}" var="i">
				<c:if test="${i==pager.index}" var="current">
					<strong>${i}</strong>
				</c:if>
				<c:if test="${!current}">
					<a href="javascript:void(0)" onclick="<%=jumpPage %>(${i})">${i}</a>
				</c:if>
			</c:forEach>
		</c:if>
		
		<c:if test="${pager.index+displayHalf<pager.count}" var="hasNextHalf">
			<c:forEach begin="1" end="${displayHalf}" var="i">
				<a href="javascript:void(0)" onclick="<%=jumpPage %>(${pager.index+i})">${pager.index+i}</a>
			</c:forEach>
		</c:if>
		<c:if test="${!hasNextHalf}">
			<c:forEach begin="${pager.index+1}" end="${pager.count}" var="i">
				<c:if test="${i==pager.index}" var="current">
					<strong>${i}</strong>
				</c:if>
				<c:if test="${!current}">
					<a href="javascript:void(0)" onclick="<%=jumpPage %>(${i})">${i}</a>
				</c:if>
			</c:forEach>
		</c:if>
	</c:if>
	
	<c:if test="${pager.index<pager.count}" var="hasNext">
		<a href="javascript:void(0)" onclick="<%=jumpPage %>(${pager.index+1})" style="cursor: pointer;">下一页</a>
	</c:if>
	<c:if test="${!hasNext}">
		<span class="na f12">下一页</span>
	</c:if>
	<c:if test="${pager.index==pager.count}" var="last">
		<span class="na f12">末页</span>
	</c:if>
	<c:if test="${!last}">
		<a onclick="<%=jumpPage %>(${pager.count})" style="cursor: pointer;">末页</a>
	</c:if>
</c:if>
</div>