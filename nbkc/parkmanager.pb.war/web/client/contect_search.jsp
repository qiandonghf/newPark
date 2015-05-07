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
	function setSelectedCustomer(customer){
		$("#customerId").val(customer.id);
		$("#customerName").val(customer.name);
	}
	function search(){
		parent.fb.end();
		parent.search(getSearchFilters());
	}
</script>
</head>

<body style=" background:#fff">
	<div class="basediv" style="height:360px; overflow-y:scroll; overflow-x:hidden">
		<div class="divlays" style="margin:0px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td class="layertdleft100">企业：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="288"><search:choose dataType="long" field="customerId" op="eq"><input id="customerId" type="hidden" class="data inputauto"/></search:choose><input id="customerName" readonly="readonly" type="text" class="inputauto" onclick="fbStart('选择企业','<%=basePath %>customer!select.action',520,400);" /></td>
								<td><img style="cursor:pointer;" onclick="fbStart('选择用户','<%=basePath %>customer!select.action',520,400);" src="core/common/images/outdiv.gif" width="20" height="22" /></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">姓名：</td>
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
					<td class="layertdleft100">性别：</td>
					<td class="layerright">
						<search:choose dataType="com.wiiy.commons.preferences.enums.GenderEnum" field="gender" op="eq">
							<enum:select styleClass="data" type="com.wiiy.commons.preferences.enums.GenderEnum"/>
						</search:choose>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">手机：</td>
					<td class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="mobile" op="cn" inputClass="inputauto"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
        			</td>
				</tr>
				<tr>
					<td class="layertdleft100">是否主要联系人：</td>
					<td colspan="3" class="layerright">
						<search:choose dataType="com.wiiy.commons.preferences.enums.BooleanEnum" field="main" op="eq">
							<enum:select styleClass="data" type="com.wiiy.commons.preferences.enums.BooleanEnum"/>
						</search:choose>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">职位：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="position" op="cn" inputClass="inputauto"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">Email：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="email" op="cn" inputClass="inputauto"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
      			<tr>
					<td class="layertdleft100">电话：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="phone" op="cn" inputClass="inputauto"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">MSN：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="msn" op="cn" inputClass="inputauto"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">QQ：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="qq" op="cn" inputClass="inputauto"/></td>
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
								<td width="310"><search:input dataType="string" field="fax" op="cn" inputClass="inputauto"/></td>
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
								<td width="310"><search:input dataType="string" field="zipcode" op="eq" inputClass="inputauto"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">家庭地址：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="homeAddr" op="cn" inputClass="inputauto"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">家庭电话：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="homePhone" op="cn" inputClass="inputauto"/></td>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">生日：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="120"><search:choose dataType="java.util.Date" field="birthDay" op="ge"><input id="birthDay1" class="data inputauto" onclick="return showCalendar('birthDay1')"/></search:choose></td>
								<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('birthDay1')"/></td>
								<td width="10" align="center">-</td>
								<td width="120" align="center"><search:choose dataType="java.util.Date" field="birthDay" op="le"><input id="birthDay2" class="data inputauto" onclick="return showCalendar('birthDay2')"/></search:choose></td>
								<td width="20"><img src="core/common/images/timeico.gif" width="20" height="22" style="position: relative;left:-1px;" onclick="return showCalendar('birthDay2')"/></td>
								<td align="center">&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="layertdleft100">爱好：</td>
					<td colspan="3" class="layerright">
						<table width="100%" border="0" cellspacing="0" cellpadding="10">
							<tr>
								<td width="310"><search:input dataType="string" field="favorite" op="cn" inputClass="inputauto"/></td>
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