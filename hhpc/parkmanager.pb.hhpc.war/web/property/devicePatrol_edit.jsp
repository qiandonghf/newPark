<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
						"devicePatrol.operator":"required",
						"devicePatrol.operationDate":"required",
						"devicePatrol.operationTime":"required",
						"devicePatrol.inspector":"required",
						"devicePatrol.patrolResults":"required"
					},
					messages: {
						"devicePatrol.operator":"请输入操作人员",
						"devicePatrol.operationDate":"请选择巡检日期",
						"devicePatrol.operationTime":"请输入巡检时间",
						"devicePatrol.inspector":"请输入检查人",
						"devicePatrol.patrolResults":"请输入巡检结果"
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
					        		setTimeout("getOpener().reloadInitList('patrolList','devicePatrol');parent.fb.end();",2000);
					        	}
					        } 
					    });
					}
				});
			}
		</script>

	</head>

	<body>
		<form action="<%=basePath %>devicePatrol!update.action" method="post" name="form1" id="form1">
		<input type="hidden" value="${result.value.deviceId}" name="devicePatrol.deviceId"/>
		<input type="hidden" value="${result.value.id}" name="devicePatrol.id"/>
		<div class="basediv">
			<div class="divlays" style="margin: 0px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>巡检日期：</td>
						<td width="32%" class="layerright">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td><input id="operationDate" value='<fmt:formatDate value="${result.value.operationDate}" pattern="yyyy-MM-dd"/>' name="devicePatrol.operationDate" type="text" readonly="readonly" class="inputauto" onclick="showCalendar('operationDate');"/></td>
									<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('operationDate');"/></td>
								</tr>
							</table>
						</td>
						<td class="layertdleft100"><span class="psred">*</span>操作人员：</td>
						<td width="32%" class="layerright"><input name="devicePatrol.operator" value="${result.value.operator}" type="text" class="inputauto" /></td>
					</tr>
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>巡检时间：</td>
						<td class="layerright"><input name="devicePatrol.operationTime" value="${result.value.operationTime}" type="text" class="inputauto" /></td>
						<td class="layertdleft100"><span class="psred">*</span>检查人：</td>
						<td class="layerright"><input name="devicePatrol.inspector" value="${result.value.inspector}" type="text" class="inputauto" /></td>
					</tr>
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>检查结果：</td>
						<td colspan="3" class="layerright" style="padding-bottom:2px;">
							<textarea name="devicePatrol.patrolResults"  class="inputauto"  style="height:60px;resize: none;">${result.value.patrolResults}</textarea>
						</td>
					</tr>
					<tr>
						<td class="layertdleft100">备注：</td>
						<td colspan="3" class="layerright" style="padding-bottom:2px;">
							<textarea name="devicePatrol.memo"  class="inputauto"  style="height:60px;resize: none;">${result.value.memo}</textarea>
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

