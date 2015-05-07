<%@ page language="java" import="java.util.*,java.text.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<style type="text/css">
	.input{ padding-left:2px; height:20px; line-height:20px; border:1px solid #e0e0e0;}
</style>

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
		loadReportGroup();
		//loadReportTemplate();
		initCalendar();
		initValue();
	});
	function initValue(){
		//$(".property").attr("checked","true");
// 		$("input[value=]").val("a");
// 		$(".double").val(200);
// 		$(".int").val(5);
// 		$(".calendarInput").val("2012-05-05");
// 		$("select").each(function(){
// 			if($(this).children().size()>2)
// 			$(this).val($(this).children().eq(1).val());
// 		});
	}
	function initCalendar(){
		$(".calendarInput").each(function(){
			$(this).click(function(){
				showCalendar(this);
			});
		});
	}
	function loadReportTemplate(){
		var url = "<%=basePath%>dataTemplate!loadTemplate.action";
		$.post(url,function(data){
			var template = $("#template");
			for(var i = 0; i < data.length; i++){
				template.append($("<option></option>",{value:data[i].id}).append(data[i].name));
			}
		});
	}
	function loadReportGroup(){
		var url = "<%=basePath%>dataReport!loadReportGroup.action";
		$.post(url,function(data){
			var group1 = $("#reportGroupId1");
			var group2 = $("#reportGroupId2");
			for(var i = 0; i < data.length; i++){
				group1.append($("<option></option>",{value:data[i].id}).append(data[i].name));
				group2.append($("<option></option>",{value:data[i].id}).append(data[i].name));
			}
		});
	}
	function loadReport(id,reportId){
		var url = "<%=basePath%>dataReport!loadReport.action?id="+id;
		$.post(url,function(data){
			var report = $("#"+reportId);
			for(var i = 0; i < data.length; i++){
				if(data[i].templateId==1){
					report.append($("<option></option>",{value:data[i].id}).append(data[i].name));
				}
			}
		});
	}
	function setSelectedUser(user){
		$("#hostId").val(user.id);
		$("#host").val(user.realName);
	}
	function setSelectedCustomer(customer){
		$("#customerName").val(customer.name);
	}
	function getCalendarScrollTop(){
		return $("#scrollDiv").scrollTop();
	}
	function doSearch(){ 
		if($("#reportGroupId1").val() != ""){
			if($("#reportId1").val() == "") return alert("若要查询报表信息,请选择具体报表");
		}
		if($("#reportGroupId2").val() != ""){
			if($("#reportId2").val() == "") return alert("若要查询报表信息,请选择具体报表");
		}
		document.form1.submit();
	}
	function checkChildren(el){
		$(el).parent().next().find('input[type=checkbox]').attr('checked',$(el).prop('checked'));
	}
</script>
</head>

