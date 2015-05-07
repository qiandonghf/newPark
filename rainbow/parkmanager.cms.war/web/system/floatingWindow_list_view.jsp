<%@page import="com.wiiy.core.service.export.AppConfig.Choice"%>
<%@page import="com.wiiy.core.service.export.AppConfig.Parameter"%>
<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@page import="com.wiiy.cms.activator.CmsActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
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
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/tree/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/tree/themes/icon.css"/>
<link rel="stylesheet" type="text/css" href="core/common/tree/demo/demo.css"/>

<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/tree/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="core/common/tree/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>

<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	initTip();
	initHeight();
});

function initHeight(){
	$("#resourceList").css("margin-top",0);
	var mainHeight = $("body").height();
	var divHeight = $("#resourceList").height();
	var btnHeight = $(".buttondiv").height();
	var height = mainHeight - divHeight -btnHeight;
	$("#resourceList").css("margin-top",height/2);
	$("#resourceList").css("margin-left","40px");
}

</script>
<style>
	table{
		table-layout:fixed;
	}
</style>
</head>

<body>
<input id="path" type="hidden" name="floatingWindow.resourcePath" />
<input type="hidden" name="floatingWindow.paramId" value="${param.paramId }"/>
<input id="newName" type="hidden" name="floatingWindow.newName"/>
<input id="oldName" type="hidden" name="floatingWindow.oldName"/>
<!--basediv-->
<div class="basediv">
<!--divlay-->
<div class="divlays" style="margin:0px;float:left;">
  <table border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">是否启用：</td>
      <td class="layerright">
      	<c:if test="${result.value.enable eq 'YES' }">&nbsp;启用</c:if>
      	<c:if test="${result.value.enable eq 'NO' }">&nbsp;禁用</c:if>
	  </td>
    </tr>
    <tr>
      <td class="layertdleft100">浮窗名称：</td>
      <td class="layerright">${result.value.name }</td>
    </tr>
    <tr>
      <td class="layertdleft100">浮窗类型：</td>
      <td class="layerright">${result.value.type.title }</td>
    </tr>
    <tr>
      <td class="layertdleft100">浮窗内容：</td>
      <td class="" style="padding-top:2px;padding-bottom:2px;">
    	<textarea class="input200" readonly="readonly" name="floatingWindow.content" style="border:0px;color:#666;height:40px;resize:none;">${result.value.content }</textarea>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">浮窗链接：</td>
      <td class="layerright">${result.value.url }</td>
    </tr>
    <tr>
      <td class="layertdleft100">浮窗尺寸：</td>
      <td class="layerright">
      	<table>
      		<tr>
      			<td>宽:</td>
      			<td width="60">${result.value.width }</td>
      			<td><span style="margin-left:5px;">高:</span></td>
      			<td width="60">${result.value.height }</td>
      		</tr>
      	</table>
      </td>
    </tr>
  </table>
</div>
<div id="resourceList" style="margin-left:40px;float:left;">
	<table>
		<c:if test="${not empty result.value.type && result.value.type eq 'IMAGE'}">
		<tr>
	        <td class="layerright">
	        	<table border="0" align="right" cellpadding="0" cellspacing="0">
		            <tr class="pic">
			           <td width="96">
			           	<c:if test="${not empty result.value.resourcePath }">
			           		<img id="imgPath" src="core/resources/${result.value.resourcePath }" width="107" height="110" class="touxian"  style="margin-left:0px;"/>
			           </c:if>
			           <c:if test="${empty result.value.resourcePath }">
			           		<img id="imgPath" src="core/common/images/carbg.jpg" width="107" height="110" class="touxian"  style="margin-left:0px;"/>
			           </c:if>
			           </td>
				   </tr>
		          </table>
		  	</td>
		</tr>
	  	</c:if>
	</table>
</div>
<div  style="float:left;">
</div>
<!--//divlay-->
	<div class="hackbox"></div>
</div>
<!--//basediv-->
<!--basediv-->
<!--//basediv-->
<div class="" style="height:5px;">
</div>
</body>
</html>
