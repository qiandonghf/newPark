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
	$(function(){
		initInvoice();
	});
	
	/*收款*/
	function initInvoice(){
		$.ajax({
		   type		: "POST",
		   url		: "<%=BaseAction.rootLocation%>/department.business/bill!invoiceCounts.action",
		   success	: function(data){
			   $("#noBillings").html(data.noBillings);
			   $("#checks").html(data.checks);
			   $("#remindBills").html(data.remindBills);
		   }
		});
	}
	
	function addNewTab(name,icon,url){
		url = "<%=BaseAction.rootLocation%>"+url;
		parent.addTab(name,icon,url);
	}
</script>
</head>
<body>


	<div id="contant2" style="overflow: auto;">

		<div id="news_contenter" class="main"
			style="padding-left: 30px; padding-top: 10px;">
			<div class="toptitle">
				<p>
					<strong>结算管理</strong><span class="subtitle">ParkCustomer</span><br />
					<span class="toptitle_bg">这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，这里是总园区的销售管理，</span>
				</p>
			</div>
			<div class="maincontent">
				<div class="mainleft">
					<div class="mainnewslist">
						<h3 class="title bg0401">费用结算</h3>
						<p class="toptext">
							这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="" class="blue">收款</a></strong> 
									<span class="w300th">
										<a href="javascript:;" onclick="addNewTab('待开票','/department.business/web/images/icon/account_02_min.png','/department.business/bill!list.action?settlementType=NOBILLING');" class="huise">待开票(<font id="noBillings">0</font>)</a> 
										<a href="javascript:;" onclick="addNewTab('待结算','/department.business/web/images/icon/account_02_min.png','/department.business/bill!list.action?settlementType=BILLING');" class="huise on">待结算(<font id="checks">0</font>)</a> 
										<a href="javascript:;" onclick="addNewTab('待催缴','/department.business/web/images/icon/account_02_min.png','/department.business/bill!list.action?settlementType=REMINDBILL');" class="huise on">待催缴(<font id="remindBills">0</font>)</a> 
									</span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">付款</a></strong> <span><a
										href="#" class="underline huise"></a> </span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">结算单</a></strong> <span><a
										href="#" class="underline huise">补录</a> <a href="#"
										class="underline huise">核销</a> </span>
								</p>
								<p class="text">
									<strong><a href="#" class="blue">统计</a></strong> <span><a
										href="#" class="underline huise"></a> <a href="#"
										class="underline huise on"></a></span>
								</p>
							</li>
						</ul>
					</div>
				</div>
				<div class="mainright">
					<div class="mainnewslist">
						<h3 class="title bg0402">合同</h3>
						<p class="toptext">
							这里是楼宇管理的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字介绍，文字介绍稍后提供，这里是销售机会的一段文字</p>
						<ul>
							<li class="main2">
								<p class="text">
									<strong><a href="#" class="blue">合同</a></strong> <span><a
										href="#" class="underline huise">合同类型1</a> <a href="#"
										class="underline huise">合同类型2</a> <a href="#"
										class="underline huise">合同类型3</a></span>
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
