<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String basePath = BaseAction.rootLocation + request.getContextPath();
%>


<script type="text/javascript">
		function jumpPage(page){
			var url = "<%=basePath%>/list.action?article.typeId=${article.typeId}&tag=${tag}&page="+page;
			url = encodeURI(url);
		//alert(url);
			location.href=url;
		}
	</script>


                    <nav>
				<ul class="pager">
					
					<span><a href="#">总数:${pager.records}</a></span>
					
					<li>
						<a href="javascript:void(0);" onclick="jumpPage(1)">首页</a>
					</li>
					
					<li>
						<a href="javascript:void(0);" onclick="jumpPage(${pager.page-1 })">上一页</a>
					</li>
					
					<li>
						<a href="javascript:void(0);"onclick="jumpPage(${pager.page+1 })">下一页</a>
					</li>
					
					<li>
						<a href="javascript:void(0);"onclick="jumpPage(${pager.total})">尾页</a>
					</li>
					
					<span style="padding-left: 5px"><a href="#">总页:${pager.page }/${pager.total }</a></span>

				</ul>
			</nav>

