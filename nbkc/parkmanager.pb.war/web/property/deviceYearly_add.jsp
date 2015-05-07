<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="<%=BaseAction.rootLocation %>/" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>无标题文档</title>
		
		<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
		<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
		<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
		
		<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.js"></script>
		<script type="text/javascript" src="core/common/js/tools.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
		<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
		<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
		<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
		<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
		<script type="text/javascript">
			$(function(){
				initTip();
				initForm();
			});
			
			/*
			让日期选择框向上居中
			*/
			function getCalendarScrollTop(){
				return $("#scrollDiv").scrollTop();
			}
			function initForm(){
				$("#form1").validate({
					rules: {
						"deviceYearly.operationDate":"required",
						"deviceYearly.unitName":"required",
						"deviceYearly.operator":"required",
						"deviceYearly.yearlyResults":"required"
					},
					messages: {
						"deviceYearly.operationDate":"请选择年检日期",
						"deviceYearly.unitName":"请输入年检单位",
						"deviceYearly.operator":"请输入操作人员",
						"deviceYearly.yearlyResults":"请输入年检结果"
					},
					errorPlacement: function(error, element){
						showTip(error.html());
					},
					submitHandler: function(form){
						$(form).ajaxSubmit({
					        dataType: 'json',		        
					        success: function(data){
				        		showTip(data.result.msg,2000);
					        	if(data.result.success){
					        		setTimeout("getOpener().reloadInitList('yearlyList','deviceYearly');parent.fb.end();",2000);
					        	}
					        } 
					    });
					}
				});
			}
		</script>

	</head>

	<body>
		<form action="<%=basePath %>deviceYearly!save.action" method="post" name="form1" id="form1">
		<input type="hidden" value="${param.deviceId}" name="deviceYearly.deviceId"/>
		<div class="basediv">
			<div class="divlays" style="margin: 0px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>年检日期：</td>
						<td width="21%" class="layerright">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td><input id="operationDate" name="deviceYearly.operationDate" type="text" readonly="readonly" class="inputauto" onclick="showCalendar('operationDate');"/></td>
									<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('operationDate');"/></td>
								</tr>
							</table>
						</td>
						<td class="layertdleft100"><span class="psred">*</span>年检单位：</td>
						<td width="21%" class="layerright"><input name="deviceYearly.unitName" value="${result.value.unitName}" type="text" class="inputauto" /></td>
						<td class="layertdleft100"><span class="psred">*</span>操作人员：</td>
						<td width="21%" class="layerright"><input name="deviceYearly.operator" value="${result.value.operator}" type="text" class="inputauto" /></td>
					</tr>
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>年检结果：</td>
						<td colspan="5" class="layerright" style="padding-bottom:2px;">
							<textarea name="deviceYearly.yearlyResults"  class="inputauto"  style="height:80px;resize: none;">${result.value.yearlyResults}</textarea>
						</td>
					</tr>
					<tr>
						<td class="layertdleft100">备注：</td>
						<td colspan="5" class="layerright" style="padding-bottom:2px;">
							<textarea name="deviceYearly.memo"  class="inputauto"  style="height:80px;resize: none;">${result.value.memo}</textarea>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="buttondiv">
			<label><input name="Submit" type="submit" class="savebtn" value="" /></label>
			<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();" /></label>
		</div>
		</form>
	</body>
</html>

