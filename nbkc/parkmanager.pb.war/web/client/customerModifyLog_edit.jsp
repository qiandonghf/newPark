<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
			function initForm(){
				$("#form1").validate({
					rules: {
						"customerModifyLog.modifyLogTime":"required",
						"customerModifyLog.content":"required"
					},
					messages: {
						"customerModifyLog.modifyLogTime":"请输入时间",
						"customerModifyLog.content":"请输入内容"
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
					        		setTimeout("getOpener().reloadModifyLogList();parent.fb.end();",2000);
					        	}
					        } 
					    });
					}
				});
			}
		</script>

	</head>

	<body>
		<form action="<%=basePath %>customerModifyLog!update.action" method="post" name="form1" id="form1">
			<input type="hidden" value="${result.value.id}" name="customerModifyLog.id"/>
			<div class="basediv">
			<div class="divlays" style="margin:0px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>企业：</td>
						<td class="layerright">${result.value.customer.name}</td>
					</tr>
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>变更日期：</td>
						<td class="layerright">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="200"><input id="linkTime" value="<fmt:formatDate value="${result.value.modifyLogTime}" pattern="yyyy-MM-dd"/>" name="customerModifyLog.modifyLogTime" type="text" class="inputauto" onclick="return showCalendar('linkTime')"/></td>
									<td width="20"><img style="position: relative;left:-1px;"  src="core/common/images/timeico.gif" width="20" height="22" onclick="return showCalendar('linkTime')"/></td>
									<td align="center">&nbsp;</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>变更内容：</td>
						<td class="layerright"><textarea name="customerModifyLog.content" style="height:150px;" class="textareaauto">${result.value.content}</textarea></td>
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

