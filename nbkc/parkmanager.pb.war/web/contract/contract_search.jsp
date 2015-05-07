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
	function setSelectedUser(user){
		$("#hostId").val(user.id);
		$("#host").val(user.realName);
	}
	function getCalendarScrollTop(){
		return $("#scrollDiv").scrollTop();
	}
	function search(){
		parent.fb.end();
		parent.search(getSearchFilters());
	}
</script>
</head>

<body style=" background:#fff">
	<div id="scrollDiv" class="basediv" style="height:360px; overflow-y:scroll; overflow-x:hidden">
		<div class="divlays" style="margin:0px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100">企业名称：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="name" op="cn" inputClass="inputauto"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">合同名称：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="name" op="cn" inputClass="inputauto"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">合同编号：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="code" op="eq" inputClass="inputauto"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">负责人：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="288"><search:choose dataType="long" field="hostId" op="eq"><input id="hostId" type="hidden" class="data inputauto"/></search:choose><input id="host" readonly="readonly" type="text" class="inputauto" onclick="fbStart('选择用户','<%=BaseAction.rootLocation %>/core/user!select.action',520,400);" /></td>
								<td><img style="cursor:pointer;" onclick="fbStart('选择用户','<%=BaseAction.rootLocation %>/core/user!select.action',520,400);" src="core/common/images/outdiv.gif" width="20" height="22" /></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">合同类型：</td>
					<td class="layerright">
						<search:choose dataType="com.wiiy.crm.preferences.enums.ParkStatusEnum" field="parkStatus" op="eq">
							<enum:select styleClass="data" type="com.wiiy.crm.preferences.enums.ParkStatusEnum"/>
						</search:choose>
        			</td>
				</tr>
				<tr>
					<td class="layertdleft100">有效日期：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="120"><search:choose dataType="java.util.Date" field="customerInfo.regTime" op="ge"><input id="regTime1" class="data inputauto" onclick="showCalendar('regTime1')"/></search:choose></td>
								<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('regTime1')"/></td>
								<td width="10">-</td>
								<td width="120"><search:choose dataType="java.util.Date" field="customerInfo.regTime" op="le"><input id="regTime2" class="data inputauto" onclick="showCalendar('regTime2')"/></search:choose></td>
								<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('regTime2')"/></td>
								<td align="center">&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">注册类型：</td>
					<td colspan="3" class="layerright">
						<search:choose dataType="long" field="customerInfo.regTypeId" op="eq">
							<dd:select styleClass="data" key="crm.0004"/>
						</search:choose>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">注册资本：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="customerInfo.regCapital" op="eq" inputClass="inputauto"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">币种：</td>
					<td colspan="3" class="layerright">
						<search:choose dataType="long" field="customerInfo.currencyTypeId" op="eq">
        					<dd:select styleClass="data" key="crm.0005"/>
						</search:choose>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">组织机构代码：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="customerInfo.organizationNumber" op="eq" inputClass="inputauto"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">工商注册号：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="customerInfo.businessNumber" op="eq" inputClass="inputauto"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">税务登记证：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="customerInfo.taxNumber" op="eq" inputClass="inputauto"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">法定代表人：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="customerInfo.legalPerson" op="eq" inputClass="inputauto"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">证件类型：</td>
					<td colspan="3" class="layerright">
						<search:choose dataType="long" field="customerInfo.documentTypeId" op="eq">
        					<dd:select styleClass="data" key="crm.0006"/>
						</search:choose>
					</td>
				</tr>
      			<tr>
					<td class="layertdleft100">E-mail：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="customerInfo.regMail" op="cn" inputClass="inputauto"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
      			<tr>
					<td class="layertdleft100">证件号：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="customerInfo.documentNumber" op="eq" inputClass="inputauto"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
      			<tr>
					<td class="layertdleft100">移动电话：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="customerInfo.cellphone" op="eq" inputClass="inputauto"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
      			<tr>
					<td class="layertdleft100">经营范围：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="customerInfo.businessScope" op="cn" inputClass="inputauto"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">营业截至日期：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="120"><search:choose dataType="java.util.Date" field="customerInfo.businessExpireDate" op="ge"><input id="businessExpireDate1" class="data inputauto" onclick="showCalendar('businessExpireDate1')"/></search:choose></td>
								<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('businessExpireDate1')"/></td>
								<td width="10">-</td>
								<td width="120"><search:choose dataType="java.util.Date" field="customerInfo.businessExpireDate" op="le"><input id="businessExpireDate2" class="data inputauto" onclick="showCalendar('businessExpireDate2')"/></search:choose></td>
								<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('businessExpireDate2')"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">注册地址：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="customerInfo.regAddress" op="cn" inputClass="inputauto"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">孵化日期起：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="120"><search:choose dataType="java.util.Date" field="incubationInfo.incubationStartDate" op="ge"><input id="incubationStartDate1" class="data inputauto" onclick="showCalendar('incubationStartDate1')"/></search:choose></td>
								<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('incubationStartDate1')"/></td>
								<td width="10">-</td>
								<td width="120"><search:choose dataType="java.util.Date" field="incubationInfo.incubationStartDate" op="le"><input id="incubationStartDate2" class="data inputauto" onclick="showCalendar('incubationStartDate2')"/></search:choose></td>
								<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('incubationStartDate2')"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">孵化日期止：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="120"><search:choose dataType="java.util.Date" field="incubationInfo.incubationEndDate" op="ge"><input id="incubationEndDate1" class="data inputauto" onclick="showCalendar('incubationEndDate1')"/></search:choose></td>
								<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('incubationEndDate1')"/></td>
								<td width="10">-</td>
								<td width="120"><search:choose dataType="java.util.Date" field="incubationInfo.incubationEndDate" op="le"><input id="incubationEndDate2" class="data inputauto" onclick="showCalendar('incubationEndDate2')"/></search:choose></td>
								<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('incubationEndDate2')"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">毕业日期：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="120"><search:choose dataType="java.util.Date" field="incubationInfo.graduationDate" op="ge"><input id="graduationDate1" class="data inputauto" onclick="showCalendar('graduationDate1')"/></search:choose></td>
								<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('graduationDate1')"/></td>
								<td width="10">-</td>
								<td width="120"><search:choose dataType="java.util.Date" field="incubationInfo.graduationDate" op="le"><input id="graduationDate2" class="data inputauto" onclick="showCalendar('graduationDate2')"/></search:choose></td>
								<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="showCalendar('graduationDate2')"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">孵化状态：</td>
					<td colspan="3" class="layerright">
						<search:choose dataType="com.wiiy.crm.preferences.enums.IncubationStatusEnum" field="incubationInfo.status" op="eq">
        					<enum:select styleClass="data" type="com.wiiy.crm.preferences.enums.IncubationStatusEnum"/>
						</search:choose>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">建立创业导师：</td>
					<td colspan="3" class="layerright">
        				<search:choose dataType="com.wiiy.commons.preferences.enums.BooleanEnum" field="incubationInfo.tutorSupport" op="eq">
        					<enum:select  styleClass="data" type="com.wiiy.commons.preferences.enums.BooleanEnum"/>
						</search:choose>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">留学生创业：</td>
					<td colspan="3" class="layerright">
        				<search:choose dataType="com.wiiy.commons.preferences.enums.BooleanEnum" field="incubationInfo.overseaEnterprise" op="eq">
        					<enum:select  styleClass="data" type="com.wiiy.commons.preferences.enums.BooleanEnum"/>
						</search:choose>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">高新技术企业：</td>
					<td colspan="3" class="layerright">
        				<search:choose dataType="com.wiiy.commons.preferences.enums.BooleanEnum" field="incubationInfo.highTechEnterprise" op="eq">
        					<enum:select  styleClass="data" type="com.wiiy.commons.preferences.enums.BooleanEnum"/>
						</search:choose>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">大学生创业：</td>
					<td colspan="3" class="layerright">
        				<search:choose dataType="com.wiiy.commons.preferences.enums.BooleanEnum" field="incubationInfo.undergraduateEnterprise" op="eq">
        					<enum:select  styleClass="data" type="com.wiiy.commons.preferences.enums.BooleanEnum"/>
						</search:choose>
					</td>
				</tr>
			</table>
		</div>
	<div class="hackbox"></div>
</div>
<div class="buttondiv">
	<input name="Submit" type="button" class="search_cx" value="" onclick="search()"/>
	<input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/>
</div>
</body>
</html>