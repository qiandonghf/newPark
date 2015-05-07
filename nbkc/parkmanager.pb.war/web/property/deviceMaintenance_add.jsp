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
						"deviceMaintenance.number":"required",
						"deviceMaintenance.plan":"required",
						"deviceMaintenance.maintenanceTime":"required",
						"deviceMaintenance.maintenanceEffect":"required",
						"deviceMaintenance.content":"required"
					},
					messages: {
						"deviceMaintenance.number":"请输入档案编号",
						"deviceMaintenance.plan":"请输入检查项目",
						"deviceMaintenance.maintenanceTime":"请选择维护日期",
						"deviceMaintenance.maintenanceEffect":"请输入维护效果",
						"deviceMaintenance.content":"请输入维护过程"
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
					        		setTimeout("getOpener().reloadInitList('maintenanceList','deviceMaintenance');parent.fb.end();",2000);
					        	}
					        } 
					    });
					}
				});
			}
		</script>

	</head>

	<body>
		<form action="<%=basePath %>deviceMaintenance!save.action" method="post" name="form1" id="form1">
		<input type="hidden" value="${param.deviceId}" name="deviceMaintenance.deviceId"/>
		<div class="basediv">
			<div class="divlays" style="margin: 0px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="layertdleft100">上次保养时间：</td>
						<td width="32%" class="layerright">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td><input id="lastTime" name="deviceMaintenance.lastTime" type="text" readonly="readonly" class="inputauto" onclick="showCalendar('lastTime');"/></td>
									<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('lastTime');"/></td>
								</tr>
							</table>
						</td>
						<td class="layertdleft100"><span class="psred">*</span>档案编号：</td>
						<td width="32%" class="layerright"><input name="deviceMaintenance.number" type="text" class="inputauto" /></td>
					</tr>
					<tr>
						<td class="layertdleft100">计划保养时间：</td>
						<td class="layerright">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td><input id="planTime" name="deviceMaintenance.planTime" type="text" readonly="readonly" class="inputauto" onclick="showCalendar('planTime');"/></td>
									<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('planTime');"/></td>
								</tr>
							</table>
						</td>
						<td class="layertdleft100"><span class="psred">*</span>检查项目：</td>
						<td class="layerright"><input name="deviceMaintenance.plan" type="text" class="inputauto" /></td>
					</tr>
					<tr>
						<td class="layertdleft100">维护工时：</td>
						<td class="layerright"><input name="deviceMaintenance.manHour" type="text" class="inputauto" /></td>
						<td class="layertdleft100">维护方式：</td>
						<td class="layerright"><input name="deviceMaintenance.maintenanceMode" type="text" class="inputauto" /></td>
					</tr>
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>本次维护日期：</td>
						<td class="layerright">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td><input id="maintenanceTime" name="deviceMaintenance.maintenanceTime" name="deviceMaintenance.planTime" type="text" readonly="readonly" class="inputauto" onclick="showCalendar('maintenanceTime');"/></td>
									<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('maintenanceTime');"/></td>
								</tr>
							</table>
						</td>
						<td class="layertdleft100">维护人：</td>
						<td class="layerright"><input name="deviceMaintenance.maintenanceMan" type="text" class="inputauto" /></td>
					</tr>
					<tr>
						<td class="layertdleft100">维护过程：</td>
						<td colspan="3" class="layerright" style="padding-bottom:2px;">
							<textarea name="deviceMaintenance.process"  class="inputauto"  style="height:40px;resize: none;"></textarea>
						</td>
					</tr>
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>维护效果：</td>
						<td colspan="3" class="layerright" style="padding-bottom:2px;">
							<textarea name="deviceMaintenance.maintenanceEffect"  class="inputauto"  style="height:40px;resize: none;"></textarea>
						</td>
					</tr>
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>维护内容：</td>
						<td colspan="3" class="layerright" style="padding-bottom:2px;">
							<textarea name="deviceMaintenance.content"  class="inputauto"  style="height:40px;resize: none;"></textarea>
						</td>
					</tr>
					<tr>
						<td class="layertdleft100">备注：</td>
						<td colspan="3" class="layerright" style="padding-bottom:2px;">
							<textarea name="deviceMaintenance.memo"  class="inputauto"  style="height:40px;resize: none;"></textarea>
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

