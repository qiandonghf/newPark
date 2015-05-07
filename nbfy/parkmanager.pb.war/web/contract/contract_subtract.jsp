<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
	<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui.css"/>
	<link rel="stylesheet" type="text/css" href="core/common/style/jquery-ui-1.8.2.custom.css" />
	<link rel="stylesheet" type="text/css" href="core/common/style/ui.jqgrid.css" />
	<link rel="stylesheet" type="text/css" href="core/common/style/ui.multiselect.css" />
	<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
	<script type="text/javascript" src="core/common/js/tools.js"></script>
	<script type="text/javascript" src="core/common/js/jquery.js"></script>
	<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
	<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
	<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
	<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
	<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
	<script type="text/javascript" src="core/common/js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="core/common/js/ui.multiselect.js"></script>
	<script type="text/javascript" src="core/common/js/grid.locale-cn.js"></script>
	<script type="text/javascript" src="core/common/js/jquery.jqGrid.min.js"></script>
	<script type="text/javascript">
		$(function(){
			initTip();
			initForm();
		});
		function setSelectedContect(contect){
			$("#contectName").val(contect.name);
			$("#contectId").val(contect.id);
		}
		function setSelectedCustomer(customer){
			$("#customerId").val(customer.id);
			$("#customerName").val(customer.name);
		}
		function selectContect(){
			if($("#customerId").val()!=''){
				fbStart('选择负责人','<%=basePath %>contect!select.action?id='+$("#customerId").val(),360,400);
			} else {
				showTip("请先选择企业");
			}
		}
		function generateCode(){
			$.post("<%=basePath%>contract!generateCode.action",function(data){
				if(data.result.success){
					$("#contractNo").val(data.result.value);
				}
			});
		}
		function initForm(){
			$("#form1").validate({
				rules: {
					"subjectRentId":"required",
					"money":{
						"required":true,
						"positivenumber":true
					},
					"executeTime":"required",
					"memo":"required"
				},
				messages: {
					"subjectRentId":"请选择减租源",
					"money":{
						"required":"请输入退款金额"
					},
					"executeTime":"请选择生效日期",
					"memo":"请输入减租说明"
				},
				errorPlacement: function(error, element){
					showTip(error.html());
				},
				submitHandler: function(form){
					$(form).ajaxSubmit({
				        dataType: 'json',		        
				        success: function(data){
			        		showTip(data.result.msg,2000);
				        	setTimeout("getOpener().location.reload();parent.fb.end();",1000);
				        } 
				    });
				}
			});
		}
		function reloadSubjectRentList(){
			$("#subjectRentList").trigger("reloadGrid");
		}
	</script>
</head>
<body>
<form action="<%=basePath %>contract!submitSubtract.action" method="post" name="form1" id="form1">
	<input type="hidden" value="${result.value.id}" name="id"/>
	<div class="basediv">
		<div class="divlays" style="margin:0px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100">企业名称：</td>
					<td class="layerright"><label>${result.value.customer.name}</label></td>
				<tr>
				</tr>
					<td class="layertdleft100">合同编号：</td>
					<td class="layerright">${result.value.contractNo}</td>
				</tr>
				<tr>
					<td class="layertdleft100">减租源：</td>
					<td class="layerright">
						<select id="subjectRentId" name="subjectRentId">
							<option value="">----请选择----</option>
							<c:forEach items="${subjectRentList}" var="subjectRent">
								<option value="${subjectRent.id}">${subjectRent.roomName}</option>
							</c:forEach>
						</select>
					</td>
				<tr>
				<tr>
					<td class="layertdleft100">退款金额：</td>
					<td class="layerright">
					<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td>
						<input name="money" class="inputauto"/></td><td>&nbsp;&nbsp;立即出账</td><td><input name="checkoutnow" value="true" type="checkbox"/>
					</td></tr></table>
					</td>
				<tr>
				</tr>
					<td class="layertdleft100">生效日期：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><input id="executeTime" readonly="readonly" name="executeTime" type="text" class="inputauto" onclick="showCalendar('executeTime')"/></td>
								<td width="20"><img src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="showCalendar('executeTime')"/></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">备忘：</td>
					<td class="layerright"><textarea name="memo" rows="5" class="textareaauto"></textarea></td>
				</tr>
			</table>
		</div>
		<div class="hackbox"></div>
	</div>
	<div class="buttondiv">
		<label><input name="Submit" type="submit" class="savebtn" value="" /></label>
		<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
	</div>
</form>
</body>
</html>
