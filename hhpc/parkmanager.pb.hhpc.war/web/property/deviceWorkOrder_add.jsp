<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
						"deviceWorkOrder.startDate":"required",
						"deviceWorkOrder.repairParts":"required",
						"deviceWorkOrder.endDate":"required",
						"deviceWorkOrder.repairStaff":"required",
						"deviceWorkOrder.head":"required",
						"deviceWorkOrder.repairContent":"required"
					},
					messages: {
						"deviceWorkOrder.startDate":"请选择开始日期",
						"deviceWorkOrder.repairParts":"请输入维修部位",
						"deviceWorkOrder.endDate":"请选择结束日期",
						"deviceWorkOrder.repairStaff":"请输入维修人员",
						"deviceWorkOrder.head":"请输入维修负责人",
						"deviceWorkOrder.repairContent":"请输入维修内容"
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
					        		setTimeout("getOpener().reloadInitList('deviceWorkOrderList','deviceWorkOrder');parent.fb.end();",2000);
					        	}
					        } 
					    });
					}
				});
			}
		</script>

	</head>

	<body>
		<form action="<%=basePath %>deviceWorkOrder!save.action" method="post" name="form1" id="form1">
		<input type="hidden" value="${param.deviceId}" name="deviceWorkOrder.deviceId"/>
		<div class="basediv">
			<div class="divlays" style="margin: 0px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>开始日期：</td>
						<td width="32%" class="layerright">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td><input id="startDate" name="deviceWorkOrder.startDate" type="text" readonly="readonly" class="inputauto" onclick="showCalendar('startDate');"/></td>
									<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('startDate');"/></td>
								</tr>
							</table>
						</td>
						<td class="layertdleft100"><span class="psred">*</span>维修部位：</td>
						<td width="32%" class="layerright"><input name="deviceWorkOrder.repairParts" type="text" class="inputauto" /></td>
					</tr>
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>结束日期：</td>
						<td class="layerright">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td><input id="endDate" name="deviceWorkOrder.endDate" type="text" readonly="readonly" class="inputauto" onclick="showCalendar('endDate');"/></td>
									<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('endDate');"/></td>
								</tr>
							</table>
						</td>
						<td class="layertdleft100"><span class="psred">*</span>维修人员：</td>
						<td class="layerright"><input name="deviceWorkOrder.repairStaff" type="text" class="inputauto" /></td>
					</tr>
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>维修负责人：</td>
						<td class="layerright"><input name="deviceWorkOrder.head" type="text" class="inputauto" /></td>
						<td class="layertdleft100"><span class="psred"></span>制单人：</td>
						<td class="layerright"><input name="deviceWorkOrder.tabulator" type="text" class="inputauto" /></td>
					</tr>
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>维修内容：</td>
						<td colspan="3" class="layerright" style="padding-bottom:2px;">
							<textarea name="deviceWorkOrder.repairContent"  class="inputauto"  style="height:40px;resize: none;"></textarea>
						</td>
					</tr>
					<tr>
						<td class="layertdleft100">更换部件：</td>
						<td colspan="3" class="layerright" style="padding-bottom:2px;">
							<textarea name="deviceWorkOrder.repairComponents"  class="inputauto"  style="height:40px;resize: none;"></textarea>
						</td>
					</tr>
					<tr>
						<td class="layertdleft100">备注：</td>
						<td colspan="3" class="layerright" style="padding-bottom:2px;">
							<textarea name="deviceWorkOrder.memo"  class="inputauto"  style="height:40px;resize: none;"></textarea>
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

