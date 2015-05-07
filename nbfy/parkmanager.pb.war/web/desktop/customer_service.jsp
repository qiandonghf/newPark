<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.wiiy.core.entity.User"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = BaseAction.rootLocation
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
                            <div class="gWel-info-more-nav">
                                <div class="gWel-info-more-nav-a gWel-info-more-nav-a-on">
                                    <div class="gWel-info-more-nav-aText">客服联系单</div>
                                </div>
                            </div>
                            <div class="gWel-info-more-line"></div>
                              <div class="gWel-info-more-cnt">
                                <ul class="list_sy_2">
	                                <c:forEach items="${result.value}" var="customerService">
	                                	<c:if test="${customerService.status eq 'ACCEPT' }">
	                                		<li class="sign_04"><span class="cor_999">[${customerService.type.moduleName }]</span><a href="javascript:void(0)" title="" class=" margin_left_10" onclick='fbStart("联系单查看","<%=basePath%>customerService!view2.action?id="+${customerService.id },700,400)'>${customerService.customer.name }</a><span class="cor_999 margin_left_10"><span class=""><c:if test="${customerService.result eq 'SOLVED' }">已完成</c:if><c:if test="${customerService.result eq 'UNSOLVE' }">未完成</c:if><c:if test="${customerService.result eq 'PartSOLVED' }">部分完成</c:if></span></span>&nbsp;<span class="cor_999 margin_left_10"><fmt:formatDate pattern="yyyy-MM-dd" value="${customerService.createTime }"/></span></li>
	                                	</c:if>
	                                	<c:if test="${customerService.status eq 'PENDING' }">
	                                		<li class="sign_02"><span class="cor_999">[${customerService.type.moduleName }]</span><a href="javascript:void(0)" title="" class=" margin_left_10" onclick='fbStart("联系单查看","<%=basePath%>customerService!view2.action?id="+${customerService.id },700,400)'>${customerService.customer.name }</a><span class="cor_999 margin_left_10"><span class=""><c:if test="${customerService.result eq 'SOLVED' }">已完成</c:if><c:if test="${customerService.result eq 'UNSOLVE' }">未完成</c:if><c:if test="${customerService.result eq 'PartSOLVED' }">部分完成</c:if></span></span>&nbsp;<span class="cor_999 margin_left_10"><fmt:formatDate pattern="yyyy-MM-dd" value="${customerService.createTime }"/></span></li>
	                                	</c:if>
	                                	<c:if test="${customerService.status eq 'CLOSE' }">
	                                		<li class="sign_01"><span class="cor_999">[${customerService.type.moduleName }]</span><a href="javascript:void(0)" title="" class=" margin_left_10" onclick='fbStart("联系单查看","<%=basePath%>customerService!view2.action?id="+${customerService.id },700,400)'>${customerService.customer.name }</a><span class="cor_999 margin_left_10"><span class=""><c:if test="${customerService.result eq 'SOLVED' }">已完成</c:if><c:if test="${customerService.result eq 'UNSOLVE' }">未完成</c:if><c:if test="${customerService.result eq 'PartSOLVED' }">部分完成</c:if></span></span>&nbsp;<span class="cor_999 margin_left_10"><fmt:formatDate pattern="yyyy-MM-dd" value="${customerService.createTime }"/></span></li>
	                                	</c:if>
	                                </c:forEach>
                                 </ul>
                            	<ul class="explain_list">
                                    <li><img src="core/common/images/sign_01.gif">灰色为完成</li>
                                    <li><img src="core/common/images/sign_04.gif">绿色为处理中</li>
                                    <li><img src="core/common/images/sign_02.gif">红色为挂起</li>
                                </ul>
                                 <p class="console-list-more"><a href="javascript:void(0);" title="" onclick="parent.addTab(parent.parent.parent.parent,'客服联系单','<%=BaseAction.rootLocation %>/parkmanager.pb/customerService!list.action')">查看全部&gt;&gt;</a></p>
                        	</div>
                        </div>
                    
                       
<script type="text/javascript">
	function getIframeHeight(){
		return document.body.clientHeight;
	}
	parent.document.getElementById("console-cont-list").style.height = document.body.clientHeight;
</script> 
</body>
</html>