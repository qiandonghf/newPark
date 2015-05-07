<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<c:set var="bill" value="${result.value}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
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
		loadTopType();
		if('${bill.customerId}'!=''){
			loadContract('${bill.customerId}');
		}
	});
	function initForm(){
		$("#form1").validate({
			rules: {
				"customerName":"required",
				"bill.billTypeId":"required",
				"bill.totalAmount":{
					"required":true,
					"positivenumber":true
				},
				"bill.factPayment":{
					"required":true,
					"positivenumber":true
				},
				"bill.planPayTime":"required",
				"bill.payTime":"required",
				"bill.penalty":{
					"required":true,
					"positivenumber":true
				},
				"bill.status":"required",
				"bill.checkoutTime":"required"
			},
			messages: {
				"customerName":"请选择企业",
				"bill.billTypeId":"请选择账单类型",
				"bill.totalAmount":{
					"required":"请输入计划支付金额"
				},
				"bill.factPayment":{
					"required":"请输入实际支付金额"
				},
				"bill.planPayTime":"请输入计划支付日期",
				"bill.payTime":"请输入实际支付日期",
				"bill.penalty":{
					"required":"请输入滞纳金"
				},
				"bill.status":"请选择状态",
				"bill.checkoutTime":"请输入出账日期"
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
			        		setTimeout("getOpener().reloadList();parent.fb.end();", 2000);
			        	}
			        } 
			    });
			}
		});
	}
	function loadTopType(){
		var billTypeId = $("#topTypeId");
		$.post("<%=basePath%>billType!loadTopType.action",function(data){
			if(data.result.success){
				var billTypes = data.result.value;
				for(var i = 0; i < billTypes.length; i++){
					var option = $("<option></option>",{value:billTypes[i].id}).append(billTypes[i].typeName);
					if(billTypes[i].id == '${bill.billType.parentId}'){
						option.attr("selected","selected");
						loadTypeChildren(billTypes[i].id);
					}
					billTypeId.append(option);
				}
			}
		});
	}
	function loadTypeChildren(parentId){
		var billTypeId = $("#billTypeId");
		billTypeId.empty();
		billTypeId.append($("<option></option>",{value:''}).append("----请选择----"));
		$.post("<%=basePath%>billType!loadChildrenType.action?id="+parentId,function(data){
			if(data.result.success){
				var billTypes = data.result.value;
				for(var i = 0; i < billTypes.length; i++){
					var option = $("<option></option>",{value:billTypes[i].id}).append(billTypes[i].typeName);
					if(billTypes[i].id == '${bill.billTypeId}'){
						option.attr("selected","selected");
					}
					billTypeId.append(option);
				}
			}
		});
	}
	function setSelectedRoom(room){
		$("#roomId").val(room.id);
		$("#roomName").val(room.name);
	}
	function setSelectedCustomer(customer){
		$("#customerId").val(customer.id);
		$("#customerName").val(customer.name);
		loadContract(customer.id);
	}
	function loadContract(id){
		var contractNo = $("#contractNo");
		contractNo.empty();
		contractNo.append($("<option></option>").append("----请选择----"));
		$.post("<%=basePath%>contract!loadContractByCustomerId.action?id="+id,function(data){
			if(data.result.success){
				var contracts = data.result.value;
				//alert(contracts[i].id);
				for(var i = 0; i < contracts.length; i++){
					var option = $("<option></option>",{value:contracts[i].contractNo}).append(contracts[i].contractNo)
					if(contracts[i].contractNo == '${bill.contractNo}'){
						option.attr("selected","selected");
					}
					contractNo.append(option);
				}
			}
		});
	}
	function getCalendarScrollTop(){
		return $("#scrollDiv").scrollTop();
	}
	function search(){
		parent.fb.end();
		parent.search(getSearchFilters());
	}
	function selectContract(){
		if($("#customerId").val()){
			fbStart('房间选择','<%=BaseAction.rootLocation %>/parkmanager.pb/contract!loadContractByCustomerId.action?id='+$("#customerId").val(),520,400);
		} else {
			showTip("请先选择企业");
		}
	}
