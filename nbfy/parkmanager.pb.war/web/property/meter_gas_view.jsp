<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link href="core/common/style/calendar.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />

<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript">


</script>
</head>

<body>
<form id="form1" name="form1" method="post" action="">
<input type="hidden" name="meter.id" value="${meter.id}"/>
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">气表名称：</td>
      <td class="layerright" style="width:170px;">${meter.name}</td>
      <td class="layertdleft100">气表倍数：</td>
      <td class="layerright" style="width:170px;">${meter.meterFactor}</td>
      </tr>
    <tr>
      <td class="layertdleft100">气表编号：</td>
      <td class="layerright" style="width:170px;">${meter.orderNo}</td>
      <td class="layertdleft100">母表编号：</td>
      <td class="layerright" style="width:170px;">${meter.parentNo}</td>
    </tr>
    <tr>
      <td class="layertdleft100" style="white-space:nowrap;">气表序列号：</td>
      <td class="layerright" style="width:170px;">${meter.sequenceNo}</td>
      <td class="layertdleft100">最后抄表日期：</td>
      <td class="layerright" style="width:170px;"><fmt:formatDate value="${meter.readingDate}" pattern="yyyy-MM-dd"/></td>
    </tr>
    <tr>
      <td class="layertdleft100">上期读数：</td>
      <td class="layerright" style="width:170px;"><fmt:formatNumber value="${meter.preReading}" pattern="#0.00"/></td>
      <td class="layertdleft100">气表性质：</td>
      <td class="layerright" style="width:170px;">
      	 ${meter.kind.title}
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">是否出表：</td>
      <td class="layerright" style="width:170px;">
      		${meter.checkOut.title}
	  </td>
      <td class="layertdleft100">气表状态：</td>
      <td class="layerright" style="width:170px;">
     	${meter.status.title}
      </td>
    </tr>
    <tr>
    	<td class="layertdleft100">所属楼宇：</td>
        <td class="layerright">
        	<c:if test="${meter.parkName!=null}"> ${meter.parkName}</c:if>
        	<c:if test="${meter.buildingName!=null}">  ${meter.buildingName}</c:if>
        </td>
    </tr>
    <tr>
      <td class="layertdleft100">备注：</td>
      <td colspan="3" class="layerright">
      	  <div style=" vertical-align:middle;height:50px; overflow-x:hidden; overflow-y:auto;word-break:break-all; word-wrap:break-word;">
	       		${meter.memo}
	       </div>
      </td>
      </tr>
  </table>
</div>
<!--//divlay-->
	<div class="hackbox"></div>
</div>
<!--//basediv-->
<!--basediv-->
<div style="height:5px;">
  </div>

</form>
</body>
</html>
