<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ page import="com.wiiy.commons.preferences.enums.BooleanEnum"%>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<title>无标题文档</title>
<link href="core/common/style/content.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/layerdiv.css" rel="stylesheet" type="text/css" />
<link href="core/common/style/calendar.css" rel="stylesheet" type="text/css" />
<link href="core/common/floatbox/floatbox.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
</head>

<body>
<div class="basediv">
<div class="divlays">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="layertdleft100">主题：</td>
        <td class="layerright">
        	${result.value.title}
        </td>
      </tr>
      <tr>
        <td class="layertdleft100">开始时间：</td>
        <td class="layerright">
        	<fmt:formatDate value="${result.value.startTime }" pattern="yyyy-MM-dd HH:mm"/>
	    </td>
      </tr>
      <tr>
        <td class="layertdleft100">结束时间：</td>
	    <td class="layerright">
	    <fmt:formatDate value="${result.value.endTime }" pattern="yyyy-MM-dd HH:mm"/></td>
      </tr>
	  <tr>
        <td class="layertdleft100">重复方式：</td>
        <td class="layerright">
        	${result.value.repeatType.title }
       	</td>
      </tr>
      <tr>
        <td class="layertdleft100">提醒：</td>
        <td class="layerright">
        	<fmt:formatDate value="${result.value.promotTime }" pattern="yyyy-MM-dd HH:mm"/>
        </td>
      </tr>	
      <tr>
        <td class="layertdleft100">提醒方式：</td>
        <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
           	<c:if test="${result.value.sms eq 'YES'}"><td width=30>短信 </td></c:if>
			
			<c:if test="${result.value.defaultEmail eq 'YES'}"><td width=50>内部邮件</td></c:if>
			
			<c:if test="${result.value.email eq 'YES'}"><td>外部邮件</td></c:if>
			<td>&nbsp;</td>
          </tr>
        </table></td>
      </tr>
	  
      <tr>
        <td class="layertdleft100">备注：</td>
        <td class="layerright" style="padding-bottom:2px;"><label>
        	<div style="height: 90px;overflow-y: auto; overflow-x: hidden;">${result.value.memo}</div>
        </label></td>
      </tr>
    </table>
	<div class="hackbox"></div>
	</div>
</div>
</body>
</html>
