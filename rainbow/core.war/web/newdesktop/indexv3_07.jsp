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
					<strong>办公管理</strong><span class="subtitle">ParkCustomer</span><br />
					<span class="toptitle_bg">这里是总园区的办公管理，这里是总园区的办公管理，这里是总园区的办公管理，这里是总园区的办公管理，这里是总园区的办公管理，这里是总园区的办公管理，这里是总园区的办公管理，这里是总园区的办公管理，这里是总园区的办公管理，这里是总园区的办公管理，</span>
				</p>
			</div>
			<div class="maincontent">
				<div class="mainleft">
					<div class="mainnewslist">
						<h3 class="title bg0701">日常工作</h3>
						<p class="toptext">
							这里是办公管理的一段文字介绍，文字介绍稍后提供，这里是办公管理的一段文字介绍，文字介绍稍后提供，这里是办公管理的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="#" class="blue">合同备案</a></strong> <span><a
										href="#" class="underline huise">合同类型1</a> <a href="#"
										class="underline huise">合同类型2</a> <a href="#"
										class="underline huise">合同类型3</a> <a href="#"
										class="underline huise">全部合同类型</a> <a href="#"
										class="underline huise">全部合同类型</a> <a href="#"
										class="underline huise">全部合同类型</a> <a href="#"
										class="underline huise">全部合同类型</a></span>
								</p>
							</li>
						</ul>
					</div>
					<div class="mainnewslist">
						<h3 class="title bg0702">人事管理</h3>
						<p class="toptext">
							这里是办公管理的一段文字介绍，文字介绍稍后提供，这里是办公管理的一段文字介绍，文字介绍稍后提供，这里是办公管理的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="#" class="blue">员工花名册</a></strong> <span><a
										href="#" class="huise"></a></span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">员工考核</a></strong> <span><a
										href="#" class="huise">2014年度考核（3） </a> 代表已经有3人上传考核表</span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">劳动合</a>(<font>N</font>)</strong>
									<span class="nolink"> 默认为2个月</span>
								</p>
							</li>
						</ul>
					</div>
					<div class="mainnewslist">
						<h3 class="title bg0703">行政管理</h3>
						<p class="toptext">
							这里是租赁管理的一段文字介绍，文字介绍稍后提供，这里是办公管理的一段文字介绍，文字介绍稍后提供，这里是办公管理的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="#" class="blue">办公用品管理</a></strong> <span><a
										href="#" class="huise on">+施工合同</a> <a href="#"
										class="huise on">+材料合同</a></span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">会议室</a>(<font>N</font>)</strong>
									<span><a href="#" class="huise on">预定</a></span>
								</p>
							</li>
						</ul>
					</div>

				</div>
				<div class="mainright">
					<div class="mainnewslist">
						<h3 class="title bg0704">信息材料</h3>
						<p class="toptext">
							这里是楼宇管理的一段文字介绍，文字介绍稍后提供，这里是办公管理的一段文字介绍，文字介绍稍后提供，这里是办公管理的一段文字</p>

						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="#" class="blue">公告</a></strong> <span><a
										href="#" class="underline huise"></a> </span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">集团文件</a></strong> <span><a
										href="#" class="underline huise"></a> </span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">规章制度</a></strong> <span><a
										href="#" class="underline huise"></a> </span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">培训材料</a></strong> <span><a
										href="#" class="underline huise"></a> </span>
								</p>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
