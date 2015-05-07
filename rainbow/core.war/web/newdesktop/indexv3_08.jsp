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
					<strong>园区宝</strong><span class="subtitle">ParkCustomer</span><br />
					<span class="toptitle_bg">这里是总园区的园区宝，这里是总园区的园区宝，这里是总园区的园区宝，这里是总园区的园区宝，这里是总园区的园区宝，这里是总园区的园区宝，这里是总园区的园区宝，这里是总园区的园区宝，这里是总园区的园区宝，这里是总园区的园区宝，</span>
				</p>
			</div>
			<div class="maincontent">
				<!----左侧内容开始------->
				<div class="mainleft">
					<div class="mainnewslist">
						<h3 class="title bg0801">内容管理</h3>
						<p class="toptext">
							这里是内容管理的一段文字介绍，文字介绍稍后提供，这里是内容管理的一段文字介绍，文字介绍稍后提供，这里是内容管理的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="#" class="blue">园区资料</a></strong> <span></span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">活动管理</a></strong> <span></span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">资讯管理</a></strong> <span></span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">物业管理</a></strong> <span><a
										href="#" class="huise"></a> </span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">园区交通</a></strong> <span></span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">电话本</a></strong> <span></span>
								</p>
							</li>
						</ul>
					</div>
					<div class="mainnewslist">
						<h3 class="title bg0802">招商管理</h3>
						<p class="toptext">
							这里是招商管理的一段文字介绍，文字介绍稍后提供，这里是招商管理的一段文字介绍，文字介绍稍后提供，这里是招商管理的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="#" class="blue">项目线索</a></strong> <span><a
										href="#" class="huise on">新增(<font>2</font>)
									</a> </span>
								</p>
							</li>
						</ul>
					</div>
				</div>
				<!----左侧内容结束------->
				<!----右侧内容开始------->
				<div class="mainright">
					<div class="mainnewslist">
						<h3 class="title bg0803">服务管理</h3>
						<p class="toptext">
							这里是服务管理的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="#" class="blue">机构管理</a></strong> <span><a
										href="#" class="underline huise"></a></span>
								</p>
								<p class="text">
									<strong class=" num"><a href="#" class="blue">贷款服务</a>(<font>5</font>)<a
										href="#" class="blue">会计服务</a>(<font>5</font>)<a href="#"
										class="blue">后勤服务</a>(<font>5</font>) <a href="#" class="blue">服务类型</a>(<font>5</font>)</strong>
									<span class=" w120th"><a href="#" class="blue">投资服务</a>
										<a href="#" class="blue">法律服务(<font>2</font>)
									</a> <a href="#" class="blue">税务服务</a> <a href="#" class="blue">人力资源(<font>2</font>)
									</a> <a href="#" class="blue">项目申报</a> <a href="#" class="blue">营销服务(<font>2</font>)
									</a></span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">统计</a></strong> <span><a
										href="#" class="huise"></a></span>
								</p>
							</li>
						</ul>
					</div>
					<div class="mainnewslist">
						<h3 class="title bg0804">系统管理</h3>
						<p class="toptext">
							这里客户管理的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="#" class="blue">用户中心</a></strong> <span
										class=" nolink">最近15天，新注册用户<font>7</font>人
									</span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">运营统计</a></strong> <span><a
										href="#" class="underline huise on"></a></span>
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
