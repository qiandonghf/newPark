<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page import="com.wiiy.commons.util.DateUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>车位状态视图</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery.treeview.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/smartMenu.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.treeview.js"></script>
<script type="text/javascript" src="core/common/js/jquery-smartMenu.js"></script>
<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	document.getElementById("pm_msglist").style.height=document.documentElement.clientHeight-34;
});
	

</script>
</head>

<body>
<div id="container" style="height: 100%;">
<style type="text/css">
  	ul.parking{margin:10px; }
  	ul.parking li{ float:left; margin:10px;  width:45px; height:80px; background:#6F6; border:1px solid #666; text-align:center; }
	
	ul.parking li.p02{background:#eee; }
  </style>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" id="viewTable">
		<tr>
			<td width="100%" valign="top">
				<div class="apptab" id="tableid">
					<ul>
						<li class="apptabli" ><a href="<%=basePath%>web/property/parkingManage_list.jsp?garageId=${garageId}">车位信息</a></li>
						<%if(PbActivator.getHttpSessionService().isInResourceMap("pb_parkingManage_view")){ %>
							<li class="apptabliover" ><a href="<%=basePath%>parkingManage!view.action?id=${garageId}">车库视图</a></li>
						<%} %>
					</ul>
				</div>
				<div class="pm_msglist" id="pm_msglist" style="overflow-y: auto;">
					<div id="displaylayer">
						<div class="parklist">
							<ul class="parking">
						  		<c:forEach items="${parkingManages}" var="parkingManage">
							    	<li title="${parkingManage.parkingId }" <c:if test="${parkingManage.status eq 'USING' }">class='p02'</c:if>>
							    		<c:choose>
							    			<c:when test="${fn:length(parkingManage.parkingId)>6}"><p >${fn:substring(parkingManage.parkingId,0,4)}...</p></c:when>
							    			<c:otherwise><p>${parkingManage.parkingId }</p></c:otherwise>
							    		</c:choose>
							    		<br/>${parkingManage.status.title }
							    	</li>
						    	</c:forEach>
						  	</ul>
						</div>
					</div>
					<div class="hackbox"></div>
				</div>
			</td>
		</tr>
	</table>
</div>
</body>
</html>
