<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
					//"billPlanRent.roomName":"required",
					"billPlanRent.feeType":"required",
					"billPlanRent.planFee":{
						"required":true,
						"positivenumber":true
					},
					"billPlanRent.realFee":{
						"required":true,
						"positivenumber":true
					},
					"billPlanRent.startDate":"required",
					"billPlanRent.endDate":"required",
					"billPlanRent.planPayDate":"required"
				},
				messages: {
					//"billPlanRent.roomName":"请选择房间",
					"billPlanRent.feeType":"请选择费用类型",
					"billPlanRent.planFee":{
						"required":"请输入计划金额"
					},
					"billPlanRent.realFee":{
						"required":"请输入实际金额"
					},
					"billPlanRent.startDate":"请输入计费开始日期",
					"billPlanRent.endDate":"请输入计费结束日期",
					"billPlanRent.planPayDate":"请输入计划付费日期"
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
					rent.put("roomName",$("#roomName").val());
					rent.put("roomId",$("#roomId").val());
					rent.put("feeType",$("#feeType").val());
					rent.put("planFee",$("#planFee").val());
					rent.put("realFee",$("#realFee").val());
					rent.put("startDate",$("#startDate").val());
					rent.put("endDate",$("#endDate").val());
					rent.put("planPayDate",$("#planPayDate").val());
					rent.put("status",$("#status").val());
					rent.put("memo",$("#memo").val());
					getOpener().appendBillPlanRent(rent);
					parent.fb.end();
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
			$("#roomName").val(room["building.park.name"]+room["building.name"]+" "+room.name);
		}
		
		function changeFee(){
			var id = $("#roomId").val();
			var index = 0;
			var jffs = $("#jffs").val();	
			var areas = $("#areas").val();
			if(id!=null && id!='' && $("#roomIds").val()!=null && $("#roomIds").val()!='' && jffs!='' && areas!=null && areas!=''){
				var roomIds = $("#roomIds").val().substring(0,$("#roomIds").val().length-1).split(",");
				$.each(roomIds,function(i){
					if(roomIds[i]==id){
						index = i;
					}
				});
				var rentPriceUnits = $("#rentPriceUnits").val().substring(0,$("#rentPriceUnits").val().length-1).split(",");
				alert(rentPriceUnits[index]);
				if(rentPriceUnits[index]=='MONTH'){
					var rentPrices = $("#rentPrices").val().substring(0,$("#rentPrices").val().length-1).split(",");
					var planFee = rentPrices[index]*jffs*areas;
					$("#planFee").val(planFee);
				}
				
			}
		}
		
	</script>
</head>

<body>
<form action="<%=basePath %>billPlanRent!save.action" method="post" name="form1" id="form1">
<input type="hidden" id="roomIds" value="${roomIds }"/>
<input type="hidden" id="rentPrices" value="${param.rentPrices }"/>
<input type="hidden" id="rentPriceUnits" value="${param.rentPriceUnits }"/>
<input type="hidden" id="areas" value="${param.areas }"/>
<div class="basediv">
	<div class="divlays" style="margin:0px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="layertdleft100">租赁房间：</td>
				<td class="layerright">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="350"><input id="roomName" name="billPlanRent.roomName" type="text" class="inputauto" readonly="readonly" /><input id="roomId" name="billPlanRent.roomId" type="hidden"/></td>
							<td><img src="core/common/images/outdiv.gif" style="position:relative;left:-4px;" width="20" height="22" onclick="fbStart('房间选择','<%=BaseAction.rootLocation%>/parkmanager.pb/room!select.action?roomIds='+$('#roomIds').val(),520,400);" style=" cursor:pointer;"/></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="layertdleft100"><span class="psred">*</span>费用类型：</td>
				<td class="layerright"><enum:select id="feeType" type="com.wiiy.crm.preferences.enums.RentBillPlanFeeEnum" name="billPlanRent.feeType"/></td>
			</tr>
			<tr>
				<td class="layertdleft100">计费方式：</td>
				<td class="layerright">
					<select id="jffs" onchange="changeFee();">
						<option value="">----请选择----</option>
						<option value="1">一个月</option>
						<option value="3">三个月</option>
						<option value="6">六个月</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="layertdleft100"><span class="psred">*</span>计划金额：</td>
				<td class="layerright">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="100"><input id="planFee" name="billPlanRent.planFee" type="text" class="inputauto" /></td>
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
							<td width="100"><input id="realFee" name="billPlanRent.realFee" type="text" class="inputauto" /></td>
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
							<td width="100"><input readonly="readonly" id="startDate" name="billPlanRent.startDate" value="<fmt:formatDate value="${startDate}" pattern="yyyy-MM-dd"/>" type="text" class="inputauto" onclick="return showCalendar('startDate')"/></td>
							<td width="20"><img src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="return showCalendar('startDate')"/></td>
							<td width="18">—</td>
							<td width="100" align="center"><input readonly="readonly" id="endDate" name="billPlanRent.endDate" value="<fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd"/>" type="text" class="inputauto" onclick="return showCalendar('endDate')"/></td>
							<td width="20"><img style="position: relative;left:-1px;" src="core/common/images/timeico.gif" width="20" height="22" onclick="return showCalendar('endDate')"/></td>
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
							<td width="100"><input readonly="readonly" id="planPayDate" name="billPlanRent.planPayDate" value="<fmt:formatDate value="${planPayTime}" pattern="yyyy-MM-dd"/>" type="text" class="inputauto" onclick="return showCalendar('planPayDate')"/></td>
							<td width="20"><img src="core/common/images/timeico.gif" style="position: relative;left:-1px;" width="20" height="22" onclick="return showCalendar('planPayDate')"/></td>
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
							<td width="80"><enum:radio styleClass="autoCheck" name="billPlanRent.autoCheck" type="com.wiiy.commons.preferences.enums.BooleanEnum"/></td>
							<td>&nbsp; </td>
						</tr>
					</table>
				</td>
			</tr> --%>
			<%-- <tr>
				<td class="layertdleft100">状态：</td>
				<td class="layerright">
					<enum:select id="status" type="com.wiiy.crm.preferences.enums.BillPlanStatusEnum" defaultValue="UNCHECK" name="billPlanRent.status"/>
				</td>
			</tr> --%>
			<tr>
				<td class="layertdleft100">备注：</td>
				<td class="layerright"><textarea id="memo" name="billPlanRent.memo" class="textareaauto" style="height:50px;"></textarea></td>
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
