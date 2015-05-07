<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
<%
String path = request.getContextPath();
String basePath = BaseAction.rootLocation+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<base href="<%=BaseAction.rootLocation %>/"/>
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/tree/themes/icon.css"/>
<link rel="stylesheet" type="text/css" href="core/common/tree/demo/demo.css"/>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/tree/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
</head>
<body>
<div class="basediv">
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">姓名：</td>
      <td class="layerright">${result.value.name}</td>
    </tr>
    <tr>
      <td class="layertdleft100">职位：</td>
      <td class="layerright">${result.value.post}</td>
    </tr>
    <tr>
    	<td class="layertdleft100" style="white-space:nowrap;">所属部门或公司：</td>
        <td class="layerright">${result.value.org.name}</td>
    
    </tr>
    <tr>
      <td class="layertdleft100">职责：</td>
      <td><div style="height: 70px; width:220px;word-break:break-all;overflow-x: hidden;overflow-y: auto">${result.value.memo}</div></td>
    </tr>
  </table>
</div>
</div>
<div style="height: 5px;"></div>
</body>
</html>
