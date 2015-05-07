<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
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
					"subjectNetwork.startDate":"required",
					"subjectNetwork.endDate":"required",
					"subjectNetwork.facilityId":"required",
					"subjectNetwork.price":{
						"required":true,
						"positivenumber":true
					},
					"subjectNetwork.priceUnit":"required",
					"subjectNetwork.ip":{
						"required":true,
						"positivenumber":true
					},
					"subjectNetwork.port":{
						"required":true,
						"positivenumber":true
					},
					"subjectNetwork.publicIP":{
						"required":true,
						"positivenumber":true
					}
				},
				messages: {
					"subjectNetwork.startDate":"请选择租用开始日期",
					"subjectNetwork.endDate":"请选择租用结束日期",
					"subjectNetwork.facilityId":"请选择宽带",
					"subjectNetwork.price":{
						"required":"请输入单价"
					},
					"subjectNetwork.priceUnit":"请选择价钱单位",
					"subjectNetwork.ip":{
						"required":"请输入IP段个数"
					},
					"subjectNetwork.port":{
						"required":"请输入接入端口数"
					},
					"subjectNetwork.publicIP":{
						"required":"请输入公网IP数"
					}
				},
				errorPlacement: function(error, element){
					showTip(error.html());
				},
				submitHandler: function(form){
					if($("#endDate").val()<$("#startDate").val()){
						showTip("租用开始日期不能小于租用结束日期",3000);
						return;
					}
					var saveFlag = $("#saveFlag").val();
					if(saveFlag==0){
						var rent = getMap();
						rent.put("facilityId",$("#facilityId").val());
						rent.put("facilityName",$("#facilityId").find("option:selected").text());
						rent.put("startDate",$("#startDate").val());
						rent.put("endDate",$("#endDate").val());
						rent.put("rentPrice",$("#rentPrice").val());
						rent.put("priceUnit",$("#priceUnit").val());
						rent.put("netWorkIp",$("#netWorkIp").val());
						rent.put("netWorkPort",$("#netWorkPort").val());
						rent.put("publicIP",$("#publicIP").val());
						getOpener().appendNet(rent);
						parent.fb.end();
					}else{
						$(form).ajaxSubmit({
					        dataType: 'json',		        
					        success: function(data){
				        		showTip(data.result.msg,2000);
					        	if(data.result.success){
					        		setTimeout("getOpener().reloadSubjectNetworkList();parent.fb.end();", 2000);
					        	}
					        } 
					    });
					}
				}
			});
		}
		function setSelectedRoom(room){
			$("#roomId").val(room.id);
			$("#roomArea").val(room.buildingArea);
			$("#buildingArea").val(room.buildingArea);
			$("#roomName").val(room["building.name"]+" "+room.name);
		}
	</script>
</head>

<body>
<form action="<%=basePath %>subjectNetwork!save.action" method="post" name="form1" id="form1">
	<input type="hidden" id="saveFlag" value="${param.saveFlag}" name="saveFlag"/>
	<input type="hidden" id="contractId" value="${id}" name="subjectNetwork.contractId"/>
	<input type="hidden" value="${result.value.customerId}" name="subjectNetwork.customerId"/>
	<div class="basediv">
		<div class="divlays" style="margin:0px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>租用日期：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="110"><input readonly="readonly" id="startDate" value="${param.startDate }" name="subjectNetwork.startDate" type="text" class="inputauto" onclick="showCalendar('startDate')"/></td>
								<td><img src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="showCalendar('startDate')"/></td>
								<td><span style="padding-left:4px;">—</span></td>
								<td width="110"><input readonly="readonly" id="endDate" value="${param.endDate }" name="subjectNetwork.endDate" type="text" class="inputauto" onclick="showCalendar('endDate')"/></td>
								<td><img style="position: relative;left:-1px;" src="core/common/images/timeico.gif" width="20" height="22" onclick="showCalendar('endDate')"/></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>宽带：</td>
					<td class="layerright">
						<select name="subjectNetwork.facilityId" id="facilityId">
							<option value="">----请选择----</option>
							<c:forEach items="${facilityList}" var="facility">
								<option value="${facility.id}">${facility.name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>单价：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100"><input id="rentPrice" name="subjectNetwork.price" type="text" class="inputauto" /></td>
								<td> &nbsp;&nbsp;<enum:select id="priceUnit" name="subjectNetwork.priceUnit" type="com.wiiy.crm.preferences.enums.NetworkPriceUnitEnum"/></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>IP段：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100"><input id="netWorkIp" name="subjectNetwork.ip" type="text" class="inputauto" /></td>
								<td> &nbsp;&nbsp;个</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>接入端口数：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100"><input id="netWorkPort" name="subjectNetwork.port" type="text" class="inputauto" /></td>
								<td> &nbsp;&nbsp;个</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>公网IP数：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100"><input id="publicIP" name="subjectNetwork.publicIP" type="text" class="inputauto" /></td>
								<td> &nbsp;&nbsp;个</td>
							</tr>
						</table>
					</td>
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
