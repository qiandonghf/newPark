<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="page" style="border-top:none;">
	<ul>
		<li>
			<c:if test="${pager.total==0}" var="nodata">无数据显示</c:if>
			<c:if test="${!nodata}">
			<c:if test="${pager.page>1}" var="firstPage">
			<span class="first" onclick="jumpPage(1)"></span><span class="pre" onclick="jumpPage(${pager.page-1})"></span>
			</c:if>
			<c:if test="${!firstPage}">
			<span class="first"></span><span class="pre"></span>
			</c:if>
			<c:if test="${pager.page==pager.total}" var="total">
			<span>显示&nbsp;${pager.rows*(pager.page-1)+1}&nbsp;-&nbsp;${pager.records}</span>
			</c:if>
			<c:if test="${!total}">
			<span>显示&nbsp;${pager.rows*(pager.page-1)+1}&nbsp;-&nbsp;${pager.rows*pager.page}</span>
			</c:if>
			<c:if test="${pager.page<pager.total}" var="lastPage">
			<span class="next" onclick="jumpPage(${pager.page+1})"></span><span class="last" onclick="jumpPage(${pager.total})"></span>
			</c:if>
			<c:if test="${!lastPage}">
			<span class="next"></span><span class="last"></span>
			</c:if>
			共&nbsp;${pager.records}&nbsp;条
			</c:if>
		</li>
	</ul>
</div>
