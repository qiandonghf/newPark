<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="page">
	<c:if test="${pager.records > 0}">
	<ul>
		<li>总数：${pager.records} </li>
		<li>
			<c:if test="${pager.page <= 1 }">
				<em class="pagepre"><a href="javascript:;">首页</a></em>
				<em class="pagepre"><a href="javascript:;">上一页</a></em>
			</c:if>
			<c:if test="${pager.page > 1 }">
				<em class="pagepre"><a href="javascript:jumpPage(1);">首页</a></em>
				<em class="pagepre"><a href="javascript:jumpPage(${pager.page-1 });">上一页</a></em>
			</c:if>
			<c:if test="${pager.page == pager.total }">
				<em class="pagepre"><a href="javascript:;">尾页</a></em>
				<em class="pagenext"><a href="javascript:;">下一页</a></em>
			</c:if>
			<c:if test="${pager.page != pager.total }">
				<em class="pagepre"><a href="javascript:jumpPage(${pager.total});">尾页</a></em>
				<em class="pagenext"><a href="javascript:jumpPage(${pager.page+1 });">下一页</a></em>
			</c:if>
		</li>
		<c:if test="${pager.total > 0}">
		<li>页次：<font color="#FF0000">${pager.page }</font>/${pager.total}</li>
		</c:if>
		<c:if test="${pager.total == 0}">
		<li>页次：<font color="#FF0000">0</font>/0</li>
		</c:if>
           <li><input name="page" onkeyup="value=value.replace(/[^\d]/g,'')"  type="text" /> <input name="go" type="button" value="GO" onclick="go();" /></li>
	</ul>
	</c:if>
</div>