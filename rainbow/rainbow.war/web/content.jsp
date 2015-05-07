<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s" %> 
<%@ page language="java"
	import="java.util.*,com.wiiy.commons.action.BaseAction"
	pageEncoding="UTF-8"%>	
	
<%@ page import="com.wiiy.cms.preferences.enums.ArticleKindEnum"  language="java"%>

<%
	String path = request.getContextPath();
	String basePath = BaseAction.rootLocation + path;
%>
<!DOCTYPE html>
<html lang="zh-cn">

<jsp:include page="head.jsp" />
<body>

	<div class="bannerbox">
		<div class="container">
			<div class="row">
				<div class="bannerimg">
					<img src="<%=BaseAction.rootLocation%>/web/image/banner2.jpg" class="bannerneiye" />
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-md-9 col-md-push-3" style="padding-right: 32px;">
				<!--mainbar-->
				<h4 class="newlist-title">
					<span class="titlenew">${articleType.typeName}</span>
					<ol class="breadcrumb">
						<li>当前位置：</li>
						<li><a href="index.action">主页</a></li>
						<li class="active">${categoryName}</li>
					</ol>
				</h4>
				<div class="feature-text">
					<div id="content">
					<s:if test="%{article.kind.toString() == 'LIST'}">
						<div id="title_wrap">
							<h3 id="title" class="text-center">${article.title}</h3>
							<div id="info" class="text-center">
								<span>发布日期：<fmt:formatDate value="${article.pubTime }" pattern="yyyy-MM-dd"/> </span><span>来源：${article.source}</span>
							</div>
						</div>
					</s:if>
						<div id="c_txt">
							${article.content}
						</div>
						
<%-- 						<s:if test="%{article.kind.toString() == 'LIST'}">
						<div id="prev_next">
							<div id="prev">
								上一篇：<a href="/fd.html">公司发布新产品阿斯顿立方空间啊撒地方现售4000元!</a>
							</div>
							<div id="next">下一篇：没有了!</div>
						</div>
						</s:if>
 --%>						<!--//上下篇-->
					</div>
				</div>

			</div>
			
			<jsp:include page="leftmenu.jsp" />

		</div>
	</div>

	<jsp:include page="foot.jsp" />
</body>
</html>
