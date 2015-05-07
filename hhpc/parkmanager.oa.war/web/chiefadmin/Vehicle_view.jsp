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
<!--basediv-->
<div class="basediv">
	<!--titlebg-->
	<!--//titlebg-->
    <!--divlay-->
<div class="divlays" style="margin:0px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="layertdleft100"><span class="psred">*</span>车牌号码：</td>
            <td class="layerright">${result.value.licenseNo}</td>
            </tr>
          <tr>
            <td class="layertdleft100"><span class="psred">*</span>状态：</td>
            <td class="layerright">
          		${result.value.status.title}
            </td>
          </tr>
          <tr>
            <td class="layertdleft100">车辆类型：</td>
            <td class="layerright">
            	${result.value.carType.dataValue}
            </td>
          </tr>
          <tr>
            <td class="layertdleft100">厂家型号：</td>
            <td class="layerright">
            	${result.value.factoryModel}
            </td>
          </tr>
          <tr>
            <td class="layertdleft100">发动机号：</td>
            <td class="layerright">
           	  ${result.value.engineNumber}
            </td>
          </tr>
          <tr>
            <td class="layertdleft100">购买保险日期：</td>
            <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="120"><fmt:formatDate value="${result.value.insuranceDate}" pattern="yyyy-MM-dd"/></td>
				<td></td>
              </tr>
            </table></td>
            </tr>
          <tr>
            <td class="layertdleft100">年审日期：</td>
            <td class="layerright"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="120"><fmt:formatDate value="${result.value.annualDate}" pattern="yyyy-MM-dd"/></td>
                <td></td>
              </tr>
            </table></td>
          </tr>

      </table></td>
      <td width="260" valign="top"><table style=" padding-top:3px;" width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
           <td width="186">
           <c:if test="${result.value.photo!=''}">
           		<img id="car_imagery_img" class="oa_img" src="core/resources/${result.value.photo}" width="180" height="185" />
           </c:if>
           <c:if test="${result.value.photo==''}">
           		<img id="car_imagery_img" class="oa_img" src="core/common/images/nopic.jpg" width="180" height="185" />
           </c:if>
           </td>
          </tr>
      </table></td>
    </tr>
  </table>
  
  
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td class="layertdleft100">购置日期：</td>
      <td class="layerright" style="width:210px;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="120"><fmt:formatDate value="${result.value.buyDate}" pattern="yyyy-MM-dd"/></td>
          <td></td>
        </tr>
      </table></td>
      <td class="layertdleft100">驾驶员：</td>
      <td class="layerright">${result.value.pilot}</td>
    </tr>
  </table>
  
  
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
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
</body>
</html>
