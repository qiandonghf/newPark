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
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/tree/themes/default/easyui.css"/>
<link rel="stylesheet" type="text/css" href="core/common/tree/themes/icon.css"/>
<link rel="stylesheet" type="text/css" href="core/common/tree/demo/demo.css"/>

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/tree/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="core/common/tree/jquery.easyui.min.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	initTip();
});



</script>
</head>

<body>
<form action="<%=basePath %>links!save.action" method="post" name="form1" id="form1">
<!--basediv-->
<div class="basediv">
<!--divlay-->
<div class="divlays" style="margin:0px;">
  <table border="0" cellspacing="0" cellpadding="0" style="float:left;">
    <tr>
      <td class="layertdleft100">是否启用链接：</td>
      <td class="layerright" width="200">
         <input type="radio" name="link.display" value="<%=BooleanEnum.YES%>" disabled="disabled" <c:if test="${result.value.display eq 'YES'}">checked="checked"</c:if> />&nbsp;启用
     	 <input type="radio" name="link.display" value="<%=BooleanEnum.NO%>" disabled="disabled" <c:if test="${result.value.display eq 'NO'}">checked="checked"</c:if>/>&nbsp;禁用
	  </td>
    </tr>
    <tr>
      <td class="layertdleft100">链接名称：</td>
      <td class="layerright">
      	&nbsp;${result.value.linkName }
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">链接类型：</td>
      <td class="layerright">&nbsp;${result.value.type.title }</td>
    </tr>
    <tr>
      <td class="layertdleft100">链接地址：</td>
      <td class="layerright">
      	 &nbsp;${result.value.linkURL }
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">排列顺序：</td>
      <td class="layerright"><label>
      	&nbsp;${result.value.displayOrder }
      </label></td>
    </tr>
  </table>
  <c:if test="${result.value.type eq 'PHOTO' }">
  <div id="resourceList" style="float:left;">
		<table>
			<tr>
				<td class="layertdleft100" width="80">图片名称：</td>
				<td class="layerright">
		        	<span style="margin-left:0px;">${result.value.oldName}</span>
			  	</td>
			</tr>
			<tr>
		        <td class="layerright" colspan="2">
		        	<table width="100%" border="0" align="right" cellpadding="0" cellspacing="0">
			            <tr class="pic">
				           <td width="92"><!-- core/resources -->
				            <c:if test="${not empty result.value.photo }">
			           			<img id="user_imagery_img" src="core/resources/${result.value.photo }" width="90" height="34" class="touxian"  style="margin-left:0px;"/>
				           </c:if>
				           <c:if test="${empty result.value.photo }">
				           		<img id="user_imagery_img" src="" width="90" height="34" class="touxian"  style="margin-left:0px;"/>
				           </c:if>
				           </td>
					   </tr>
			          </table>
			  	</td>
			</tr>
		</table>
	</div>
	</c:if>
</div>
<!--//divlay-->
	<div class="hackbox"></div>
</div>
<!--//basediv-->
<!--basediv-->
<!--//basediv-->
<div class="" style="height:3px;">
</div>
</form>
</body>
</html>
