<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"%>
<%@taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
						"customerRiskCapital.time":"required",
						"customerRiskCapital.money":"required"
					},
					messages: {
						"customerRiskCapital.time":"请输入日期",
						"customerRiskCapital.money":"请输入金额"
					},
					errorPlacement: function(error, element){
						showTip(error.html());
					},
					submitHandler: function(form){
						if(check()){
							$(form).ajaxSubmit({
						        dataType: 'json',		        
						        success: function(data){
					        		showTip(data.result.msg,2000);
						        	if(data.result.success){
						        		setTimeout("getOpener().reloadRiskCapitalList();parent.fb.end();",2000);
						        	}
						        } 
						    });
						}
					}
				});
			}
			
			function check(){
				var risk = $("input[name='customerRiskCapital.money']").val().replace(/[^\d]/g,'');
				var typeId = $("select[name='customerRiskCapital.currencyTypeId']").val();
				if(risk != ''){
					if(typeId == ''){
						$("select[name='customerRiskCapital.currencyTypeId']").focus();
						showTip("请选择币种",2000);
						return false;
					}
				}
				return true;
			}
		</script>
	<style>
		table{
			table-layout:fixed;
		}
	</style>
	</head>
	
	<body>
		<form action="<%=basePath %>customerRiskCapital!update.action" method="post" name="form1" id="form1">
			<input type="hidden" value="${result.value.customer.id}" name="customerRiskCapital.customerId"/>
			<input type="hidden" value="${result.value.id}" name="customerRiskCapital.id"/>
			<div class="basediv">
			<div class="divlays" style="margin:0px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="layertdleft100">企业：</td>
						<td class="layerright">${result.value.customer.name}</td>
						<td class="layertdleft100"><span class="psred">*</span>日期：</td>
						<td class="layerright">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td><input id="time" name="customerRiskCapital.time" value='<fmt:formatDate value="${result.value.time }" pattern="yyyy-MM-dd" />' onclick="showCalendar('time');" readonly="readonly" class="inputauto" /></td>
									<td width="30"><img src="core/common/images/timeico.gif" width="20" height="22" onclick="showCalendar('time');"/></td>
								</tr>
							</table> 
						</td>
					</tr>
					<tr>
						<td class="layertdleft100"><span class="psred">*</span>金额：</td>
						<td class="layerright">
							<input name="customerRiskCapital.money" value="${result.value.money }" type="text" class="inputauto" style="width:45px;"/> 万元 <dd:select name="customerRiskCapital.currencyTypeId" checked="result.value.currencyTypeId" key="crm.0005"/>
						</td>
						<td class="layertdleft100"><span class="psred">*</span>机构名称：</td>
						<td class="layerright"><input name="customerRiskCapital.orgName" value="${result.value.orgName }" class="inputauto"/></td>
					</tr>
					<tr>
						<td class="layertdleft100">备注：</td>
						<td class="layerright" colspan="3"><textarea name="customerRiskCapital.memo" style="resize:none;height:80px;" class="inputauto">${result.value.memo }</textarea></td>
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

