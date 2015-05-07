<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/oawork.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/content.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/portal/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/portal/themes/icon.css"/>
<link rel="stylesheet" type="text/css" href="core/common/portal/portal.css"/>
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
	<div class="gWel-info-more">
	    <div class="gWel-info-more-nav" id="tab">
	        <div class="gWel-info-more-nav-a gWel-info-more-nav-a-on">
	            <div class="gWel-info-more-nav-aText">收款</div>
	        </div>
	        <div class="gWel-info-more-nav-a">
	            <div class="gWel-info-more-nav-aText">付款</div>
	        </div>
	    </div>
        <div class="gWel-info-more-line"></div>
        <div class="gWel-cont-list">
        	<div class="gWel-info-more-cnt" style="display:block;">
           		<div class="tip tip5_tip" style="margin-top: 8px;">
                	<div class="calculate">共<a href="javascript:void(0)" title="">${billCountIn}</a>笔费用需要收款&nbsp;&nbsp;&nbsp;&nbsp;应付总计：<a href="javascript:void(0)" title="">￥<fmt:formatNumber value="${receiveCount}" pattern="#0.00"/></a>万元</div>
                </div>
                <ul class="list_sy_1_min">
                	<c:forEach items="${inDtoList}" var="inDto">
                    	<li class=""><a href="javascript:void(0)" title="" onclick="parent.addTab(parent.parent.parent.parent,'费用结算','<%=BaseAction.rootLocation %>/parkmanager.pb/bill!listOnDeskTop.action?id='+'${inDto.billId}')">${inDto.billType}（<fmt:formatDate value="${inDto.createTime}" pattern="yyyy-MM-dd"/>）</a>&nbsp;<span class="cor_f00">￥<fmt:formatNumber value="${inDto.moneyPerBill}" pattern="#0.00"/></span>&nbsp;<span class="cor_999">${inDto.customerName}</span></li>
                 	</c:forEach>
                </ul>
				<p class="console-list-more"><a href="javascript:void(0)" title="" onclick="parent.addTab(parent.parent.parent.parent,'费用结算','<%=BaseAction.rootLocation %>/parkmanager.pb/bill!listOnDeskTop.action')">查看全部&gt;&gt;</a></p>
           	</div>
            <div class="gWel-info-more-cnt">
            	<div class="tip tip5_tip" style="margin-top: 8px;">
            		<div class="calculate">共<a href="javascript:void(0)" title="">${billCountOut}</a>笔费用需要付款&nbsp;&nbsp;&nbsp;&nbsp;应付总计：<a href="javascript:void(0)" title="">￥<fmt:formatNumber value="${payCount}" pattern="#0.00"/></a>万元</div>
                </div>
                <ul class="list_sy_1_min">
                	<c:forEach items="${outDtoList}" var="outDto">
                 		<li class=""><a href="javascript:void(0)" title="" onclick="parent.addTab(parent.parent.parent.parent,'费用结算','<%=BaseAction.rootLocation %>/parkmanager.pb/bill!listOnDeskTop.action?id='+'${outDto.billId}')">${outDto.billType}（<fmt:formatDate value="${outDto.createTime}" pattern="yyyy-MM-dd"/>）</a>&nbsp;<span class="cor_f00">￥<fmt:formatNumber value="${outDto.moneyPerBill}" pattern="#0.00"/></span>&nbsp;<span class="cor_999">${outDto.customerName}</span></li>
                    </c:forEach>
                </ul>
                <p class="console-list-more"><a href="javascript:void(0)" title="" onclick="parent.addTab(parent.parent.parent.parent,'费用结算','<%=BaseAction.rootLocation %>/parkmanager.pb/bill!listOnDeskTop.action')">查看全部&gt;&gt;</a></p>
            </div>
        </div>
        <input type="hidden" value="${billCount}"/>
    </div> 
<script type="text/javascript">
	function getIframeHeight(){
		return document.body.clientHeight;
	}
	parent.document.getElementById("console-cont-list").style.height = document.body.clientHeight;
	function tabChange(tabbtn,tabpannel,tabclass){
		var $div_li = tabbtn;
		$div_li.click(function(){
			$(this).addClass(tabclass).siblings().removeClass(tabclass);
			var index = $div_li.index(this);
			$(tabpannel).eq(index).show().siblings().hide();
		});
	}
	
	//JS调用：触发器，切换容器，当前状态
	//tabChange($("#console-menu li"),$("#console-cont-list .li"),"on");
	tabChange($("#tab .gWel-info-more-nav-a"),$(".gWel-cont-list .gWel-info-more-cnt"),"gWel-info-more-nav-a-on");
</script>                          	
</body>
</html>
