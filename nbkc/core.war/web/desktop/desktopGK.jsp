<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.core.activator.CoreActivator"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.wiiy.core.entity.User"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
Date now = new Date();
SimpleDateFormat format = new SimpleDateFormat();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/oawork.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/content.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/portal/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/portal/themes/icon.css"/>
<link rel="stylesheet" type="text/css" href="core/common/portal/portal.css"/>
<style type="text/css">
		.onlyOne {
			padding:0 19px 0 5px; 
			overflow:hidden; 
			color:#333; 
			text-decoration:none; 
			line-height:22px; 
			cursor:pointer;
			background:url(../../common/images/btn_bg.png);
		}
</style>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/righth.js"></script>
<script type="text/javascript" src="core/common/portal/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="core/common/FusionChartsFree/JSClass/FusionCharts.js"></script>
<script type="text/javascript" src="core/common/portal/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/portal/jquery.portal.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
</head>

<body>
	<div class="gWel-main-recommand-cont" style="padding: 0px;">
		<div class="gWel-main-recommand-box">
			<div class="rt">
    			<div class="gWel-info-more">
            		<div class="gWel-info-more-nav">
		                <div class="gWel-info-more-nav-a gWel-info-more-nav-a-on">
		                    <div class="gWel-info-more-nav-aText">新招商项目</div>
		                </div>
            		</div>
            	<div class="gWel-info-more-line"></div>
            	<div class="gWel-info-more-cnt">
	                <ul class="list_sy_5" id="list_1">
	                 <li><a href="javascript:void(0)" title="" id="" onclick="openInvestment(this)"></a>　<span class="cor_999"></span></li>
	                 <li><a href="javascript:void(0)" title="" id="" onclick="openInvestment(this)"></a>　<span class="cor_999"></span></li>
	                 <li><a href="javascript:void(0)" title="" id="" onclick="openInvestment(this)"></a>　<span class="cor_999"></span></li>
	                 <li><a href="javascript:void(0)" title="" id="" onclick="openInvestment(this)"></a>　<span class="cor_999"></span></li>
	                 <li><a href="javascript:void(0)" title="" id="" onclick="openInvestment(this)"></a>　<span class="cor_999"></span></li>
	                 <li><a href="javascript:void(0)" title="" id="" onclick="openInvestment(this)"></a>　<span class="cor_999"></span></li>
	                </ul>
	            </div>
        	</div>
	        <div class="gWel-info-more">
	            <div class="gWel-info-more-nav">
	                <div class="gWel-info-more-nav-a gWel-info-more-nav-a-on">
	                    <div class="gWel-info-more-nav-aText">新入驻客户</div>
	                </div>
	            </div>
	            <div class="gWel-info-more-line"></div>
	            <div class="gWel-info-more-cnt">
	                <ul class="list_sy_5" id="list_2">
	                 <li><a href="javascript:void(0)" title="" id="" onclick="openCustomer(this)"></a><span class="cor_999"></span></li>
	                 <li><a href="javascript:void(0)" title="" id="" onclick="openCustomer(this)"></a><span class="cor_999"></span></li>
	                 <li><a href="javascript:void(0)" title="" id="" onclick="openCustomer(this)"></a><span class="cor_999"></span></li>
	                 <li><a href="javascript:void(0)" title="" id="" onclick="openCustomer(this)"></a><span class="cor_999"></span></li>
	                 <li><a href="javascript:void(0)" title="" id="" onclick="openCustomer(this)"></a><span class="cor_999"></span></li>
	                 <li><a href="javascript:void(0)" title="" id="" onclick="openCustomer(this)"></a><span class="cor_999"></span></li>
	                </ul>
	            </div>
	        </div>
		</div>
		<div class="lt">
		    <ul id="parkSituations" class="buildingList">
		    </ul>
		   <div class="otherlink">
		   	<a href="javascript:void(0)" title="" onclick="myAddTab(parent.parent.parent,'楼宇总览','<%=BaseAction.rootLocation %>/parkmanager.pb/building!buildingCensus.action','/parkmanager.pb/web/images/icon/client_51_min.png')">楼宇总览</a>|
		   	<a href="javascript:void(0)" title="" onclick="myAddTab(parent.parent.parent,'楼宇出租率','<%=BaseAction.rootLocation %>/parkmanager.pb/building!buildingRent.action','/parkmanager.pb/web/images/icon/client_51_min.png')">楼宇出租率</a>|
		   	<a href="javascript:void(0)" title="" onclick="myAddTab(parent.parent.parent,'入驻情况','<%=BaseAction.rootLocation %>/parkmanager.pb/statistic!customerParkStatus.action','/parkmanager.pb/web/images/icon/client_51_min.png')">入驻情况</a>|
		   	<a href="javascript:void(0)" title="" onclick="myAddTab(parent.parent.parent,'孵化情况','<%=BaseAction.rootLocation %>/parkmanager.pb/statistic!customerIncubationStatus.action','/parkmanager.pb/web/images/icon/client_51_min.png')">孵化情况</a>|
		   	<a href="javascript:void(0)" title="" onclick="myAddTab(parent.parent.parent,'客户分类','<%=BaseAction.rootLocation %>/parkmanager.pb/statistic!customerLabel.action','/parkmanager.pb/web/images/icon/client_51_min.png')">客户分类</a>
		   </div>
		</div>
	</div>
</div>
</body>
</html>
