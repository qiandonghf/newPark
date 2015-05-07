<%@page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
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
<title>无标题文档</title>
<link rel="stylesheet" type="text/css" href="core/common/style/base.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript">
	$(function(){
		//alert($("body").height());
	});
</script>
<style>
	.layerright{
		word-break:break-all;
	}
	.layertdleft100{
		white-space:nowrap;
	}
	table{
		table-layout:fixed;
	}
</style>
</head>
<body>
<form action="" method="post" name="form1" id="form1">
<input name="articleType.id" type="hidden" value="${result.value.id}"/>
<!--basediv-->
<div class="basediv">
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">栏目名称：</td>
      <td class="layerright">${result.value.typeName}</td>
      <td class="layertdleft100">是否隐藏栏目：</td>
      <td class="layerright">
      	 <c:if test="${result.value.display eq 'YES'}">显示</c:if>
      	 <c:if test="${result.value.display eq 'NO'}">隐藏</c:if>
	  </td>
    </tr>
    <tr>
      <td class="layertdleft100">内容模型：</td>
      <td class="layerright" colspan="3">
       		${result.value.kind.title}
       		<c:if test="${not empty result.value.url}">自定义&nbsp;${result.value.url}</c:if>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">所属网站：</td>
      <td class="layerright">${result.value.param.name}</td>
      <td class="layertdleft100">上级目录：</td>
      <td class="layerright">${result.value.parentType.typeName}</td>
    </tr>
    <tr>
		<td class="layertdleft100">排列顺序：</td>
		<td class="layerright">${result.value.displayOrder}</td>
		<td class="layertdleft100">显示位置：</td>
    	<td class="layerright">${result.value.displayPosition.dataValue}</td>
    </tr>
    <tr>
      <td class="layertdleft100">关鍵字：</td>
      <td class="layerright" colspan="3" style="padding-bottom:2px;"><label>
        <textarea class="" style="width:100%;border:0px;color:#666;resize:none;height:60px;">${result.value.keyWord}</textarea>
      </label></td>
    </tr>
    <tr>
      <td class="layertdleft100">描述：</td>
      <td class="layerright" colspan="3" style="border:0px;padding-bottom:2px;">
      	<textarea class="" style="width:100%;border:0px;color:#666;height:60px;resize:none;">${result.value.ext2}</textarea>
      </td>
    </tr>
  </table>
</div>
<!--//divlay-->
	<div class="hackbox"></div>
</div>
<!--//basediv-->
<!--basediv-->
<!--//basediv-->
<div class="" style="height:5px;">
 </div>
</form>
</body>
</html>
