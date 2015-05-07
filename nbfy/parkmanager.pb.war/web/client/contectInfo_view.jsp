<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
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
</head>

<body>
<div class="basediv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="layertdleft100">企业名称：</td>
       	<td class="layerright">${result.value.customer.name }</td>
      </tr>
      <tr>
        <td class="layertdleft100">联系人：</td>
        <td class="layerright">${result.value.contect.name }</td>
      </tr>
      <tr>
        <td class="layertdleft100">交往类型：</td>
        <td class="layerright">${result.value.type.dataValue }</td>
      </tr>
      <tr>
        <td class="layertdleft100">交往日期：</td>
        <td class="layerright"><fmt:formatDate value="${result.value.startTime }" pattern="yyyy-MM-dd HH:mm"/></td>
      </tr>
      <tr>
        <td class="layertdleft100">内容：</td>
        <td class="layerright"><div style="height: 50px;overflow-x: hidden;overflow-y: auto;word-break:break-all; word-wrap:break-word;">${result.value.content }</div></td>
      </tr>
      <tr>
        <td class="layertdleft100">备注：</td>
        <td class="layerright"><div style="height:50px;overflow-x: hidden;overflow-y: auto;word-break:break-all; word-wrap:break-word;">${result.value.memo }</div></td>
      </tr>
      <%-- <tr>
      <td class="layertdleft100">创建人：</td>
      <td class="layerright">
      	${result.value.creator }
   	  </td>
   	 </tr>
    <tr>  
      <td class="layertdleft100">创建时间：</td>
      <td class="layerright">
     	<fmt:formatDate value="${result.value.createTime }" pattern="yyyy-MM-dd"/>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">最后修改人：</td>
      <td class="layerright">
      	${result.value.modifier }
   	  </td>
   	  </tr>
    <tr>
      <td class="layertdleft100">最后修改时间：</td>
      <td class="layerright">
      	<fmt:formatDate value="${result.value.modifyTime }" pattern="yyyy-MM-dd"/>
      </td>
    </tr> --%>
    </table>
	<div class="hackbox"></div>
</div>
<div style="height: 5px;"></div>
</body>
</html>
