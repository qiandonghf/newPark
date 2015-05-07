<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
					var flag = $("#saveFlag").val();
					if(flag==0){
						var rent = getMap();
						rent.put("roomName",$("#roomName").val());
						rent.put("roomId",$("#roomId").val());
						rent.put("startDate",$("#startDate").val());
						rent.put("endDate",$("#endDate").val());
						rent.put("roomArea",$("#roomArea").val());
						rent.put("rentPrice",$("#rentPrice").val());
						rent.put("rentPriceUnit",$("#rentPriceUnit").val());
						/* rent.put("managePrice",$("#managePrice").val()); 
						rent.put("managePriceUnit",$("#managePriceUnit").val());*/
						rent.put("rebate",$(".rebate").val());
						rent.put("rebateRuleId",$("#rebateRuleId").val());
						rent.put("memo",$("#memo").val());
						getOpener().appendRoom(rent);
						parent.fb.end();
					}else{
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
				}
			});
		}
		
		function getMap() {//初始化map_,给map_对象增加方法，使map_像Map    
	         var map_ = new Object();    
	         map_.put = function(key, value) {    
	             map_[key+'_'] = value;    
	         };    
	         map_.get = function(key) {    
	             return map_[key+'_'];    
	         };    
	         map_.remove = function(key) {    
	             delete map_[key+'_'];    
	         };    
	         map_.keyset = function() {    
	             var ret = "";    
	             for(var p in map_) {    
	                 if(typeof p == 'string' && p.substring(p.length-1) == "_") {    
	                     ret += ",";    
	                     ret += p.substring(0,p.length-1);    
	                 }    
	             }    
	             if(ret == "") {    
	                 return ret.split(",");    
	             } else {    
	                 return ret.substring(1).split(",");    
	             }    
	         };    
	         return map_;    
		}  
		
		function setSelectedRoom(room){
			if(room["kind.dataValue"]!='出租' || room["status.title"]!='空闲'){
				if(!confirm("该房间状态不是空闲 或 性质不是出租 是否继续")){
					return false;
				}
			}
			$("#roomId").val(room.id);
			$("#roomArea").val(room.buildingArea);
			$("#buildingArea").val(room.buildingArea);
			$("#roomName").val(room["building.park.name"]+room["building.name"]+" "+room.name);
		}
	</script>
</head>

<body>
<form action="<%=basePath %>subjectRent!save.action" method="post" name="form1" id="form1">
	<input type="hidden" id="saveFlag" value="${param.saveFlag}" name="saveFlag"/>
	<input type="hidden" id="contractId" value="${param.contractId}" name="subjectRent.contractId"/>
	<div class="basediv">
		<div class="divlays" style="margin:0px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>租用地址：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="350"><input id="roomName" name="subjectRent.roomName" type="text" class="inputauto" readonly="readonly" /><input id="roomId" name="subjectRent.roomId" type="hidden"/><input id="buildingArea" name="subjectRent.room.buildingArea" type="hidden"/></td>
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
								<td width="100"><input readonly="readonly" id="startDate" name="subjectRent.startDate" value="${param.startDate }" type="text" class="inputauto" onclick="showCalendar('startDate')"/></td>
								<td width="22"><img src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="showCalendar('startDate')"/></td>
								<td width="18"><span style="padding-left:4px;">—</span></td>
								<td width="111" align="center"><input readonly="readonly" id="endDate" name="subjectRent.endDate" value="${param.endDate }" type="text" class="inputauto" onclick="showCalendar('endDate')"/></td>
								<td width="20" align="center"><img style="position: relative;left:-1px;" src="core/common/images/timeico.gif" width="20" height="22" onclick="showCalendar('endDate')"/></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100"><span class="psred">*</span>租用面积：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100"><input id="roomArea" name="subjectRent.roomArea" class="inputauto"/></td>
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
								<td width="100"><input id="rentPrice" name="subjectRent.rentPrice" type="text" class="inputauto" /></td>
								<td> &nbsp;&nbsp;<enum:select id="rentPriceUnit" name="subjectRent.rentPriceUnit" type="com.wiiy.crm.preferences.enums.PriceUnitEnum"/></td>
							</tr>
						</table>
					</td>
				</tr>
				<%-- <tr>
					<td class="layertdleft100"><span class="psred">*</span>物管单价：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="100"><input id="managePrice" name="subjectRent.managePrice" type="text" class="inputauto" /></td>
								<td> &nbsp;&nbsp;<enum:select id="managePriceUnit" name="subjectRent.managePriceUnit" type="com.wiiy.crm.preferences.enums.PriceUnitEnum"/></td>
							</tr>
						</table>
					</td>
				</tr> --%>
				<tr>
					<td class="layertdleft100">是否优惠：</td>
					<td class="layerright" ><enum:radio defaultValue="NO" styleClass="rebate" name="subjectRent.rebate" type="com.wiiy.commons.preferences.enums.BooleanEnum"/></td>
				</tr>
				<tr>
					<td class="layertdleft100"><p>优惠规则：</p></td>
					<td class="layerright"><dd:select id="rebateRuleId" key="crm.0020" name="subjectRent.rebateRuleId"/></td>
				</tr>
				<tr>
					<td class="layertdleft100">备注：</td>
					<td class="layerright"><textarea id="memo" name="subjectRent.memo" style="height:50px;" class="textareaauto"></textarea></td>
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
