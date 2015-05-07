<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
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
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
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
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
</head>

<body>
<body>
<form id="form1" name="form1" method="post" action="">
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<div class="titlebg">基本信息</div>
	<!--//titlebg-->
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>资产名称：</td>
      <td class="layerright">${result.value.name}</td>
      </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>资产类别：</td>
      <td class="layerright">  		
    		${result.value.type.dataValue}
      </td>
      <td >&nbsp;</td>
      <td>&nbsp;</td>
     </tr>
    <tr>
     <td class="layertdleft100"><span class="psred">*</span>置办日期：</td>
     <td class="layerright">
		<table border="0" cellspacing="0" cellpadding="10">
		<tr>
			<td width="120"><fmt:formatDate value="${result.value.dealDate}" pattern="yyyy-MM-dd"/></td>
		</tr>
		</table>
	 </td>
    </tr>
    <tr>
      <td class="layertdleft100">所属部门：</td>
      	<td class="layerright">${result.value.org.name }</td>
    </tr>
     <tr>
        <td class="layertdleft100">规格型号：</td>
        <td class="layerright">${result.value.spec}</td>
        </tr>
      <tr>
        <td class="layertdleft100">厂商：</td>
        <td class="layerright">${result.value.factory}</td>
      </tr>
      <tr>
        <td class="layertdleft100">使用人：</td>
        <td class="layerright">${result.value.user}</td>
      </tr>
      <tr>
        <td class="layertdleft100">保管人：</td>
        <td class="layerright">${result.value.custodian}</td>
      </tr>
      <tr>
        <td class="layertdleft100">状态：</td>
        <td class="layerright"> ${result.value.status.title} </td>
      </tr>
      <tr>
        <td class="layertdleft100">采购日期：</td>
        <td class="layerright"><table border="0" cellspacing="0" cellpadding="10">
			<tr>
				<td width="120"><fmt:formatDate value="${result.value.buyDate}" pattern="yyyy-MM-dd"/></td>		
			</tr>
		</table></td>
	  </tr>
      <tr>
        <td class="layertdleft100">备注：</td>
       <td colspan="3" class="layerright"><label>${result.value.memo}</label></td>
      </tr>
  </table>

</div>

<div class="buttondiv">
  <label><input name="Submit" type="submit" class="savebtn" value="" /></label>
  <label><input name="Submit2" type="button" class="cancelbtn" value="" onclick="parent.fb.end();"/></label>
  </div>
</form>
</body>
</html>
