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
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link href="core/common/calendar/calendar.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript">
	
</script>
</head>
<body>
<div class="basediv">
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">企业名称：</td>
      <td class="layerright">
          ${result.value.customer.name}
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">商标名称：</td>
      <td class="layerright">${result.value.name} </td>
    </tr>
    <tr>
      <td class="layertdleft100">商标编号：</td>
      <td class="layerright">${result.value.brandNo}</td>
    </tr>
    <tr>
      <td class="layertdleft100">注册人：</td>
      <td class="layerright">${result.value.register}</td>
    </tr>
	<tr>
      <td class="layertdleft100">注册地址：</td>
      <td class="layerright">${result.value.registerAddress}</td>
    </tr>
    <tr>
      <td class="layertdleft100">注册有效期：</td>
      <td class="layerright">
      	 <fmt:formatDate value='${result.value.startDate}' pattern='yyyy-MM-dd'/>
      	   至
      	 <fmt:formatDate value='${result.value.endDate}' pattern='yyyy-MM-dd'/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">授权日期：</td>
      <td class="layerright">
      	  <fmt:formatDate value='${result.value.grantDate}' pattern='yyyy-MM-dd'/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">详细说明：</td>
      <td class="layerright">
           <div style="height:80px;overflow-x:hidden; overflow-y:auto;word-break:break-all; word-wrap:break-word;">
       		 ${result.value.memo}
       	   </div>
     </td>
    </tr>
  </table>
</div>
</div>
<div style="height: 5px;"></div>
</body>
</html>
