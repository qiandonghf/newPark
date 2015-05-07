<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>



<script type="text/javascript">
		function jumpPage(page){
			var url = "<%=BaseAction.rootLocation%>/list.action?article.typeId=${article.typeId}&categoryName=${categoryName}&page="+page;
			url = encodeURI(url);
		//alert(url);
			location.href=url;
			
			
		}
	</script>



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
				<em class="pagepre"><a href="javascript:void(0);" onclick="jumpPage(1)">首页</a></em>
				<em class="pagepre"><a href="javascript:void(0);" onclick="jumpPage(${pager.page-1 })">上一页</a></em>
			</c:if>
			<c:if test="${pager.page == pager.total }">
				<em class="pagenext"><a href="javascript:;">下一页</a></em>
				<em class="pagepre"><a href="javascript:;">尾页</a></em>

			</c:if>
			<c:if test="${pager.page != pager.total }">
				<em class="pagenext"><a href="javascript:void(0);"onclick="jumpPage(${pager.page+1 })";>下一页</a></em>
				<em class="pagepre"><a href="javascript:void(0);"onclick="jumpPage(${pager.total})";>尾页</a></em>

			</c:if>
		</li>
		<c:if test="${pager.total > 0}">
		<li>页次：<font color="#FF0000">${pager.page }</font>/${pager.total}</li>
		</c:if>
		<c:if test="${pager.total == 0}">
		<li>页次：<font color="#FF0000">0</font>/0</li>
		</c:if>
	</ul>
	</c:if>
</div>