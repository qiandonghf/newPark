<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
String uploadPath = BaseAction.rootLocation+"/";
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
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link rel="stylesheet" type="text/css" href="core/common/uploadify-v3.1/uploadify.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
</head>

<body>
<form action="<%=basePath %>contractRecord!update.action" method="post" name="form1" id="form1">
<input id="contractRecordId" name="contractRecord.id" value="${result.value.id }" type="hidden" />
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>甲方：</td>
      <td class="layerright">${result.value.partya }</td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>乙方：</td>
      <td class="layerright">${result.value.partyb }</td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>合同名称：</td>
      <td class="layerright">${result.value.contractName }</td>
    </tr>
    <tr>
		<td class="layertdleft100">合同期限：</td>
		<td class="layerright">${result.value.duration}</td>
	</tr>
	<tr>
		<td class="layertdleft100">签约时间：</td>
		<td class="layerright"><fmt:formatDate value="${result.value.signingDate}" pattern="yyyy-MM-dd"/></td>
	</tr>
	<tr>
      <td class="layertdleft100">合同性质：</td>
      <td class="layerright">${ result.value.contractCharacter.title}</td>
    </tr>
	<tr>
      <td class="layertdleft100">金额：</td>
      <td class="layerright">${result.value.money }</td>
    </tr>
	<tr>
		<td class="layertdleft100">附件列表：</td>
		<td class="layerright">
			<table border=0 cellspacing=0 cellpadding=0 width="70%"><tr><td style="padding-left:5px;">
				<div id="attList" style="height: 100px;overflow-x:hidden;overflow-y: auto; ">
				<c:forEach items="${result.value.atts}" var="att">
				<li style="width: 180px;" id="li${att.id}"><label><a href="core/resources/${att.newName}?name=${att.name}" style="text-decoration: underline;">${att.name}</a><input type="hidden" value="${att.newName}" class="att"/></label></li>
			</c:forEach></div>
			</td></tr></table>
		</td>
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
