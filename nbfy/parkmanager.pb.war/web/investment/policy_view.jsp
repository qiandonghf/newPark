<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"%>
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
			function initForm(){
				$("#form1").validate({
					rules: {
						"policy.content":"required"
					},
					messages: {
						"policy.content":"请输入内容"
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
					        		setTimeout("parent.refresh();parent.fb.end();",2000);
					        	}
					        } 
					    });
					}
				});
			}
			function setSelectedUser(user){
				$("#username").val(user.realName);
				$("#userId").val(user.id);
			}
			function setSelectedInvestment(investment){
				$("#investmentName").val(investment.name);
				$("#investmentId").val(investment.id);
			}
		</script>

	</head>

	<body>
		<form action="<%=basePath %>policy!update.action" method="post" name="form1" id="form1">
			<input type="hidden" value="${result.value.id}" name="policy.id"/>
			<div class="basediv">
			<div class="divlays" style="margin:0px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="layertdleft100">年度：</td>
						<td class="layerright">${result.value.year}&nbsp;年
						</td>
					</tr>
					<tr>
						<td class="layertdleft100">类型：</td>
						<td class="layerright">${result.value.type.dataValue}</td>
					</tr>
					<tr>
						<td class="layertdleft100">启用：</td>
						<td class="layerright">${result.value.usable.title}</td>
					</tr>
					<tr>
						<td class="layertdleft100">内容：</td>
						<td class="layerright">
							<div style="height: 90px;overflow-y: auto; overflow-x: hidden;word-break:break-all; word-wrap:break-word;">${result.value.content}</div></td>
					</tr>
					<tr>
						<td class="layertdleft100">备注：</td>
						<td class="layerright">
							<div style="height: 90px;overflow-y: auto; overflow-x: hidden;word-break:break-all; word-wrap:break-word;">${result.value.memo}</div></td>
					</tr>
				</table>
			</div>
			<div class="hackbox"></div>
		</div>
		<div style="height: 5px;"></div>
	</form>
	</body>
</html>

