<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="search" uri="http://www.wiiy.com/taglib/search" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
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
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript">
	$(function(){
		initTip();
	});
	function loadBillType(){
		
	}
	function getCalendarScrollTop(){
		return $("#scrollDiv").scrollTop();
	}
	function search(){
		parent.fb.end();
		parent.search(getSearchFilters());
	}
	function setSelectedRoom(room){
		$("#roomId").val(room.id);
		$("#roomName").val(room.name);
	}
	function setSelectedCustomer(customer){
		$("#customerId").val(customer.id);
		$("#customerName").val(customer.name);
	}
</script>
</head>

<body style=" background:#fff">
	<div class="basediv" style="height:370px; overflow-y:auto; overflow-x:hidden">
		<div class="divlays" style="margin:0px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100">企业名称：</td>
					<td class="layerright">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="286">
									<search:choose dataType="long" field="customerId" op="eq">
									<input type="hidden" id="customerId" class="data inputauto"/>
									</search:choose>
									<search:choose dataType="string" field="customer.name" op="cn">
									<input onkeyup="$('#customerId').val('')" id="customerName" name="endTime" type="text" class="data inputauto"/>
									</search:choose>
								</td>
								<td width="20" align="center"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="fbStart('企业选择','<%=BaseAction.rootLocation %>/parkmanager.pb/customer!select.action',520,400);" style=" cursor:pointer;"/></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">房间编号：</td>
					<td class="layerright">
						<table border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="286">
									<search:choose dataType="long" field="roomId" op="eq">
									<input type="hidden" id="roomId" class="data inputauto"/>
									</search:choose>
									<search:choose dataType="string" field="room.name" op="cn">
									<input onkeyup="$('#roomId').val('')" id="roomName" name="roomName" type="text" class="data inputauto"/>
									</search:choose>
								</td>
								<td width="20" align="center"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="fbStart('房间选择','<%=BaseAction.rootLocation %>/parkmanager.pb/room!select.action',520,400);" style=" cursor:pointer;"/></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">帐单类型：</td>
					<td class="layerright">
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">计划支付金额：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310">
								<search:choose dataType="java.util.Date" field="totalAmount" op="eq">
								<input type="text" class="data inputauto" onkeyup="value=value.replace(/[^\d\.]/g,'');">
								</search:choose>
								</td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">实际支付金额：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310">
								<search:choose dataType="java.util.Date" field="factPayment" op="eq">
								<input type="text" class="data inputauto" onkeyup="value=value.replace(/[^\d\.]/g,'');">
								</search:choose>
								</td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">计划支付日期：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tbody>
								<tr>
									<td width="120">
										<search:choose dataType="java.util.Date" field="planPayTime" op="ge">
										<input id="planPayTimeS" type="text" class="data inputauto" onclick="showCalendar('planPayTimeS')">
										</search:choose>
									</td>
									<td width="30" align="center"><img src="core/common/images/timeico.gif" onclick="showCalendar('planPayTimeS')" width="20" height="22" style="cursor:pointer;"></td>
									<td width="10" align="center">-</td>
									<td width="120" align="center">
										<search:choose dataType="java.util.Date" field="planPayTime" op="le">
										<input id="planPayTimeE" type="text" class="data inputauto" onclick="showCalendar('planPayTimeE')">
										</search:choose>
									</td>
									<td width="30" align="center"><img src="core/common/images/timeico.gif" onclick="showCalendar('planPayTimeE')" width="20" height="22" style="cursor:pointer;"></td>
									<td align="center">&nbsp;</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">实际支付日期：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tbody>
								<tr>
									<td width="120">
										<search:choose dataType="java.util.Date" field="payTime" op="ge">
										<input id="payTimeS" type="text" class="data inputauto" onclick="showCalendar('payTimeS')">
										</search:choose>
									</td>
									<td width="30" align="center"><img src="core/common/images/timeico.gif" onclick="showCalendar('payTimeS')" width="20" height="22" style="cursor:pointer;"></td>
									<td width="10" align="center">-</td>
									<td width="120" align="center">
										<search:choose dataType="java.util.Date" field="payTime" op="le">
										<input id="payTimeE" type="text" class="data inputauto" onclick="showCalendar('payTimeE')">
										</search:choose>
									</td>
									<td width="30" align="center"><img src="core/common/images/timeico.gif" onclick="showCalendar('payTimeE')" width="20" height="22" style="cursor:pointer;"></td>
									<td align="center">&nbsp;</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">滞纳金：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310">
								<search:choose dataType="java.util.Date" field="penalty" op="eq">
								<input type="text" class="data inputauto" onkeyup="value=value.replace(/[^\d\.]/g,'');">
								</search:choose>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">状态：</td>
					<td class="layerright">
						<search:choose dataType="com.wiiy.crm.preferences.enums.BillStatusEnum" field="status" op="eq">
						<enum:select type="com.wiiy.crm.preferences.enums.BillStatusEnum" styleClass="data"/>
						</search:choose>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">出帐日期：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tbody>
								<tr>
									<td width="120">
										<search:choose dataType="java.util.Date" field="createTime" op="ge">
										<input id="createTimeS" type="text" class="data inputauto" onclick="showCalendar('createTimeS')">
										</search:choose>
									</td>
									<td width="30" align="center"><img src="core/common/images/timeico.gif" onclick="showCalendar('createTimeS')" width="20" height="22" style="cursor:pointer;"></td>
									<td width="10" align="center">-</td>
									<td width="120" align="center">
										<search:choose dataType="java.util.Date" field="createTime" op="le">
										<input id="createTimeE" type="text" class="data inputauto" onclick="showCalendar('createTimeE')">
										</search:choose>
									</td>
									<td width="30" align="center"><img src="core/common/images/timeico.gif" onclick="showCalendar('createTimeE')" width="20" height="22" style="cursor:pointer;"></td>
									<td align="center">&nbsp;</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">费用起始日期：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tbody>
								<tr>
									<td width="120">
										<search:choose dataType="java.util.Date" field="feeStartTime" op="ge">
										<input id="feeStartTimeS" type="text" class="data inputauto" onclick="showCalendar('feeStartTimeS')">
										</search:choose>
									</td>
									<td width="30" align="center"><img src="core/common/images/timeico.gif" onclick="showCalendar('feeStartTimeS')" width="20" height="22" style="cursor:pointer;"></td>
									<td width="10" align="center">-</td>
									<td width="120" align="center">
										<search:choose dataType="java.util.Date" field="feeStartTime" op="le">
										<input id="feeStartTimeE" type="text" class="data inputauto" onclick="showCalendar('feeStartTimeE')">
										</search:choose>
									</td>
									<td width="30" align="center"><img src="core/common/images/timeico.gif" onclick="showCalendar('feeStartTimeE')" width="20" height="22" style="cursor:pointer;"></td>
									<td align="center">&nbsp;</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">费用截止日期：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tbody>
								<tr>
									<td width="120">
										<search:choose dataType="java.util.Date" field="feeEndTime" op="ge">
										<input id="feeEndTimeS" type="text" class="data inputauto" onclick="showCalendar('feeEndTimeS')">
										</search:choose>
									</td>
									<td width="30" align="center"><img src="core/common/images/timeico.gif" onclick="showCalendar('feeEndTimeS')" width="20" height="22" style="cursor:pointer;"></td>
									<td width="10" align="center">-</td>
									<td width="120" align="center">
										<search:choose dataType="java.util.Date" field="feeEndTime" op="le">
										<input id="feeEndTimeE" type="text" class="data inputauto" onclick="showCalendar('feeEndTimeE')">
										</search:choose>
									</td>
									<td width="30" align="center"><img src="core/common/images/timeico.gif" onclick="showCalendar('feeEndTimeE')" width="20" height="22" style="cursor:pointer;"></td>
									<td align="center">&nbsp;</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
			</table>
		</div>
		<div class="hackbox"></div>
	</div>
	<div class="buttondiv">
		<label><input name="Submit" type="button" class="search_cx" value="" onclick="search()"/>
		</label>
		<label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
	</div>
</form>
</body>
</html>