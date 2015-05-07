<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java"
	import="java.util.*,com.wiiy.commons.action.BaseAction"
	pageEncoding="UTF-8"%>

<%@ page import="com.wiiy.cms.preferences.enums.ArticleKindEnum"
	language="java"%>

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
					<img src="<%=BaseAction.rootLocation %>/web/image/banner2.jpg" class="bannerneiye" />
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-md-9 col-md-push-3" style="padding-right: 32px;">
				<!--mainbar-->
				<h4 class="newlist-title">
					<span class="titlenew">客户案例</span>
					<ol class="breadcrumb">
						<li>当前位置：</li>
						<li><a href="#">主页</a></li>
						<li class="active">${categoryName}</li>
					</ol>
				</h4>
				<div class="feature-text">
					<div id="content">

						<div id="c_txt">

							<ul class="kehu">
								<li>
									<DIV>
										<img src="<%=BaseAction.rootLocation %>/web/image/case/hgdq.jpg" width="280" height="100">
									</DIV>
									<p>客户公司名称</p>
								</li>
								<li>
									<DIV>
										<img src="<%=BaseAction.rootLocation %>/web/image/case/hsdz.png" width="280" height="100">
									</DIV>
									<p>客户公司名称</p>
								</li>
								<li>
									<DIV>
										<img src="<%=BaseAction.rootLocation %>/web/image/case/jhsh.png" width="280" height="100">
									</DIV>
									<p>客户公司名称</p>
								</li>
								<li>
									<DIV>
										<img src="<%=BaseAction.rootLocation %>/web/image/case/jrs.jpg" width="280" height="100">
									</DIV>
									<p>客户公司名称</p>
								</li>
																<li>
									<DIV>
										<img src="<%=BaseAction.rootLocation %>/web/image/case/jyyy.png" width="280" height="100">
									</DIV>
									<p>客户公司名称</p>
								</li>
								<li>
									<DIV>
										<img src="<%=BaseAction.rootLocation %>/web/image/case/jzdj.jpg" width="280" height="100">
									</DIV>
									<p>客户公司名称</p>
								</li>
								<li>
									<DIV>
										<img src="<%=BaseAction.rootLocation %>/web/image/case/shhg.jpg" width="280" height="100">
									</DIV>
									<p>客户公司名称</p>
								</li>
								<li>
									<DIV>
										<img src="<%=BaseAction.rootLocation %>/web/image/case/tyhb.jpg" width="280" height="100">
									</DIV>
									<p>客户公司名称</p>
								</li>
								<div class="clearfix"></div>
							</ul>


						</div>

						<!--//上下篇-->
					</div>
				</div>

			</div>
			<jsp:include page="leftmenu.jsp" />
		</div>
	</div>

	<jsp:include page="foot.jsp" />
</body>
</html>
