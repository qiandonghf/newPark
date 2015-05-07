<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<style>
	table{
		table-layout:fixed;
	}
</style>
</head>

<body>
<form action="<%=basePath%>agency!update.action" method="post" name="form1" id="form1">
<!--basediv-->
<div class="basediv">
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
		<td class="layertdleft100">名称：</td>
		<td width="35%" class="layerright">
			${result.value.name}
		</td>
		<td class="layertdleft100">编号：</td>
    	<td class="layerright">
    		${result.value.orderId }
    	</td>
    </tr>
    <tr>
		<td class="layertdleft100">发布到网站：</td>
		<td width="35%" class="layerright">
			${result.value.pub.title}
		</td>
		<td class="layertdleft100">网址：</td>
    	<td class="layerright">
    		${result.value.homePage }
    	</td>
    </tr>
    <tr>
    	<td class="layertdleft100">负责人：</td>
    	<td class="layerright">${result.value.charger}</td>
    	<td class="layertdleft100">职务：</td>
    	<td class="layerright">
    		${result.value.position}
    	</td>
   	</tr>
    <tr>
    	<td class="layertdleft100">负责人手机：</td>
    	<td class="layerright">
    		${result.value.mobile}
    	</td>
    	<td class="layertdleft100">负责人电话：</td>
    	<td class="layerright">
			${result.value.phone}
		</td>
   	</tr>
    <tr>
    	<td class="layertdleft100">联系人：</td>
    	<td class="layerright">${result.value.contact}</td>
    	<td class="layertdleft100">联系人职务：</td>
    	<td class="layerright">
    		${result.value.cposition}
    	</td>
   	</tr>
   	<tr>
   		<td class="layertdleft100">联系人手机：</td>
    	<td class="layerright">
    		${result.value.contractMobile}
    	</td>
    	<td class="layertdleft100">联系人电话：</td>
    	<td class="layerright">
			${result.value.contractPhone}
		</td>
   	</tr>
    <tr>
    	<td class="layertdleft100">Email：</td>
    	<td class="layerright">
    		${result.value.email}
    	</td>
    	<td class="layertdleft100">机构类型：</td>
    	<td class="layerright">
    		${result.value.agencyType.title }
    	</td>
   	</tr>
    <%-- <tr>
    	<td class="layertdleft100">网址：</td>
    	<td class="layerright">
    		${result.value.homePage}
    	</td>
    	<td class="layertdleft100"><span class="psred">*</span>邮编：</td>
		<td class="layerright">
			${result.value.zipcode}
		</td>
    	</tr>
	</table>
	<table  width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>通讯地址：</td>
      <td colspan="3" class="layerright">
      	${result.value.address}
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">LOGO：</td>
      <td colspan="3" class="layerright" style="padding-bottom:2px;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="50">
					<c:if test="${result.value.logo ne ''}">
						<img id="imgpre" src="core/resources/${result.value.logo}" style="border:1px solid #ddd;"  width="50"  height="50" />
					</c:if>	
				</td>
				<td>&nbsp;</td>
			</tr>
		</table></td>
    </tr> --%>
    
    <tr>
    	<td class="layertdleft100">简介：</td>
    	<td colspan="3" class="layerright">
    		<textarea style="height:100px;color:#666;padding-left:0px;border:0px;" readonly="readonly" class="inputauto">${result.value.memo}</textarea>
    	</td>
    </tr>
  </table>
</div>
<!--//divlay-->
	<div class="hackbox"></div>
</div>
<!--//basediv-->
<!--basediv-->
<!--//basediv-->
<div class="" style="height:5px;">
<!--    <label><input name="Submit2" type="button" class="closebtn" value="" onclick="parent.fb.end();"/></label>-->
</div> 
</form>
</body>
</html>
