<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/uploadify-v3.1/uploadify.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>

</head>

<body>
<form id="form1" name="form1" method="post" action="">
	<!--basediv-->
	<div class="basediv" style="border:none;">
		<table width="100%"  class="oatableAdd" cellspacing="0" cellpadding="0">
			<tr>
				<td colspan="2"  style=" border-right:none; text-align:center; background:#e3e3e3; color:#003877; border-bottom:1px solid #c3c3c3;"><h2 style="text-align:center; padding-top:5px;font-size:14px;">用印审批</h2></td>
			</tr>
			<tr>
				<td class="layertdleftblack">姓名：</td>
				<td class="oatabletdright">张庆华</td>
			</tr>
			<tr>
				<td class="layertdleftblack">申请日期：</td>
				<td class="oatabletdright">2012-09-27</td>
			</tr>
			<tr>
				<td class="layertdleftblack">申请项目：</td>
				<td  class="oatabletdright"><label>
					三略科技项目
				</label></td>
			</tr>
			<tr>
				<td class="layertdleftblack">用印名称：</td>
				<td class="oatabletdright">公司例子</td>
			</tr>
			<tr>
				<td class="layertdleftblack">用印数量：</td>
				<td  class="oatabletdright">2</td>
			</tr>
			<tr>
				<td class="layertdleftblack">申请内容：</td>
				<td  class="oatabletdright" style="padding:2px 5px;"><label>
					<div style="width:620; border:none; height:50px; color:#333;line-height:22px;">暂无</div>
					</label>				</td>
			</tr>
			<tr>
				<td class="layertdleftblack">用印类型：</td>
				<td  class="oatabletdright" style="padding:2px 5px;"><label>
					<select name="select">
						<option>----请选择----</option>
						<option>法人章</option>
					</select>
				</label></td>
			</tr>
		</table>
		<table style="border-left:1px solid #c3c3c3" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td  class="layertdleftblack">审批人：</td>
				<td class="oatabletdright" width="200">张庆华</td>
				<td  class="layertdleftblack">审批时间：</td>
				<td class="oatabletdright">2012-09-27 12:30 </td>
			</tr>
			<tr>
				<td class="layertdleftblack">审批意见：</td>
				<td class="oatabletdright" colspan="3"><div style="width:620; border:none; height:50px; color:#333;line-height:22px;">同意</div></td>
			</tr>
		</table>
		<table style="border-left:1px solid #c3c3c3" width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td  class="layertdleftblack">审批人：</td>
						<td class="oatabletdright" width="200">张庆华</td>
						<td  class="layertdleftblack">审批时间：</td>
						<td class="oatabletdright">2012-09-27 12:30 </td>
					</tr>
					<tr>
						<td class="layertdleftblack">审批意见：</td>
						<td class="oatabletdright" colspan="3"><textarea name="textarea" class="textareaauto" style=" height:50px;"></textarea></td>
			</tr>
		</table>
	</div>
	<!--//basediv-->
	<div class="buttondiv">
		<label>
			<input name="Submit" type="button" class="audittn" value="" />
		</label>
		<label>
			<input name="Submit2" type="button" class="cancelbtn" value="" />
		</label>
	</div>
</form>
</body>
</html>
