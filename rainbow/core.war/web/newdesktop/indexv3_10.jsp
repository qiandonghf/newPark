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
	
	function addTabList(obj,msg,actionName){
		if(!actionName) actionName = 'department.business';
		var title = "";
		if(obj)
		 title = $(obj).text();
		if(msg)
		 title = msg;
		var icon = 'core/common/images/console.png';
		var url = "<%=BaseAction.rootLocation%>/department.business/statistic!"+ actionName + ".action?hide=hide";
		parent.addTab(title, icon, url);
	}
</script>
</head>
<body>


	<div id="contant2" style="overflow: auto;">

		<div id="news_contenter" class="main"
			style="padding-left: 30px; padding-top: 10px;">
			<div class="toptitle">
				<p>
					<strong>综合数据</strong><span class="subtitle">ParkCustomer</span><br />
					<span class="toptitle_bg">这里是总园区的综合数据，这里是总园区的综合数据，这里是总园区的综合数据，这里是总园区的综合数据，这里是总园区的综合数据，这里是总园区的综合数据，这里是总园区的综合数据，这里是总园区的综合数据，这里是总园区的综合数据，这里是总园区的综合数据，</span>
				</p>
			</div>
			<div class="maincontent">
				<!----左侧内容开始------->
				<div class="mainleft">
					<div class="mainnewslist">
						<h3 class="title bg1001">综合查询</h3>
						<p class="toptext">
							这里是内容管理的一段文字介绍，文字介绍稍后提供，这里是内容管理的一段文字介绍，文字介绍稍后提供，这里是内容管理的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="#" class="blue">客户（销售类）</a></strong> <span></span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">招商项目</a></strong> <span></span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">客户（租赁类）</a></strong> <span></span>
								</p>
							</li>
						</ul>
					</div>
					<div class="mainnewslist">
						<h3 class="title bg1002">图形分析</h3>
						<p class="toptext">
							这里是招商管理的一段文字介绍，文字介绍稍后提供，这里是招商管理的一段文字介绍，文字介绍稍后提供，这里是招商管理的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="javascript:;" class="blue">楼宇总览分析</a></strong>
									<span><a href="#" class="huise on"></a> </span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue">出租率分析</a></strong>
									<span><a href="#" class="huise"></a> </span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue">出售率分析</a></strong>
									<span></span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue">企业经营数据分析</a></strong>
									<span></span>
								</p>
								<p class="text">
									<strong><a href="javascript:;"
										onclick="addTabList(this,null,'customerParkStatus');"
										class="blue">企业入驻情况</a></strong> <span><a href="#"
										class="huise on"></a> </span>
								</p>
								<p class="text">
									<strong><a href="javascript:;"
										onclick="addTabList(this,null,'customerIncubationStatus');"
										class="blue">企业孵化状态</a></strong> <span><a href="#" class="huise"></a>
									</span>
								</p>
								<p class="text">
									<strong><a href="javascript:;"
										onclick="addTabList(this,null,'customerTechnic');"
										class="blue">企业技术领域统计</a></strong> <span></span>
								</p>
								<p class="text">
									<strong><a href="javascript:;"
										onclick="addTabList(this,null,'customerLabel');" class="blue">企业分类统计</a></strong>
									<span></span>
								</p>
								<p class="text">
									<strong><a href="javascript:;"
										onclick="addTabList(this,null,'registeredCapital');"
										class="blue">企业注资情况</a></strong> <span><a href="#"
										class="huise on"></a> </span>
								</p>
								<p class="text">
									<strong><a href="javascript:;"
										onclick="addTabList(this,null,'customerStaffer');"
										class="blue">企业从业人员情况</a></strong> <span><a href="#"
										class="huise"></a> </span>
								</p>
								<p class="text">
									<strong><a href="javascript:;"
										onclick="addTabList(this,null,'propertyRight');" class="blue">企业知识产权情况</a></strong>
									<span></span>
								</p>
								<p class="text">
									<strong><a href="javascript:;"
										onclick="addTabList(this,null,'productTechnic');" class="blue">企业产品情况</a></strong>
									<span></span>
								</p>
								<p class="text">
									<strong><a href="javascript:;" class="blue">企业服务联系单情况</a></strong>
									<span></span>
								</p>
							</li>
						</ul>
					</div>
				</div>
				<!----左侧内容结束------->
				<!----右侧内容开始------->
				<div class="mainright">
					<div class="mainnewslist">
						<h3 class="title bg1003">报表</h3>
						<p class="toptext">
							这里是服务管理的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="#" class="blue">出售明细表</a></strong> <span>当前
										<a href="#" class="huise">2014</a> <a href="#" class="huise">2013</a>
										<a href="#" class="huise">2012</a>
									</span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">出租明细表</a></strong> <span>当前
										<a href="#" class="huise">2014</a> <a href="#" class="huise">2013</a>
										<a href="#" class="huise">2012</a>
									</span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">孵化用房管理表</a></strong> <span>当前
										<a href="#" class="huise">2014</a> <a href="#" class="huise">2013</a>
										<a href="#" class="huise">2012</a>
									</span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">结算表</a></strong> <span><a
										href="#" class="huise">日</a> <a href="#" class="huise">月</a> <a
										href="#" class="huise">年</a></span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">分户明细表（租赁）</a></strong> <span><a
										href="#" class="huise"></a> <a href="#" class="huise"></a> <a
										href="#" class="huise"></a></span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">实收统计表</a></strong> <span><a
										href="#" class="huise"></a> <a href="#" class="huise"></a> <a
										href="#" class="huise"></a></span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">应收未收统计表（租赁）</a></strong> <span><a
										href="#" class="huise"></a> <a href="#" class="huise"></a> <a
										href="#" class="huise"></a></span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">科技企业孵化器综合情况表</a></strong> <span><a
										href="#" class="huise">2014</a> <a href="#" class="huise">2013</a>
										<a href="#" class="huise">2012</a></span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">科技企业孵化器在孵（毕业）企业情况表</a></strong>
									<span><a href="#" class="huise">2014</a> <a href="#"
										class="huise">2013</a> <a href="#" class="huise">2012</a></span>
								</p>
							</li>
						</ul>
					</div>
					<div class="mainnewslist">
						<h3 class="title bg1004">特殊定制</h3>
						<p class="toptext">
							这里客户管理的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="#" class="blue">定制表单1</a></strong> <span
										class=" nolink"></span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">定制表单2</a></strong> <span><a
										href="#" class="underline huise on"></a></span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">定制表单3</a></strong> <span
										class=" nolink"></span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">定制表单4</a></strong> <span><a
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
