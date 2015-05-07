<%@page import="com.wiiy.commons.action.BaseAction"%>
<%@page import="com.wiiy.commons.util.DateUtil"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
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
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css"/>


<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />

<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript">
	$(function(){
		initTip();
		$("#amount").focus();
	});
	function calculateRemain(){
		if($("#totalAmount").val()-$("#amount").val()<0){
			showTip("拆分金额不能大于原始金额");
		} else {
			$("#remain").html($("#totalAmount").val()-$("#amount").val());
		}
	}
	function toSubmit(){
		if($("#amount").val()){
			$.post("<%=basePath%>bill!apart.action",{id:$("#id").val(),amount:$("#amount").val()},function(data){
				showTip(data.result.msg,2000);
				if(data.result.success){
					setTimeout("getOpener().reloadList();parent.fb.end();", 2000);
				}
			});
		} else {
			showTip("请输入拆分金额");
			setTimeout("$(\"#amount\").focus();", 2000);
		}
	}
</script>
</head>

<body>
<input type="hidden" value="${param.id}" id="id"/>
<input type="hidden" value="${param.totalAmount}" id="totalAmount"/>
<div class="basediv">
	<div class="divlays" style="margin:0px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="layertdleft100">拆分金额：</td>
				<td class="layerright">${param.totalAmount}</td>
			</tr>
			<tr>
				<td class="layertdleft100">被拆分金额：</td>
				<td class="layerright"><input id="amount" type="text" class="input100" value="" onkeyup="value=value.replace(/[^\d\.]/g,'');calculateRemain()"/></td>
			</tr>
			<tr>
				<td class="layertdleft100">剩余金额：</td>
				<td class="layerright"><span id="remain">${param.totalAmount}</span></td>
			</tr>
		</table>
	</div>
	<div class="hackbox"></div>
</div>
<div class="buttondiv">
	<label><input name="Submit" type="button" class="savebtn" value="" onclick="toSubmit()"/></label>
	<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
</div>
</body>
</html>
