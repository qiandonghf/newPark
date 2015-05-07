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
var userType = 0;
	$(function(){
		initTip();
	});
	function setSelectedUser(user){
		if(userType==1){
			$("#hostId").val(user.id);
			$("#host").val(user.realName);
			}else if(userType==2){
				$("#importId").val(user.id);
				$("#import").val(user.realName);
			}
	}
	function getCalendarScrollTop(){
		return $("#scrollDiv").scrollTop();
	}
	function search(){
		parent.fb.end();
		parent.search(getSearchFilters());
	}
	function selectUser(obj){
		userType=obj;
		fbStart('选择用户','<%=BaseAction.rootLocation %>/core/user!selectSelf.action',520,400);
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
					<td class="layertdleft100">企业编号：</td>
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
					<td class="layertdleft100">跟踪人：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="288"><search:choose dataType="long" field="hostId" op="eq"><input id="hostId" type="hidden" class="data inputauto"/></search:choose><input id="host" readonly="readonly" type="text" class="inputauto" onclick="selectUser(1)" /></td>
								<td><img style="cursor:pointer;" onclick="selectUser(1)" src="core/common/images/outdiv.gif" width="20" height="22" /></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">引进人：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="288"><search:choose dataType="long" field="importId" op="eq"><input id="importId" type="hidden" class="data inputauto"/></search:choose><input id="import" readonly="readonly" type="text" class="inputauto" onclick="selectUser(2)" /></td>
								<td><img style="cursor:pointer;" onclick="selectUser(2)" src="core/common/images/outdiv.gif" width="20" height="22" /></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">入驻状态：</td>
					<td class="layerright">
						<search:choose dataType="com.wiiy.crm.preferences.enums.ParkStatusEnum" field="parkStatus" op="eq">
							<enum:select styleClass="data" type="com.wiiy.crm.preferences.enums.ParkStatusEnum"/>
						</search:choose>
        			</td>
				</tr>
				<tr>
					<td class="layertdleft100">产业类别：</td>
					<td colspan="3" class="layerright">
						<search:choose dataType="string" field="technicId" op="eq">
							<dd:select styleClass="data" key="crm.0002"/>
						</search:choose>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">企业来源：</td>
					<td colspan="3" class="layerright">
						<search:choose dataType="string" field="sourceId" op="eq">
								<dd:select styleClass="data" key="crm.0003"/>
						</search:choose>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">企业分类：</td>
					<td colspan="3" class="layerright">
						<search:choose dataType="string" field="customerTypeId" op="eq">
								<dd:select styleClass="data" key="crm.0040"/>
						</search:choose>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">企业性质：</td>
					<td colspan="3" class="layerright">
						<search:choose dataType="com.wiiy.crm.preferences.enums.CustomerTypeEnum" field="type" op="eq">
							<enum:select styleClass="data" type="com.wiiy.crm.preferences.enums.CustomerTypeEnum"/>
						</search:choose>
					</td>
				</tr>
      			<tr>
					<td class="layertdleft100">是否孵化企业：</td>
					<td colspan="3" class="layerright">
						<search:choose dataType="com.wiiy.commons.preferences.enums.BooleanEnum" field="incubated" op="eq">
        					<enum:select  styleClass="data" type="com.wiiy.commons.preferences.enums.BooleanEnum"/>
						</search:choose>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">联系地址：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="customerInfo.address" op="cn" inputClass="inputauto"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">办公电话：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="customerInfo.officePhone" op="cn" inputClass="inputauto"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">传真：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="customerInfo.fax" op="cn" inputClass="inputauto"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">邮编：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="customerInfo.zipCode" op="eq" inputClass="inputauto"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">网址：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="customerInfo.webSite" op="cn" inputClass="inputauto"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">E-mail：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="customerInfo.email" op="cn" inputClass="inputauto"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">注册时间：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="120"><search:choose dataType="java.util.Date" field="customerInfo.regTime" op="ge"><input id="regTime1" class="data inputauto" onclick="return showCalendar('regTime1')"/></search:choose></td>
								<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('regTime1')"/></td>
								<td width="10">-</td>
								<td width="120"><search:choose dataType="java.util.Date" field="customerInfo.regTime" op="le"><input id="regTime2" class="data inputauto" onclick="return showCalendar('regTime2')"/></search:choose></td>
								<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('regTime2')"/></td>
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
								<td width="120"><search:choose dataType="java.util.Date" field="customerInfo.businessExpireDate" op="ge"><input id="businessExpireDate1" class="data inputauto" onclick="return showCalendar('businessExpireDate1')"/></search:choose></td>
								<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('businessExpireDate1')"/></td>
								<td width="10"> -</td>
								<td width="120"><search:choose dataType="java.util.Date" field="customerInfo.businessExpireDate" op="le"><input id="businessExpireDate2" class="data inputauto" onclick="return showCalendar('businessExpireDate2')"/></search:choose></td>
								<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('businessExpireDate2')"/></td>
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
								<td width="120"><search:choose dataType="java.util.Date" field="incubationInfo.incubationStartDate" op="ge"><input id="incubationStartDate1" class="data inputauto" onclick="return showCalendar('incubationStartDate1')"/></search:choose></td>
								<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('incubationStartDate1')"/></td>
								<td width="10"> -</td>
								<td width="120"><search:choose dataType="java.util.Date" field="incubationInfo.incubationStartDate" op="le"><input id="incubationStartDate2" class="data inputauto" onclick="return showCalendar('incubationStartDate2')"/></search:choose></td>
								<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('incubationStartDate2')"/></td>
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
								<td width="120"><search:choose dataType="java.util.Date" field="incubationInfo.incubationEndDate" op="ge"><input id="incubationEndDate1" class="data inputauto" onclick="return showCalendar('incubationEndDate1')"/></search:choose></td>
								<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('incubationEndDate1')"/></td>
								<td width="10"> -</td>
								<td width="120"><search:choose dataType="java.util.Date" field="incubationInfo.incubationEndDate" op="le"><input id="incubationEndDate2" class="data inputauto" onclick="return showCalendar('incubationEndDate2')"/></search:choose></td>
								<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('incubationEndDate2')"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
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