<body style=" background:#fff">
	<div class="titlebg">企业基本信息查询</div>
	<div class="overflowAuto" id="overflowAuto">
		<div style="height:36px; font: bold 16px/36px ''; text-align:center;"><strong>企业基本信息查询</strong></div>
		<form action="<%=basePath%>search.action?tab=result" method="post" name="form1" id="form1">
			<div class="pm_msglist" id="pm_msglist" style=" margin:1px auto; width:860px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="layertdleft120">企业名称：</td>
						<td class="layerright" width="270">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td><input name="customer.name.like" type="text" class="inputauto" id="customerName"/></td>
									<td width="20" align="center"><img src="core/common/images/outdiv.gif" width="20" height="22" onclick="fbStart('选择客户','<%=basePath%>customer!select.action',520,400);" style=" cursor:pointer;"/></td>
								</tr>
							</table>
						</td>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property" value="customer.reportType" />上报类型：</td>
						<td class="layerright"><enum:checkbox name="customer.reportType.in" styleClass="vetM" type="com.wiiy.crm.preferences.enums.CustomerRouteTypeEnum" /></td>
					</tr>
					<tr>
						<td class="layertdleft120">企业编号：</td>
						<td class="layerright"><input name="customer.code.like" type="text" class="inputauto" /></td>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property" value="customer.hostName"/>跟踪引进：</td>
						<td class="layerright"><input name="customer.hostName.like" type="text" class="inputauto" /></td>
					</tr>
					<tr>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property"  value="customer.customerType" onclick="checkChildren(this)"/>企业分类：</td>
						<td class="layerright" colspan="3"><dd:checkbox key="crm.0040" styleClass="vetM" name="customer.customerTypeId.in"/></td>
					</tr>
					<tr>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property" value="customerInfo.zyjck"/>自营进出口权：</td>
						<td class="layerright"><enum:select name="customerInfo.zyjck.eq" type="com.wiiy.commons.preferences.enums.BooleanEnum" /></td>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property" value="customerInfo.ybnsr"/>一般纳税人：</td>
						<td class="layerright"><enum:select name="customerInfo.ybnsr.eq" type="com.wiiy.commons.preferences.enums.BooleanEnum" /></td>
					</tr>
					<tr>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property" value="incubationRoute" onclick="checkChildren(this)"/>孵化过程：</td>
						<td colspan="3" class="layerright">
							<table width="100%" border="0" cellpadding="0" cellspacing="5" cols="0">
								<tr>
									<c:forEach items="${incubationRouteList}" var="incubation" varStatus="s">
									<td width="170"><input name="property" type="checkbox" class="vetM property" value="incubationRoute.${incubation.id}"/>${incubation.dataValue}</td>
									<td><input name="incubationRoute.${incubation.id}.ge" size="8" class="input calendarInput"/>—<input name="incubationRoute.${incubation.id}.le" size="8" class="input calendarInput" /></td>
									<c:if test="${s.index % 2 eq 1 }"></tr><tr></c:if>
									</c:forEach>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property"  value="incubationInfo.status"/>孵化状态：</td>
						<td class="layerright"><dd:select key="crm.0025" name="incubationInfo.status.routeId.eq"/></td>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property" value="incubationRoute.time"/>对应时间：</td>
						<td class="layerright"><input name="incubationRoute.time.ge" size="8" class="input calendarInput"/>—<input name="incubationRoute.time.le" size="8" class="input calendarInput" /></td>
					</tr>
					<tr>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property" value="customerInfo.businessNumber"/>工商注册号：</td>
						<td class="layerright"><input name="customerInfo.businessNumber.like" type="text" class="inputauto" /></td>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property" value="customerInfo.regTime"/>注册时间：</td>
						<td class="layerright"><input name="customerInfo.regTime.ge" size="8" class="input calendarInput"/>—<input name="customerInfo.regTime.le" size="8" class="input calendarInput" /></td>
					</tr>
					<tr>
						<td rowspan="2" class="layertdleft120">税务登记号：</td>
						<td class="layerright"><input name="property" type="checkbox" class="vetM property" value="customerInfo.taxNumberG"/>国税登记号：<input name="customerInfo.taxNumberG.like" type="text" class="inputauto" style="width:100px;" /></td>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property" value="customer.type"/>企业性质：</td>
						<td class="layerright"><enum:select id="type" name="customer.type.eq" type="com.wiiy.crm.preferences.enums.CustomerTypeEnum"/></td>
					</tr>
					<tr>
						<td class="layerright"><input name="property" type="checkbox" class="vetM property" value="customerInfo.taxNumberD"/>地税登记号：<input name="customerInfo.taxNumberD.like" type="text" class="inputauto" style="width:100px;" /></td>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property" value="customerInfo.taxAddress"/>纳税所在地：</td>
						<td class="layerright"><dd:select id="taxAddressId" name="customerInfo.taxAddressId.eq" key="crm.0028"/></td>
					</tr>
					<tr>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property" value="customerInfo.webSite"/>公司网址：</td>
						<td class="layerright"><input name="customerInfo.webSite.like" type="text" class="inputauto"/></td>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property" value="customerInfo.organizationNumber"/>组织机构代码：</td>
						<td class="layerright"><input name="customerInfo.organizationNumber.like" type="text" class="inputauto" /></td>
					</tr>
					<tr>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property"  value="customerInfo.regCapital"/>注册资金：</td>
						<td class="layerright">
						<dd:select name="customerInfo.regTypeId" key="crm.0004"/>
						<dd:select name="customerInfo.currencyTypeId" key="crm.0005"/>
						<input name="customerInfo.regCapital.ge" size="8" class="input double"/>—<input name="customerInfo.regCapital.le" size="8" class="input double" />（单位：万元）
						</td>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property" value="customerInfo.realCapital"/>实际到位资金：</td>
						<td class="layerright"><input name="customerInfo.realCapital.ge" size="8" class="input double"/>—<input name="customerInfo.realCapital.le" size="8" class="input double" />万元</td>
					</tr>
					<tr>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property"  value="customerInfo.regAddress"/>注册地址：</td>
						<td class="layerright"><input name="customerInfo.regAddress.like" type="text" class="inputauto" /></td>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property" value="customerInfo.inPark"/>在园区内：</td>
						<td class="layerright"><enum:select styleClass="incubated" name="customerInfo.inPark.eq" type="com.wiiy.commons.preferences.enums.BooleanEnum" /></td>
					</tr>
					<tr>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property"  value="customerInfo.managerAddress"/>经营地址：</td>
						<td class="layerright"><input name="customerInfo.managerAddress.like" type="text" class="inputauto" id="txtComp_fare_add" /></td>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property" value="customerInfo.inBuild"/>在大厦内：</td>
						<td class="layerright"><enum:select styleClass="incubated" name="customerInfo.inBuild.eq" type="com.wiiy.commons.preferences.enums.BooleanEnum" /></td>
					</tr>
					<tr>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property"  value="customer.parkTime"/>引进时间：</td>
						<td class="layerright"><input name="customer.parkTime.ge" size="8" class="input calendarInput"/>—<input name="customer.parkTime.le" size="8" class="input calendarInput" /></td>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property" value="customerInfo.research"/>是否是研发机构：</td>
						<td class="layerright"><enum:select styleClass="incubated" name="customerInfo.research.eq" type="com.wiiy.commons.preferences.enums.BooleanEnum" /></td>
					</tr>
					<tr>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property"  value="legal" onclick="checkChildren(this)"/>法人代表：</td>
						<td colspan="3" class="layerright">
							<table border="0" cellpadding="0" cellspacing="5">
								<tr>
									<td><input name="property" type="checkbox" class="vetM property"  value="legal.name"/>姓名：</td>
									<td><input name="legal.name.like" type="text" class="inputborder"/></td>
									<td><input name="property" type="checkbox" class="vetM property"  value="legal.birth"/>出生年月：</td>
									<td><input name="legal.birth.ge" size="8" class="input calendarInput"/>—<input name="legal.birth.le" size="8" class="input calendarInput" /></td>
									<td><input name="property" type="checkbox" class="vetM property"  value="legal.phone"/>联系电话：</td>
									<td><input name="legal.phone.like" type="text" class="inputborder"/></td>
								</tr>
								<tr>
									<td><input name="property" type="checkbox" class="vetM property"  value="legal.gender"/>性别：</td>
									<td><enum:select styleClass="incubated" name="legal.gender.eq" type="com.wiiy.commons.preferences.enums.GenderEnum" /></td>
									<td><input name="property" type="checkbox" class="vetM property"  value="legal.degree"/>学位：</td>
									<td><dd:select id="degreeId" name="legal.degreeId.eq" key="crm.0015" /></td>
									<td><input name="property" type="checkbox" class="vetM property"  value="legal.position"/>职称：</td>
									<td><dd:select id="positionId" name="legal.positionId.eq" key="crm.0014" /></td>
								</tr>
								<tr>
									<td><input name="property" type="checkbox" class="vetM property"  value="legal.email"/>E-mail：</td>
									<td colspan="5"><input name="legal.email.like" type="text" class="inputborder" id="txtMaster_add" /></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property"  value="manager" onclick="checkChildren(this)"/>总经理：</td>
						<td colspan="3" class="layerright">
							<table border="0" cellpadding="0" cellspacing="5">
								<tr>
									<td><input name="property" type="checkbox" class="vetM property"  value="manager.name"/>姓名：</td>
									<td><input name="manager.name.like" type="text" class="inputborder"/></td>
									<td><input name="property" type="checkbox" class="vetM property"  value="manager.birth"/>出生年月：</td>
									<td><input name="manager.birth.ge" size="8" class="input calendarInput"/>—<input name="manager.birth.le" size="8" class="input calendarInput" /></td>
									<td><input name="property" type="checkbox" class="vetM property"  value="manager.phone"/>联系电话：</td>
									<td><input name="manager.phone.like" type="text" class="inputborder"/></td>
								</tr>
								<tr>
									<td><input name="property" type="checkbox" class="vetM property"  value="manager.gender"/>性别：</td>
									<td><enum:select styleClass="incubated" name="manager.gender.eq" type="com.wiiy.commons.preferences.enums.GenderEnum" /></td>
									<td><input name="property" type="checkbox" class="vetM property"  value="manager.degree"/>学位：</td>
									<td><dd:select id="degreeId" name="manager.degreeId.eq" key="crm.0015" /></td>
									<td><input name="property" type="checkbox" class="vetM property"  value="manager.positionId"/>职称：</td>
									<td><dd:select id="positionId" name="manager.positionId.eq" key="crm.0014" /></td>
								</tr>
								<tr>
									<td><input name="property" type="checkbox" class="vetM property"  value="manager.email"/>E-mail：</td>
									<td colspan="5"><input name="manager.email.like" type="text" class="inputborder" id="txtMaster_add" /></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property"  value="staffer" onclick="checkChildren(this)"/>人才实名：</td>
						<td colspan="3" class="layerright">
							<table border="0" cellpadding="0" cellspacing="5">
								<tr>
									<td><input name="property" type="checkbox" class="vetM property"  value="staffer.name"/>姓名：</td>
									<td><input name="staffer.name.like" type="text" class="inputborder"/></td>
									<td><input name="property" type="checkbox" class="vetM property"  value="staffer.birth"/>出生年月：</td>
									<td><input name="staffer.birth.ge" size="8" class="input calendarInput"/>—<input name="staffer.birth.le" size="8" class="input calendarInput" /></td>
									<td><input name="property" type="checkbox" class="vetM property"  value="staffer.phone"/>联系电话：</td>
									<td><input name="staffer.phone.like" type="text" class="inputborder"/></td>
								</tr>
								<tr>
									<td><input name="property" type="checkbox" class="vetM property"  value="staffer.gender"/>性别：</td>
									<td><enum:select styleClass="incubated" name="staffer.gender.eq" type="com.wiiy.commons.preferences.enums.GenderEnum" /></td>
									<td><input name="property" type="checkbox" class="vetM property"  value="staffer.degree"/>学位：</td>
									<td><dd:select id="degreeId" name="staffer.degree.eq" key="crm.0015" /></td>
									<td><input name="property" type="checkbox" class="vetM property"  value="staffer.positionId"/>职称：</td>
									<td><dd:select id="positionId" name="staffer.positionId.eq" key="crm.0014" /></td>
								</tr>
								<tr>
									<td><input name="property" type="checkbox" class="vetM property"  value="staffer.email"/>E-mail：</td>
									<td colspan="5"><input name="staffer.email.like" type="text" class="inputborder" id="txtMaster_add" /></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property"  value="contect" onclick="checkChildren(this)"/>联系企业：</td>
						<td colspan="3" class="layerright">
							<table border="0" cellpadding="0" cellspacing="5">
								<tr>
									<td><input name="property" type="checkbox" class="vetM property"  value="contect.position"/>职位：</td>
									<td><input name="contect.position.like" type="text" class="inputborder" id="txtPer_post" style="width:80px;" /></td>
									<td><input name="property" type="checkbox" class="vetM property"  value="contect.name"/>姓名：</td>
									<td><input name="contect.name.like" type="text" class="inputborder" id="txtPer_name" style="width:80px;" /></td>
									<td><input name="property" type="checkbox" class="vetM property"  value="contect.phone"/>电话：</td>
									<td><input name="contect.phone.like" type="text" class="inputborder" id="txtPer_tel" style="width:80px;" /></td>
								</tr>
								<tr>
									<td><input name="property" type="checkbox" class="vetM property"  value="contect.mobile"/>手机：</td>
									<td><input name="contect.mobile.like" type="text" class="inputborder" id="txtPer_mobile" style="width:80px;" /></td>
									<td><input name="property" type="checkbox" class="vetM property"  value="contect.email"/>Email：</td>
									<td><input name="contect.email.like" type="text" class="inputborder" id="txtPer_email_qq" style="width:80px;" /></td>
									<td><input name="property" type="checkbox" class="vetM property"  value="contect.qq"/>QQ：</td>
									<td><input name="contect.qq.like" type="text" class="inputborder" id="txtPer_email_qq" style="width:80px;" /></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property"  value="customerInfo.userCount"/>企业总人数：</td>
						<td colspan="3" class="layerright">
							<table border="0" cellpadding="0" cellspacing="5" class="table_bordercolor">
								<tr>
									<td rowspan="3">
		                                <input name="customerInfo.userCount.ge" size="5" class="input int"/>—<input name="customerInfo.userCount.le" size="5" class="input int" />
		                            </td>
		                            <td>
		                                <input name="property" type="checkbox" class="vetM property"  value="customerInfo.userbsh"/>博士后
		                                <input name="customerInfo.userbsh.ge" size="5" class="input int"/>—<input name="customerInfo.userbsh.le" size="5" class="input int" />
		                            </td>
		                            <td>
		                                <input name="property" type="checkbox" class="vetM property"  value="customerInfo.userbs"/>博士
		                                <input name="customerInfo.userbs.ge" size="5" class="input int"/>—<input name="customerInfo.userbs.le" size="5" class="input int" />
		                            </td>
		                            <td>
		                                <input name="property" type="checkbox" class="vetM property"  value="customerInfo.userss"/>硕士
		                                <input name="customerInfo.userss.ge" size="5" class="input int"/>—<input name="customerInfo.userss.le" size="5" class="input int" />
		                            </td>
		                        </tr>
		                        <tr>
		                        	<td>
		                                <input name="property" type="checkbox" class="vetM property" value="customerInfo.userbk"/>本科
		                                <input name="customerInfo.userbk.ge" size="5" class="input int"/>—<input name="customerInfo.userbk.le" size="5" class="input int" />
		                            </td>
		                            <td>
		                                <input name="property" type="checkbox" class="vetM property" value="customerInfo.userqt"/>其他
		                                <input name="customerInfo.userqt.ge" size="5" class="input int"/>—<input name="customerInfo.userqt.le" size="5" class="input int" />
		                            </td>
		                            <td colspan="5">
		                                <input name="property" type="checkbox" class="vetM property" value="customerInfo.userlxs"/>留学生
		                                <input name="customerInfo.userlxs.ge" size="5" class="input int"/>—<input name="customerInfo.userlxs.le" size="5" class="input int" />
		                            </td>
		                        </tr>
		                        <tr>
		                        	<td>
		                                <input name="property" type="checkbox" class="vetM property"  value="customerInfo.usergj"/>高级职称
		                                <input name="customerInfo.usergj.ge" size="5" class="input int"/>—<input name="customerInfo.usergj.le" size="5" class="input int" />
		                            </td>
		                            <td>
		                                <input name="property" type="checkbox" class="vetM property"  value="customerInfo.userzj"/>中级职称
		                                <input name="customerInfo.userzj.ge" size="5" class="input int"/>—<input name="customerInfo.userzj.le" size="5" class="input int" />
		                            </td>
		                            <td colspan="3">
		                                <input name="property" type="checkbox" class="vetM property"  value="customerInfo.usercj"/>初级职称
		                                <input name="customerInfo.usercj.ge" size="5" class="input int"/>—<input name="customerInfo.usercj.le" size="5" class="input int" />
		                            </td>
		                        </tr>
							</table>
		 				</td>
					</tr>
					<tr>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property" value="customer.technic" onclick="checkChildren(this);"/>产业类别：</td>
						<td colspan="3" class="layerright">
							<table border="0" cellpadding="0" cellspacing="5" id="CheckBoxList1">
								<tr>
								<c:forEach items="${technicList}" var="technic" varStatus="s">
									<td><label><input name="customer.technicId.in" type="checkbox" class="vetM" value="${technic.id}"/>${technic.dataValue}</label></td>
									<c:if test="${s.index % 5 eq 4 }"></tr><tr></c:if>
								</c:forEach>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property"  value="incubationInfo.incubateConfig" />孵化器配置：</td>
						<td colspan="3" class="layerright">
							<table border="0" cellpadding="0" cellspacing="5" id="CheckBoxList2">
								<tr>
								<c:forEach items="${incubateList}" var="incubate" varStatus="s">
									<td><label><input name="incubationInfo.incubateConfigId.in" type="checkbox" class="vetM" value="${incubate.id}"/>${incubate.dataValue}</label></td>
								</c:forEach>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property" value="customerVentureType" onclick="checkChildren(this);"/>创业类型：</td>
						<td colspan="3" class="layerright">
							<table border="0" cellpadding="0" cellspacing="5" id="CheckBoxList1">
								<tr>
								<c:forEach items="${enterpriseTypeList}" var="enterpriseType" varStatus="s">
									<td><label><input name="customerVentureType.ventureTypeId.in" type="checkbox" class="vetM" value="${enterpriseType.id}"/>${enterpriseType.dataValue}</label></td>
									<c:if test="${s.index % 5 eq 4 }"></tr><tr></c:if>
								</c:forEach>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property"  value="customerQualification" />企业资质：</td>
						<td colspan="3" class="layerright">
							<table border="0" cellpadding="0" cellspacing="5" id="Apti_config1_tabApti_config">
								<tr>
								<c:forEach items="${qualificationList}" var="qualification" varStatus="s">
									<td>
										<input name="property" type="checkbox" class="vetM property" value="customerQualification.${qualification.id}"/><label for="CheckBoxList1_0">${qualification.dataValue}</label>
										<input name="customerQualification.${qualification.id}.ge" size="8" class="input calendarInput"/>—<input name="customerQualification.${qualification.id}.le" size="8" class="input calendarInput" />
									</td>
									<c:if test="${s.index % 2 eq 1 }"></tr><tr></c:if>
								</c:forEach>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property" value="patent" onclick="checkChildren(this);"/>专利：</td>
						<td colspan="3" class="layerright">
							<table border="0" cellpadding="0" cellspacing="5">
								<tr>
									<td><input name="property" type="checkbox" class="vetM property" value="patent.name"/>专利名称：</td>
									<td><input name="patent.name.like" type="text" class="inputborder" id="txtPatentName" /></td>
									<td><input name="property" type="checkbox" class="vetM property" value="patent.type"/>专利类别：</td>
									<td><dd:select id="type" name="patent.typeId.eq" key="crm.0010"/></td>
								</tr>
								<tr>
									<td><input name="property" type="checkbox" class="vetM property" value="patent.applyTime"/>申请日期：</td>
									<td><input name="patent.applyTime.ge" size="8" class="input calendarInput"/>—<input name="patent.applyTime.le" size="8" class="input calendarInput" /></td>
									<td><input name="property" type="checkbox" class="vetM property" value="patent.buyTime"/>授权公告日：</td>
									<td><input name="patent.buyTime.ge" size="8" class="input calendarInput"/>—<input name="patent.buyTime.le" size="8" class="input calendarInput" /></td>
								</tr>
								<tr>
									<td><input name="property" type="checkbox" class="vetM property" value="patent.summery"/>授权情况：</td>
									<td><input name="patent.summery.like" type="text" class="inputborder" id="txtPatentName"/></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property" value="copyright" onclick="checkChildren(this);"/>软件著作权：</td>
						<td colspan="3" class="layerright">
							<table border="0" cellpadding="0" cellspacing="5">
								<tr>
									<td><input name="property" type="checkbox" class="vetM property" value="copyright.name"/>著作权名称：</td>
									<td><input name="copyright.name.like" type="text" class="inputborder"/></td>
									<td><input name="property" type="checkbox" class="vetM property" value="copyright.serialNo"/>证书号：</td>
									<td><input name="copyright.serialNo.like" type="text" class="inputborder" style="width:100px;" /></td>
									<td><input name="property" type="checkbox" class="vetM property" value="copyright.effectivetime"/>发证时间：</td>
									<td><input name="copyright.effectivetime.ge" size="8" class="input calendarInput"/>—<input name="copyright.effectivetime.le" size="8" class="input calendarInput" /></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property" value="brand" onclick="checkChildren(this);"/>商标：</td>
						<td colspan="3" class="layerright">
							<table border="0" cellpadding="0" cellspacing="5">
								<tr>
									<td><input name="property" type="checkbox" class="vetM property" value="brand.name"/>名称：</td>
									<td><input name="brand.name.like" type="text" class="inputborder" id="txtSoftName" /></td>
									<td><input name="property" type="checkbox" class="vetM property" value="brand.brandNo"/>编号：</td>
									<td><input name="brand.brandNo.like" type="text" class="inputborder" id="txtCode" style="width:100px;" /></td>
									<td><input name="property" type="checkbox" class="vetM property" value="brand.grantDate"/>授权日期：</td>
									<td><input name="brand.grantDate.ge" size="8" class="input calendarInput"/>—<input name="brand.grantDate.le" size="8" class="input calendarInput" /></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property" value="projectApply"/>项目产品：</td>
						<td colspan="3" class="layerright">
							<table border="0" cellpadding="0" cellspacing="5">
								<tr>
									<td><input name="property" type="checkbox" class="vetM property" value="projectApply.name"/>项目名称：</td>
									<td><input name="projectApply.name.like" type="text" class="inputborder" id="txtSoftName" /></td>
									<td><input name="property" type="checkbox" class="vetM property" value="projectApply.checkTime"/>验收时间：</td>
									<td><input name="projectApply.checkTime.ge" size="8" class="input calendarInput"/>—<input name="projectApply.checkTime.le" size="8" class="input calendarInput" /></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property" value="customerInfo.shareholder"/>股东构成：</td>
						<td colspan="3" class="layerright" style="padding:5px;"><input name="customerInfo.shareholder.like" type="text" class="inputborder" id="txtSoftName" style="width: 80%"/></td>
					</tr>
					<tr>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property"  value="customerInfo.businessScope"/>经营范围：</td>
						<td colspan="3" class="layerright" style="padding:5px;"><input name="customerInfo.businessScope.like" type="text" class="inputborder" id="txtSoftName" style="width: 80%"/></td>
					</tr>
					<tr>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property" value="customerInfo.memo"/>备注：</td>
						<td colspan="3" class="layerright" style="padding:5px;"><input name="customerInfo.memo.like" type="text" class="inputborder" id="txtSoftName" style="width: 80%"/></td>
					</tr>
					<tr>
						<td class="layertdleft120"><input name="property" type="checkbox" class="vetM property" value="dataReport" onclick="checkChildren(this)"/>企业经营情况</td>
						<td colspan="3" style="width: 725px;" class="layerright">
							<table border="0" cellpadding="0" cellspacing="5" class="table_bordercolor" style="text-align: left">
								<tr>
									<td><input name="property" type="checkbox" class="vetM property" value="report1"/>报表一：</td>
									<td><select id="reportGroupId1" onchange="loadReport(this.value,'reportId1')"><option value="">----请选择----</option></select></td>
									<td><select id="reportId1" name="dataReport1"><option value="">----请选择----</option></select></td>
								</tr>
								<tr>
									<td><input name="property" type="checkbox" class="vetM property" value="report2"/>报表二：</td>
									<td><select id="reportGroupId2" onchange="loadReport(this.value,'reportId2')"><option value="">----请选择----</option></select></td>
									<td><select id="reportId2" name="dataReport2"><option value="">----请选择----</option></select></td>
								</tr>
							</table>
							 ${reportHtml}
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="" style="padding:20px; text-align:center;">
			<a href="javascript:void(0)" title="" class="btn_bg" onclick="doSearch()"><span><img src="core/common/images/search_icon.gif"/>查询</span></a>
		</div>
	</form>
	</div>
</body>
</html>