<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
						<td class="layertdleft100"><span class="psred">*</span>年度：</td>
						<td class="layerright">
							<select name="policy.year">
								<c:forEach begin="2010" end="2020" var="s">
								<option value="${s}" <c:if test="${result.value.year eq s}">selected="selected"</c:if>>${s}</option>
								</c:forEach>
							</select>&nbsp;年
						</td>
					</tr>
					<tr>
						<td class="layertdleft100">类型：</td>
						<td class="layerright"><dd:select checked="result.value.typeId" id="typeId" name="policy.typeId" key="crm.0022"/></td>
					</tr>
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>启用：</td>
						<td class="layerright"><enum:radio checked="result.value.usable" name="policy.usable" type="com.wiiy.commons.preferences.enums.BooleanEnum"/></td>
					</tr>
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>内容：</td>
						<td class="layerright"><textarea name="policy.content" style="height:100px;" class="textareaauto">${result.value.content}</textarea></td>
					</tr>
					<tr>
						<td class="layertdleft100">备注：</td>
						<td class="layerright"><textarea name="policy.memo" style="height:100px;" class="textareaauto">${result.value.memo}</textarea></td>
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

