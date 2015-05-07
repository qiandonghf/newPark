<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
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
					"billPlanFacility.subjectId":"required",
					"billPlanFacility.planFee":{
						"required":true,
						"positivenumber":true
					},
					"billPlanFacility.realFee":{
						"required":true,
						"positivenumber":true
					},
					"billPlanFacility.startDate":"required",
					"billPlanFacility.endDate":"required",
					"billPlanFacility.planPayDate":"required"
				},
				messages: {
					"billPlanFacility.subjectId":"请选择宽带",
					"billPlanFacility.planFee":{
						"required":"请输入计划金额"
					},
					"billPlanFacility.realFee":{
						"required":"请输入实际金额"
					},
					"billPlanFacility.startDate":"请输入计费开始日期",
					"billPlanFacility.endDate":"请输入计费结束日期",
					"billPlanFacility.planPayDate":"请输入计划付费日期"
				},
				errorPlacement: function(error, element){
					showTip(error.html());
				},
				submitHandler: function(form){
					if($("#endDate").val()<$("#startDate").val()){
						showTip("计费开始日期不能小于计费结束日期",3000);
						return;
					}
					$(form).ajaxSubmit({
				        dataType: 'json',		        
				        success: function(data){
			        		showTip(data.result.msg,2000);
				        	if(data.result.success){
				        		setTimeout("getOpener().reloadBillPlanFacilityList();parent.fb.end();", 2000);
				        	}
				        } 
				    });
				}
			});
		}
	</script>
</head>

<body>
<form action="<%=basePath %>billPlanFacility!update.action" method="post" name="form1" id="form1">
<input id="id" name="billPlanFacility.id" type="hidden" value="${result.value.id}"/>
<div class="basediv">
	<div class="divlays" style="margin:0px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="layertdleft100"><span class="psred">*</span>宽带：</td>
				<td class="layerright">
					<select name="billPlanFacility.subjectId" onchange="$('#facilityId').val($('#facilityId'+this.value).val());">
						<option value="">----请选择----</option>
						<c:forEach items="${subjectNetworkList}" var="subjectNetwork">
							<option value="${subjectNetwork.id}" <c:if test="${result.value.subjectId eq subjectNetwork.id}">selected="selected"</c:if>>${subjectNetwork.facility.name}</option>
						</c:forEach>
					</select>
					<c:forEach items="${subjectNetworkList}" var="subjectNetwork">
						<input value="${subjectNetwork.facilityId}" type="hidden" id="facilityId${subjectNetwork.id}"/>
					</c:forEach>
				</td>
			</tr>
			<tr>
				<td class="layertdleft100">费用类型：</td>
				<td class="layerright">网络租用费</td>
			</tr>
			<tr>
				<td class="layertdleft100"><span class="psred">*</span>计划金额：</td>
				<td class="layerright">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="100"><input value="<fmt:formatNumber value="${result.value.planFee}" pattern="#0.00"/>" name="billPlanFacility.planFee" type="text" class="inputauto" /></td>
							<td>&nbsp; 元 本期设置优惠之前的金额 </td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="layertdleft100"><span class="psred">*</span>实际金额：</td>
				<td class="layerright">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="100"><input value="<fmt:formatNumber value="${result.value.realFee}" pattern="#0.00"/>" name="billPlanFacility.realFee" type="text" class="inputauto" /></td>
							<td>&nbsp; 元 本期实际需要支付的金额 </td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="layertdleft100"><span class="psred">*</span>计费日期：</td>
				<td class="layerright">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="100"><input value="<fmt:formatDate value="${result.value.startDate}" pattern="yyyy-MM-dd"/>" readonly="readonly" id="startDate" name="billPlanFacility.startDate" type="text" class="inputauto" onclick="showCalendar('startDate')"/></td>
							<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('startDate')"/></td>
							<td width="18">—</td>
							<td width="100" align="center"><input value="<fmt:formatDate value="${result.value.endDate}" pattern="yyyy-MM-dd"/>" readonly="readonly" id="endDate" name="billPlanFacility.endDate" type="text" class="inputauto" onclick="showCalendar('endDate')"/></td>
							<td width="20"><img style="position: relative;left:-1px;" src="core/common/images/timeico.gif" width="20" height="22" onclick="showCalendar('endDate')"/></td>
							<td align="center">&nbsp;</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="layertdleft100"><span class="psred">*</span>计划付费日期：</td>
				<td class="layerright">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="100"><input value="<fmt:formatDate value="${result.value.planPayDate}" pattern="yyyy-MM-dd"/>" readonly="readonly" id="planPayDate" name="billPlanFacility.planPayDate" type="text" class="inputauto" onclick="showCalendar('planPayDate')"/></td>
							<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('planPayDate')"/></td>
							<td>&nbsp;</td>
						</tr>
					</table>
				</td>
			</tr>
			<%-- <tr>
				<td class="layertdleft100">自动出帐：</td>
				<td class="layerright">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="80"><enum:radio checked="result.value.autoCheck" name="billPlanFacility.autoCheck" type="com.wiiy.commons.preferences.enums.BooleanEnum"/></td>
							<td> &nbsp; </td>
						</tr>
					</table>
				</td>
			</tr> --%>
			<%-- <tr>
				<td class="layertdleft100">状态：</td>
				<td class="layerright">
					<enum:select type="com.wiiy.crm.preferences.enums.BillPlanStatusEnum" checked="result.value.status" name="billPlanRent.status"/>
				</td>
			</tr> --%>
			<tr>
				<td class="layertdleft100">备注：</td>
				<td class="layerright"><textarea name="billPlanFacility.memo" class="textareaauto" style="height:50px;">${result.value.memo}</textarea></td>
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
