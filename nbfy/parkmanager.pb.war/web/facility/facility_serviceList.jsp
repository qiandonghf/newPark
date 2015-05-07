<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@page import="com.wiiy.pb.entity.Facility"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="parkmanager.ps/web/style/user.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css"/>
<link rel="stylesheet" type="text/css" href="parkmanager.pb/web/style/pb.css"/>
<link rel="stylesheet" type="text/css" href="parkmanager.pb/web/style/ps.css"/>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript">
$(function(){
	$("#resizable").css("height",getTabContentHeight()-11);
	$("#typeList").css("height",getTabContentHeight()-11);
});

</script>
</head>

<body >
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="182" valign="top">
			<div class="pstextleft" id="resizable">
		    	<div class="pstitles"><span><a href="javascript:void(0)" onclick="fbStart('使用清单','<%=basePath%>facilityOrder!serviceList.action',720,400);">使用清单</a></span>提示</div>
		        <%out.print(PbActivator.getAppConfig().getConfig("facilityInfo").getParameter("name")); %>
		        <!-- <p class="pstextcolor">　　中心提供公共设施的免费试用与租用服务，你可以通过查看公共设施了解其当前使用状况，也可以通过在线或电话方式预约使用中心公共设施。</p>
		        <p class="ptop">预约电话：<span class="psnamecolor">88776655</span></p> -->
		    </div>
	    </td>
	    <td width="100%" valign="top">
	    	<div class="resources" style="overflow-y:scroll;" id="typeList">
				<c:forEach items="${typeList}" var="type">
						<h1 style="padding-bottom: 5px;padding-top: 5px;"><img src="core/common/images/rommico.gif" />${type.title}</h1>
						<c:forEach items="${facilityList}" var="facility">
							<c:if test="${facility.type.title eq type.title}">
								<div class="listcontent" onclick="fbStart('信息查看','<%=basePath %>facility!serviceView.action?id=${facility.id}',780,450);">
									<img src="core/common/images/MinIcons_012.png" />
									<ul>
										<li>${facility.name}</li>
										<li>设施状态：${facility.status.title}</li>
									</ul>
								</div>
							</c:if>
						</c:forEach>
						<div class="hackbox"></div>
				</c:forEach>
			</div>
		</td>
	</tr>
  </table>
</body>
</html>