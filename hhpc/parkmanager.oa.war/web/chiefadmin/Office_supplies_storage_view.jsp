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
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/calendar/calendar.css" rel="stylesheet" type="text/css" />
<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
</head>
<body>
<input value="${result.value.id}" name="supplyStockIn.id" type="hidden" id="id"/>
<div class="basediv">
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">商品名称：</td>
      <td class="layerright">${result.value.supply.name}</td>
      </tr>
    <tr>
      <td class="layertdleft100">供应商：</td>
      <td class="layerright">${result.value.supplier}</td>
      </tr>
    <tr>
      <td class="layertdleft100">价格：</td>
      <td class="layerright"><fmt:formatNumber value="${result.value.price}" pattern="#0.00"/></td>
      </tr>
    <tr>
      <td class="layertdleft100">总数：</td>
      <td class="layerright"><fmt:formatNumber value="${result.value.amount}" pattern="#0.00"/></td>
    </tr>
    <tr>
      <td class="layertdleft100">进货时间：</td>
      <td class="layerright"><fmt:formatDate value="${result.value.inTime}" pattern="yyyy-MM-dd"/></td>
    </tr>
    <tr>
      <td class="layertdleft100">购买人：</td>
      <td class="layerright">${result.value.purchaser}</td>
      </tr>
  </table>
</div>
</div>
</body>
</html>
