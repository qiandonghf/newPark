<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<script type="text/javascript">
$(function(){
});

</script>
</head>

<body>
<div class="basediv">
	<div class="divlays" style="margin:0px;">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
      		<tr>
        		<td class="layertdleft100"><span class="psred">*</span>处理人：</td>
      	 		<td class="layerright" style="width:250px;">${result.value.user.realName }</td>
        	</tr>
      		<tr>
	      		<td class="layertdleft100"><span class="psred">*</span>处理时间：</td>
	      		<td class="layerright"><fmt:formatDate value="${result.value.handleTime }" pattern="yyyy-MM-dd"/> </td>
	      	</tr>
      		<tr>
		      	<td class="layertdleft100">内容：</td>
		      	<td ><span class="layerright" style="padding-top:4px;">
		      	  <textarea name="customerServiceTrack.content"  class="textareaauto"  style="color:#666;resize:none;border:0px;padding-left:0px;height:70px; width:95%;">${result.value.content }</textarea>
		      	</span></td>
      		</tr>
    	</table>
	</div>
</div>
<div class="" style="height:5px;">
</div>
</body>
</html>
