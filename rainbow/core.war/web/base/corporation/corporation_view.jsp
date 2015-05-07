<%@page import="com.wiiy.core.activator.CoreActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = BaseAction.rootLocation+path+"/";
	String uploadPath = BaseAction.rootLocation+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation%>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/uploadify-v3.1/uploadify.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script type="text/javascript">
	$(function(){
	});
	
</script>
<style>
	.mainTable{
		table-layout:fixed;
	}
</style>
</head>

<body>
<div>			
	<div class="basediv">
		<div class="divlays" style="margin:0px;">
			<table class="mainTable" width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100">名称：</td>
					<td class="layerright">${result.value.name }</td>
					<td class="layertdleft100">编号：</td>
					<td class="layerright">${result.value.code }</td>
				</tr>
				<tr>
					<td class="layertdleft100">简称：</td>
					<td class="layerright">${result.value.shortName }</td>
					<td class="layertdleft100">开户行：</td>
					<td class="layerright">${result.value.bankName }</td>
				</tr>
				<tr>
					<td class="layertdleft100">开户人：</td>
					<td class="layerright">${result.value.owner }</td>
					<td class="layertdleft100">账号：</td>
					<td class="layerright">${result.value.bankAccount }</td>
				</tr>
				<tr>
					<td class="layertdleft100">地址：</td>
					<td class="layerright">${result.value.address }</td>
					<td class="layertdleft100">邮编：</td>
					<td class="layerright">${result.value.zipCode }</td>
				</tr>
				<tr>
					<td class="layertdleft100">网址：</td>
					<td class="layerright">${result.value.webSite }</td>
					<td class="layertdleft100">办公电话：</td>
					<td class="layerright">${result.value.officePhone }</td>
				</tr>
				<tr>
					<td class="layertdleft100">传真：</td>
					<td class="layerright">${result.value.fax }</td>
					<td class="layertdleft100">E-Mail：</td>
					<td class="layerright">${result.value.email }</td>
					
				</tr>
				<tr>
					<td class="layertdleft100">法定代表人：</td>
					<td class="layerright">${result.value.legalPerson }</td>
					<td class="layertdleft100">股东：</td>
					<td class="layerright">${result.value.shareholder }</td>
				</tr>
				<tr>
					<td class="layertdleft100">公司描述：</td>
					<td class="layerright" colspan="3">
						<textarea name="corporation.description" style="height:60px;resize:none;border:0px;color:#666;padding-left:0px;" class="inputauto">${result.value.description }</textarea>
					</td>
				</tr>
			</table>
		</div>
		<div class="hackbox"></div>
	</div>
	<div style="heihgt:5px;">
	</div>
</div>
</body>
</html>