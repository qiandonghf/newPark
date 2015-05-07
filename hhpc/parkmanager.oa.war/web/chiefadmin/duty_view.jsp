<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
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
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/uploadify-v3.1/uploadify.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

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
<div class="basediv">
<div class="divlays" style="margin:0px;">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
 		<tr>
	        <td class="layertdleft100" >单位：</td>
	        <td class="layerright" width="180px;"><label>${result.value.company }</label></td>
	        <td class="layertdleft100">值班日期：</td>
	        <td class="layerright"><fmt:formatDate value="${result.value.dutyDate}" pattern="yyyy-MM-dd"/></td>
     	</tr>
     	<tr>
	        <td class="layertdleft100">值班人员：</td>
	        <td class="layerright"><label>${result.value.woker }</label></td>
	        <td class="layertdleft100">联系电话：</td>
			<td class="layerright"><label>${result.value.phone }</label></td>     	
		</tr>
		<tr>
	      <td class="layertdleft100">来访情况：</td>
	      <td colspan="3">
	      	<div style="height: 60px;width:480px;overflow-y: auto;word-break:break-all; overflow-x: hidden;">${result.value.visitContent }</div>
	      </td>
	    </tr>
		<tr>
	      <td class="layertdleft100">公共设施情况：</td>
	      <td colspan="3">
	      	<div style="height: 60px;width:480px;overflow-y: auto;word-break:break-all; overflow-x: hidden;">${result.value.facilitiesContent }</div>
	      </td>
	    </tr>
		<tr>
	      <td class="layertdleft100">消防、安全情况：</td>
	      <td colspan="3">
			<div style="height: 60px;width:480px;overflow-y: auto;word-break:break-all; overflow-x: hidden;">${result.value.safeContent }</div>
	      </td>
	    </tr>
		<tr>
	      <td class="layertdleft100">门岗、消控情况：</td>
	      <td colspan="3">
			<div style="height: 60px;width:480px;overflow-y: auto;word-break:break-all; overflow-x: hidden;">${result.value.gateContent }</div>
	      </td>
	    </tr>
		<tr>
	      <td class="layertdleft100">卫生情况：</td>
	      <td colspan="3">
			<div style="height: 60px;width:480px;overflow-y: auto;word-break:break-all; overflow-x: hidden;">${result.value.healthContent }</div>
	      </td>
	    </tr>
		<tr>
	      <td class="layertdleft100">其他：</td>
	      <td colspan="3">
	      	<div style="height: 60px;width:480px;overflow-y: auto;word-break:break-all; overflow-x: hidden;">${result.value.otherContent }</div>
	      </td>
	    </tr>
		<tr>
	      <td class="layertdleft100">备注：</td>
	      <td colspan="3">
	      	<div style="height: 60px;width:480px;overflow-y: auto;word-break:break-all; overflow-x: hidden;">${result.value.comment }</div>
	      </td>
	    </tr>
		
		
  </table>
</div>
</div>
</body>
</html>