</script>
</head>

<body>
<form action="<%=basePath %>bill!update.action" method="post" name="form1" id="form1">
<input name="bill.id" value="${bill.id}" type="hidden"/>
<div id="scrollDiv" class="basediv">
	<div class="divlays" style="margin:0px;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
				<td class="layertdleft100"><span class="psred">*</span>帐单类型：</td>
				<td colspan="3" class="layerright">
        			<select id="topTypeId" onchange="loadTypeChildren(this.value)">
						<option value="">----请选择----</option>
					</select>
        			<select id="billTypeId" name="bill.billTypeId">
						<option value="">----请选择----</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="layertdleft100"><span class="psred">*</span>企业名称：</td>
				<td class="layerright">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
								<input type="hidden" id="customerId" class="data" name="bill.customerId" value="${bill.customerId}"/>
								<input readonly="readonly" id="customerName" name="customerName" value="${bill.customer.name}" type="text" class="data inputauto"/>
							</td>
							<td width="20"><img style="cursor:pointer;" src="core/common/images/outdiv.gif" width="20" height="22"  onclick="fbStart('选择企业','<%=basePath %>customer!select.action',520,400);"/></td>
						</tr>
					</table>
				</td>
				<td class="layertdleft100"><span class="psred">*</span>计划支付金额：</td>
				<td class="layerright">
					<table width="100%" border="0" cellspacing="0" cellpadding="10">
						<tr>
							<td width="120"><input value="<fmt:formatNumber value="${bill.totalAmount}" pattern="#0.00"/>" name="bill.totalAmount" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d\.]/g,'');"/></td>
							<td align="left" style="padding-left:5px;">&nbsp;元</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="layertdleft100">合同编号：</td>
				<td width="" class="layerright">
					<select id="contractNo" name="bill.contractNo">
						<option>----请选择----</option>
					</select>
				</td>
				<td class="layertdleft100"><span class="psred">*</span>实际支付金额：</td>
				<td class="layerright">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="120"><input value="<fmt:formatNumber value="${bill.factPayment}" pattern="#0.00"/>" name="bill.factPayment" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d\.]/g,'');"/></td>
							<td align="left" style="padding-left:5px;">&nbsp;元</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="layertdleft100">房间编号：</td>
				<td class="layerright">
					<table border="0" cellspacing="0" cellpadding="10">
						<tr>
							<td>
								<input type="hidden" id="roomId" class="data" name="bill.roomId" value="${bill.roomId}"/>
								<input readonly="readonly" id="roomName" name="roomName" value="${bill.room.name}" type="text" class="data inputauto"/>
							</td>
							<td width="20" align="center"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="fbStart('房间选择','<%=BaseAction.rootLocation %>/parkmanager.pb/room!select.action',520,400);" style=" cursor:pointer;"/></td>
						</tr>
					</table>
				</td>
				<td class="layertdleft100"><span class="psred">*</span>滞纳金：</td>
				<td class="layerright">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="120"><input value="<fmt:formatNumber value="${bill.penalty}" pattern="#0.00"/>" name="bill.penalty" type="text" class="inputauto" onkeyup="value=value.replace(/[^\d\.]/g,'');"/></td>
							<td align="left" style="padding-left:5px;">&nbsp;元</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class="layertdleft100"><span class="psred">*</span>计划支付日期：</td>
				<td class="layerright">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="133"><input value="<fmt:formatDate value="${bill.planPayTime}" pattern="yyyy-MM-dd"/>" id="planPayTime" readonly="readonly" name="bill.planPayTime" type="text" class="data inputauto" onclick="showCalendar('planPayTime');"/></td>
							<td width="20" align="center"><img src="core/common/images/timeico.gif" width="20" height="22" style="cursor:pointer;" onclick="showCalendar('planPayTime');"></td>
						</tr>
					</table>
				</td>
				<td class="layertdleft100"><span class="psred">*</span>状态：</td>
				<td class="layerright">
					<enum:select checked="bill.status" type="com.wiiy.crm.preferences.enums.BillStatusEnum" name="bill.status"/>
				</td>
			</tr>
			<tr>
				<td class="layertdleft100"><span class="psred">*</span>实际支付日期：</td>
				<td class="layerright">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="133"><input id="payTime" value="<fmt:formatDate value="${bill.payTime}" pattern="yyyy-MM-dd"/>" readonly="readonly" name="bill.payTime" type="text" class="data inputauto" onclick="showCalendar('payTime');"/></td>
							<td width="20" align="center"><img src="core/common/images/timeico.gif" width="20" height="22" style="cursor:pointer;" onclick="showCalendar('payTime');"></td>
						</tr>
					</table>
				</td>
				<td class="layertdleft100"><span class="psred">*</span>收支：</td>
				<td class="layerright"><enum:radio checked="bill.inOut" type="com.wiiy.crm.preferences.enums.BillInOutEnum" name="bill.inOut"/></td>
			</tr>
			<tr>
				<td class="layertdleft100"><span class="psred">*</span>出帐日期：</td>
				<td class="layerright">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="133"><input id="checkoutTime" value="<fmt:formatDate value="${bill.checkoutTime}" pattern="yyyy-MM-dd"/>" readonly="readonly" name="bill.checkoutTime" type="text" class="data inputauto" onclick="showCalendar('checkoutTime');"/></td>
							<td width="20" align="center"><img src="core/common/images/timeico.gif" width="20" height="22" style="cursor:pointer;" onclick="showCalendar('checkoutTime');"></td>
						</tr>
					</table>
				</td>
				<td class="layertdleft100"><span class="psred">*</span>是否开票：</td>
				<td class="layerright"><enum:radio checked="bill.invoice" type="com.wiiy.commons.preferences.enums.BooleanEnum" name="bill.invoice"/></td>
			</tr>
			<tr>
				<td class="layertdleft100">费用起始日期：</td>
				<td class="layerright">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="133"><input id="feeStartTime" value="<fmt:formatDate value="${bill.feeStartTime}" pattern="yyyy-MM-dd"/>" name="bill.feeStartTime" type="text" class="data inputauto" onclick="showCalendar('feeStartTime');"/></td>
							<td width="20" align="center"><img src="core/common/images/timeico.gif" width="20" height="22" style="cursor:pointer;" onclick="showCalendar('feeStartTime');"></td>
						</tr>
					</table>
				</td>
				<td class="layertdleft100"><span class="psred">*</span>已催缴：</td>
				<td class="layerright">
					<enum:radio checked="bill.urged" type="com.wiiy.commons.preferences.enums.BooleanEnum" name="bill.urged"/>
				</td>
			</tr>
			<tr>
				<td class="layertdleft100">费用截止日期：</td>
				<td class="layerright">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="133"><input id="feeEndTime" value="<fmt:formatDate value="${bill.feeEndTime}" pattern="yyyy-MM-dd"/>" name="bill.feeEndTime" type="text" class="data inputauto" onclick="showCalendar('feeEndTime');"/></td>
							<td width="20" align="center"><img src="core/common/images/timeico.gif" width="20" height="22" style="cursor:pointer;" onclick="showCalendar('feeEndTime');"></td>
						</tr>
					</table>
				</td>
				<td class="layertdleft100"><span class="psred">*</span>支付方式：</td>
				<td class="layerright">
					<enum:select checked="bill.payType" type="com.wiiy.crm.preferences.enums.PayTypeEnum" name="bill.payType"/>
	      		</td>
			</tr>
			<tr>
				<td class="layertdleft100">备注：</td>
				<td colspan="3" class="layerright"><textarea name="bill.memo" rows="5" class="textareaauto" style="width:100%;">${bill.memo}</textarea></td>
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