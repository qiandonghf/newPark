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
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
</head>

<body>
<div class="basediv">
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">班次名称：</td>
      <td class="layerright">${workClass.name}</td>
    </tr>
    <tr>
      <td class="layertdleft100">上班时间：</td>
      <td class="layerright">${startTimeHour}时${startTimeMinute}分 
	  </td>
    </tr>
    <tr>
      <td class="layertdleft100">签到开始时间：</td>
      <td class="layerright">${signInStartTimeHour}时${signInStartTimeMinute}分
	  </td>
    </tr>
    <tr>
      <td class="layertdleft100">签到结束时间：</td>
      <td class="layerright">${signInEndTimeHour}时${signInEndTimeMinute}分 
	</td>
    </tr>
    <tr>
      <td class="layertdleft100">下班时间：</td>
      <td class="layerright">${endTimeHour}时${endTimeMinute}分
   	  </td>
    </tr>
    
    <tr>
      <td class="layertdleft100">签退开始时间：</td>
      <td class="layerright">${signOutStartTimeHour}时${signOutStartTimeMinute}分
    </td>
    </tr>
    <tr>
      <td class="layertdleft100">签退结束时间：</td>
      <td class="layerright">${signOutEndTimeHour}时${signOutEndTimeMinute}分 
	</td>
    </tr>
    <tr>
      <td class="layertdleft100">备注：</td>
      <td class="layerright">
      	<div style="height: 100px;overflow-x: hidden;overflow-y: auto">${workClass.memo}</div>
	  </td>
    </tr>
  </table>
</div>
</div>
<div style="height: 5px;"></div>
</body>
</html>
