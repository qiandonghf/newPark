<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
					var rent = getMap();
					rent.put("facilityId",$("#facilityId").val());
					rent.put("startDate",$("#startDate").val());
					rent.put("endDate",$("#endDate").val());
					rent.put("planPayDate",$("#planPayDate").val());
					rent.put("planFee",$("#planFee").val());
					rent.put("realFee",$("#realFee").val());
					rent.put("memo",$("#memo").val());
					getOpener().appendPlan(rent);
					parent.fb.end();
				}
			});
		}
	</script>
</head>

<body>
<form action="<%=basePath %>billPlanFacility!save.action" method="post" name="form1" id="form1">
<input id="facilityId" name="billPlanFacility.facilityId" type="hidden"/>
<div class="basediv">
	<div class="divlays" style="margin:0px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="layertdleft100"><span class="psred">*</span>宽带：</td>
				<td class="layerright">
					<select name="billPlanFacility.subjectId" onchange="$('#facilityId').val($('#facilityId'+this.value).val());">
						<option value="">----请选择----</option>
						<c:forEach items="${facilityList}" var="facility">
							<option value="${facility.id}">${facility.name}</option>
						</c:forEach>
						<c:forEach items="${facilityList}" var="facility">
							<input value="${facility.id}" type="hidden" id="facilityId${facility.id}"/>
							<input value="${facility.price}元(${facility.checkType.title})" type="hidden" id="price${facility.id}"/>
						</c:forEach>
					</select>
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
							<td width="100"><input id="planFee" name="billPlanFacility.planFee" type="text" class="inputauto" /></td>
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
							<td width="100"><input id="realFee" name="billPlanFacility.realFee" type="text" class="inputauto" /></td>
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
							<td width="100"><input readonly="readonly" id="startDate" value="${param.startDate }" name="billPlanFacility.startDate" type="text" class="inputauto" onclick="showCalendar('startDate')"/></td>
							<td width="20"><img src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="showCalendar('startDate')"/></td>
							<td width="18">—</td>
							<td width="100" align="center"><input readonly="readonly" id="endDate" value="${param.endDate }" name="billPlanFacility.endDate" type="text" class="inputauto" onclick="showCalendar('endDate')"/></td>
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
							<td width="100"><input readonly="readonly" id="planPayDate" value="${param.startDate }" name="billPlanFacility.planPayDate" type="text" class="inputauto" onclick="showCalendar('planPayDate')"/></td>
							<td width="20"><img src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="showCalendar('planPayDate')"/></td>
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
							<td width="80"><enum:radio name="billPlanFacility.autoCheck" type="com.wiiy.commons.preferences.enums.BooleanEnum"/></td>
							<td> &nbsp; </td>
						</tr>
					</table>
				</td>
			</tr> --%>
			<%-- <tr>
				<td class="layertdleft100">状态：</td>
				<td class="layerright">
					<enum:select type="com.wiiy.crm.preferences.enums.BillPlanStatusEnum" name="billPlanFacility.status"/>
				</td>
			</tr> --%>
			<tr>
				<td class="layertdleft100">备注：</td>
				<td class="layerright"><textarea id="memo" name="billPlanFacility.memo" class="textareaauto" style="height:50px;"></textarea></td>
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
