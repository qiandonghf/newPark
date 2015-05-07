<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@page import="java.util.Map"%>
<%@page import="com.wiiy.commons.preferences.enums.UserTypeEnum"%>
<%@page import="com.wiiy.core.activator.CoreActivator"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = BaseAction.rootLocation + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation%>/" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>园区动力-销售管理</title>
<link href="core/common/style/index.css" rel="stylesheet"
	type="text/css" />
<link href="core/web/newdesktop/style/newindex.css" rel="stylesheet"
	type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet"
	type="text/css" />
<link href="core/common/style/tab.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/jquery-ui.css" rel="stylesheet"
	type="text/css" />

<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/menu.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tab.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>



<script type="text/javascript">
	
</script>
</head>
<body>


	<div id="contant2" style="overflow: auto;">

		<div id="news_contenter" class="main"
			style="padding-left: 30px; padding-top: 10px;">
			<div class="toptitle">
				<p>
					<strong>驾驶舱</strong><span class="subtitle">ParkCMS</span><br />
					<span class="toptitle_bg">这里是驾驶舱的一段文字介绍，文字介绍稍后提供</span>
				</p>
			</div>
			<div class="maincontent">
				<!----左侧内容开始------->
				<div class="mainleft">
					<div class="mainnewslist">
						<h3 class="title bg0801">当前园区运营数据</h3>
						<p class="toptext">
							这里是网站管理的一段文字介绍，文字介绍稍后提</p>
						<ul>
							<li class="main2">
								工程数据
								<p class="text">
									<strong><a href="#" class="blue">工程进度</a></strong> <span>
									</span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">工程合同控制(以下显示与实际进度严重不符的合同列表)</a></strong> 
									<span class="w300th">
										<a href="#" class="huise">合同名称1</a>
										<span style="clear:both;"></span>
										<a href="#" class="huise">合同名称2</a>
										<span style="clear:both;"></span>
										<a href="#" class="huise">合同名称3</a>
									</span>
								</p>
								<div style="border-top:1px dashed #cccccc;"/>
								销售数据
								<div style="border-top:1px dashed #cccccc;"/>
								招商数据
								<div style="border-top:1px dashed #cccccc;"/>
								物业数据
								<div style="border-top:1px dashed #cccccc;"/>
								客户数据
								<div style="border-top:1px dashed #cccccc;"/>
								结算数据
								<div style="border-top:1px dashed #cccccc;"/>
								数据报表
							</li>
						</ul>
					</div>
				</div>
				<!----左侧内容结束------->
				<!----右侧内容开始------->
				<div class="mainright">
					<div class="mainnewslist">
						<h3 class="title bg0803">历史情况</h3>
						<p class="toptext">
							这里是文档管理的一段文字介绍，文字介绍稍后提</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="#" class="blue">一览表</a></strong> 
									<span class="w300th">
										<a href="#" class="huise">12月</a>
										<a href="#" class="huise">11月</a>
										<a href="#" class="huise">10月</a>
										<a href="#" class="huise">9月</a>
										<a href="#" class="huise">8月</a>
										<a href="#" class="huise">之前</a>
									</span>
								</p>
							</li>
						</ul>
					</div>
					<div class="mainnewslist">
						<h3 class="title bg0804">检索</h3>
						<p class="toptext">
							这里是抓取管理的一段文字介绍，文字介绍稍后提</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="#" class="blue">客户(销售类)</a></strong> 
								</p>
								<p class="text">
									<strong><a href="#" class="blue">招商项目</a></strong> 
								</p>
								<p class="text">
									<strong><a href="#" class="blue">客户(租赁类)</a></strong> 
								</p>
							</li>
						</ul>
					</div>
				</div>

				<!----右侧内容结束------->
			</div>
		</div>
	</div>
</body>
</html>
