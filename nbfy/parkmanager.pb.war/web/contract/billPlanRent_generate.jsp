<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript">
	$(function(){
		initTip();
		initForm();
		$("#feeType").change(function(){
			var id = $(this).val();
			$(".price").hide();
			$("#"+id).show();
		});
	});
	function initForm(){
		$("#form1").validate({
			rules: {
				"feeType":"required",
				"rentBillPlan":"required",
				"billingMethod":"required",
				"startDate":"required",
				"endDate":"required"
			},
			messages: {
				"feeType":"请选择费用项",
				"rentBillPlan":"请选择结算方式",
				"billingMethod":"请选择计费方式",
				"startDate":"请输入租用开始日期",
				"endDate":"请输入租用结束日期"
			},
			errorPlacement: function(error, element){
				showTip(error.html());
			},
			submitHandler: function(form){
				if($("#endDate").val()<$("#startDate").val()){
					showTip("租用开始日期不能小于租用结束日期",3000);
					return false;
				}
				form.submit();
			}
		});
	}
</script>
</head>
 
<body>
<form action="<%=basePath %>billPlanRent!autoGenerate.action" method="post" name="form1" id="form1">
	<input type="hidden" value="${result.value.id}" name="id"/>
	<div class="basediv">
		<div class="divlays" style="margin:0px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100">租用地址：</td>
					<td class="layerright">${result.value.roomName}</td>
				</tr>
				<tr>
					<td class="layertdleft100">租用面积：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100">${result.value.roomArea} <input type="hidden" name="roomArea" value="${result.value.roomArea}"/>&nbsp;平方米</span></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>费用项：</td>
					<td class="layerright"><enum:select id="feeType" type="com.wiiy.crm.preferences.enums.RentBillPlanFeeEnum" name="feeType"/></td>
				</tr>
				<tr>
					<td class="layertdleft100">单位价格：</td>
					<td class="layerright">
						<span class="price" style="display: none;" id="RENT">${result.value.rentPrice}&nbsp;&nbsp;${result.value.rentPriceUnit.title}</span><span class="price" style="display: none;" id="MANAGE">${result.value.managePrice}&nbsp;&nbsp;${result.value.managePriceUnit.title}</span>
						<input type="hidden" value="${result.value.rentPrice}" name="rentPrice"/>
						<input type="hidden" value="${result.value.rentPriceUnit}" name="rentPriceUnit"/>
						<input type="hidden" value="${result.value.managePrice}" name="managePrice"/>
						<input type="hidden" value="${result.value.managePriceUnit}" name="managePriceUnit"/>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>结算方式：</td>
					<td class="layerright"><enum:select type="com.wiiy.crm.preferences.enums.RentBillPlanEnum" name="rentBillPlan"/></td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>计费方式：</td>
					<td class="layerright"><enum:select type="com.wiiy.crm.preferences.enums.BillingMethodEnum" name="billingMethod"/></td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>租用日期：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100"><input id="startDate" name="startDate" type="text" class="inputauto" onclick="showCalendar('startDate')"/></td>
								<td width="20"><img src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="showCalendar('startDate')"/></td>
								<td width="18">—</td>
								<td width="100" align="center"><input id="endDate" name="endDate" type="text" class="inputauto" onclick="showCalendar('endDate')"/></td>
								<td width="20"><img style="position: relative;left:-1px;" src="core/common/images/timeico.gif" width="20" height="22" onclick="showCalendar('endDate')"/></td>
								<td align="center">&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">备注：</td>
					<td class="layerright"><textarea name="memo" rows="5" class="textareaauto"></textarea></td>
				</tr>
			</table>
		</div>
		<div class="hackbox"></div>
	</div>
	<div class="buttondiv">
		<label><input name="Submit" type="submit" class="rightbtn" value="" /></label>
		<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
	</div>
</form>
</body>
</html>

