<%@page import="com.wiiy.pb.activator.PbActivator"%>
<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
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
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
</head>

<body>
<input value="${result.value.id}" name="contect.id" type="hidden"/>
<div class="basediv">
	<div class="divlays" style="margin:0px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="layertdleft100">企业：</td>
				<td class="layerright">${result.value.customer.name}</td>
			</tr>
			<tr>
				<td class="layertdleft100">姓名：</td>
				<td class="layerright">${result.value.name}</td>
			</tr>
			<tr>
				<td class="layertdleft100">性别：</td>
				<td class="layerright">${result.value.gender.title}</td>
			</tr>
			<tr>
				<td class="layertdleft100">手机：</td>
				<td class="layerright">${result.value.mobile}</td>
			</tr>
			<tr>
				<td class="layertdleft100">是否主要联系人：</td>
				<td class="layerright">${result.value.main.title}</td>
			</tr>
			<tr>
				<td class="layertdleft100">职位：</td>
				<td class="layerright">${result.value.position}</td>
			</tr>
		</table>
	</div>
	<div class="hackbox"></div>
</div>
<div class="apptab" id="tableid">
	<ul>
			<li class="apptabliover" onclick="tabSwitch('apptabli','apptabliover','tabswitch',0)">联系方式</li>
			<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',1)">扩展信息</li>
			<li class="apptabli" onclick="tabSwitch('apptabli','apptabliover','tabswitch',2)">其它信息</li>
	</ul>
</div>
	<div class="basediv tabswitch" style="margin-top:0px;" id="textname">
		<div class="divlays" style="margin:0px;">
	    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100">Email：</td>
					<td class="layerright">${result.value.email}</td>
				</tr>
				<tr>
					<td class="layertdleft100">电话：</td>
					<td class="layerright">${result.value.phone}</td>
				</tr>
				<tr>
					<td class="layertdleft100">MSN：</td>
					<td class="layerright">${result.value.msn}</td>
				</tr>
				<tr>
					<td class="layertdleft100">QQ：</td>
					<td class="layerright">${result.value.qq}</td>
				</tr>
				<tr>
					<td class="layertdleft100">传真：</td>
					<td class="layerright">${result.value.fax}</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="basediv tabswitch" style="margin-top:0px;display:none;" id="textname">
		<div class="divlays" style="margin:0px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100">邮编：</td>
					<td class="layerright">${result.value.zipcode}</td>
				</tr>
				<tr>
					<td class="layertdleft100">家庭地址：</td>
					<td class="layerright">${result.value.homeAddr}</td>
				</tr>
				<tr>
					<td class="layertdleft100">家庭电话：</td>
					<td class="layerright">${result.value.homePhone}</td>
				</tr>
				<tr>
					<td class="layertdleft100">生日：</td>
					<td class="layerright"><fmt:formatDate value="${result.value.birthDay}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
				</tr>
				<tr>
					<td class="layertdleft100">爱好：</td>
					<td class="layerright">${result.value.favorite}</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="basediv tabswitch" style="margin-top:0px;display:none;" id="textname">
		<div class="divlays" style="margin:0px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100">备注：</td>
					<td class="layerright"><div style="height:80px;overflow-y:auto; overflow-x:hidden;word-break:break-all; word-wrap:break-word; ">${result.value.memo}</div></td>
				</tr>
			</table>
		</div>
	</div>
	<div style="height: 5px;"></div>
</body>
</html>