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
</head>

<body>
<div class="basediv">
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">企业名称：</td>
      <td class="layerright">
      	${result.value.customer.name }
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">著作权名称：</td>
      <td class="layerright">${result.value.name }</td>
    </tr>
    <tr>
      <td class="layertdleft100">著作权号：</td>
      <td class="layerright">${result.value.serialNo }</td>
    </tr>
    <tr>
      <td class="layertdleft100">申请日期：</td>
      <td class="layerright"><fmt:formatDate value="${result.value.applyTime }" pattern="yyyy-MM-dd"/></td>
    </tr>
    <tr>
      <td class="layertdleft100">著作申请人：</td>
      <td class="layerright">${result.value.appler }</td>
    </tr>
    <tr>
      <td class="layertdleft100">著作权类型：</td>
      <td class="layerright">
        ${result.value.type.dataValue }
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">生效日期：</td>
      <td class="layerright"><fmt:formatDate value="${result.value.effectivetime }" pattern="yyyy-MM-dd"/></td>
    </tr>
    <tr>
      <td class="layertdleft100">失效日期：</td>
      <td class="layerright"><fmt:formatDate value="${result.value.expireTime }" pattern="yyyy-MM-dd"/></td>
    </tr>
    <tr>
    <td class="layertdleft100">是否发布：</td>
      <td class="layerright">
      	${result.value.pub.title }
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">著作权摘要：</td>
      <td class="layerright">
      	<div style="height:80px;overflow-y:auto; overflow-x:hidden;word-break:break-all; word-wrap:break-word; ">${result.value.summery}</div>
      </td>
    </tr>
     <%-- <tr>
      <td class="layertdleft100">创建人：</td>
      <td class="layerright">
      	${result.value.creator }
   	  </td>
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
      <td class="layertdleft100">最后修改时间：</td>
      <td class="layerright">
      	<fmt:formatDate value="${result.value.modifyTime }" pattern="yyyy-MM-dd"/>
      </td>
    </tr> --%>
  </table>
</div>
	<div class="hackbox"></div>
</div>
<div style="height: 5px;"></div>
</body>
</html>
