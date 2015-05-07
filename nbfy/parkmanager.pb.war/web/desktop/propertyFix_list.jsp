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
          <div class="gWel-info-more-nav-aText">物业报修</div>
      </div>
  </div>
  <div class="gWel-info-more-line"></div>
  
  <div class="gWel-info-more-cnt">
  
  	 <ul class="list_sy_2">
  	 <c:forEach items="${propertyFixList}" var="propertyFix">
   <%String value = "";%>
		<c:if test="${propertyFix.status eq 'HANGUP' }"><%value="sign_02";%></c:if>
		<c:if test="${propertyFix.status eq 'HANGIN' }"><%value="sign_04";%></c:if>
		<c:if test="${propertyFix.status eq 'FINISHED' }"><%value="sign_01";%></c:if>
		<c:if test="${propertyFix.status eq 'UNSTART' }"><%value="sign_03";%></c:if>
		<li class="<%=value %>"><a href="javascript:void(0);" title="" onclick="fbStart('查看物业保修单','<%=BaseAction.rootLocation %>/parkmanager.pb/propertyFix!handleDesktop.action?id=${propertyFix.id }',800,230)">${fn:substring(propertyFix.reportReason,0,10) }</a><span class="cor_999"><c:if test="${propertyFix.reporter == null} ">()</c:if><c:if test="${propertyFix.reporter != null }">(${propertyFix.reporter})</c:if></span><span class="cor_999 margin_left_10"><fmt:formatDate pattern="yyyy-MM-dd" value="${property.reportTime }"/></span></li>
                             </c:forEach>
                          </ul>
                                  <ul class="explain_list">
                                    <li><img src="core/common/images/sign_01.gif">灰色为完成</li>
                                    <li><img src="core/common/images/sign_04.gif">绿色为处理中</li>
                                    <li><img src="core/common/images/sign_02.gif">红色为挂起</li>
                                  </ul>
                                <p class="console-list-more"><a href="javascript:void(0);" title="" onclick="parent.addTab(parent.parent.parent.parent,'物业报修','<%=BaseAction.rootLocation %>/parkmanager.pb/web/property/property_repair_list.jsp')">查看全部&gt;&gt;</a></p>
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