<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<link rel="stylesheet" type="text/css" href="core/common/style/oawork.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
</head>
<body>
<div>
	<div class="gWel-info-more">
		<div class="gWel-info-more-nav">
            <div class="gWel-info-more-nav-a gWel-info-more-nav-a-on" style="width:170px;">
                <div class="gWel-info-more-nav-aText" style="width:170px;">入驻/迁出企业（30天内）</div>
            </div>
        </div>
        <div class="gWel-info-more-line"></div>
        <div>
			<ul class="list_sy_1_min2">
					<li><strong>入驻企业：</strong>
						<c:forEach items="${result.value}" var="customer">
							<c:if test="${'INPARK' == customer.parkStatus}">
								<a href="javascript:void(0)" onclick="fbStart('查看企业档案','<%=basePath %>customer!view.action?id=${customer.id }',890,460);">${customer.name }</a>&nbsp;
							</c:if>
						</c:forEach>
					</li>
					<li><strong>迁出企业：</strong>
						<c:forEach items="${result.value}" var="customer">
							<c:if test="${'OUTPARK' == customer.parkStatus}">
								<a href="javascript:void(0)" onclick="fbStart('查看企业档案','<%=basePath %>customer!view.action?id=${customer.id }',890,460);">${customer.name }</a>&nbsp;
							</c:if>
						</c:forEach>
					</li>
					<%-- <li><strong>续签企业：</strong>
						<c:forEach items="${result.value}" var="customer" >
							<c:if test="${'RENEW' == customer.parkStatus}">
								<a href="javascript:void(0)" onclick="fbStart('查看企业档案','<%=basePath %>customer!view.action?id=${customer.id }',890,460);">${customer.name }</a>&nbsp;
							</c:if>
						</c:forEach>
					</li>
					<li><strong>退租企业：</strong>
						<c:forEach items="${result.value}" var="customer">
							<c:if test="${'THROWALEASE' == customer.parkStatus}">
								<a href="javascript:void(0)" onclick="fbStart('查看企业档案','<%=basePath %>customer!view.action?id=${customer.id }',890,460);">${customer.name }</a>&nbsp;
							</c:if>
						</c:forEach>
					</li> --%>
			</ul>
			<p class="console-list-more"><a href="javascript:void(0)" title="" onclick="parent.addTab(parent.parent.parent.parent,'企业信息','<%=BaseAction.rootLocation %>/parkmanager.pb/web/client/customer_list.jsp')">查看全部&gt;&gt;</a></p>
		</div>
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