<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
	<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
	<script type="text/javascript" src="core/common/js/tools.js"></script>
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
					"subjectRent.roomName":"required",
					"subjectRent.startDate":"required",
					"subjectRent.endDate":"required",
					"subjectRent.roomArea":{
						"required":true,
						"positivenumber":true
					},
					"subjectRent.rentPrice":{
						"required":true,
						"positivenumber":true
					},
					"subjectRent.rentPriceUnit":"required"
					/* "subjectRent.managePrice":{
						"required":true,
						"positivenumber":true
					},
					"subjectRent.managePriceUnit":"required" */
				},
				messages: {
					"subjectRent.roomName":"请选择房间",
					"subjectRent.startDate":"请选择租用开始日期",
					"subjectRent.endDate":"请选择租用结束日期",
					"subjectRent.roomArea":{
						"required":"请输入租用面积"
					},
					"subjectRent.rentPrice":{
						"required":"请输入房间单价"
					},
					"subjectRent.rentPriceUnit":"请输入房间单价单位"
					/* "subjectRent.managePrice":{
						"required":"请输入物管单价"
					},
					"subjectRent.managePriceUnit":"请输入物管单价单位" */
				},
				errorPlacement: function(error, element){
					showTip(error.html());
				},
				submitHandler: function(form){
					if($("#endDate").val()<$("#startDate").val()){
						showTip("租用开始日期不能小于租用结束日期",3000);
						return;
					}
					if($(".rebate:checked").val()=='YES'){
						if(!checkSelect("rebateRuleId","优惠规则")){
							return;
						}
					}
					$(form).ajaxSubmit({
				        dataType: 'json',		        
				        success: function(data){
			        		showTip(data.result.msg,2000);
				        	if(data.result.success){
				        		setTimeout("getOpener().reloadSubjectRentList();parent.fb.end();", 2000);
				        	}
				        } 
				    });
				}
			});
		}
		function setSelectedRoom(room){
			if(room["kind.dataValue"]!='出租' || room["status.title"]!='空闲'){
				if(!confirm("该房间状态不是空闲 或 性质不是出租 是否继续")){
					return false;
				}
			}
			$("#roomId").val(room.id);
			$("#buildingArea").val(room.buildingArea);
			$("#roomName").val(room["building.park.name"]+room["building.name"]+" "+room.name);
		}
	</script>
</head>

<body>
<form action="<%=basePath %>subjectRent!update.action" method="post" name="form1" id="form1">
	<input type="hidden" value="${result.value.id}" name="subjectRent.id"/>
	<input type="hidden" id="saveFlag" value="${saveFlag}" name="saveFlag"/>
	<div class="basediv">
		<div class="divlays" style="margin:0px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>租用地址：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="350"><input id="roomName" value="${result.value.roomName}" name="subjectRent.roomName" type="text" class="inputauto" readonly="readonly" /><input value="${result.value.roomId}" id="roomId" name="subjectRent.roomId" type="hidden"/><input id="buildingArea" name="subjectRent.room.buildingArea" type="hidden"/></td>
								<td><img src="core/common/images/outdiv.gif" style="position:relative;left:-4px;" width="20" height="22" onclick="fbStart('房间选择','<%=BaseAction.rootLocation %>/parkmanager.pb/room!select.action',520,400);" style=" cursor:pointer;"/></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>租用日期：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="110"><input readonly="readonly" value="<fmt:formatDate value="${result.value.startDate}" pattern="yyyy-MM-dd"/>" id="startDate" name="subjectRent.startDate" type="text" class="inputauto" onclick="return showCalendar('startDate')"/></td>
								<td><img src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="return showCalendar('startDate')"/></td>
								<td><span style="padding-left:4px;">—</span></td>
								<td width="111"><input readonly="readonly" value="<fmt:formatDate value="${result.value.endDate}" pattern="yyyy-MM-dd"/>" id="endDate" name="subjectRent.endDate" type="text" class="inputauto" onclick="return showCalendar('endDate')"/></td>
								<td><img style="position: relative;left:-1px;" src="core/common/images/timeico.gif" width="20" height="22" onclick="return showCalendar('endDate')"/></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>租用面积：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100"><input id="roomArea" name="subjectRent.roomArea" value="<fmt:formatNumber value="${result.value.roomArea}" pattern="#0.00"/>" class="inputauto"/></td>
								<td>&nbsp; 平方米</td>
								<td>&nbsp;</td>
                			</tr>
               			</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>租金单价：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100"><input id="rentPrice" value="<fmt:formatNumber value="${result.value.rentPrice}" pattern="#0.00"/>" name="subjectRent.rentPrice" type="text" class="inputauto" /></td>
								<td> &nbsp;&nbsp;<enum:select id="rentPriceUnit" checked="result.value.rentPriceUnit" name="subjectRent.rentPriceUnit" type="com.wiiy.crm.preferences.enums.PriceUnitEnum"/></td>
							</tr>
						</table>
					</td>
				</tr>
				<%-- <tr>
					<td class="layertdleft100"><span class="psred">*</span>物管单价：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100"><input id="managePrice" value="<fmt:formatNumber value="${result.value.managePrice}" pattern="#0.00"/>" name="subjectRent.managePrice" type="text" class="inputauto" /></td>
								<td> &nbsp;&nbsp;<enum:select id="managePriceUnit" checked="result.value.managePriceUnit" name="subjectRent.managePriceUnit" type="com.wiiy.crm.preferences.enums.PriceUnitEnum"/></td>
							</tr>
						</table>
					</td>
				</tr> --%>
				<tr>
					<td class="layertdleft100">是否优惠：</td>
					<td class="layerright"><enum:radio checked="result.value.rebate" styleClass="rebate" name="subjectRent.rebate" type="com.wiiy.commons.preferences.enums.BooleanEnum"/></td>
				</tr>
				<tr>
					<td class="layertdleft100"><p>优惠规则：</p></td>
					<td class="layerright"><dd:select checked="result.value.rebateRuleId" id="rebateRuleId" key="crm.0020" name="subjectRent.rebateRuleId"/></td>
				</tr>
				<tr>
					<td class="layertdleft100">备注：</td>
					<td class="layerright"><textarea name="subjectRent.memo" style="height:50px;" class="textareaauto">${result.value.memo}</textarea></td>
				</tr>
			</table>
		</div>
		<div class="hackbox"></div>
	</div>
	<div class="buttondiv">
		<input name="Submit" type="submit" class="savebtn" value="" />
		<input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/>
	</div>
</form>
</body>
</html>
