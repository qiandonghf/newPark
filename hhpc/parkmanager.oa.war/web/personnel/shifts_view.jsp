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
<div class="basediv">
	<div class="layertitle">基本信息</div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="layertdleft100">班制名称：</td>
        <td width="170">${result.value.name}</td>
      </tr>
      <tr>
        <td class="layertdleft100">是否缺省：</td>
        <td class="layerright">${result.value.isDefault.title}</td>
      </tr>
      <tr>
        <td class="layertdleft100">周日：</td>
        <td class="layerright">${day7Class}</td>
      </tr>
      <tr>
        <td class="layertdleft100">周一：</td>
        <td class="layerright">${day1Class}</td>
      </tr>
      <tr>
        <td class="layertdleft100">周二：</td>
        <td class="layerright">${day2Class}</td>
      </tr>
      <tr>
        <td class="layertdleft100">周三：</td>
        <td class="layerright">${day3Class}</td>
      </tr>
      <tr>
        <td class="layertdleft100">周四：</td>
        <td class="layerright">${day4Class}</td>
      </tr>
      <tr>
        <td class="layertdleft100">周五：</td>
        <td class="layerright">${day5Class}</td>
      </tr>
      <tr>
        <td class="layertdleft100">周六：</td>
        <td class="layerright">${day6Class}</td>
      </tr>
    </table>
</div>
<div style="height: 5px;"></div>
</body>
</html>
