<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@page import="com.wiiy.cms.activator.CmsActivator"%>
<%@page import="com.wiiy.core.dto.ResourceDto"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>

<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="core/common/ckeditor/ckeditor.js"></script>

<script type="text/javascript">
$(document).ready(function(){
});



</script>
<style>
	.layerright{
		word-break:break-all;
		width:32%;
	}
	.layertdleft100{
		white-space:nowrap;
		width:18%;
	}
	</style>
</head>

<body style="">
<form id="form1" name="form1" method="post" action="<%=basePath%>param!save.action">
	<input id="param" type="hidden" name="param.id" value="${result.value.id}"/>
	 <input id="imgPath" name="imgPath" type="hidden"/>
	<div class="basediv">
		<!-- <div class="titlebg">网站基本信息</div> -->
		<div class="divlays" style="margin:0px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100"><span class="psred"></span>姓名：</td>
					<td width="29%" class="layerright">${result.value.name }</td>
					<td width="40%" class="layertdleft100"><span class="psred"></span>电话：</td>
					<td width="29%" class="layerright">${result.value.phone}</td>
				</tr>
				<tr>
					<td class="layertdleft100">E-mail：</td>
					<td class="layerright">${result.value.email}</td>
					<td class="layertdleft100">留言时间：</td>
					<td class="layerright"><fmt:formatDate value="${result.value.createTime }" pattern="yyyy-MM-dd HH:mm" /> </td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred"></span>留言内容：</td>
					<td class="layerright" colspan="3" style="padding-left:0px;">
						<textarea class="inputauto" readonly="readonly" style="border:0px;height:80px;resize:none;color:#666;padding-left:4px;">${result.value.content }</textarea>
					</td>
				</tr>
			</table>
		</div>
		<div class="hackbox"></div>
	</div>
	<div class="" style="height:5px;">
	</div>
</form>
</body>
</html>
