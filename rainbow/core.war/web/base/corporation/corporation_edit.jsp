<%@page import="com.wiiy.core.activator.CoreActivator"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		initTip();
		initForm();
	});
	
	function generateCode(){
		showTip("正在生成编号,请稍后……",60000);
		$.post("<%=basePath%>corporation!generateCode.action",function(data){
			if(data.result.success){
				showTip("生成编号成功",2000);
				$("#code").val(data.result.value);
			}
		});
	}
	function initForm(){
		$("#form1").validate({
			rules: {
				"corporation.code":"required",
				"corporation.name":"required"
			},
			messages: {
				"corporation.code":"请输入企业编号",
				"corporation.name": "请输入企业名称"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				$('#form1').ajaxSubmit({ 
			        dataType: 'json',		        
			        success: function(data){
		        		showTip(data.result.msg,2000);
			        	if(data.result.success){
			        		setTimeout("getOpener().reloadList();parent.fb.end();", 2000);
			        	}
			        } 
			    });
			}
		});
	}
	function setSelectedUser(user){
		$("#importId").val(user.id);
		$("#importName").val(user.realName);
	}
	function selectUser(){
		fbStart('选择用户','<%=BaseAction.rootLocation%>/core/user!selectSelf.action',520,400);
	}
	
</script>
<style>
	.mainTable{
		table-layout:fixed;
	}
</style>
</head>

<body>
<form action="<%=basePath%>corporation!update.action" method="post" name="form1" id="form1">
	<input type="hidden" value="${result.value.id }" name="corporation.id" />
	<div id="scrollDiv" style=" position:relative;">			
		<div class="basediv">
			<div class="divlays" style="margin:0px;">
				<table class="mainTable" width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>名称：</td>
						<td class="layerright"><input  value="${result.value.name }"id="name" name="corporation.name" type="text" class="inputauto" /></td>
						<td class="layertdleft100"><span class="psred">*</span>编号：</td>
						<td class="layerright">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td><input  value="${result.value.code }"id="code" name="corporation.code" type="text" class="inputauto" /></td>
									<td width="80" align="center"><img src="core/common/images/auto.gif" width="75" height="22" style="cursor:pointer;" onclick="generateCode()"/></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="layertdleft100">简称：</td>
						<td class="layerright"><input  value="${result.value.shortName }"id="shortName" name="corporation.shortName" type="text" class="inputauto" /></td>
						<td class="layertdleft100">开户行：</td>
						<td class="layerright"><input  value="${result.value.bankName }"name="corporation.bankName" type="text" class="inputauto" /></td>
					</tr>
					<tr>
						<td class="layertdleft100">开户人：</td>
						<td class="layerright"><input  value="${result.value.owner }"name="corporation.owner" type="text" class="inputauto" /></td>
						<td class="layertdleft100">账号：</td>
						<td class="layerright"><input  value="${result.value.bankAccount }"name="corporation.bankAccount" type="text" class="inputauto" /></td>
					</tr>
					<tr>
						<td class="layertdleft100">地址：</td>
						<td class="layerright"><input  value="${result.value.address }"name="corporation.address" type="text" class="inputauto" /></td>
						<td class="layertdleft100">邮编：</td>
						<td class="layerright"><input  value="${result.value.zipCode }"name="corporation.zipCode" type="text" class="inputauto" /></td>
					</tr>
					<tr>
						<td class="layertdleft100">网址：</td>
						<td class="layerright"><input  value="${result.value.webSite }"name="corporation.webSite" type="text" class="inputauto" /></td>
						<td class="layertdleft100">办公电话：</td>
						<td class="layerright"><input  value="${result.value.officePhone }"name="corporation.officePhone" type="text" class="inputauto" /></td>
					</tr>
					<tr>
						<td class="layertdleft100">传真：</td>
						<td class="layerright"><input  value="${result.value.fax }"name="corporation.fax" type="text" class="inputauto" /></td>
						<td class="layertdleft100">E-Mail：</td>
						<td class="layerright"><input  value="${result.value.email }"name="corporation.email" type="text" class="inputauto" /></td>
						
					</tr>
					<tr>
						<td class="layertdleft100">法定代表人：</td>
						<td class="layerright"><input  value="${result.value.legalPerson }"name="corporation.legalPerson" type="text" class="inputauto" /></td>
						<td class="layertdleft100">股东：</td>
						<td class="layerright"><input  value="${result.value.shareholder }"name="corporation.shareholder" type="text" class="inputauto" /></td>
					</tr>
					<tr>
						<td class="layertdleft100">公司描述：</td>
						<td class="layerright" colspan="3" style="padding-top:2px;">
							<textarea name="corporation.description" style="height:60px;resize:none;" class="inputauto">${result.value.description }</textarea>
						</td>
					</tr>
				</table>
			</div>
			<div class="hackbox"></div>
		</div>
		<div class="buttondiv">
			<label><input name="Submit" type="submit" class="savebtn" value=""/></label>
			<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end()"/></label>
		</div>
	</div>
</form>
</body>
</html>