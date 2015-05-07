<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
						"investmentDirector.name":"required",
						"investmentDirector.mobile":"required",
						"investmentDirector.phone":"required"
					},
					messages: {
						"investmentDirector.name":"请输入负责人姓名",
						"investmentDirector.mobile":"请输入手机号码",
						"investmentDirector.phone":"请输入联系电话"
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
					        		setTimeout("getOpener().reloadInvestmentDirectorList();parent.fb.end();",2000);
					        	}
					        } 
					    });
					}
				});
			}
		</script>

	</head>

	<body>
		<form action="<%=basePath %>investmentDirector!update.action" method="post" name="form1" id="form1">
		<input type="hidden" value="${param.investmentId}" name="investmentDirector.investmentId"/>
		<input type="hidden" value="${result.value.id}" name="investmentDirector.id"/>
		<div class="basediv">
			<div class="divlays" style="margin: 0px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>姓名:</td>
						<td class="layerright"><input name="investmentDirector.name" type="text" class="inputauto" value="${result.value.name}"/></td>
					</tr>
					
					<tr>
						<td class="layertdleft100">学历:</td>
						<td class="layerright"><dd:select key="crm.0015" name="investmentDirector.degreeId" checked="result.value.degreeId"/></td>
					</tr>
					
					<tr>
						<td class="layertdleft100">专业:</td>
						<td class="layerright"><input name="investmentDirector.specialty" type="text" class="inputauto" value="${result.value.specialty}" /></td>
					</tr>
					<tr>
						<td class="layertdleft100">学位/职称:</td>
						<td class="layerright"><input name="investmentDirector.profession" type="text" class="inputauto" value="${result.value.profession}" /></td>
					</tr>
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>手机:</td>
						<td class="layerright"><input name="investmentDirector.mobile" type="text" class="inputauto" value="${result.value.mobile}"/></td>
					</tr>
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>联系电话:</td>
						<td class="layerright"><input name="investmentDirector.phone" type="text" class="inputauto" value="${result.value.phone}"/></td>
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