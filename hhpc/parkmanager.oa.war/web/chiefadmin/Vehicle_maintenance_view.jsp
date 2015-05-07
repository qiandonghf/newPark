<%@ page language="java" import="java.util.*,com.wiiy.commons.action.BaseAction" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="enum" uri="http://www.wiiy.com/taglib/enum" %>
<%@ taglib prefix="dd" uri="http://www.wiiy.com/taglib/datadict"%>
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
<link rel="stylesheet" type="text/css" href="core/common/style/content.css"/>
<link rel="stylesheet" type="text/css" href="core/common/style/layerdiv.css"/>
<link rel="stylesheet" type="text/css" href="core/common/floatbox/floatbox.css" />
<link href="core/common/uploadify-v3.1/uploadify.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="core/common/calendar/calendar.css" />

<script type="text/javascript" src="core/common/calendar/calendar.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-setup.js"></script>
<script type="text/javascript" src="core/common/calendar/calendar-zh.js"></script>
<script type="text/javascript" src="core/common/floatbox/floatbox.js"></script>
<script type="text/javascript" src="core/common/js/jquery.js"></script>
<script type="text/javascript" src="core/common/js/tools.js"></script>
<script type="text/javascript" src="core/common/js/jquery.form.js"></script>
<script type="text/javascript" src="core/common/js/jquery.validate.js"></script>
<script type="text/javascript" src="core/common/uploadify-v3.1/jquery.uploadify-3.1.min.js"></script>
<script type="text/javascript">

</script>
</head>
<body>
<form id="form1" name="form1" method="post" action="<%=basePath%>carFix!update.action">
<!--basediv-->
<div class="basediv">
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>车牌号：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="154">
            ${result.value.licenseNo}
          </td>
		  <td></td>
        </tr>
      </table></td>
      </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>维护日期：</td>
      <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
        
          <td width="14">
            <fmt:formatDate value="${result.value.fixDate}" pattern="yyyy-MM-dd"/>
          </td>
          
        </tr>
      </table></td>
      </tr>
    <tr>
      <td class="layertdleft100">经办人：</td>
      <td class="layerright">${result.value.operator}</td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>维修类型：</td>
      <td class="layerright">
      	${result.value.carFixType.dataValue}
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">费用：</td>
      <td class="layerright"><fmt:formatNumber value="${result.value.fee}" pattern="#0.00"/>元</td>
    </tr>
    <tr>
      <td class="layertdleft100"><span class="psred">*</span>维护原因：</td>
      <td class="layerright" style="padding-bottom:2px;">
        <div style="height: 75px;overflow-x: hidden;overflow-y: auto">
        	${result.value.reason}
        </div>
      </td>
    </tr>
    <tr>
      <td class="layertdleft100">备注：</td>
      <td class="layerright">
        <div style="height: 75px;overflow-x: hidden;overflow-y: auto">${result.value.memo}</div>
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
</form>
</body>
</html>
